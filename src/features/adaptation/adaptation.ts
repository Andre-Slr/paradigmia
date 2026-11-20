/**
 * Motor de adaptación de Paradigmia.
 *
 * Funciones puras (no consultan la base de datos) que reciben el perfil del
 * estudiante y los cursos publicados en Supabase, y deciden qué cursos
 * recomendar, en qué lección empezar y qué ayudas mostrar. Cada regla lleva un
 * identificador (R1, R2...) que coincide con adaptationRules.json.
 */
import { questions } from '@/features/onboarding/questions'
import type { Answers } from '@/features/onboarding/types'
import {
  normalizeLanguage as normalizeRuleLanguage,
  normalizeLevel,
  runJsonAdaptationEngine,
} from './ruleInterpreter'
import type { SessionBudget } from './ruleInterpreter'

/** Los cursos y los estudiantes usan los mismos 3 niveles. */
export type Nivel = 'basico' | 'intermedio' | 'avanzado'

/** Lo mínimo que el motor necesita saber de un curso (coincide con la tabla courses). */
export interface AdaptableCourse {
  id: string
  title: string
  language: string | null
  level: string | null
}

export interface DiagnosticResult {
  lenguaje: string
  aciertos: number
  total: number
}

export interface LearnerProfile {
  nivel: Nivel | null
  experienciaAnswer: string | null
  intereses: string[]
  lenguaje: string | null
  diagnostico: DiagnosticResult | null
  /** Tiempo que estudia por sesión (R9–R11). */
  tiempoSesion: SessionBudget | null
}

export interface Recommendation<C extends AdaptableCourse> {
  course: C
  reasons: string[]
  score: number
}

const SESSION_BUDGETS: SessionBudget[] = ['<10', '10-20', '>20']

/** Convierte el lenguaje guardado en Supabase ("Python", "C++"...) a la clave del cuestionario. */
export function normalizeLanguage(language: string | null): string | null {
  return normalizeRuleLanguage(language)
}

/** Convierte el nivel guardado en Supabase ("Principiante", "Intermedio"...) a un Nivel. */
export function normalizeNivel(level: string | null): Nivel {
  return normalizeLevel(level)
}

function sameAnswer(answer: unknown, correct: string | string[]): boolean {
  if (Array.isArray(correct)) {
    if (!Array.isArray(answer) || answer.length !== correct.length) return false
    return correct.every((value) => answer.includes(value))
  }
  return answer === correct
}

/** Califica las preguntas de diagnóstico que el estudiante respondió. */
export function scoreDiagnostic(answers: Answers): DiagnosticResult | null {
  const lenguaje = typeof answers.lenguaje === 'string' ? answers.lenguaje : null
  const answered = questions.filter(
    (question) =>
      question.section === 'diagnostico' &&
      question.correct !== undefined &&
      question.id in answers,
  )

  if (!lenguaje || answered.length === 0) return null

  const aciertos = answered.filter((question) =>
    sameAnswer(answers[question.id], question.correct!),
  ).length

  return { lenguaje, aciertos, total: answered.length }
}

/** Aciertos del diagnóstico en escala de 0 a 10, como los esperan R5 y R16. */
function diagnosticOutOfTen(diag: DiagnosticResult | null): number | null {
  return diag && diag.total > 0 ? (diag.aciertos / diag.total) * 10 : null
}

function engineInput(profile: LearnerProfile) {
  return {
    experienceAnswer: profile.experienciaAnswer,
    initialLevel: profile.nivel,
    interests: profile.intereses,
    preferredLanguage: profile.lenguaje,
  }
}

/** R1 + R16: arma el perfil del estudiante a partir de su cuestionario inicial. */
export function buildLearnerProfile(
  answers: Answers | null,
  nivelGuardado?: string | null,
): LearnerProfile {
  const experiencia = typeof answers?.experiencia === 'string' ? answers.experiencia : ''
  const tiempo = typeof answers?.tiempo === 'string' ? answers.tiempo : null
  const diagnostico = answers ? scoreDiagnostic(answers) : null

  const base: LearnerProfile = {
    nivel: nivelGuardado ? normalizeNivel(nivelGuardado) : null,
    experienciaAnswer: experiencia || null,
    intereses: Array.isArray(answers?.intereses) ? answers.intereses : [],
    lenguaje: typeof answers?.lenguaje === 'string' ? answers.lenguaje : null,
    diagnostico,
    tiempoSesion: SESSION_BUDGETS.includes(tiempo as SessionBudget) ? (tiempo as SessionBudget) : null,
  }

  if (!base.experienciaAnswer) return base

  // El nivel se recalcula con las reglas para que coincida siempre con el cuestionario.
  const { computedLevel } = runJsonAdaptationEngine({
    ...engineInput(base),
    diagnosticScore: diagnosticOutOfTen(diagnostico),
    courses: [],
  })
  return { ...base, nivel: computedLevel }
}

