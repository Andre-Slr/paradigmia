import rulesConfig from './adaptationRules.json'
import type { AdaptableCourse, Nivel } from './adaptation'
import type { CourseLearningStep } from '@/features/courses/courseService'

/**
 * Intérprete de las reglas de adaptación (adaptationRules.json).
 *
 * Todas las funciones son puras: reciben datos y devuelven decisiones. Cada
 * regla se puede apagar con "enabled": false en el JSON, y sus números
 * (puntos, límites, rutas) se cambian ahí mismo sin tocar este archivo.
 */

type Facts = Record<string, unknown>

interface RuleCondition {
  field: string
  operator: string
  value?: unknown
}

interface RuleDefinition {
  id: string
  priority: number
  enabled: boolean
  condition: RuleCondition
  action: Record<string, unknown>
}

interface CourseScore {
  score: number
  reasons: string[]
}

export interface RuleInput<C extends AdaptableCourse> {
  experienceAnswer: string | null
  initialLevel: Nivel | null
  interests: string[]
  preferredLanguage: string | null
  /** Aciertos del diagnóstico en escala de 0 a 10 (null si no hizo diagnóstico). */
  diagnosticScore: number | null
  courses: C[]
  /** Cursos que el estudiante ya terminó al 100 % (R15). */
  completedCourses?: AdaptableCourse[]
}

export interface RuleRecommendation<C extends AdaptableCourse> {
  course: C
  reasons: string[]
  score: number
}

export interface RuleOutput<C extends AdaptableCourse> {
  computedLevel: Nivel
  recommendedCourses: RuleRecommendation<C>[]
  suggestedStartLesson: 1 | 2
  openHintsByDefault: boolean
}

export const LEVEL_ORDER: Nivel[] = ['basico', 'intermedio', 'avanzado']
const LEVEL_RANK: Record<Nivel, number> = {
  basico: 1,
  intermedio: 2,
  avanzado: 3,
}

const LANGUAGE_NAMES: Record<string, string> = {
  c: 'C',
  cpp: 'C++',
  python: 'Python',
  java: 'Java',
  css: 'CSS',
  html: 'HTML',
  php: 'PHP',
  javascript: 'JavaScript',
}

const INTEREST_NAMES: Record<string, string> = {
  web: 'las páginas web',
  videojuegos: 'los videojuegos',
  apps: 'las aplicaciones',
  circuitos: 'los circuitos',
  automatizacion: 'la automatización de tareas',
}

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === 'object' && value !== null && !Array.isArray(value)
}

function isRuleDefinition(value: unknown): value is RuleDefinition {
  return (
    isRecord(value) &&
    typeof value.id === 'string' &&
    typeof value.priority === 'number' &&
    typeof value.enabled === 'boolean' &&
    isRecord(value.condition) &&
    typeof value.condition.field === 'string' &&
    typeof value.condition.operator === 'string' &&
    isRecord(value.action)
  )
}

function getRules(): RuleDefinition[] {
  if (!Array.isArray(rulesConfig.rules)) {
    throw new Error('La configuración de reglas de adaptación no contiene una lista de reglas.')
  }

  const rules = rulesConfig.rules.map((rule, index) => {
    if (!isRuleDefinition(rule)) {
      throw new Error(`La regla de adaptación en la posición ${index} tiene un formato inválido.`)
    }
    return rule
  })

  return rules.filter((rule) => rule.enabled).sort((a, b) => b.priority - a.priority)
}

/** Devuelve una regla encendida por su id, o null si no existe o está apagada. */
function getRule(id: string): RuleDefinition | null {
  return getRules().find((rule) => rule.id === id) ?? null
}

function matchesCondition(condition: RuleCondition, facts: Facts): boolean {
  const actual = facts[condition.field]

  switch (condition.operator) {
    case 'exists':
      return actual !== undefined && actual !== null && actual !== ''
    case 'not_empty':
      return Array.isArray(actual) && actual.length > 0
    case '==':
      return actual === condition.value
    case '>=':
      return typeof actual === 'number' &&
        typeof condition.value === 'number' &&
        actual >= condition.value
    case 'in':
      return Array.isArray(condition.value) && condition.value.includes(actual)
    case 'outside_range': {
      // [inicio, fin): fuera del rango significa antes de inicio o desde fin en adelante.
      if (typeof actual !== 'number' || !Array.isArray(condition.value)) return false
      const [start, end] = condition.value
      return typeof start === 'number' && typeof end === 'number' && (actual < start || actual >= end)
    }
    default:
      return false
  }
}

