import { useEffect, useState } from 'react'
import { Link, useParams } from 'react-router-dom'
import AppShell from '@/components/layout/AppShell'
import mascot from '@/assets/branding/mascota-estudiando.png'
import {
  buildCourseLearningSequence,
  getAssessmentAttemptAnswers,
  getAssessmentAttemptsForEnrollment,
  getAssessmentQuestions,
  getAttemptReview,
  getCourseAcademicProgressForEnrollment,
  getCourseEnrollment,
  getLessonProgressStatus,
  getPublishedCourseActivityBySlug,
  getPublishedCourseAssessments,
  getPublishedCourseBySlug,
  getPublishedCourseLessons,
  getQuestionOptions,
  submitAssessmentAnswers,
  type AttemptReviewEntry,
  type PublishedAssessmentRecord,
  type PublishedCourseRecord,
  type PublishedQuestionOptionRecord,
} from './courseService'

interface ActivityPageProps {
  user: {
    id?: string
    email?: string | null
  }
  onLogout: () => Promise<string | null>
}

type QuestionAnswers = Record<string, string>

interface ActivityQuestionViewModel {
  id: string
  prompt: string
  explanation: string | null
  position: number | null
  points: number | null
  options: PublishedQuestionOptionRecord[]
}

export default function ActivityPage({ user, onLogout }: ActivityPageProps) {
  const { courseId, activityId } = useParams()
  const [course, setCourse] = useState<PublishedCourseRecord | null>(null)
  const [activity, setActivity] = useState<PublishedAssessmentRecord | null>(null)
  const [sequence, setSequence] = useState<ReturnType<typeof buildCourseLearningSequence>>([])
  const [questions, setQuestions] = useState<ActivityQuestionViewModel[]>([])
  const [answers, setAnswers] = useState<QuestionAnswers>({})
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [submitMessage, setSubmitMessage] = useState<string | null>(null)
  const [isEnrolled, setIsEnrolled] = useState(false)
  const [isSubmitting, setIsSubmitting] = useState(false)
  const [isActivityApproved, setIsActivityApproved] = useState(false)
  const [passedActivityIds, setPassedActivityIds] = useState<string[]>([])
  const [examPassed, setExamPassed] = useState(false)
  const [previousLessonCompleted, setPreviousLessonCompleted] = useState(true)
  const [latestApprovedScore, setLatestApprovedScore] = useState<number | null>(null)
  const [persistedAnswers, setPersistedAnswers] = useState<Record<string, string>>({})
  const [attemptReview, setAttemptReview] = useState<Record<string, AttemptReviewEntry>>({})
  const [revealedCorrectAnswers, setRevealedCorrectAnswers] = useState<Record<string, boolean>>({})
  const [reviewError, setReviewError] = useState<string | null>(null)

  useEffect(() => {
    const currentCourseSlug = courseId ?? ''
    const currentActivitySlug = activityId ?? ''

    if (!currentCourseSlug || !currentActivitySlug) {
      setCourse(null)
      setActivity(null)
      setQuestions([])
      setSequence([])
      setLoading(false)
      setError('No se recibió una referencia válida de la actividad.')
      return
    }

    let active = true

    async function loadActivity() {
      try {
        setLoading(true)
        setError(null)
        setSubmitMessage(null)

        const courseData = await getPublishedCourseBySlug(currentCourseSlug)
        if (!active) return

        if (!courseData) {
          setCourse(null)
          setActivity(null)
          setQuestions([])
          setSequence([])
          return
        }

        setCourse(courseData)

        const [courseAssessments, activityData] = await Promise.all([
          getPublishedCourseAssessments(courseData.id),
          getPublishedCourseActivityBySlug(courseData.id, currentActivitySlug),
        ])

        if (!active) return

        if (!activityData) {
          setActivity(null)
          setQuestions([])
          setSequence([])
          return
        }

        const lessonData = await getPublishedCourseLessons(courseData.id)
        setActivity(activityData)
        setSequence(buildCourseLearningSequence(lessonData, courseAssessments, courseData.slug))

        const activityQuestions = await getAssessmentQuestions(activityData.id)
        if (!active) return

        const enrichedQuestions = await Promise.all(
          activityQuestions.map(async (question) => {
            const options = await getQuestionOptions(question.id)
            return {
              id: question.id,
              prompt: question.prompt ?? 'Pregunta sin enunciado disponible.',
              explanation: question.explanation ?? null,
              position: question.position ?? null,
              points: question.points ?? null,
              options: options.sort((left, right) => (left.position ?? 0) - (right.position ?? 0)),
            } satisfies ActivityQuestionViewModel
          })
        )

        if (!active) return
        setQuestions(enrichedQuestions.sort((left, right) => (left.position ?? 0) - (right.position ?? 0)))

        const enrollment = user.id ? await getCourseEnrollment(user.id, courseData.id) : null
        const academicProgress = enrollment ? await getCourseAcademicProgressForEnrollment(enrollment.id, courseData.id) : null
        const attempts = enrollment ? await getAssessmentAttemptsForEnrollment(enrollment.id, courseData.id) : []
        const relevantAttempts = attempts.filter((attempt) => attempt.assessment_id === activityData.id)
        const bestValidAttempt = relevantAttempts
          .filter((attempt) => typeof attempt.score === 'number' && typeof activityData.passing_score === 'number' && Number(attempt.score) >= Number(activityData.passing_score))
          .sort((left, right) => Number(right.score ?? 0) - Number(left.score ?? 0))[0] ?? null

        const nextPersistedAnswers = bestValidAttempt?.id ? await getAssessmentAttemptAnswers(bestValidAttempt.id) : []
        const normalizedPersistedAnswers = Object.fromEntries(
          nextPersistedAnswers
            .filter((entry) => entry.question_id && entry.option_id)
            .map((entry) => [entry.question_id, entry.option_id])
        )

        await loadAttemptReview(bestValidAttempt?.id ?? null)

        if (!active) return
        setIsEnrolled(Boolean(enrollment))
        setPassedActivityIds(academicProgress?.passedActivityIds ?? [])
        setExamPassed(Boolean(academicProgress?.examPassed))
        setLatestApprovedScore(bestValidAttempt?.score ?? null)
        setIsActivityApproved(Boolean(bestValidAttempt))
        setPersistedAnswers(normalizedPersistedAnswers)
        setAnswers(normalizedPersistedAnswers)
      } catch (loadError) {
        if (!active) return
        setError(
          loadError instanceof Error
            ? loadError.message
            : 'No se pudo cargar la actividad en este momento.'
        )
        setCourse(null)
        setActivity(null)
        setQuestions([])
        setSequence([])
      } finally {
        if (active) {
          setLoading(false)
        }
      }
    }

    void loadActivity()

    return () => {
      active = false
    }
  }, [courseId, activityId, user.id])

  async function loadAttemptReview(attemptId: string | null): Promise<void> {
    if (!attemptId) {
      setAttemptReview({})
      setRevealedCorrectAnswers({})
      setReviewError(null)
      return
    }

    try {
      const reviewRows = await getAttemptReview(attemptId)
      const nextReview = Object.fromEntries(
        reviewRows
          .filter((row) => row.question_id)
          .map((row) => [String(row.question_id), row])
      )
      setAttemptReview(nextReview)
      setRevealedCorrectAnswers({})
      setReviewError(null)
    } catch (loadReviewError) {
      setAttemptReview({})
      setRevealedCorrectAnswers({})
      setReviewError(
        loadReviewError instanceof Error
          ? `No se pudo cargar la revisión de la actividad: ${loadReviewError.message}`
          : 'No se pudo cargar la revisión de la actividad.'
      )
    }
  }

  function toggleCorrectAnswerReveal(questionId: string): void {
    setRevealedCorrectAnswers((current) => ({
      ...current,
      [questionId]: !current[questionId],
    }))
  }

  async function handleLogout(): Promise<string | null> {
    return onLogout()
  }

  const allAnswered = questions.length > 0 && Object.keys(answers).length === questions.length
  const showRetryButton = !isActivityApproved && !isSubmitting && (
    Object.keys(attemptReview).length > 0 ||
    Boolean(submitMessage && (submitMessage.includes('Calificación:') || submitMessage.includes('Aún no alcanzas')))
  )
  const currentSequenceIndex = activity ? sequence.findIndex((item) => item.type === 'activity' && item.id === activity.id) : -1
  const previousStep = currentSequenceIndex > 0 ? sequence[currentSequenceIndex - 1] ?? null : null
  const nextStep = currentSequenceIndex >= 0 ? sequence[currentSequenceIndex + 1] ?? null : null
  useEffect(() => {
    if (!course || !user.id) {
      setPreviousLessonCompleted(true)
      return
    }

    const currentCourse = course
    const currentUserId = user.id
    const currentLessonPrerequisite = previousStep && previousStep.type === 'lesson' ? previousStep : null

    if (!currentCourse || !currentUserId || !currentLessonPrerequisite) {
      setPreviousLessonCompleted(true)
      return
    }

    const lessonPrerequisiteId = currentLessonPrerequisite.id
    let active = true

    async function loadPreviousLessonCompletion() {
      try {
        const enrollment = await getCourseEnrollment(currentUserId, currentCourse.id)
        if (!active) return

        if (!enrollment) {
          setPreviousLessonCompleted(false)
          return
        }

        const isCompleted = await getLessonProgressStatus(currentUserId, currentCourse.id, lessonPrerequisiteId)
        if (!active) return
        setPreviousLessonCompleted(isCompleted)
      } catch (loadError) {
        if (!active) return
        setError(
          loadError instanceof Error
            ? `No se pudo comprobar si la lección anterior está completada: ${loadError.message}`
            : 'No se pudo comprobar si la lección anterior está completada.'
        )
        setPreviousLessonCompleted(false)
      }
    }

    void loadPreviousLessonCompletion()

    return () => {
      active = false
    }
  }, [course, previousStep, user.id])

  const previousStepCompleted = previousStep
    ? previousStep.type === 'lesson'
      ? previousLessonCompleted
      : previousStep.type === 'activity'
        ? passedActivityIds.includes(previousStep.id)
        : examPassed
    : true
  const isBlockedByPrerequisite = Boolean(previousStep) && !previousStepCompleted

  const handleOptionSelect = (questionId: string, optionId: string): void => {
    setAnswers((current) => ({ ...current, [questionId]: optionId }))
  }

  const handleRetryActivity = (): void => {
    setAnswers({})
    setPersistedAnswers({})
    setAttemptReview({})
    setRevealedCorrectAnswers({})
    setReviewError(null)
    setSubmitMessage(null)
    setLatestApprovedScore(null)
  }

  const handleSubmit = async (): Promise<void> => {
    if (!activity) {
      setSubmitMessage('La actividad no está disponible para enviar.')
      return
    }

    if (!user.id) {
      setSubmitMessage('Debes iniciar sesión para enviar la actividad.')
      return
    }

    if (!isEnrolled) {
      setSubmitMessage('Debes inscribirte en el curso para poder responder esta actividad.')
      return
    }

    if (!allAnswered) {
      setSubmitMessage('Debes responder todas las preguntas antes de enviar.')
      return
    }

    if (isSubmitting) {
      return
    }

    setIsSubmitting(true)
    setSubmitMessage(null)

    try {
      const enrollment = await getCourseEnrollment(user.id, course?.id ?? '')

      if (!enrollment) {
        setSubmitMessage('No se encontró la inscripción activa para este curso. Revisa tu acceso antes de entregar la actividad.')
        return
      }

      const payload = questions
        .map((question) => ({
          question_id: question.id,
          option_id: answers[question.id],
        }))
        .filter((answer) => Boolean(answer.option_id))

      if (payload.length !== questions.length) {
        setSubmitMessage('Todavía faltan respuestas por seleccionar antes de enviar.')
        return
      }

      const result = await submitAssessmentAnswers(activity.id, payload)
      const attempts = await getAssessmentAttemptsForEnrollment(enrollment.id, course?.id ?? '')
      const activityAttempts = attempts.filter((attempt) => attempt.assessment_id === activity.id)
      const bestApprovedAttempt = activityAttempts
        .filter((attempt) => typeof attempt.score === 'number' && typeof activity.passing_score === 'number' && Number(attempt.score) >= Number(activity.passing_score))
        .sort((left, right) => Number(right.score ?? 0) - Number(left.score ?? 0))[0] ?? null
      const latestScore = typeof result.score === 'number' ? result.score : bestApprovedAttempt?.score ?? activityAttempts[0]?.score ?? null
      const passedByScore = Boolean(bestApprovedAttempt)

      if (result.attempt_id) {
        await loadAttemptReview(result.attempt_id)
      }

      setLatestApprovedScore(bestApprovedAttempt?.score ?? null)
      setIsActivityApproved(passedByScore)
      if (passedByScore) {
        const approvedAnswers = Object.fromEntries(
          payload.map((entry) => [entry.question_id, entry.option_id])
        )
        setPersistedAnswers(approvedAnswers)
        setAnswers(approvedAnswers)
        setSubmitMessage(`Actividad completada. Calificación: ${latestScore ?? 0}/100. Puedes continuar con la siguiente lección.`)
      } else if (typeof latestScore === 'number') {
        setPersistedAnswers({})
        setAnswers({})
        setSubmitMessage(`Calificación: ${latestScore}/100. Aún no alcanzas la nota mínima para completar esta actividad.`)
      } else {
        setPersistedAnswers({})
        setAnswers({})
        setSubmitMessage('La actividad se ha enviado correctamente. El resultado todavía no tiene una calificación registrada.')
      }
    } catch (submitError) {
      setSubmitMessage(
        submitError instanceof Error
          ? `No se pudo guardar la actividad: ${submitError.message}`
          : 'No se pudo guardar la actividad en este momento.'
      )
    } finally {
      setIsSubmitting(false)
    }
  }

  if (loading) {
    return (
      <AppShell onLogout={handleLogout}>
        <div className="student-empty-state student-detail-empty">
          <h2>Cargando actividad</h2>
          <p>Estamos consultando la actividad y sus preguntas publicadas en Supabase.</p>
        </div>
      </AppShell>
    )
  }

  if (error) {
    return (
      <AppShell onLogout={handleLogout}>
        <div className="student-empty-state student-detail-empty">
          <h2>No se pudo cargar la actividad</h2>
          <p>{error}</p>
          <Link to={course ? `/courses/${course.slug}` : '/courses'} className="student-back-link">
            Volver al curso
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
          <p>El curso asociado a esta actividad no existe o aún no está publicado.</p>
          <Link to="/courses" className="student-back-link">
            Volver al catálogo
          </Link>
        </div>
      </AppShell>
    )
  }

  if (!activity) {
    return (
      <AppShell onLogout={handleLogout}>
        <div className="student-empty-state student-detail-empty">
          <h2>Actividad no disponible</h2>
          <p>La actividad solicitada no existe, no está publicada o no pertenece a este curso.</p>
          <Link to={`/courses/${course.slug}`} className="student-back-link">
            Volver al curso
          </Link>
        </div>
      </AppShell>
    )
  }

  if (isBlockedByPrerequisite) {
    return (
      <AppShell onLogout={handleLogout}>
        <div className="student-empty-state student-detail-empty">
          <h2>Contenido bloqueado</h2>
          <p>
            Debes completar <strong>{previousStep?.title ?? 'el contenido anterior'}</strong> antes de acceder a esta actividad.
          </p>
          <Link to={previousStep?.url ?? `/courses/${course.slug}`} className="student-back-link">
            Volver al contenido anterior
          </Link>
        </div>
      </AppShell>
    )
  }

  return (
    <AppShell onLogout={handleLogout}>
      <div className="student-activity-page">
        <div className="student-lesson-topbar">
          <Link to={`/courses/${course.slug}`} className="student-back-link">
            ← Volver al curso
          </Link>
          <span className="student-lesson-meta">{user.email ?? 'Estudiante'}</span>
        </div>

        <div className="student-activity-header">
          <div className="student-activity-copy">
            <p className="student-catalog-kicker">Actividad</p>
            <h1>{activity.title ?? 'Actividad sin título'}</h1>
            <p className="student-activity-objective">
              {activity.description ?? 'Esta actividad no incluye una descripción adicional.'}
            </p>
            <div className="student-activity-instructions">
              <strong>Instrucciones:</strong>
              <span>{activity.instructions ?? 'Lee cada enunciado y responde según tu criterio.'}</span>
            </div>
          </div>

          <div className="student-activity-visual" aria-hidden="true">
            <img src={mascot} alt="" />
          </div>
        </div>

        {isActivityApproved && latestApprovedScore !== null && (
          <div className="student-exam-result student-activity-summary" role="status" style={{ borderColor: '#687D31' }}>
            <h3 style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', color: '#19350C' }}>✓ Actividad completada</h3>
            <p>Calificación: {latestApprovedScore}/100</p>
            <p>Puedes continuar con la siguiente lección.</p>
          </div>
        )}

        {questions.length === 0 ? (
          <div className="student-empty-state">
            <h2>Actividad sin preguntas</h2>
            <p>Esta actividad está publicada pero todavía no tiene preguntas disponibles.</p>
          </div>
        ) : (
          <div className="student-activity-list">
            {questions.map((question, index) => {
              const selectedOptionId = answers[question.id] ?? persistedAnswers[question.id]
              const reviewEntry = attemptReview[question.id]
              const isApprovedReview = isActivityApproved && Boolean(reviewEntry)
              const isFailedReview = !isActivityApproved && Boolean(reviewEntry) && !reviewEntry.is_correct
              const isQuestionCorrect = Boolean(reviewEntry && reviewEntry.is_correct)
              const showCorrectAnswer = Boolean(revealedCorrectAnswers[question.id]) && isFailedReview

              return (
                <section className="student-quiz-card" key={question.id}>
                  <div className="student-quiz-question-head">
                    <span className="student-quiz-index">Pregunta {index + 1}</span>
                  </div>

                  <h2>{question.prompt}</h2>

                  <div className="student-quiz-options">
                    {question.options.map((option) => {
                      const isSelected = selectedOptionId === option.id
                      const optionClasses = ['student-option']
                      const wasSelectedCorrect = Boolean(reviewEntry && reviewEntry.selected_option_id === option.id && reviewEntry.is_correct)
                      const wasSelectedIncorrect = Boolean(reviewEntry && reviewEntry.selected_option_id === option.id && !reviewEntry.is_correct)
                      const isCorrectOption = Boolean(
                        (isApprovedReview && reviewEntry && reviewEntry.correct_option_id === option.id) ||
                          (showCorrectAnswer && reviewEntry && reviewEntry.correct_option_id === option.id)
                      )
                      const isWrongSelected = Boolean(
                        (isApprovedReview && reviewEntry && reviewEntry.selected_option_id === option.id && !reviewEntry.is_correct) ||
                          (isFailedReview && reviewEntry && reviewEntry.selected_option_id === option.id && !reviewEntry.is_correct)
                      )

                      if (isSelected) optionClasses.push('is-selected')
                      if (isCorrectOption || wasSelectedCorrect) optionClasses.push('is-correct')
                      if (isWrongSelected || wasSelectedIncorrect) optionClasses.push('is-wrong')

                      return (
                        <button
                          key={option.id}
                          type="button"
                          className={optionClasses.join(' ')}
                          onClick={() => !isActivityApproved && handleOptionSelect(question.id, option.id)}
                          aria-pressed={isSelected}
                          disabled={isActivityApproved}
                          title={
                            isApprovedReview && reviewEntry && reviewEntry.correct_option_id === option.id
                              ? 'Respuesta correcta'
                              : isApprovedReview && reviewEntry && reviewEntry.selected_option_id === option.id && !reviewEntry.is_correct
                                ? 'Tu respuesta'
                                : isQuestionCorrect && isSelected
                                  ? 'Respuesta correcta'
                                  : isFailedReview && wasSelectedIncorrect
                                    ? 'Tu respuesta'
                                    : undefined
                          }
                          style={{
                            borderColor: isCorrectOption || wasSelectedCorrect ? '#2E7D32' : isWrongSelected || wasSelectedIncorrect ? '#B42318' : undefined,
                            background: isCorrectOption || wasSelectedCorrect ? '#EAF7EC' : isWrongSelected || wasSelectedIncorrect ? '#FBEAE8' : undefined,
                          }}
                        >
                          <span>{option.option_text ?? 'Opción sin texto'}</span>
                          {(isCorrectOption || wasSelectedCorrect) && <strong style={{ marginLeft: '0.5rem' }}>✓</strong>}
                          {(isWrongSelected || wasSelectedIncorrect) && <strong style={{ marginLeft: '0.5rem' }}>✕</strong>}
                        </button>
                      )
                    })}
                  </div>

                  {reviewError && (
                    <div className="student-question-feedback" style={{ color: '#8B1E1E' }}>
                      <small>{reviewError}</small>
                    </div>
                  )}

                  {!isActivityApproved && isFailedReview && (
                    <div style={{ marginTop: '0.7rem', display: 'flex', alignItems: 'center', gap: '0.5rem', flexWrap: 'wrap' }}>
                      <button
                        type="button"
                        className="student-button-secondary"
                        onClick={() => toggleCorrectAnswerReveal(question.id)}
                        style={{ padding: '0.5rem 0.8rem', fontSize: '0.85rem' }}
                      >
                        {showCorrectAnswer ? 'Ocultar respuesta' : 'Ver respuesta'}
                      </button>
                    </div>
                  )}

                  {showCorrectAnswer && reviewEntry && reviewEntry.correct_option_text && (
                    <div className="student-question-feedback" style={{ marginTop: '0.7rem', background: '#F4F8F1', borderRadius: '12px', padding: '0.7rem 0.8rem' }}>
                      <div>
                        <strong style={{ color: '#19350C' }}>Respuesta correcta:</strong> {reviewEntry.correct_option_text}
                      </div>
                    </div>
                  )}

                  {isApprovedReview && reviewEntry && (
                    <div className="student-question-feedback" style={{ marginTop: '0.7rem', background: '#F4F8F1', borderRadius: '12px', padding: '0.7rem 0.8rem' }}>
                      <div>
                        <strong style={{ color: '#19350C' }}>Tu respuesta:</strong>{' '}
                        {reviewEntry.selected_option_text ??
                          question.options.find((option) => option.id === selectedOptionId)?.option_text ??
                          'No disponible'}
                      </div>
                      <div style={{ color: reviewEntry.is_correct ? '#19350C' : '#8B1E1E', marginTop: '0.2rem' }}>
                        <strong>{reviewEntry.is_correct ? 'Correcta' : 'Incorrecta'}</strong>
                      </div>
                      {!reviewEntry.is_correct && reviewEntry.correct_option_text && (
                        <div style={{ marginTop: '0.2rem' }}>
                          <strong>Respuesta correcta:</strong> {reviewEntry.correct_option_text}
                        </div>
                      )}
                      {reviewEntry.explanation && (
                        <div style={{ marginTop: '0.2rem' }}>
                          <strong>Explicación:</strong> {reviewEntry.explanation}
                        </div>
                      )}
                    </div>
                  )}
                </section>
              )
            })}
          </div>
        )}

        {!isActivityApproved && (
          <div className="student-activity-footer">
            <button
              type="button"
              className="student-button"
              onClick={handleSubmit}
              disabled={!allAnswered || isSubmitting}
            >
              {isSubmitting ? 'Enviando...' : 'Enviar actividad'}
            </button>

            <button
              type="button"
              className="student-button-secondary"
              onClick={() => {
                setAnswers({})
                setSubmitMessage(null)
              }}
              disabled={isSubmitting}
            >
              Limpiar respuestas
            </button>
          </div>
        )}

        {submitMessage && (
          <div className="student-exam-result student-activity-summary" role="status">
            <p>{submitMessage}</p>
          </div>
        )}

        {showRetryButton && (
          <div className="student-activity-footer">
            <button
              type="button"
              className="student-button-secondary"
              onClick={handleRetryActivity}
            >
              Volver a intentar
            </button>
          </div>
        )}

        {nextStep ? (
          <div className="student-activity-footer">
            <Link
              to={nextStep.url}
              className="student-catalog-action student-catalog-link"
              onClick={(event) => {
                if (!isActivityApproved) {
                  event.preventDefault()
                }
              }}
              aria-disabled={!isActivityApproved}
              style={{
                pointerEvents: isActivityApproved ? 'auto' : 'none',
                opacity: isActivityApproved ? 1 : 0.6,
                textDecoration: 'none',
              }}
            >
              {isActivityApproved ? `Siguiente: ${nextStep.title}` : 'Primero debes aprobar la actividad'}
            </Link>
          </div>
        ) : null}
      </div>
    </AppShell>
  )
}