/** Nivel que se guarda en perfiles.nivel al terminar el cuestionario (R1 + R16). */
export function computeLevelFromAnswers(answers: Answers): Nivel | null {
  return buildLearnerProfile(answers).nivel
}

/** R1–R4, R15 y R16: decide qué cursos recomendar y explica por qué. */
export function recommendCourses<C extends AdaptableCourse>(
  profile: LearnerProfile,
  catalog: C[],
  completedCourses: AdaptableCourse[] = [],
): Recommendation<C>[] {
  const { recommendedCourses } = runJsonAdaptationEngine({
    ...engineInput(profile),
    diagnosticScore: diagnosticOutOfTen(profile.diagnostico),
    courses: catalog,
    completedCourses,
  })

  return recommendedCourses
}

export type LessonTag = 'repaso' | 'sugerida'

export interface CoursePlan {
  /** Lección en la que conviene empezar, o null si no hay lecciones. */
  startLessonId: string | null
  /** Etiquetas por lección para mostrar en la vista del curso. */
  tags: Record<string, LessonTag>
  /** Mensaje que explica la adaptación al estudiante, si la hay. */
  message: string | null
}

/**
 * R5 · Diagnóstico: si el estudiante acertó al menos el 80 % del diagnóstico
 * del lenguaje del curso, se le sugiere empezar en la segunda lección y la
 * primera queda como repaso opcional.
 */
export function planCourse(
  course: AdaptableCourse,
  lessons: Array<{ id: string; title: string | null }>,
  profile: LearnerProfile,
): CoursePlan {
  const [first, second] = lessons
  const diag = profile.diagnostico

  if (!first) return { startLessonId: null, tags: {}, message: null }

  const matchingDiagnostic =
    diag !== null &&
    diag.total > 0 &&
    normalizeLanguage(course.language) === normalizeLanguage(diag.lenguaje)
  const { suggestedStartLesson } = runJsonAdaptationEngine({
    ...engineInput(profile),
    diagnosticScore: matchingDiagnostic ? diagnosticOutOfTen(diag) : null,
    courses: [course],
  })

  if (diag && matchingDiagnostic && second) {
    if (suggestedStartLesson === 2) {
      return {
        startLessonId: second.id,
        tags: { [first.id]: 'repaso', [second.id]: 'sugerida' },
        message: `Acertaste ${diag.aciertos} de ${diag.total} preguntas del diagnóstico, así que puedes empezar en "${second.title ?? 'la lección 2'}". La primera lección queda como repaso.`,
      }
    }
    return {
      startLessonId: first.id,
      tags: { [first.id]: 'sugerida' },
      message: `Acertaste ${diag.aciertos} de ${diag.total} preguntas del diagnóstico. Te sugerimos empezar desde la primera lección para reforzar las bases.`,
    }
  }

  return { startLessonId: first.id, tags: {}, message: null }
}

/**
 * R5 aplicado a la ruta: si el diagnóstico permite empezar en la lección 2,
 * la lección 1 y su actividad dejan de bloquear lo que sigue (quedan como
 * repaso opcional). En la página de un paso de repaso se usa la ruta completa.
 */
export function pathForStudent<S extends { id: string; type: string; title: string; lessonId?: string }>(
  sequence: S[],
  course: AdaptableCourse | null,
  profile: LearnerProfile,
  currentStepId?: string | null,
): S[] {
  if (!course) return sequence
  const lessons = sequence
    .filter((step) => step.type === 'lesson')
    .map((step) => ({ id: step.id, title: step.title }))
  const { tags } = planCourse(course, lessons, profile)
  const optional = new Set(
    Object.entries(tags)
      .filter(([, tag]) => tag === 'repaso')
      .map(([lessonId]) => lessonId),
  )
  if (optional.size === 0) return sequence

  const path = sequence.filter((step) => !step.lessonId || !optional.has(step.lessonId))
  if (currentStepId && !path.some((step) => step.id === currentStepId)) return sequence
  return path
}

/**
 * R6 · Ayudas para principiantes: los bloques de tipo "principiante" de una
 * lección se muestran abiertos a quien está en nivel básico y cerrados (con un
 * botón para abrirlos) a quien ya tiene más experiencia.
 */
export function showBeginnerHelp(profile: LearnerProfile): boolean {
  return runJsonAdaptationEngine({
    ...engineInput(profile),
    diagnosticScore: diagnosticOutOfTen(profile.diagnostico),
    courses: [],
  }).openHintsByDefault
}
