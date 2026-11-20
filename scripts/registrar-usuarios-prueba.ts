/**
 * Registra en Supabase a los 15 usuarios de prueba del motor de recomendación.
 *
 * Para cada usuario:
 *   1. Crea la cuenta ya confirmada (no se manda ningún correo).
 *   2. Guarda su cuestionario inicial (onboarding_responses) y su nivel (perfiles).
 *   3. Lo inscribe en cursos y registra su avance: lecciones, actividades y
 *      exámenes aprobados, o intentos reprobados para probar R8.
 *
 * Se puede correr varias veces: si un usuario o un avance ya existe, no se duplica.
 *
 * Cómo correrlo (desde la carpeta paradigmia):
 *   1. Agrega al .env la clave secreta que te pase Andre:
 *        SUPABASE_SERVICE_ROLE_KEY=...
 *   2. bun run usuarios:prueba
 *
 * La clave service_role salta todas las reglas de seguridad: nunca la subas a
 * GitHub y no le pongas el prefijo VITE_ (así nunca llega al navegador).
 */
import { createClient, type SupabaseClient } from '@supabase/supabase-js'
import { questions } from '../src/features/onboarding/questions'
import type { Answers } from '../src/features/onboarding/types'
import { computeLevelFromAnswers } from '../src/features/adaptation/adaptation'
import { courseKey } from '../src/features/adaptation/ruleInterpreter'

const PASSWORD = 'Paradigmia2026!'

/* ------------------------------------------------------------------------- */
/* Datos de los 15 usuarios (los mismos del documento de casos de uso)        */
/* ------------------------------------------------------------------------- */

interface CourseProgress {
  /** Curso como "lenguaje|nivel", igual que las rutas de R15. */
  course: string
  /** completo = todas las lecciones, actividades y el examen aprobados. */
  status: 'completo' | 'en-curso'
  /** Para "en-curso": cuántas lecciones lleva terminadas. */
  lessonsDone?: number
  /** Intentos reprobados en la primera actividad pendiente (3 o más activa R8). */
  failedAttempts?: number
}

interface TestUser {
  nombre: string
  usuario: string
  edad: number
  email: string
  experiencia: 'principiante' | 'basico' | 'previos' | 'varios'
  intereses?: string[]
  lenguaje?: string
  /** Aciertos en el diagnóstico de Python (0 a 10). */
  diagnostico?: number
  tiempo: '<10' | '10-20' | '>20'
  progreso: CourseProgress[]
}