/** Evalúa la condición de una regla con los datos dados. */
function ruleApplies(id: string, facts: Facts): RuleDefinition | null {
  const rule = getRule(id)
  return rule && matchesCondition(rule.condition, facts) ? rule : null
}

export function normalizeLanguage(language: string | null): string | null {
  const value = (language ?? '').trim().toLowerCase()
  if (!value) return null
  if (value.includes('javascript') || value === 'js') return 'javascript'
  if (value.includes('typescript')) return 'typescript'
  if (value.includes('python')) return 'python'
  if (value.includes('html')) return 'html'
  if (value.includes('css')) return 'css'
  if (value.includes('java')) return 'java'
  if (value.includes('php')) return 'php'
  if (value.includes('c++') || value.includes('cpp')) return 'cpp'
  if (value === 'c') return 'c'
  return value
}

/** Convierte el nivel de un curso o perfil a uno de los 3 niveles. "Principiante" = básico. */
export function normalizeLevel(level: string | null): Nivel {
  const value = (level ?? '').trim().toLowerCase()
  if (value.includes('avanz')) return 'avanzado'
  if (value.includes('interm')) return 'intermedio'
  return 'basico'
}

/** Clave "lenguaje|nivel" con la que las rutas de R15 identifican a un curso. */
export function courseKey(course: Pick<AdaptableCourse, 'language' | 'level'>): string {
  return `${normalizeLanguage(course.language) ?? ''}|${normalizeLevel(course.level)}`
}

function isNivel(value: unknown): value is Nivel {
  return typeof value === 'string' && LEVEL_ORDER.includes(value as Nivel)
}

function getString(value: unknown): string | null {
  return typeof value === 'string' ? value : null
}

function getNumber(value: unknown): number | null {
  return typeof value === 'number' && Number.isFinite(value) ? value : null
}

function getStringArray(value: unknown): string[] {
  return Array.isArray(value) ? value.filter((item): item is string => typeof item === 'string') : []
}

function getPosition(course: AdaptableCourse): number | null {
  if ('position' in course && typeof course.position === 'number') return course.position
  return null
}

function getInterestMatches(
  interests: string[],
  interestMap: Record<string, unknown>,
  courseLanguage: string,
): string[] {
  return interests.filter((interest) => {
    const mappedLanguages = getStringArray(interestMap[interest.toLowerCase()])
    return mappedLanguages.some(
      (language) => normalizeLanguage(language) === courseLanguage,
    )
  })
}

