import { useEffect, useMemo, useState } from 'react'
import { Link, useParams } from 'react-router-dom'
import AppShell from '@/components/layout/AppShell'
import { languageIcons } from '@/features/onboarding/languageIcons'
import { planCourse } from '@/features/adaptation/adaptation'
import { useLearnerProfile } from '@/features/adaptation/useLearnerProfile'
import { findNextStep, planStudySession, type SessionPlan } from '@/features/adaptation/ruleInterpreter'
import '@/features/adaptation/adaptation.css'
import {
  buildCourseLearningSequence,
  createCourseEnrollment,
  getAssessmentAttemptsForEnrollment,
  getCourseAcademicProgressForEnrollment,
  getCourseEnrollment,
  getPublishedCourseAssessments,
  getPublishedCourseBySlug,
  getPublishedCourseLessons,
  type PublishedAssessmentRecord,
  type PublishedCourseRecord,
  type PublishedLessonRecord,
} from './courseService'

interface CourseDetailPageProps {
  user: {
    id: string
    email?: string | null
  }
  onLogout: () => Promise<string | null>
}

function normalizeLanguageKey(language: string | null): string {
  const normalized = (language ?? '').trim().toLowerCase()

  if (!normalized) return 'javascript'
  if (normalized.includes('python')) return 'python'
  if (normalized.includes('javascript') || normalized.includes('js')) return 'javascript'
  if (normalized.includes('html')) return 'html'
  if (normalized.includes('css')) return 'css'
  if (normalized.includes('java')) return 'java'
  if (normalized.includes('php')) return 'php'
  if (normalized.includes('c++') || normalized.includes('cpp')) return 'cpp'
  if (normalized.includes('c ')) return 'c'
  if (normalized.includes('c')) return 'c'

  return 'javascript'
}

function normalizeLevel(level: string | null): string {
  const normalized = (level ?? '').trim().toLowerCase()

  if (normalized.includes('principiante') || normalized.includes('beginner')) return 'Principiante'
  if (normalized.includes('básico') || normalized.includes('basic')) return 'Básico'
  if (normalized.includes('intermedio') || normalized.includes('intermediate')) return 'Intermedio'
  if (normalized.includes('avanzado') || normalized.includes('advanced')) return 'Avanzado'

  return 'Principiante'
}

function formatDuration(weeks: number | null): string | null {
  if (weeks === null || weeks === undefined) return null
  return `${weeks} semana${weeks === 1 ? '' : 's'}`
}

function getAssessmentKind(assessment: Pick<PublishedAssessmentRecord, 'kind' | 'type'>): string {
  return ((assessment.kind ?? assessment.type ?? '') as string).trim().toLowerCase()
}

function isExamAssessment(assessment: Pick<PublishedAssessmentRecord, 'kind' | 'type'>): boolean {
  const kind = getAssessmentKind(assessment)
  return kind === 'exam' || kind === 'final' || kind === 'evaluacion' || kind === 'evaluación'
}

