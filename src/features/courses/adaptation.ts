/**
 * Motor de adaptación de Paradigmia.
 *
 * Funciones puras (sin llamadas a la base de datos) que reciben el perfil del
 * estudiante y deciden qué cursos recomendar, en qué lección empezar y qué
 * ayudas mostrar. Cada regla lleva un identificador (R1, R2...) que coincide
 * con la lista de reglas del documento del proyecto.
 */
import { questions } from '@/features/onboarding/questions'
import type { Answers } from '@/features/onboarding/types'
import type { Course, Nivel } from './types'

export interface DiagnosticResult {
  lenguaje: string
  aciertos: number
  total: number
}

export interface LearnerProfile {
  nivel: Nivel | null
  intereses: string[]
  lenguaje: string | null
  diagnostico: DiagnosticResult | null
}

export interface Recommendation {
  course: Course
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

const ORDEN_NIVEL: Nivel[] = ['principiante', 'basico', 'intermedio', 'avanzado']

export const NOMBRE_NIVEL: Record<Nivel, string> = {
  principiante: 'Principiante',
  basico: 'Básico',
  intermedio: 'Intermedio',
  avanzado: 'Avanzado',
}

const NOMBRE_INTERES: Record<string, string> = {
  web: 'las páginas web',
  videojuegos: 'los videojuegos',
  apps: 'las aplicaciones',
  circuitos: 'los circuitos',
  automatizacion: 'la automatización de tareas',
}

const NOMBRE_LENGUAJE: Record<string, string> = {
  c: 'C',
  cpp: 'C++',
  python: 'Python',
  java: 'Java',
  css: 'CSS',
  html: 'HTML',
  php: 'PHP',
  javascript: 'JavaScript',
}

/** Porcentaje del diagnóstico a partir del cual se considera que domina lo básico. */
export const UMBRAL_DOMINIO = 0.8

function esNivel(value: unknown): value is Nivel {
  return typeof value === 'string' && ORDEN_NIVEL.includes(value as Nivel)
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
    nivel: esNivel(nivelGuardado) ? nivelGuardado : esNivel(nivelDerivado) ? nivelDerivado : null,
    intereses: Array.isArray(answers?.intereses) ? answers.intereses : [],
    lenguaje: typeof answers?.lenguaje === 'string' ? answers.lenguaje : null,
    diagnostico: answers ? scoreDiagnostic(answers) : null,
  }
}

/** Distancia entre el nivel del curso y el del estudiante (positiva = curso más difícil). */
function nivelGap(course: Course, profile: LearnerProfile): number {
  const user = ORDEN_NIVEL.indexOf(profile.nivel ?? 'principiante')
  return ORDEN_NIVEL.indexOf(course.level) - user
}

/** R2, R3 y R4: decide qué cursos recomendar y explica por qué. */
export function recommendCourses(
  profile: LearnerProfile,
  catalog: Course[],
): Recommendation[] {
  const recommendations: Recommendation[] = []

  for (const course of catalog) {
    const reasons: string[] = []
    let score = 0

    // R2 · Intereses: solo se preguntan a quien apenas empieza.
    for (const interes of profile.intereses) {
      if (course.interests.includes(interes)) {
        reasons.push(`Te interesan ${NOMBRE_INTERES[interes] ?? interes}`)
        score += 2
      }
    }

    // R3 · Lenguaje elegido en el cuestionario.
    if (profile.lenguaje && course.languages.includes(profile.lenguaje)) {
      reasons.push(`Elegiste aprender ${NOMBRE_LENGUAJE[profile.lenguaje]}`)
      score += 3
    }

    // R4 · Nivel: no se recomiendan cursos más de un nivel por encima.
    const gap = nivelGap(course, profile)
    if (gap > 1) continue
    if (score > 0 && gap >= -1) {
      reasons.push('Va de acuerdo con tu nivel')
      score += 1
    } else if (score > 0) {
      reasons.push('Te sirve como repaso de los fundamentos')
    }

    if (score > 0) recommendations.push({ course, reasons, score })
  }

  // R4 (respaldo) · Si nada coincidió, por ejemplo porque eligió un lenguaje que
  // todavía no tiene curso, se recomiendan los cursos introductorios.
  if (recommendations.length === 0) {
    const pendiente = profile.lenguaje ? NOMBRE_LENGUAJE[profile.lenguaje] : null
    for (const course of catalog) {
      if (course.level !== 'principiante') continue
      recommendations.push({
        course,
        reasons: [
          pendiente
            ? `Mientras preparamos el curso de ${pendiente}, este curso te da bases que te servirán`
            : 'Es un buen punto de partida para empezar a programar',
        ],
        score: 0,
      })
    }
  }

  return recommendations.sort((a, b) => b.score - a.score)
}

export type LessonTag = 'repaso' | 'sugerida'

export interface CoursePlan {
  /** Lección en la que conviene empezar. */
  startLessonId: string
  /** Etiquetas por lección para mostrar en la vista del curso. */
  tags: Record<string, LessonTag>
  /** Mensaje que explica la adaptación al estudiante, si la hay. */
  message: string | null
}

/**
 * R5 · Diagnóstico: si el estudiante acertó al menos el 80 % del diagnóstico del
 * lenguaje del curso, se le sugiere empezar en la segunda lección y la primera
 * queda como repaso opcional.
 */
export function planCourse(course: Course, profile: LearnerProfile): CoursePlan {
  const first = course.lessons[0]
  const second = course.lessons[1]
  const diag = profile.diagnostico

  if (diag && second && course.languages.includes(diag.lenguaje)) {
    const ratio = diag.aciertos / diag.total
    if (ratio >= UMBRAL_DOMINIO) {
      return {
        startLessonId: second.id,
        tags: { [first.id]: 'repaso', [second.id]: 'sugerida' },
        message: `Acertaste ${diag.aciertos} de ${diag.total} preguntas del diagnóstico, así que puedes empezar en "${second.title}". La primera lección queda como repaso.`,
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
 * R6 · Ayudas para principiantes: los recuadros marcados como "para
 * principiantes" se muestran abiertos a quien está empezando y se ocultan
 * (pero se pueden abrir) a quien ya tiene experiencia.
 */
export function showBeginnerHelp(profile: LearnerProfile): boolean {
  return profile.nivel === null || profile.nivel === 'principiante' || profile.nivel === 'basico'
}

/**
 * R7 · Progreso: la siguiente lección es la primera no completada a partir del
 * punto de inicio sugerido; si ya terminó esas, la primera pendiente del curso.
 */
export function nextLesson(
  course: Course,
  plan: CoursePlan,
  completed: Set<string>,
): { lessonId: string; started: boolean; finished: boolean } {
  const key = (lessonId: string) => `${course.id}/${lessonId}`
  const started = course.lessons.some((lesson) => completed.has(key(lesson.id)))
  const startIndex = Math.max(
    0,
    course.lessons.findIndex((lesson) => lesson.id === plan.startLessonId),
  )
  const pending =
    course.lessons.slice(startIndex).find((lesson) => !completed.has(key(lesson.id))) ??
    course.lessons.find((lesson) => !completed.has(key(lesson.id)))

  return {
    lessonId: pending?.id ?? course.lessons[0].id,
    started,
    finished: !pending,
  }
}