export function runJsonAdaptationEngine<C extends AdaptableCourse>(
  input: RuleInput<C>,
): RuleOutput<C> {
  const completedCourses = input.completedCourses ?? []
  const facts: Facts = {
    experienceAnswer: input.experienceAnswer,
    computedLevel: input.initialLevel ?? 'basico',
    interests: input.interests,
    preferredLanguage: input.preferredLanguage,
    diagnosticScore: input.diagnosticScore,
    completedCourses,
  }
  const completedIds = new Set(completedCourses.map((course) => course.id))
  let eligibleCourses = input.courses.filter((course) => !completedIds.has(course.id))
  let suggestedStartLesson: 1 | 2 = 1
  let openHintsByDefault = false
  const courseScores = new Map<string, CourseScore>(
    input.courses.map((course) => [course.id, { score: 0, reasons: [] }]),
  )

  for (const rule of getRules()) {
    if (!matchesCondition(rule.condition, facts)) continue

    switch (rule.action.type) {
      case 'SET_LEVEL': {
        const mapping = isRecord(rule.action.mapping) ? rule.action.mapping : {}
        const experience = getString(facts.experienceAnswer)
        const mappedLevel = experience ? mapping[experience] : undefined
        const defaultLevel = rule.action.default
        facts.computedLevel = isNivel(mappedLevel)
          ? mappedLevel
          : isNivel(defaultLevel)
            ? defaultLevel
            : 'basico'
        break
      }

      case 'RAISE_LEVEL': {
        // R16: un diagnóstico alto sube el nivel (sin pasar de avanzado).
        const current = isNivel(facts.computedLevel) ? facts.computedLevel : 'basico'
        const steps = getNumber(rule.action.steps) ?? 1
        const index = Math.min(LEVEL_ORDER.indexOf(current) + steps, LEVEL_ORDER.length - 1)
        facts.computedLevel = LEVEL_ORDER[index]
        break
      }

      case 'FILTER_COURSE_LEVEL': {
        const userLevel = isNivel(facts.computedLevel) ? facts.computedLevel : 'basico'
        const byExperience = isRecord(rule.action.maxLevelDeltaByExperience)
          ? rule.action.maxLevelDeltaByExperience
          : {}
        const experience = getString(facts.experienceAnswer)
        const maxLevelDelta =
          (experience ? getNumber(byExperience[experience]) : null) ??
          getNumber(rule.action.maxLevelDelta) ??
          0
        const filtered = eligibleCourses.filter(
          (course) =>
            LEVEL_RANK[normalizeLevel(course.level)] <= LEVEL_RANK[userLevel] + maxLevelDelta,
        )
        if (filtered.length > 0) {
          eligibleCourses = filtered
        } else {
          const fallbackLevel = getString(rule.action.fallbackLevel)
          eligibleCourses = eligibleCourses.filter(
            (course) => normalizeLevel(course.level) === normalizeLevel(fallbackLevel),
          )
        }
        break
      }

      case 'SCORE_NEXT_COURSE': {
        // R15: al terminar un curso se recomienda el que sigue en su ruta. Este curso
        // se agrega aunque R4 lo haya ocultado, porque terminar el anterior demuestra el nivel.
        const routes = isRecord(rule.action.routes) ? rule.action.routes : {}
        const points = getNumber(rule.action.points) ?? 0
        for (const finished of completedCourses) {
          const targets = new Set(getStringArray(routes[courseKey(finished)]))
          if (targets.size === 0) continue

          for (const course of input.courses) {
            if (completedIds.has(course.id) || !targets.has(courseKey(course))) continue
            const entry = courseScores.get(course.id)
            if (!entry) continue
            entry.score += points
            entry.reasons.push(`Terminaste "${finished.title}" y este es el siguiente paso`)
            if (!eligibleCourses.some((item) => item.id === course.id)) {
              eligibleCourses = [...eligibleCourses, course]
            }
          }
        }
        break
      }

      case 'SCORE_COURSE_BY_LANGUAGE': {
        const preferredLanguage = normalizeLanguage(getString(facts.preferredLanguage))
        const points = getNumber(rule.action.points) ?? 0
        if (!preferredLanguage) break

        for (const course of eligibleCourses) {
          if (normalizeLanguage(course.language) !== preferredLanguage) continue
          const entry = courseScores.get(course.id)
          if (!entry) continue
          entry.score += points
          entry.reasons.push(
            `Elegiste aprender ${LANGUAGE_NAMES[preferredLanguage] ?? preferredLanguage}`,
          )
        }
        break
      }

      case 'SCORE_COURSE_BY_INTEREST': {
        if (!isRecord(rule.action.interestMap)) break
        const points = getNumber(rule.action.points) ?? 0

        for (const course of eligibleCourses) {
          const courseLanguage = normalizeLanguage(course.language)
          if (!courseLanguage) continue
          const matches = getInterestMatches(
            input.interests,
            rule.action.interestMap,
            courseLanguage,
          )
          const entry = courseScores.get(course.id)
          if (matches.length === 0 || !entry) continue
          entry.score += points
          entry.reasons.push(
            `Te interesan ${matches.map((interest) => INTEREST_NAMES[interest] ?? interest).join(', ')}`,
          )
        }
        break
      }

      case 'SET_START_LESSON': {
        suggestedStartLesson = getNumber(rule.action.onTrue) === 2 ? 2 : 1
        break
      }

      case 'SET_HINTS_VISIBILITY':
        openHintsByDefault = rule.action.onTrue === true
        break
    }
  }

  const userLevel = isNivel(facts.computedLevel) ? facts.computedLevel : 'basico'
  for (const course of eligibleCourses) {
    const entry = courseScores.get(course.id)
    if (!entry || entry.score === 0) continue
    const levelGap = LEVEL_RANK[normalizeLevel(course.level)] - LEVEL_RANK[userLevel]
    if (levelGap >= 0) {
      entry.reasons.push('Va de acuerdo con tu nivel')
      entry.score += 1
    } else {
      entry.reasons.push('Te sirve como repaso de los fundamentos')
    }
  }

  let recommendedCourses = eligibleCourses
    .map((course, index) => ({
      course,
      reasons: courseScores.get(course.id)?.reasons ?? [],
      score: courseScores.get(course.id)?.score ?? 0,
      index,
    }))
    .sort(
      (a, b) =>
        b.score - a.score ||
        (getPosition(a.course) ?? a.index) - (getPosition(b.course) ?? b.index),
    )
    .map(({ course, reasons, score }) => ({ course, reasons, score }))

  if (recommendedCourses.every(({ score }) => score === 0)) {
    const fallbackCourses = eligibleCourses.filter(
      (course) => normalizeLevel(course.level) === 'basico',
    )
    recommendedCourses = fallbackCourses.map((course) => ({
      course,
      reasons: [
        input.preferredLanguage
          ? `Mientras preparamos el curso de ${
              LANGUAGE_NAMES[normalizeLanguage(input.preferredLanguage) ?? ''] ??
              input.preferredLanguage
            }, este te da bases que te servirán`
          : 'Es un buen punto de partida para empezar a programar',
      ],
      score: 0,
    }))
  }

  return {
    computedLevel: userLevel,
    recommendedCourses,
    suggestedStartLesson,
    openHintsByDefault,
  }
}

