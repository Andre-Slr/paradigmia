import { useCallback, useEffect, useMemo, useRef, useState } from 'react'
import { Link, useLocation, useNavigate, useParams } from 'react-router-dom'
import AppShell from '@/components/layout/AppShell'
import Toast, { type StudentToastMessage } from '@/components/Toast'
import { getCourseLanguageIcon, normalizeCourseLanguageKey } from './courseLanguage'
import { pathForStudent, planCourse } from '@/features/adaptation/adaptation'
import { useLearnerProfile } from '@/features/adaptation/useLearnerProfile'
import { findNextStep, planStudySession, type SessionPlan } from '@/features/adaptation/ruleInterpreter'
import '@/features/adaptation/adaptation.css'
import {
  buildCourseLearningSequence,
  createCourseEnrollment,
  deleteCourseEnrollment,
  getAssessmentAttemptsForEnrollment,
  getCourseAcademicProgressForEnrollment,
  getCourseEnrollment,
  getBestExamScore,
  getPublishedCourseAssessments,
  getPublishedCourseBySlug,
  getPublishedCourseLessons,
  resetCourseProgress,
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
  const location = useLocation()
  const navigate = useNavigate()
  const confirmationDialogRef = useRef<HTMLDialogElement | null>(null)
  const toastIdRef = useRef(0)
  const [course, setCourse] = useState<PublishedCourseRecord | null>(null)
  const [lessons, setLessons] = useState<PublishedLessonRecord[]>([])
  const [assessments, setAssessments] = useState<PublishedAssessmentRecord[]>([])
  const [isEnrolled, setIsEnrolled] = useState(false)
  const [enrollmentCourseId, setEnrollmentCourseId] = useState<string | null>(null)
  const [enrollmentLoading, setEnrollmentLoading] = useState(true)
  const [enrollmentSubmitting, setEnrollmentSubmitting] = useState(false)
  const [courseActionConfirmation, setCourseActionConfirmation] = useState<'restart' | 'delete' | null>(null)
  const [courseActionSubmitting, setCourseActionSubmitting] = useState(false)
  const [courseToast, setCourseToast] = useState<StudentToastMessage | null>(null)
  const [continueLearningLoading, setContinueLearningLoading] = useState(false)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [continueLearningState, setContinueLearningState] = useState<{
    courseId: string
    target: string | null
    sessionPlan: SessionPlan | null
  } | null>(null)
  const [completedLessonIds, setCompletedLessonIds] = useState<string[]>([])
  const [completedActivityIds, setCompletedActivityIds] = useState<string[]>([])
  const [examPassed, setExamPassed] = useState(false)
  const [finalExamScore, setFinalExamScore] = useState<number | null>(null)
  const [progressRevision, setProgressRevision] = useState(0)
  const routeToast = (location.state as { courseToast?: StudentToastMessage } | null)?.courseToast ?? null
  const visibleToast = routeToast ?? courseToast
  const showToast = useCallback((message: string, type: StudentToastMessage['type']): StudentToastMessage => {
    const toast = { id: ++toastIdRef.current, message, type }
    setCourseToast(toast)
    return toast
  }, [])
  const dismissToast = useCallback(() => {
    setCourseToast(null)
    if (routeToast) {
      navigate(`${location.pathname}${location.search}${location.hash}`, { replace: true, state: null })
    }
  }, [location.hash, location.pathname, location.search, navigate, routeToast])
  const currentIsEnrolled = Boolean(course && enrollmentCourseId === course.id && isEnrolled)
  const currentEnrollmentLoading = Boolean(
    course && (enrollmentCourseId !== course.id || enrollmentLoading),
  )
  const continueLearningTarget =
    course && continueLearningState?.courseId === course.id
      ? continueLearningState.target
      : null
  const sessionPlan =
    course && continueLearningState?.courseId === course.id
      ? continueLearningState.sessionPlan
      : null

  useEffect(() => {
    const dialog = confirmationDialogRef.current
    if (courseActionConfirmation && dialog && !dialog.open) {
      dialog.showModal()
    }
  }, [courseActionConfirmation])

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
        setCompletedLessonIds([])
        setCompletedActivityIds([])
        setExamPassed(false)
        setFinalExamScore(null)

        const existingEnrollment = await getCourseEnrollment(user.id, currentCourseId)

        if (!active) return
        setEnrollmentCourseId(currentCourseId)
        setIsEnrolled(Boolean(existingEnrollment))

        if (existingEnrollment) {
          const [academicProgressResult, examScoreResult] = await Promise.allSettled([
            getCourseAcademicProgressForEnrollment(existingEnrollment.id, currentCourseId),
            getBestExamScore(existingEnrollment.id, currentCourseId),
          ])
          if (!active) return
          if (academicProgressResult.status === 'rejected') {
            throw academicProgressResult.reason
          }

          const academicProgress = academicProgressResult.value
          setCompletedLessonIds(academicProgress.completedLessonIds)
          setCompletedActivityIds(academicProgress.passedActivityIds ?? [])
          setExamPassed(academicProgress.examPassed)
          if (examScoreResult.status === 'fulfilled') {
            setFinalExamScore(examScoreResult.value)
          } else {
            showToast(
              examScoreResult.reason instanceof Error
                ? `No se pudo consultar la nota del examen: ${examScoreResult.reason.message}`
                : 'No se pudo consultar la nota del examen.',
              'error',
            )
          }
        } else {
          setCompletedLessonIds([])
          setCompletedActivityIds([])
          setExamPassed(false)
          setFinalExamScore(null)
        }
      } catch (loadError) {
        if (!active) return
        setEnrollmentCourseId(currentCourseId)
        showToast(
          loadError instanceof Error
            ? loadError.message
            : 'No se pudo comprobar tu inscripción en este curso.',
          'error',
        )
        setIsEnrolled(false)
        setCompletedLessonIds([])
        setCompletedActivityIds([])
        setExamPassed(false)
        setFinalExamScore(null)
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
  }, [course, showToast, user?.id])

  const normalizedLanguageKey = useMemo(
    () => normalizeCourseLanguageKey(course?.language ?? null),
    [course?.language]
  )
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
  const optionalLessonIds = useMemo(
    () =>
      new Set(
        Object.entries(coursePlan?.tags ?? {})
          .filter(([, tag]) => tag === 'repaso')
          .map(([lessonId]) => lessonId),
      ),
    [coursePlan],
  )
  const requiredLearningSequence = useMemo(
    () => learningSequence.filter((step) => !step.lessonId || !optionalLessonIds.has(step.lessonId)),
    [learningSequence, optionalLessonIds],
  )
  const isFinalExamUnlocked =
    currentIsEnrolled &&
    lessons.every((lesson) => completedLessonIds.includes(lesson.id)) &&
    assessments
      .filter((assessment) => !isExamAssessment(assessment))
      .every((activity) => completedActivityIds.includes(activity.id))
  const getBlockingPreviousStep = (stepId: string) => {
    if (!currentIsEnrolled) return null

    const currentStep = learningSequence.find((step) => step.id === stepId)
    if (currentStep?.type === 'exam' && !isFinalExamUnlocked) {
      return learningSequence.find((step) =>
        step.type === 'lesson'
          ? !completedLessonIds.includes(step.id)
          : step.type === 'activity' && !completedActivityIds.includes(step.id),
      ) ?? null
    }

    const studentPath = pathForStudent(learningSequence, course, learnerProfile, stepId)
    const currentIndex = studentPath.findIndex((step) => step.id === stepId)
    if (currentIndex <= 0) return null

    const previousStep = studentPath[currentIndex - 1]
    const isPreviousStepComplete = previousStep.type === 'lesson'
      ? completedLessonIds.includes(previousStep.id)
      : previousStep.type === 'activity'
        ? completedActivityIds.includes(previousStep.id)
        : examPassed

    return isPreviousStepComplete ? null : previousStep
  }
  const completedLessonsCount = lessons.filter((lesson) => completedLessonIds.includes(lesson.id)).length
  const isCourseComplete =
    currentIsEnrolled &&
    !currentEnrollmentLoading &&
    learningSequence.length > 0 &&
    requiredLearningSequence.every((step) =>
      step.type === 'lesson'
        ? completedLessonIds.includes(step.id)
        : step.type === 'activity'
          ? completedActivityIds.includes(step.id)
          : examPassed,
    )

  useEffect(() => {
    if (!course || !user?.id || !currentIsEnrolled) {
      return
    }

    const currentCourseId = course.id
    let active = true

    async function loadContinueSequence() {
      setContinueLearningLoading(true)
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

        // R7: siguiente paso. R8–R11: plan de hoy según intentos y tiempo por sesión.
        const nextStep = findNextStep(requiredLearningSequence, safeProgress)
        const plan = planStudySession(requiredLearningSequence, safeProgress, attempts, learnerProfile.tiempoSesion)

        setContinueLearningState({
          courseId: currentCourseId,
          target: plan.steps[0]?.url ?? nextStep?.url ?? null,
          sessionPlan: plan,
        })
      } catch (loadError) {
        if (!active) return
        setContinueLearningState({
          courseId: currentCourseId,
          target: null,
          sessionPlan: null,
        })
        showToast(
          loadError instanceof Error
            ? loadError.message
            : 'No se pudo determinar el siguiente paso del curso.',
          'error',
        )
      } finally {
        if (active) {
          setContinueLearningLoading(false)
        }
      }
    }

    void loadContinueSequence()

    return () => {
      active = false
    }
  }, [course, currentIsEnrolled, learnerProfile.tiempoSesion, progressRevision, requiredLearningSequence, showToast, user?.id])

  const activities = useMemo(() => {
    return assessments.filter((assessment) => !isExamAssessment(assessment))
  }, [assessments])

  const finalExam = useMemo(() => {
    return assessments.find((assessment) => isExamAssessment(assessment)) ?? null
  }, [assessments])

  async function handleEnrollment(): Promise<void> {
    if (!course?.id || !user?.id) {
      showToast('No se pudo completar la inscripción porque faltan datos del usuario o del curso.', 'error')
      return
    }

    try {
      setEnrollmentSubmitting(true)

      const existingEnrollment = await getCourseEnrollment(user.id, course.id)
      if (existingEnrollment) {
        setEnrollmentCourseId(course.id)
        setIsEnrolled(true)
        return
      }

      await createCourseEnrollment(user.id, course.id)
      setEnrollmentCourseId(course.id)
      setIsEnrolled(true)
      setFinalExamScore(null)
    } catch (submitError) {
      if (course) setEnrollmentCourseId(course.id)
      showToast(
        submitError instanceof Error
          ? submitError.message
          : 'No se pudo completar la inscripción en este momento.',
        'error',
      )
    } finally {
      setEnrollmentSubmitting(false)
    }
  }

  async function handleConfirmedCourseAction(): Promise<void> {
    if (!course || !courseActionConfirmation) {
      return
    }

    try {
      setCourseActionSubmitting(true)

      if (courseActionConfirmation === 'restart') {
        await resetCourseProgress(course.id)
        setCompletedLessonIds([])
        setCompletedActivityIds([])
        setExamPassed(false)
        setFinalExamScore(null)
        setContinueLearningState(null)
        setProgressRevision((revision) => revision + 1)
        setCourseActionConfirmation(null)

        const firstLesson = lessons[0]
        const toast = showToast('Se reinició el progreso del curso.', 'success')
        navigate(
          firstLesson
            ? `/courses/${course.slug}/lessons/${firstLesson.slug ?? firstLesson.id}`
            : `/courses/${course.slug}`,
          { state: { courseToast: toast } },
        )
        return
      }

      await deleteCourseEnrollment(course.id)
      setEnrollmentCourseId(course.id)
      setIsEnrolled(false)
      setCompletedLessonIds([])
      setCompletedActivityIds([])
      setExamPassed(false)
      setFinalExamScore(null)
      setContinueLearningState(null)
      setCourseActionConfirmation(null)
      showToast('Se eliminó tu inscripción y el progreso asociado a este curso.', 'success')
    } catch (actionError) {
      setCourseActionConfirmation(null)
      showToast(
        actionError instanceof Error
          ? actionError.message
          : 'No se pudo completar la acción para este curso.',
        'error',
      )
    } finally {
      setCourseActionSubmitting(false)
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
              <img src={getCourseLanguageIcon(normalizedLanguageKey)} alt={course.language ?? 'curso'} />
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
              {currentIsEnrolled ? (
                <div className="student-course-enrollment-actions">
                  {isCourseComplete ? (
                    <>
                      <p className="student-course-complete-message" role="status">
                        Curso completado
                      </p>
                      <button
                        type="button"
                        className="student-catalog-action student-catalog-link"
                        onClick={() => setCourseActionConfirmation('restart')}
                      >
                        Volver a cursar
                      </button>
                    </>
                  ) : (
                    <>
                      {continueLearningTarget ? (
                        <Link
                          to={continueLearningTarget}
                          className="student-catalog-action student-catalog-link student-course-enrollment-primary"
                        >
                          Continuar aprendizaje
                        </Link>
                      ) : (
                        <button
                          type="button"
                          className="student-catalog-action student-catalog-link student-course-enrollment-primary"
                          disabled
                        >
                          {continueLearningLoading ? 'Calculando siguiente paso...' : 'No hay pasos pendientes'}
                        </button>
                      )}
                      <button
                        type="button"
                        className="student-button-secondary"
                        onClick={() => setCourseActionConfirmation('delete')}
                      >
                        Eliminar registro
                      </button>
                    </>
                  )}
                </div>
              ) : (
                <button
                  type="button"
                  className="student-catalog-action student-catalog-link student-course-enrollment-primary"
                  onClick={() => void handleEnrollment()}
                  disabled={enrollmentSubmitting || currentEnrollmentLoading}
                >
                  {enrollmentSubmitting
                    ? 'Procesando...'
                    : currentEnrollmentLoading
                      ? 'Comprobando inscripción...'
                      : 'Inscribirme al curso'}
                </button>
              )}

              {courseActionConfirmation && (
                <dialog
                  ref={confirmationDialogRef}
                  className="student-course-action-dialog"
                  aria-labelledby="course-action-dialog-title"
                  aria-describedby="course-action-dialog-description"
                  onCancel={(event) => {
                    event.preventDefault()
                    if (!courseActionSubmitting) setCourseActionConfirmation(null)
                  }}
                >
                  <h2 id="course-action-dialog-title">
                    {courseActionConfirmation === 'restart' ? '¿Volver a cursar?' : '¿Eliminar registro?'}
                  </h2>
                  <p id="course-action-dialog-description">
                    {courseActionConfirmation === 'restart'
                      ? 'Al volver a cursar se borrarán el avance de las lecciones y los resultados de actividades y examen. Seguirás inscrito en el curso.'
                      : 'Se eliminará tu inscripción, el avance de las lecciones y los resultados de actividades y examen. Para volver a acceder tendrás que inscribirte de nuevo.'}
                  </p>
                  <div className="student-course-action-dialog-buttons">
                    <button
                      type="button"
                      className="student-button"
                      onClick={() => void handleConfirmedCourseAction()}
                      disabled={courseActionSubmitting}
                    >
                      {courseActionSubmitting
                        ? 'Procesando...'
                        : courseActionConfirmation === 'restart'
                          ? 'Confirmar y volver a cursar'
                          : 'Confirmar eliminación'}
                    </button>
                    <button
                      type="button"
                      className="student-button-secondary"
                      onClick={() => setCourseActionConfirmation(null)}
                      disabled={courseActionSubmitting}
                    >
                      Cancelar
                    </button>
                  </div>
                </dialog>
              )}
            </div>
          </div>
        </article>

        <section className="student-course-lesson-panel">
          <div className="student-course-detail-section-header">
            <h2>Lecciones</h2>
            <span>
              {currentIsEnrolled && lessons.length > 0
                ? `${completedLessonsCount} de ${lessons.length} completadas`
                : `${lessons.length} disponibles`}
            </span>
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
                {sessionPlan.steps.map((step, index) => {
                  const blockingStep = getBlockingPreviousStep(step.id)
                  const stepContent = (
                    <>
                      <span className="student-session-step-number">{index + 1}</span>
                      <span className="student-session-step-title">{step.title}</span>
                      <span className="student-session-step-type">
                        {step.type === 'lesson' ? 'Lección' : step.type === 'activity' ? 'Actividad' : 'Examen'}
                      </span>
                    </>
                  )

                  return (
                    <li key={step.id}>
                      {blockingStep ? (
                        <span
                          className="student-session-step is-locked"
                          aria-disabled="true"
                          title={`Completa primero: ${blockingStep.title}`}
                        >
                          {stepContent}
                        </span>
                      ) : (
                        <Link to={step.url} className="student-session-step">
                          {stepContent}
                        </Link>
                      )}
                    </li>
                  )
                })}
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
                const isCompletedLesson = currentIsEnrolled && completedLessonIds.includes(lesson.id)
                const blockingStep = getBlockingPreviousStep(lesson.id)
                const lessonContent = (
                  <>
                    <div className="student-lesson-number">0{index + 1}</div>
                    <div className="student-lesson-copy">
                      <strong>{lesson.title ?? `Lección ${index + 1}`}</strong>
                      <span>{lesson.objective ?? lesson.description ?? 'Objetivo no disponible.'}</span>
                      {!currentIsEnrolled && (
                        <span className="student-lesson-status is-locked">
                          {currentEnrollmentLoading ? 'Verificando inscripción…' : 'Inscríbete para acceder'}
                        </span>
                      )}
                      {blockingStep && (
                        <span className="student-lesson-status is-locked">
                          Completa primero: {blockingStep.title}
                        </span>
                      )}
                    </div>
                    {(currentIsEnrolled || tag) && (
                      <div className="student-lesson-item-badges">
                        {currentIsEnrolled && (
                          <span className={`student-lesson-status${isCompletedLesson ? '' : ' is-pending'}`}>
                            {isCompletedLesson ? '✓ Completada' : 'Pendiente'}
                          </span>
                        )}
                        {tag && (
                          <span className={`student-lesson-tag is-${tag}`}>
                            {tag === 'sugerida' ? 'Empieza aquí' : 'Repaso opcional'}
                          </span>
                        )}
                      </div>
                    )}
                  </>
                )

                return (
                  currentIsEnrolled && !blockingStep ? (
                    <Link
                      key={lesson.id}
                      className="student-lesson-item"
                      to={`/courses/${course.slug}/lessons/${lessonIdentifier}`}
                    >
                      {lessonContent}
                    </Link>
                  ) : (
                    <div key={lesson.id} className="student-lesson-item is-locked" aria-disabled="true">
                      {lessonContent}
                    </div>
                  )
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
                const isCompletedActivity = currentIsEnrolled && completedActivityIds.includes(activity.id)
                const blockingStep = getBlockingPreviousStep(activity.id)
                const activityContent = (
                  <>
                    <div className="student-lesson-number">A{index + 1}</div>
                    <div className="student-lesson-copy">
                      <strong>{activity.title ?? `Actividad ${index + 1}`}</strong>
                      <span>{activity.description ?? 'Actividad publicada en Supabase.'}</span>
                      {!currentIsEnrolled && (
                        <span className="student-lesson-status is-locked">
                          {currentEnrollmentLoading ? 'Verificando inscripción…' : 'Inscríbete para acceder'}
                        </span>
                      )}
                      {blockingStep && (
                        <span className="student-lesson-status is-locked">
                          Completa primero: {blockingStep.title}
                        </span>
                      )}
                    </div>
                    {isCompletedActivity && (
                      <div className="student-lesson-item-badges">
                        <span className="student-lesson-status">✓ Completada</span>
                      </div>
                    )}
                  </>
                )

                return (
                  currentIsEnrolled && !blockingStep ? (
                    <Link
                      key={activity.id}
                      className="student-lesson-item"
                      to={`/courses/${course.slug}/activities/${activityIdentifier}`}
                    >
                      {activityContent}
                    </Link>
                  ) : (
                    <div key={activity.id} className="student-lesson-item is-locked" aria-disabled="true">
                      {activityContent}
                    </div>
                  )
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
          ) : currentIsEnrolled && isFinalExamUnlocked ? (
            <Link to={`/courses/${course.slug}/exam`} className="student-lesson-item">
              <div className="student-lesson-number">EF</div>
              <div className="student-lesson-copy">
                <strong>{finalExam.title ?? 'Examen final del curso'}</strong>
                <span>{finalExam.description ?? 'Accede al examen final de este curso.'}</span>
              </div>
              {finalExamScore !== null && (
                <div className="student-lesson-item-badges">
                  <span className="student-lesson-status">✓ Completado</span>
                  <span className="student-lesson-status is-score">
                    Puntaje: {finalExamScore.toLocaleString('es-MX', { maximumFractionDigits: 2 })}%
                  </span>
                </div>
              )}
            </Link>
          ) : (
            <div className="student-lesson-item is-locked" aria-disabled="true">
              <div className="student-lesson-number">EF</div>
              <div className="student-lesson-copy">
                <strong>{finalExam.title ?? 'Examen final del curso'}</strong>
                <span>{finalExam.description ?? 'Accede al examen final de este curso.'}</span>
                <span className="student-lesson-status is-locked">
                  {!currentIsEnrolled
                    ? currentEnrollmentLoading
                      ? 'Verificando inscripción…'
                      : 'Inscríbete para acceder'
                    : 'Completa todas las lecciones y aprueba las actividades para desbloquear el examen.'}
                </span>
              </div>
            </div>
          )}
        </section>

        <Toast toast={visibleToast} onDismiss={dismissToast} />

        <div className="student-course-detail-footer">
          <span>{user.email ?? 'Estudiante'}</span>
        </div>
      </div>
    </AppShell>
  )
}
