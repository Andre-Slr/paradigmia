/**
 * Motor de adaptación de Paradigmia.
 *
 * Funciones puras (no consultan la base de datos) que reciben el perfil del
 * estudiante y los cursos publicados en Supabase, y deciden qué cursos
 * recomendar, en qué lección empezar y qué ayudas mostrar. Cada regla lleva un
 * identificador (R1, R2...) que coincide con el documento del proyecto.
 */
import { questions } from '@/features/onboarding/questions'
import type { Answers } from '@/features/onboarding/types'
import { runJsonAdaptationEngine } from './ruleInterpreter'

export type Nivel = 'principiante' | 'basico' | 'intermedio' | 'avanzado'

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
}

export interface Recommendation<C extends AdaptableCourse> {
  course: C
  reasons: string[]
  score: number
}

/** Misma equivalencia que usa useOnboarding al guardar el nivel en el perfil. */
const NIVEL_POR_EXPERIENCIA: Record<string, Nivel> = {
  principiante: 'principiante',
  basico: 'basico',
  previos: 'intermedio',
  varios: 'avanzado',
}

/** Convierte el lenguaje guardado en Supabase ("Python", "C++"...) a la clave del cuestionario. */
export function normalizeLanguage(language: string | null): string | null {
  const value = (language ?? '').trim().toLowerCase()
  if (!value) return null
  if (value.includes('python')) return 'python'
  if (value.includes('javascript') || value === 'js') return 'javascript'
  if (value.includes('html')) return 'html'
  if (value.includes('css')) return 'css'
  if (value.includes('java')) return 'java'
  if (value.includes('php')) return 'php'
  if (value.includes('c++') || value.includes('cpp')) return 'cpp'
  if (value === 'c') return 'c'
  return value
}

/** Convierte el nivel guardado en Supabase ("Básico", "Intermedio"...) a un Nivel. */
export function normalizeNivel(level: string | null): Nivel {
  const value = (level ?? '').trim().toLowerCase()
  if (value.includes('avanz')) return 'avanzado'
  if (value.includes('interm')) return 'intermedio'
  if (value.includes('básico') || value.includes('basico') || value.includes('basic')) return 'basico'
  return 'principiante'
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

/** R1: arma el perfil del estudiante a partir de su cuestionario inicial. */
export function buildLearnerProfile(
  answers: Answers | null,
  nivelGuardado?: string | null,
): LearnerProfile {
  const experiencia = typeof answers?.experiencia === 'string' ? answers.experiencia : ''
  const nivelDerivado = NIVEL_POR_EXPERIENCIA[experiencia]

  return {
    nivel: nivelGuardado ? normalizeNivel(nivelGuardado) : nivelDerivado ?? null,
    experienciaAnswer: experiencia || null,
    intereses: Array.isArray(answers?.intereses) ? answers.intereses : [],
    lenguaje: typeof answers?.lenguaje === 'string' ? answers.lenguaje : null,
    diagnostico: answers ? scoreDiagnostic(answers) : null,
  }
}

/** R1–R4: decide qué cursos recomendar y explica por qué. */
export function recommendCourses<C extends AdaptableCourse>(
  profile: LearnerProfile,
  catalog: C[],
): Recommendation<C>[] {
  const { recommendedCourses } = runJsonAdaptationEngine({
    experienceAnswer: profile.experienciaAnswer,
    initialLevel: profile.nivel,
    interests: profile.intereses,
    preferredLanguage: profile.lenguaje,
    diagnosticScore: null,
    courses: catalog,
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
  const diagnosticScore =
    diag && matchingDiagnostic ? (diag.aciertos / diag.total) * 10 : null
  const { suggestedStartLesson } = runJsonAdaptationEngine({
    experienceAnswer: profile.experienciaAnswer,
    initialLevel: profile.nivel,
    interests: profile.intereses,
    preferredLanguage: profile.lenguaje,
    diagnosticScore,
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
 * R6 · Ayudas para principiantes: los bloques de tipo "principiante" de una
 * lección se muestran abiertos a quien está empezando y cerrados (con un botón
 * para abrirlos) a quien ya tiene experiencia.
 */
export function showBeginnerHelp(profile: LearnerProfile): boolean {
  return runJsonAdaptationEngine({
    experienceAnswer: profile.experienciaAnswer,
    initialLevel: profile.nivel,
    interests: profile.intereses,
    preferredLanguage: profile.lenguaje,
    diagnosticScore: null,
    courses: [],
  }).openHintsByDefault
}