const USERS: TestUser[] = [
  { nombre: 'Ana', usuario: 'ana', edad: 22, email: 'ana.avanzadopython@gmail.com', experiencia: 'varios', lenguaje: 'python', diagnostico: 9, tiempo: '>20',
    progreso: [{ course: 'python|avanzado', status: 'completo' }] },
  { nombre: 'Luis', usuario: 'luis', edad: 19, email: 'luis.webdesdecero@gmail.com', experiencia: 'principiante', intereses: ['web'], tiempo: '10-20',
    progreso: [{ course: 'html|basico', status: 'completo' }, { course: 'css|basico', status: 'en-curso', lessonsDone: 1, failedAttempts: 3 }] },
  { nombre: 'Sofía', usuario: 'sofia', edad: 20, email: 'sofia.videojuegos@gmail.com', experiencia: 'principiante', intereses: ['videojuegos'], tiempo: '<10',
    progreso: [{ course: 'python|basico', status: 'en-curso', lessonsDone: 1 }] },
  { nombre: 'Diego', usuario: 'diego', edad: 24, email: 'diego.circuitos@gmail.com', experiencia: 'principiante', intereses: ['circuitos'], tiempo: '10-20',
    progreso: [{ course: 'c|basico', status: 'completo' }] },
  { nombre: 'Mariana', usuario: 'mariana', edad: 21, email: 'mariana.apps@gmail.com', experiencia: 'principiante', intereses: ['apps'], tiempo: '10-20',
    progreso: [{ course: 'java|basico', status: 'completo' }] },
  { nombre: 'Jorge', usuario: 'jorge', edad: 30, email: 'jorge.automatiza@gmail.com', experiencia: 'principiante', intereses: ['automatizacion', 'web'], tiempo: '>20',
    progreso: [{ course: 'python|basico', status: 'completo' }] },
  { nombre: 'Valeria', usuario: 'valeria', edad: 20, email: 'valeria.basicopython@gmail.com', experiencia: 'basico', lenguaje: 'python', diagnostico: 5, tiempo: '10-20',
    progreso: [{ course: 'python|basico', status: 'en-curso', lessonsDone: 1 }] },
  { nombre: 'Carlos', usuario: 'carlos', edad: 23, email: 'carlos.basicojs@gmail.com', experiencia: 'basico', lenguaje: 'javascript', tiempo: '>20',
    progreso: [{ course: 'javascript|intermedio', status: 'completo' }] },
  { nombre: 'Andrés', usuario: 'andres', edad: 26, email: 'andres.basicocss@gmail.com', experiencia: 'basico', lenguaje: 'css', tiempo: '10-20',
    progreso: [{ course: 'css|basico', status: 'completo' }] },
  { nombre: 'Lucía', usuario: 'lucia', edad: 18, email: 'lucia.basicohtml@gmail.com', experiencia: 'basico', lenguaje: 'html', tiempo: '<10',
    progreso: [{ course: 'html|basico', status: 'completo' }] },
  { nombre: 'Fernanda', usuario: 'fernanda', edad: 25, email: 'fernanda.previosjava@gmail.com', experiencia: 'previos', lenguaje: 'java', tiempo: '10-20',
    progreso: [{ course: 'java|avanzado', status: 'completo' }] },
  { nombre: 'Ricardo', usuario: 'ricardo', edad: 27, email: 'ricardo.previoscpp@gmail.com', experiencia: 'previos', lenguaje: 'cpp', tiempo: '10-20',
    progreso: [{ course: 'cpp|intermedio', status: 'completo' }] },
  { nombre: 'Daniela', usuario: 'daniela', edad: 22, email: 'daniela.previospython@gmail.com', experiencia: 'previos', lenguaje: 'python', diagnostico: 10, tiempo: '>20',
    progreso: [{ course: 'python|intermedio', status: 'completo' }, { course: 'sql|basico', status: 'completo' }] },
  { nombre: 'Emilio', usuario: 'emilio', edad: 28, email: 'emilio.avanzadophp@gmail.com', experiencia: 'varios', lenguaje: 'php', tiempo: '<10',
    progreso: [{ course: 'php|basico', status: 'completo' }] },
  { nombre: 'Paola', usuario: 'paola', edad: 31, email: 'paola.avanzadoc@gmail.com', experiencia: 'varios', lenguaje: 'c', tiempo: '10-20',
    progreso: [{ course: 'c|basico', status: 'completo' }] },
]

/* ------------------------------------------------------------------------- */

/** Respuestas del cuestionario: las primeras N preguntas del diagnóstico bien y el resto mal. */
function buildAnswers(user: TestUser): Answers {
  const answers: Answers = { experiencia: user.experiencia, tiempo: user.tiempo }
  if (user.intereses) answers.intereses = user.intereses
  if (user.lenguaje) answers.lenguaje = user.lenguaje

  if (user.lenguaje === 'python' && user.diagnostico !== undefined) {
    const diagnostic = questions.filter((question) => question.section === 'diagnostico' && question.correct)
    diagnostic.forEach((question, index) => {
      if (index < user.diagnostico!) {
        answers[question.id] = question.correct!
      } else {
        const wrong = question.options?.find((option) => option.value !== question.correct)?.value ?? 'incorrecta'
        answers[question.id] = Array.isArray(question.correct) ? [wrong] : wrong
      }
    })
  }
  return answers
}

function fail(message: string): never {
  console.error(`\n✖ ${message}\n`)
  process.exit(1)
}

