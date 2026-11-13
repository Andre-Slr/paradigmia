import rulesConfig from '../config/adaptationRules.json';
import {
  AdaptationOutput,
  Course,
  RecommendedCourse,
  UserAdaptationInput,
  UserLevel,
} from '/adaptation'

const LEVEL_RANK: Record<UserLevel, number> = {
  principiante: 1,
  básico: 2,
  intermedio: 3,
  avanzado: 4,
};

interface RuleCondition {
  field: string;
  operator: string;
  value?: unknown;
}

interface RuleDefinition {
  id: string;
  name: string;
  priority: number;
  enabled: boolean;
  condition: RuleCondition;
  action: Record<string, any>;
}

// Evaluador genérico de condiciones declarativas
function matchesCondition(condition: RuleCondition, facts: Record<string, any>): boolean {
  const actual = facts[condition.field];

  switch (condition.operator) {
    case 'exists':
      return actual !== undefined && actual !== null && actual !== '';
    case 'not_empty':
      return Array.isArray(actual) && actual.length > 0;
    case '==':
      return actual === condition.value;
    case '>=':
      return typeof actual === 'number' && actual >= Number(condition.value);
    case 'in':
      return Array.isArray(condition.value) && condition.value.includes(actual);
    case 'outside_range': {
      const [min, max] = condition.value as [number, number];
      return typeof actual === 'number' && (actual >= max || actual < min);
    }
    default:
      return false;
  }
}