/* ------------------------------------------------------------------------- */
/* R7–R11: avance, repaso y plan de la sesión dentro de un curso              */
/* ------------------------------------------------------------------------- */

export interface StepProgress {
  completedLessonIds: string[]
  passedActivityIds: string[]
  examPassed: boolean
}

export interface AttemptLike {
  assessment_id: string | null
  passed: boolean | null
}

export type SessionBudget = '<10' | '10-20' | '>20'

export interface ReviewNeeded {
  /** Actividad que el estudiante ha reprobado varias veces. */
  activity: CourseLearningStep
  /** Lección de esa actividad, para repasarla antes de reintentar. */
  lesson: CourseLearningStep | null
  failedAttempts: number
}

export interface SessionPlan {
  /** Regla de sesión que se aplicó (R9, R10 u R11), o null si no sabemos su tiempo. */
  sessionRule: 'R9' | 'R10' | 'R11' | null
  /** Pasos sugeridos para hoy, en orden. */
  steps: CourseLearningStep[]
  /** R8: repaso obligatorio, si aplica. */
  review: ReviewNeeded | null
  message: string | null
}

function isStepDone(step: CourseLearningStep, progress: StepProgress): boolean {
  if (step.type === 'lesson') return progress.completedLessonIds.includes(step.id)
  if (step.type === 'activity') return progress.passedActivityIds.includes(step.id)
  return progress.examPassed
}

/** R7: el siguiente paso pendiente del curso (lección, actividad o examen). */
export function findNextStep(
  sequence: CourseLearningStep[],
  progress: StepProgress,
): CourseLearningStep | null {
  const nextStep = sequence.find((step) => !isStepDone(step, progress)) ?? null
  return ruleApplies('R7', { nextStepInCourse: nextStep?.id ?? null }) ? nextStep : null
}

/** R8: si alguna actividad pendiente lleva 3 o más intentos reprobados, pide repasar su lección. */
export function findReviewStep(
  sequence: CourseLearningStep[],
  progress: StepProgress,
  attempts: AttemptLike[],
): ReviewNeeded | null {
  let worst: ReviewNeeded | null = null

  for (const step of sequence) {
    if (step.type !== 'activity' || progress.passedActivityIds.includes(step.id)) continue
    const failedAttempts = attempts.filter(
      (attempt) => attempt.assessment_id === step.id && attempt.passed !== true,
    ).length
    if (!worst || failedAttempts > worst.failedAttempts) {
      worst = {
        activity: step,
        lesson: sequence.find((item) => item.type === 'lesson' && item.id === step.lessonId) ?? null,
        failedAttempts,
      }
    }
  }

  if (!worst) return null
  return ruleApplies('R8', { maxFailedAttempts: worst.failedAttempts }) ? worst : null
}