async function findUserId(admin: SupabaseClient, email: string): Promise<string | null> {
  for (let page = 1; page < 50; page += 1) {
    const { data, error } = await admin.auth.admin.listUsers({ page, perPage: 200 })
    if (error) throw new Error(error.message)
    const match = data.users.find((item) => item.email?.toLowerCase() === email.toLowerCase())
    if (match) return match.id
    if (data.users.length < 200) return null
  }
  return null
}

async function ensureUser(admin: SupabaseClient, user: TestUser): Promise<{ id: string; created: boolean }> {
  const existing = await findUserId(admin, user.email)
  if (existing) return { id: existing, created: false }

  const { data, error } = await admin.auth.admin.createUser({
    email: user.email,
    password: PASSWORD,
    email_confirm: true,
    user_metadata: { nombre: user.nombre, nombre_usuario: user.usuario, edad: user.edad, usuario_de_prueba: true },
  })
  if (error || !data.user) throw new Error(error?.message ?? 'No se pudo crear el usuario.')
  return { id: data.user.id, created: true }
}

async function saveProfile(admin: SupabaseClient, userId: string, user: TestUser, answers: Answers) {
  const nivel = computeLevelFromAnswers(answers)

  const { error: onboardingError } = await admin
    .from('onboarding_responses')
    .upsert({ user_id: userId, answers, completed_at: new Date().toISOString() }, { onConflict: 'user_id' })
  if (onboardingError) throw new Error(`onboarding_responses: ${onboardingError.message}`)

  // Normalmente un trigger crea la fila de perfiles al registrarse; si no existe, se crea aquí.
  const { data: updated, error: updateError } = await admin
    .from('perfiles')
    .update({ nombre: user.nombre, usuario: user.usuario, nivel })
    .eq('id', userId)
    .select('id')
  if (updateError) throw new Error(`perfiles: ${updateError.message}`)
  if (!updated || updated.length === 0) {
    const { error: insertError } = await admin
      .from('perfiles')
      .insert({ id: userId, nombre: user.nombre, usuario: user.usuario, nivel })
    if (insertError) throw new Error(`perfiles: ${insertError.message}`)
  }
  return nivel
}

interface CourseRow { id: string; title: string; language: string | null; level: string | null }
interface AssessmentRow { id: string; lesson_id: string | null; kind: string | null; position: number | null }

function isExam(assessment: AssessmentRow) {
  const kind = (assessment.kind ?? '').toLowerCase()
  return kind === 'exam' || kind === 'final' || kind === 'evaluacion' || kind === 'evaluación'
}