export function runJsonAdaptationEngine(
  input: UserAdaptationInput
): AdaptationOutput & { triggeredRules: string[] } {
  const activeRules = (rulesConfig.rules as RuleDefinition[])
    .filter((r) => r.enabled)
    .sort((a, b) => b.priority - a.priority);

  const triggeredRules: string[] = [];

  // Hechos (facts) normalizados a partir de los datos del usuario y navegador
  const failedAttempt = input.attemptsByAssessment.find((a) => !a.passed && a.attempts_count >= 3);
  const facts: Record<string, any> = {
    experienceAnswer: input.experienceAnswer,
    computedLevel: input.level,
    interests: input.interests,
    preferredLanguage: input.preferredLanguage,
    diagnosticScore: input.diagnosticScore ?? 0,
    nextStepInCourse: input.nextStepInCourse,
    maxFailedAttempts: failedAttempt?.attempts_count ?? 0,
    sessionTimeBudget: input.sessionTimeBudget ?? '10-20',
    localHour: input.context.localHour,
    isWeakConnection: input.context.isWeakConnection,
    inactiveMinutes: input.context.isInactive ? 7 : 0,
  };

  // Estado inicial por defecto
  let eligibleCourses: Course[] = [...input.courses].filter((c) => c.is_published);
  const courseScores = new Map<string, { score: number; reasons: string[] }>();
  eligibleCourses.forEach((c) => courseScores.set(c.id, { score: 0, reasons: [] }));

  let suggestedStartLesson: 1 | 2 = 1;
  let openHintsByDefault = true;
  let isNightModeActive = input.themeOverride === 'dark';
  let liteMode = { enabled: false, hideDecorativeFoliage: false, showSubmissionWarning: false };
  let inactivityPrompt = false;
  let forcedReview = false;
  let sessionPlanTemplates: string[] = ['lesson', 'activity'];

  // Ejecución de reglas ordenadas por prioridad
  for (const rule of activeRules) {
    if (!matchesCondition(rule.condition, facts)) continue;
    triggeredRules.push(rule.id);

    switch (rule.action.type) {
      case 'SET_LEVEL': {
        const mapped = rule.action.mapping[facts.experienceAnswer];
        facts.computedLevel = mapped ?? rule.action.default;
        break;
      }

      case 'FILTER_COURSE_LEVEL': {
        const userRank = LEVEL_RANK[facts.computedLevel as UserLevel];
        const filtered = eligibleCourses.filter(
          (c) => LEVEL_RANK[c.level] <= userRank + rule.action.maxLevelDelta
        );
        eligibleCourses =
          filtered.length > 0
            ? filtered
            : eligibleCourses.filter((c) => c.level === rule.action.fallbackLevel);
        break;
      }

      case 'SCORE_COURSE_BY_LANGUAGE': {
        eligibleCourses.forEach((c) => {
          if (c.language.toLowerCase() === String(facts.preferredLanguage).toLowerCase()) {
            const entry = courseScores.get(c.id)!;
            entry.score += rule.action.points;
            entry.reasons.push(`Lenguaje elegido (${facts.preferredLanguage})`);
          }
        });
        break;
      }

      case 'SCORE_COURSE_BY_INTEREST': {
        const map: Record<string, string[]> = rule.action.interestMap;
        eligibleCourses.forEach((c) => {
          const matches = (facts.interests as string[]).filter((int) =>
            (map[int.toLowerCase()] ?? []).some(
              (lang) => lang.toLowerCase() === c.language.toLowerCase()
            )
          );
          if (matches.length > 0) {
            const entry = courseScores.get(c.id)!;
            entry.score += rule.action.points;
            entry.reasons.push(`Interés en ${matches.join(', ')}`);
          }
        });
        break;
      }

      case 'SET_START_LESSON': {
        suggestedStartLesson = rule.action.onTrue;
        break;
      }

      case 'SET_HINTS_VISIBILITY': {
        openHintsByDefault = rule.action.onTrue;
        break;
      }

      case 'FORCE_REVIEW_STEP': {
        forcedReview = true;
        break;
      }

      case 'SET_SESSION_STEPS': {
        sessionPlanTemplates = rule.action.plan;
        break;
      }

      case 'ENABLE_NIGHT_MODE': {
        if (input.themeOverride === 'system') {
          isNightModeActive = true;
        }
        break;
      }

      case 'ENABLE_LITE_MODE': {
        liteMode = {
          enabled: true,
          hideDecorativeFoliage: rule.action.hideDecorativeFoliage,
          showSubmissionWarning: rule.action.showSubmissionWarning,
        };
        break;
      }

      case 'PAUSE_STUDY_TIMER': {
        inactivityPrompt = true;
        break;
      }
    }
  }

  // Construcción final de cursos ordenados
  const recommendedCourses: RecommendedCourse[] = eligibleCourses
    .map((c) => ({
      ...c,
      score: courseScores.get(c.id)?.score ?? 0,
      reasons: courseScores.get(c.id)?.reasons ?? [],
    }))
    .sort((a, b) => b.score - a.score || a.position - b.position);

  // Construcción del plan de pasos respetando prioridad R8 > R9-R11
  const steps = buildStepsFromPlan(
    forcedReview,
    failedAttempt,
    sessionPlanTemplates,
    input.nextStepInCourse
  );

  return {
    computedLevel: facts.computedLevel,
    recommendedCourses,
    suggestedStartLesson,
    openHintsByDefault,
    actionPlan: {
      prioritizedReview: forcedReview,
      steps,
    },
    isNightModeActive,
    liteMode,
    inactivityPrompt,
    triggeredRules,
  };
}

function buildStepsFromPlan(
  forcedReview: boolean,
  failedAttempt: UserAdaptationInput['attemptsByAssessment'][number] | undefined,
  planTemplates: string[],
  nextStep?: UserAdaptationInput['nextStepInCourse']
) {
  if (forcedReview && failedAttempt) {
    const reviewStep = {
      type: 'review_lesson' as const,
      targetId: failedAttempt.lesson_id ?? failedAttempt.assessment_id,
      label: 'Repasar lección relacionada antes de reintentar',
    };
    // Si R9 limitó planTemplates a 1 paso, solo devuelve el repaso (Caso C2)
    if (planTemplates.length === 1) return [reviewStep];
    return [
      reviewStep,
      {
        type: 'activity' as const,
        targetId: failedAttempt.assessment_id,
        label: 'Reintentar actividad',
      },
    ];
  }

  if (!nextStep) return [];

  return planTemplates.map((tpl) => {
    if (tpl === 'next_single_step') {
      return { type: nextStep.type, targetId: nextStep.id, label: nextStep.title };
    }
    if (tpl === 'lesson') {
      return { type: 'lesson' as const, targetId: nextStep.id, label: nextStep.title };
    }
    if (tpl === 'activity') {
      return { type: 'activity' as const, label: 'Actividad de práctica' };
    }
    return { type: 'lesson' as const, label: 'Siguiente lección o examen' };
  });
}