const SESSION_RULES = ['R9', 'R10', 'R11'] as const

/** R7–R11: arma el plan de estudio de hoy según el avance, los intentos y el tiempo disponible. */
export function planStudySession(
  sequence: CourseLearningStep[],
  progress: StepProgress,
  attempts: AttemptLike[],
  sessionTimeBudget: SessionBudget | null,
): SessionPlan {
  const review = findReviewStep(sequence, progress, attempts)
  const reviewRule = getRule('R8')

  if (review && reviewRule?.action.overridesSessionBudget === true) {
    const steps = [review.lesson, review.activity].filter(
      (step): step is CourseLearningStep => step !== null,
    )
    return {
      sessionRule: null,
      steps,
      review,
      message: `Llevas ${review.failedAttempts} intentos sin aprobar "${review.activity.title}". Antes de volver a intentarlo, repasa ${
        review.lesson ? `"${review.lesson.title}"` : 'la lección'
      }.`,
    }
  }

  const nextStep = findNextStep(sequence, progress)
  if (!nextStep) {
    return { sessionRule: null, steps: [], review: null, message: null }
  }

  const facts = { sessionTimeBudget }
  const sessionRule = SESSION_RULES.map((id) => ruleApplies(id, facts)).find(Boolean) ?? null
  const maxSteps = sessionRule ? getNumber(sessionRule.action.maxSteps) ?? 1 : 1
  const startIndex = sequence.findIndex((step) => step.id === nextStep.id)
  const steps = sequence
    .slice(startIndex)
    .filter((step) => !isStepDone(step, progress))
    .slice(0, maxSteps)

  const budgetText: Record<SessionBudget, string> = {
    '<10': 'menos de 10 minutos',
    '10-20': 'de 10 a 20 minutos',
    '>20': 'más de 20 minutos',
  }

  return {
    sessionRule: sessionRule ? (sessionRule.id as SessionPlan['sessionRule']) : null,
    steps,
    review: null,
    message:
      sessionRule && sessionTimeBudget
        ? `Como estudias ${budgetText[sessionTimeBudget]} por sesión, hoy te proponemos ${
            steps.length === 1 ? 'este paso' : `estos ${steps.length} pasos`
          }.`
        : null,
  }
}

/* ------------------------------------------------------------------------- */
/* R12–R14: reglas del entorno (hora, conexión, inactividad)                  */
/* ------------------------------------------------------------------------- */

/** R12: ¿la hora local cae fuera del horario diurno? */
export function isNightTime(localHour: number): boolean {
  return ruleApplies('R12', { localHour }) !== null
}

export interface LiteModeDecision {
  lite: boolean
  hideDecorativeFoliage: boolean
  showSubmissionWarning: boolean
}

/** R13: con conexión débil se quitan las decoraciones y se avisa al enviar. */
export function decideLiteMode(isWeakConnection: boolean): LiteModeDecision {
  const rule = ruleApplies('R13', { isWeakConnection })
  return {
    lite: rule !== null,
    hideDecorativeFoliage: rule?.action.hideDecorativeFoliage === true,
    showSubmissionWarning: rule?.action.showSubmissionWarning === true,
  }
}

/** R14: minutos de inactividad antes de preguntar "¿Sigues ahí?" (null si la regla está apagada). */
export function getInactivityRule(): { minutes: number; message: string } | null {
  const rule = getRule('R14')
  const minutes = getNumber(rule?.condition.value)
  if (!rule || minutes === null) return null
  return { minutes, message: getString(rule.action.message) ?? '¿Sigues ahí?' }
}

/** R14: ¿ya pasó el límite de inactividad? */
export function isInactive(inactiveMinutes: number): boolean {
  return ruleApplies('R14', { inactiveMinutes }) !== null
}