async function saveProgress(
  admin: SupabaseClient,
  userId: string,
  progress: CourseProgress,
  courses: CourseRow[],
): Promise<string> {
  const course = courses.find((item) => courseKey(item) === progress.course)
  if (!course) return `⚠ no existe un curso "${progress.course}" en Supabase; se omitió`

  const { data: enrollment, error: enrollmentError } = await admin
    .from('enrollments')
    .upsert({ user_id: userId, course_id: course.id }, { onConflict: 'user_id,course_id' })
    .select('id')
    .single()
  if (enrollmentError || !enrollment) throw new Error(`enrollments: ${enrollmentError?.message}`)

  const [{ data: lessons, error: lessonsError }, { data: assessments, error: assessmentsError }, { data: attempts, error: attemptsError }] =
    await Promise.all([
      admin.from('lessons').select('id, position').eq('course_id', course.id).order('position'),
      admin.from('assessments').select('id, lesson_id, kind, position').eq('course_id', course.id).order('position'),
      admin.from('assessment_attempts').select('assessment_id, passed').eq('enrollment_id', enrollment.id),
    ])
  if (lessonsError || assessmentsError || attemptsError) {
    throw new Error(lessonsError?.message ?? assessmentsError?.message ?? attemptsError?.message)
  }

  const allLessons = (lessons ?? []) as Array<{ id: string }>
  const allAssessments = (assessments ?? []) as AssessmentRow[]
  const previous = (attempts ?? []) as Array<{ assessment_id: string; passed: boolean }>
  const lessonsToComplete =
    progress.status === 'completo' ? allLessons : allLessons.slice(0, progress.lessonsDone ?? 0)

  if (lessonsToComplete.length > 0) {
    const { error } = await admin.from('lesson_progress').upsert(
      lessonsToComplete.map((lesson) => ({ enrollment_id: enrollment.id, course_id: course.id, lesson_id: lesson.id })),
      { onConflict: 'enrollment_id,lesson_id', ignoreDuplicates: true },
    )
    if (error) throw new Error(`lesson_progress: ${error.message}`)
  }

  const newAttempts: Array<Record<string, unknown>> = []
  if (progress.status === 'completo') {
    for (const assessment of allAssessments) {
      if (previous.some((attempt) => attempt.assessment_id === assessment.id && attempt.passed)) continue
      newAttempts.push({ enrollment_id: enrollment.id, course_id: course.id, assessment_id: assessment.id, score: 100, passed: true })
    }
  } else if (progress.failedAttempts) {
    const target = allAssessments.find((assessment) => !isExam(assessment))
    if (target) {
      const alreadyFailed = previous.filter((attempt) => attempt.assessment_id === target.id && !attempt.passed).length
      for (let i = alreadyFailed; i < progress.failedAttempts; i += 1) {
        newAttempts.push({ enrollment_id: enrollment.id, course_id: course.id, assessment_id: target.id, score: 40, passed: false })
      }
    }
  }

  if (newAttempts.length > 0) {
    const { error } = await admin.from('assessment_attempts').insert(newAttempts)
    if (error) throw new Error(`assessment_attempts: ${error.message}`)
  }

  const detail =
    progress.status === 'completo'
      ? 'terminado'
      : `${lessonsToComplete.length} lección(es)${progress.failedAttempts ? `, ${progress.failedAttempts} intentos reprobados` : ''}`
  return `${course.title}: ${detail}`
}

async function main() {
  const url = process.env.VITE_SUPABASE_URL
  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY
  if (!url) fail('Falta VITE_SUPABASE_URL en el archivo .env.')
  if (!serviceKey) fail('Falta SUPABASE_SERVICE_ROLE_KEY en el archivo .env (pídesela a Andre).')
  if (serviceKey.startsWith('sb_publishable_')) {
    fail('SUPABASE_SERVICE_ROLE_KEY tiene la clave pública. Necesitas la clave secreta (service_role).')
  }

  const admin = createClient(url, serviceKey, { auth: { persistSession: false, autoRefreshToken: false } })

  const { data: courses, error: coursesError } = await admin.from('courses').select('id, title, language, level')
  if (coursesError) fail(`No se pudieron leer los cursos: ${coursesError.message}`)

  console.log(`\nRegistrando ${USERS.length} usuarios de prueba (contraseña de todos: ${PASSWORD})\n`)
  let failures = 0

  for (const user of USERS) {
    try {
      const { id, created } = await ensureUser(admin, user)
      const answers = buildAnswers(user)
      const nivel = await saveProfile(admin, id, user, answers)
      const details: string[] = []
      for (const item of user.progreso) {
        details.push(await saveProgress(admin, id, item, (courses ?? []) as CourseRow[]))
      }
      console.log(`✔ ${user.nombre.padEnd(9)} ${created ? 'creado   ' : 'ya existía'}  nivel ${nivel}  · ${details.join(' · ')}`)
    } catch (error) {
      failures += 1
      console.log(`✖ ${user.nombre.padEnd(9)} ${error instanceof Error ? error.message : String(error)}`)
    }
  }

  console.log(failures === 0 ? '\nListo. Ya puedes iniciar sesión con cualquiera de los correos.\n' : `\nTerminó con ${failures} error(es). Revisa los mensajes de arriba.\n`)
  if (failures > 0) process.exit(1)
}

void main()