export default function CourseDetailPage({ user, onLogout }: CourseDetailPageProps) {
  const { courseId } = useParams()
  const [course, setCourse] = useState<PublishedCourseRecord | null>(null)
  const [lessons, setLessons] = useState<PublishedLessonRecord[]>([])
  const [assessments, setAssessments] = useState<PublishedAssessmentRecord[]>([])
  const [isEnrolled, setIsEnrolled] = useState(false)
  const [enrollmentCourseId, setEnrollmentCourseId] = useState<string | null>(null)
  const [enrollmentLoading, setEnrollmentLoading] = useState(true)
  const [enrollmentSubmitting, setEnrollmentSubmitting] = useState(false)
  const [enrollmentError, setEnrollmentError] = useState<string | null>(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [continueLearningState, setContinueLearningState] = useState<{
    courseId: string
    target: string
    sessionPlan: SessionPlan | null
  } | null>(null)
  const [completedActivityIds, setCompletedActivityIds] = useState<string[]>([])
  const currentIsEnrolled = Boolean(course && enrollmentCourseId === course.id && isEnrolled)
  const currentEnrollmentLoading = Boolean(
    course && (enrollmentCourseId !== course.id || enrollmentLoading),
  )
  const currentEnrollmentError =
    course && enrollmentCourseId === course.id ? enrollmentError : null
  const continueLearningTarget =
    course && continueLearningState?.courseId === course.id
      ? continueLearningState.target
      : null
  const sessionPlan =
    course && continueLearningState?.courseId === course.id
      ? continueLearningState.sessionPlan
      : null

  useEffect(() => {
    if (!courseId) {
      return
    }

    const currentCourseId = courseId as string
    let active = true

    async function loadCourseDetail() {
      try {
        setLoading(true)
        setError(null)

        const courseData = await getPublishedCourseBySlug(currentCourseId)

        if (!active) return

        if (!courseData) {
          setCourse(null)
          setLessons([])
          setAssessments([])
          return
        }

        setCourse(courseData)

        const [courseLessonsData, courseAssessmentData] = await Promise.all([
          getPublishedCourseLessons(courseData.id),
          getPublishedCourseAssessments(courseData.id),
        ])

        if (!active) return

        setLessons(courseLessonsData)
        setAssessments(courseAssessmentData)
      } catch (loadError) {
        if (!active) return
        const message =
          loadError instanceof Error
            ? loadError.message
            : 'No se pudo cargar la información del curso en este momento.'
        setError(message)
        setCourse(null)
        setLessons([])
        setAssessments([])
      } finally {
        if (active) {
          setLoading(false)
        }
      }
    }

    void loadCourseDetail()

    return () => {
      active = false
    }
  }, [courseId])

  useEffect(() => {
    if (!course || !user?.id) {
      return
    }

    const currentCourseId = course.id
    let active = true

    async function loadEnrollmentStatus() {
      try {
        setEnrollmentLoading(true)
        setEnrollmentError(null)

        const existingEnrollment = await getCourseEnrollment(user.id, currentCourseId)

        if (!active) return
        setEnrollmentCourseId(currentCourseId)
        setIsEnrolled(Boolean(existingEnrollment))

        if (existingEnrollment) {
          const academicProgress = await getCourseAcademicProgressForEnrollment(existingEnrollment.id, currentCourseId)
          if (!active) return
          setCompletedActivityIds(academicProgress.passedActivityIds ?? [])
        } else {
          setCompletedActivityIds([])
        }
      } catch (loadError) {
        if (!active) return
        setEnrollmentCourseId(currentCourseId)
        setEnrollmentError(
          loadError instanceof Error
            ? loadError.message
            : 'No se pudo comprobar tu inscripción en este curso.'
        )
        setIsEnrolled(false)
        setCompletedActivityIds([])
      } finally {
        if (active) {
          setEnrollmentLoading(false)
        }
      }
    }

    void loadEnrollmentStatus()

    return () => {
      active = false
    }
  }, [course, user?.id])

  const normalizedLanguageKey = useMemo(() => normalizeLanguageKey(course?.language ?? null), [course?.language])
  const displayLevel = useMemo(() => normalizeLevel(course?.level ?? null), [course?.level])
  const durationLabel = useMemo(() => formatDuration(course?.duration_weeks ?? null), [course?.duration_weeks])

  // Motor de adaptación, regla R5: punto de inicio según el diagnóstico.
  const { profile: learnerProfile } = useLearnerProfile(user.id)
  const coursePlan = useMemo(
    () => (course ? planCourse(course, lessons, learnerProfile) : null),
    [course, lessons, learnerProfile],
  )
  const learningSequence = useMemo(() => {
    if (!course) {
      return []
    }

    return buildCourseLearningSequence(lessons, assessments, course.slug)
  }, [assessments, course, lessons])

  useEffect(() => {
    if (!course || !user?.id || !currentIsEnrolled) {
      return
    }

    const currentCourseId = course.id
    const currentCourseSlug = course.slug
    let active = true

    async function loadContinueSequence() {
      try {
        const enrollment = await getCourseEnrollment(user.id, currentCourseId)
        const [academicProgress, attempts] = enrollment
          ? await Promise.all([
              getCourseAcademicProgressForEnrollment(enrollment.id, currentCourseId),
              getAssessmentAttemptsForEnrollment(enrollment.id, currentCourseId),
            ])
          : [null, []]
        if (!active) return

        const safeProgress: { completedLessonIds: string[]; passedActivityIds: string[]; examPassed: boolean } = academicProgress ?? {
          completedLessonIds: [],
          passedActivityIds: [],
          examPassed: false,
        }

        // R5: si el diagnóstico permite saltar la primera lección, sus pasos quedan como repaso opcional.
        const optionalLessonIds = new Set(
          Object.entries(coursePlan?.tags ?? {})
            .filter(([, tag]) => tag === 'repaso')
            .map(([lessonId]) => lessonId),
        )
        const pathSequence = learningSequence.filter(
          (step) => !step.lessonId || !optionalLessonIds.has(step.lessonId),
        )

        // R7: siguiente paso. R8–R11: plan de hoy según intentos y tiempo por sesión.
        const nextStep = findNextStep(pathSequence, safeProgress)
        const plan = planStudySession(pathSequence, safeProgress, attempts, learnerProfile.tiempoSesion)

        setContinueLearningState({
          courseId: currentCourseId,
          target: plan.steps[0]?.url ?? nextStep?.url ?? `/courses/${currentCourseSlug}`,
          sessionPlan: plan,
        })
      } catch {
        if (!active) return
        setContinueLearningState({
          courseId: currentCourseId,
          target: `/courses/${currentCourseSlug}`,
          sessionPlan: null,
        })
      }
    }

    void loadContinueSequence()

    return () => {
      active = false
    }
  }, [course, coursePlan, currentIsEnrolled, learningSequence, learnerProfile.tiempoSesion, user?.id])

  const activities = useMemo(() => {
    return assessments.filter((assessment) => !isExamAssessment(assessment))
  }, [assessments])

  const finalExam = useMemo(() => {
    return assessments.find((assessment) => isExamAssessment(assessment)) ?? null
  }, [assessments])

  async function handleEnrollment(): Promise<void> {
    if (!course?.id || !user?.id) {
      setEnrollmentError('No se pudo completar la inscripción porque faltan datos del usuario o del curso.')
      return
    }

    try {
      setEnrollmentSubmitting(true)
      setEnrollmentError(null)

      const existingEnrollment = await getCourseEnrollment(user.id, course.id)
      if (existingEnrollment) {
        setEnrollmentCourseId(course.id)
        setIsEnrolled(true)
        return
      }

      await createCourseEnrollment(user.id, course.id)
      setEnrollmentCourseId(course.id)
      setIsEnrolled(true)
    } catch (submitError) {
      if (course) setEnrollmentCourseId(course.id)
      setEnrollmentError(
        submitError instanceof Error
          ? submitError.message
          : 'No se pudo completar la inscripción en este momento.'
      )
    } finally {
      setEnrollmentSubmitting(false)
    }
  }

  async function handleLogout(): Promise<string | null> {
    return onLogout()
  }

  if (!courseId) {
    return (
      <AppShell onLogout={handleLogout}>
        <div className="student-empty-state student-detail-empty">
          <h2>No se pudo cargar el curso</h2>
          <p>No se recibió una referencia válida del curso.</p>
          <Link to="/courses" className="student-back-link">
            Volver al catálogo
          </Link>
        </div>
      </AppShell>
    )
  }

  if (loading) {
    return (
      <AppShell onLogout={handleLogout}>
        <div className="student-empty-state student-detail-empty">
          <h2>Cargando curso</h2>
          <p>Estamos consultando la información publicada del curso en Supabase.</p>
        </div>
      </AppShell>
    )
  }

  if (error) {
    return (
      <AppShell onLogout={handleLogout}>
        <div className="student-empty-state student-detail-empty">
          <h2>No se pudo cargar el curso</h2>
          <p>{error}</p>
          <Link to="/courses" className="student-back-link">
            Volver al catálogo
          </Link>
        </div>
      </AppShell>
    )
  }

  if (!course) {
    return (
      <AppShell onLogout={handleLogout}>
        <div className="student-empty-state student-detail-empty">
          <h2>Curso no disponible</h2>
          <p>El curso que estás buscando no existe o aún no está publicado.</p>
          <Link to="/courses" className="student-back-link">
            Volver al catálogo
          </Link>
        </div>
      </AppShell>
    )
  }

  return (
    <AppShell onLogout={handleLogout}>
      <div className="student-course-detail">
        <div className="student-course-detail-header">
          <div>
            <p className="student-catalog-kicker">Curso</p>
            <h1>{course.title}</h1>
          </div>
          <Link to="/courses" className="student-back-link">
            Volver al catálogo
          </Link>
        </div>

        <article className="student-course-detail-card">
          <div className="student-catalog-card-top">
            <div className="student-language-icon" aria-label={course.language ?? 'curso'}>
              <img src={languageIcons[normalizedLanguageKey]} alt={course.language ?? 'curso'} />
            </div>
            <span className="student-course-level">{displayLevel}</span>
          </div>

          <div className="student-course-detail-body">
            <p>{course.description ?? 'Sin descripción disponible.'}</p>

            <div className="student-catalog-meta">
              {durationLabel && <span>{durationLabel}</span>}
              {lessons.length > 0 && <span>{lessons.length} lecciones</span>}
              {course.language && <span>{course.language}</span>}
            </div>

            <div className="student-course-enrollment-block">
              {currentEnrollmentError && <p className="student-form-error">{currentEnrollmentError}</p>}
              {currentIsEnrolled && continueLearningTarget ? (
                <Link to={continueLearningTarget} className="student-catalog-action student-catalog-link">
                  Continuar aprendizaje
                </Link>
              ) : (
                <button
                  type="button"
                  className="student-catalog-action student-catalog-link"
                  onClick={() => void handleEnrollment()}
                  disabled={enrollmentSubmitting || currentEnrollmentLoading}
                >
                  {enrollmentSubmitting
                    ? 'Procesando...'
                    : currentEnrollmentLoading
                      ? 'Comprobando inscripción...'
                      : currentIsEnrolled
                        ? 'Ya estás inscrito'
                        : 'Inscribirme al curso'}
                </button>
              )}
            </div>
          </div>
        </article>

        <section className="student-course-lesson-panel">
          <div className="student-course-detail-section-header">
            <h2>Lecciones</h2>
            <span>{lessons.length} disponibles</span>
          </div>

          {sessionPlan && sessionPlan.steps.length > 0 && (
            <div
              className={`student-session-plan ${sessionPlan.review ? 'is-review' : ''}`}
              role="note"
              aria-label="Tu plan para hoy"
            >
              <strong>{sessionPlan.review ? 'Repaso antes de continuar' : 'Tu plan para hoy'}</strong>
              {sessionPlan.message && <p>{sessionPlan.message}</p>}
              <ol className="student-session-steps">
                {sessionPlan.steps.map((step, index) => (
                  <li key={step.id}>
                    <Link to={step.url} className="student-session-step">
                      <span className="student-session-step-number">{index + 1}</span>
                      <span className="student-session-step-title">{step.title}</span>
                      <span className="student-session-step-type">
                        {step.type === 'lesson' ? 'Lección' : step.type === 'activity' ? 'Actividad' : 'Examen'}
                      </span>
                    </Link>
                  </li>
                ))}
              </ol>
            </div>
          )}

          {coursePlan?.message && (
            <div className="student-adaptive-note" role="note">
              <span aria-hidden="true">🎯</span>
              <span>{coursePlan.message}</span>
            </div>
          )}

          {lessons.length === 0 ? (
            <div className="student-empty-state">
              <h2>Contenido aún no disponible</h2>
              <p>Este curso todavía no tiene lecciones publicadas. En esta etapa sigue siendo un contenido provisional.</p>
            </div>
          ) : (
            <div className="student-course-lesson-list">
              {lessons.map((lesson, index) => {
                const lessonIdentifier = lesson.slug ?? lesson.id
                const tag = coursePlan?.tags[lesson.id]

                return (
                  <Link
                    key={lesson.id}
                    className="student-lesson-item"
                    to={`/courses/${course.slug}/lessons/${lessonIdentifier}`}
                  >
                    <div className="student-lesson-number">0{index + 1}</div>
                    <div className="student-lesson-copy">
                      <strong>{lesson.title ?? `Lección ${index + 1}`}</strong>
                      <span>{lesson.objective ?? lesson.description ?? 'Objetivo no disponible.'}</span>
                    </div>
                    {tag && (
                      <span className={`student-lesson-tag is-${tag}`}>
                        {tag === 'sugerida' ? 'Empieza aquí' : 'Repaso opcional'}
                      </span>
                    )}
                  </Link>
                )
              })}
            </div>
          )}
        </section>

        <section className="student-course-lesson-panel">
          <div className="student-course-detail-section-header">
            <h2>Actividades</h2>
            <span>{activities.length} disponibles</span>
          </div>

          {activities.length === 0 ? (
            <div className="student-empty-state">
              <h2>Actividades aún no disponibles</h2>
              <p>Este curso no tiene actividades publicadas todavía.</p>
            </div>
          ) : (
            <div className="student-course-lesson-list">
              {activities.map((activity, index) => {
                const activityIdentifier = activity.slug ?? activity.id
                const isCompletedActivity = completedActivityIds.includes(activity.id)

                return (
                  <Link
                    key={activity.id}
                    className="student-lesson-item"
                    to={`/courses/${course.slug}/activities/${activityIdentifier}`}
                  >
                    <div className="student-lesson-number">A{index + 1}</div>
                    <div className="student-lesson-copy">
                      <strong>{activity.title ?? `Actividad ${index + 1}`}</strong>
                      <span>{activity.description ?? 'Actividad publicada en Supabase.'}</span>
                      {isCompletedActivity && (
                        <span style={{ display: 'inline-flex', alignItems: 'center', gap: '0.35rem', color: '#19350C', fontWeight: 700, marginTop: '0.35rem' }}>
                          ✓ Completada
                        </span>
                      )}
                    </div>
                  </Link>
                )
              })}
            </div>
          )}
        </section>

        <section className="student-course-lesson-panel">
          <div className="student-course-detail-section-header">
            <h2>Examen final</h2>
            <span>{finalExam ? 'Disponible' : 'Próximamente'}</span>
          </div>

          {!finalExam ? (
            <div className="student-empty-state">
              <h2>Examen final no disponible</h2>
              <p>Este curso todavía no tiene un examen final publicado.</p>
            </div>
          ) : (
            <Link to={`/courses/${course.slug}/exam`} className="student-lesson-item">
              <div className="student-lesson-number">EF</div>
              <div className="student-lesson-copy">
                <strong>{finalExam.title ?? 'Examen final del curso'}</strong>
                <span>
                  {finalExam.description ?? 'Accede al examen final de este curso.'}
                </span>
              </div>
            </Link>
          )}
        </section>

        <div className="student-course-detail-footer">
          <span>{user.email ?? 'Estudiante'}</span>
        </div>
      </div>
    </AppShell>
  )
}
