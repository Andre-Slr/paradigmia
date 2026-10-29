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

const ORDEN_NIVEL: Nivel[] = ['principiante', 'basico', 'intermedio', 'avanzado']

const NOMBRE_INTERES: Record<string, string> = {
  web: 'las páginas web',
  videojuegos: 'los videojuegos',
  apps: 'las aplicaciones',
  circuitos: 'los circuitos',
  automatizacion: 'la automatización de tareas',
}

/** R2: lenguajes con los que se relaciona cada interés del cuestionario. */
const LENGUAJES_POR_INTERES: Record<string, string[]> = {
  web: ['html', 'css', 'javascript', 'php'],
  videojuegos: ['python', 'javascript', 'cpp'],
  apps: ['java', 'javascript', 'python'],
  circuitos: ['c', 'cpp', 'python'],
  automatizacion: ['python'],
}

export const NOMBRE_LENGUAJE: Record<string, string> = {
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
  if (value.includes('básico') || value.includes('basico')) return 'basico'
  return 'principiante'
}

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
    nivel: esNivel(nivelGuardado) ? nivelGuardado : nivelDerivado ?? null,
    intereses: Array.isArray(answers?.intereses) ? answers.intereses : [],
    lenguaje: typeof answers?.lenguaje === 'string' ? answers.lenguaje : null,
    diagnostico: answers ? scoreDiagnostic(answers) : null,
  }
}

/** R2, R3 y R4: decide qué cursos recomendar y explica por qué. */
export function recommendCourses<C extends AdaptableCourse>(
  profile: LearnerProfile,
  catalog: C[],
): Recommendation<C>[] {
  const nivelUsuario = ORDEN_NIVEL.indexOf(profile.nivel ?? 'principiante')
  const recommendations: Recommendation<C>[] = []

  for (const course of catalog) {
    const lenguaje = normalizeLanguage(course.language)
    const reasons: string[] = []
    let score = 0

    // R4 · Nivel: no se recomiendan cursos más de un nivel por encima.
    const gap = ORDEN_NIVEL.indexOf(normalizeNivel(course.level)) - nivelUsuario
    if (gap > 1) continue

    // R2 · Intereses: solo se preguntan a quien apenas empieza.
    for (const interes of profile.intereses) {
      if (lenguaje && LENGUAJES_POR_INTERES[interes]?.includes(lenguaje)) {
        reasons.push(`Te interesan ${NOMBRE_INTERES[interes] ?? interes}`)
        score += 2
      }
    }

    // R3 · Lenguaje elegido en el cuestionario.
    if (profile.lenguaje && lenguaje === profile.lenguaje) {
      reasons.push(`Elegiste aprender ${NOMBRE_LENGUAJE[profile.lenguaje] ?? profile.lenguaje}`)
      score += 3
    }

    if (score === 0) continue

    if (gap >= -1) {
      reasons.push('Va de acuerdo con tu nivel')
      score += 1
    } else {
      reasons.push('Te sirve como repaso de los fundamentos')
    }

    recommendations.push({ course, reasons, score })
  }

  // R4 (respaldo) · Si nada coincidió, por ejemplo porque el lenguaje elegido
  // aún no tiene curso, se recomiendan los cursos de nivel inicial.
  if (recommendations.length === 0) {
    const pendiente = profile.lenguaje ? NOMBRE_LENGUAJE[profile.lenguaje] : null
    for (const course of catalog) {
      if (ORDEN_NIVEL.indexOf(normalizeNivel(course.level)) > 1) continue
      recommendations.push({
        course,
        reasons: [
          pendiente
            ? `Mientras preparamos el curso de ${pendiente}, este te da bases que te servirán`
            : 'Es un buen punto de partida para empezar a programar',
        ],
        score: 0,
      })
    }
  }

  // El orden del catálogo se respeta entre cursos con el mismo puntaje.
  return recommendations.sort((a, b) => b.score - a.score)
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

  if (diag && second && normalizeLanguage(course.language) === diag.lenguaje) {
    if (diag.aciertos / diag.total >= UMBRAL_DOMINIO) {
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
  return profile.nivel === null || profile.nivel === 'principiante' || profile.nivel === 'basico'
}
