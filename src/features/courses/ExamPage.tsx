import { useEffect, useState } from 'react'
import { Link, useParams } from 'react-router-dom'
import AppShell from '@/components/layout/AppShell'
import mascot from '@/assets/branding/mascota-estudiando.png'
import {
  getAssessmentAttemptsForEnrollment,
  getAssessmentQuestions,
  getAttemptReview,
  getCourseAcademicProgressForEnrollment,
  getCourseEnrollment,
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

interface ExamPageProps {
  user: {
    id?: string
    email?: string | null
  }
  onLogout: () => Promise<string | null>
}

type QuestionAnswers = Record<string, string>

interface ExamQuestionViewModel {
  id: string
  prompt: string
  explanation: string | null
  position: number | null
  options: PublishedQuestionOptionRecord[]
}

export default function ExamPage({ user, onLogout }: ExamPageProps) {
  const { courseId } = useParams()
  const [course, setCourse] = useState<PublishedCourseRecord | null>(null)
  const [exam, setExam] = useState<PublishedAssessmentRecord | null>(null)
  const [questions, setQuestions] = useState<ExamQuestionViewModel[]>([])
  const [answers, setAnswers] = useState<QuestionAnswers>({})
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [submitMessage, setSubmitMessage] = useState<string | null>(null)
  const [isEnrolled, setIsEnrolled] = useState(false)
  const [examPassed, setExamPassed] = useState(false)
  const [bestExamScore, setBestExamScore] = useState<number | null>(null)
  const [isExamUnlocked, setIsExamUnlocked] = useState(false)
  const [unlockMessage, setUnlockMessage] = useState<string | null>(null)
  const [latestAttemptId, setLatestAttemptId] = useState<string | null>(null)
  const [hasSubmittedExam, setHasSubmittedExam] = useState(false)
  const [showExamReview, setShowExamReview] = useState(false)
  const [examReview, setExamReview] = useState<Record<string, AttemptReviewEntry>>({})
  const [reviewLoading, setReviewLoading] = useState(false)
  const [reviewError, setReviewError] = useState<string | null>(null)

  useEffect(() => {
    const routeCourseId = courseId ?? ''

    if (!routeCourseId) {
      setCourse(null)
      setExam(null)
      setQuestions([])
      setLoading(false)
      setError('No se recibió una referencia válida del examen.')
      return
    }

    let active = true

    async function loadExam() {
      try {
        setLoading(true)
        setError(null)
        setSubmitMessage(null)

        const courseData = await getPublishedCourseBySlug(routeCourseId)
        if (!active) return

        if (!courseData) {
          setCourse(null)
          setExam(null)
          setQuestions([])
          return
        }

        setCourse(courseData)

        const [lessons, assessments] = await Promise.all([
          getPublishedCourseLessons(courseData.id),
          getPublishedCourseAssessments(courseData.id),
        ])
        if (!active) return

        const examData = assessments.find((assessment) => {
          const kind = ((assessment.kind ?? assessment.type ?? '') as string).trim().toLowerCase()
          return kind === 'exam' || kind === 'final' || kind === 'evaluacion' || kind === 'evaluación'
        }) ?? null

        if (!examData) {
          setExam(null)
          setQuestions([])
          return
        }

        setExam(examData)

        const examQuestions = await getAssessmentQuestions(examData.id)
        if (!active) return

        const enrichedQuestions = await Promise.all(
          examQuestions.map(async (question) => {
            const options = await getQuestionOptions(question.id)
            return {
              id: question.id,
              prompt: question.prompt ?? 'Pregunta sin enunciado disponible.',
              explanation: question.explanation ?? null,
              position: question.position ?? null,
              options: options.sort((left, right) => (left.position ?? 0) - (right.position ?? 0)),
            } satisfies ExamQuestionViewModel
          })
        )

        if (!active) return
        setQuestions(enrichedQuestions.sort((left, right) => (left.position ?? 0) - (right.position ?? 0)))

        if (user.id) {
          const enrollment = await getCourseEnrollment(user.id, courseData.id)
          const academicProgress = enrollment ? await getCourseAcademicProgressForEnrollment(enrollment.id, courseData.id) : null
          const attempts = enrollment ? await getAssessmentAttemptsForEnrollment(enrollment.id, courseData.id) : []
          const examAttempts = attempts.filter((attempt) => attempt.assessment_id === examData.id)
          const bestAttempt = examAttempts
            .filter((attempt) => typeof attempt.score === 'number')
            .sort((left, right) => Number(right.score ?? 0) - Number(left.score ?? 0))[0] ?? null

          setLatestAttemptId(bestAttempt?.id ?? null)

          const courseActivities = assessments.filter((assessment) => {
            const kind = ((assessment.kind ?? assessment.type ?? '') as string).trim().toLowerCase()
            return kind !== 'exam' && kind !== 'final' && kind !== 'evaluacion' && kind !== 'evaluación'
          })

          const isUnlocked = Boolean(
            enrollment &&
              lessons.length === (academicProgress?.completedLessonIds.length ?? 0) &&
              courseActivities.length === (academicProgress?.passedActivityIds.length ?? 0)
          )

          if (!active) return
          setIsEnrolled(Boolean(enrollment))
          setExamPassed(Boolean(academicProgress?.examPassed || (bestAttempt && typeof examData.passing_score === 'number' && Number(bestAttempt.score ?? 0) >= Number(examData.passing_score))))
          setBestExamScore(bestAttempt?.score ?? null)
          setIsExamUnlocked(isUnlocked)
          setUnlockMessage(
            isUnlocked
              ? null
              : 'Completa todas las lecciones y aprueba las actividades del curso antes de acceder al examen final.'
          )
        } else {
          setIsEnrolled(false)
          setIsExamUnlocked(false)
          setUnlockMessage('Inicia sesión y completa los requisitos del curso para desbloquear el examen.')
        }
      } catch (loadError) {
        if (!active) return
        setError(
          loadError instanceof Error
            ? loadError.message
            : 'No se pudo cargar el examen final en este momento.'
        )
        setCourse(null)
        setExam(null)
        setQuestions([])
      } finally {
        if (active) {
          setLoading(false)
        }
      }
    }

    void loadExam()

    return () => {
      active = false
    }
  }, [courseId, user.id])

  const allAnswered = questions.length > 0 && Object.keys(answers).length === questions.length

  const handleOptionSelect = (questionId: string, optionId: string): void => {
    setAnswers((current) => ({ ...current, [questionId]: optionId }))
  }

  async function loadAttemptReview(attemptId: string): Promise<void> {
    if (!attemptId) {
      return
    }

    try {
      setReviewLoading(true)
      setReviewError(null)
      const rows = await getAttemptReview(attemptId)
      const nextReview = Object.fromEntries(
        rows.filter((entry) => entry.question_id).map((entry) => [String(entry.question_id), entry])
      )
      setExamReview(nextReview)
    } catch (loadReviewError) {
      setReviewError(
        loadReviewError instanceof Error
          ? `No se pudo cargar la revisión del examen: ${loadReviewError.message}`
          : 'No se pudo cargar la revisión del examen.'
      )
      setExamReview({})
    } finally {
      setReviewLoading(false)
    }
  }

  const handleSubmit = async (): Promise<void> => {
    if (!exam) {
      setSubmitMessage('El examen final aún no está disponible.')
      return
    }

    if (!user.id) {
      setSubmitMessage('Debes iniciar sesión para enviar el examen.')
      return
    }

    if (!isEnrolled) {
      setSubmitMessage('Debes estar inscrito en el curso antes de intentar el examen final.')
      return
    }

    if (!isExamUnlocked) {
      setSubmitMessage('El examen aún no está disponible. Completa antes todas las lecciones y actividades del curso.')
      return
    }

    if (!allAnswered) {
      setSubmitMessage('Debes responder todas las preguntas antes de enviarlas.')
      return
    }

    if (examPassed) {
      setSubmitMessage('Este examen ya está aprobado y queda registrado como resultado persistido.')
      return
    }

    try {
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

      const result = await submitAssessmentAnswers(exam.id, payload)
      const score = typeof result.score === 'number' ? result.score : null
      const resolvedBestScore = typeof result.best_exam_score === 'number' ? result.best_exam_score : score
      const passingScore = typeof exam.passing_score === 'number' ? exam.passing_score : null
      const passedThisAttempt = score !== null && passingScore !== null ? score >= passingScore : Boolean(result.passed)

      setLatestAttemptId(result.attempt_id ?? latestAttemptId)
      setBestExamScore(resolvedBestScore ?? bestExamScore)
      setExamPassed(passedThisAttempt)
      setHasSubmittedExam(true)
      setShowExamReview(false)
      setReviewError(null)

      if (result.attempt_id) {
        await loadAttemptReview(result.attempt_id)
      }

      if (passedThisAttempt) {
        setSubmitMessage(`Examen aprobado. Calificación: ${score ?? 0}/100. Mejor calificación registrada: ${resolvedBestScore ?? score ?? 0}/100.`)
      } else {
        setSubmitMessage(`Calificación: ${score ?? 0}/100. No has superado la nota mínima de ${passingScore ?? 'la evaluación'}. Puedes repetir el examen.`)
      }
    } catch (submitError) {
      setSubmitMessage(
        submitError instanceof Error
          ? `No se pudo enviar el examen: ${submitError.message}`
          : 'No se pudo enviar el examen en este momento.'
      )
    }
  }

  async function handleLogout(): Promise<string | null> {
    return onLogout()
  }

  if (loading) {
    return (
      <AppShell onLogout={handleLogout}>
        <div className="student-empty-state student-detail-empty">
          <h2>Cargando examen</h2>
          <p>Estamos consultando el examen final publicado en Supabase.</p>
        </div>
      </AppShell>
    )
  }

  if (error) {
    return (
      <AppShell onLogout={handleLogout}>
        <div className="student-empty-state student-detail-empty">
          <h2>No se pudo cargar el examen</h2>
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
          <p>El curso asociado a este examen no existe o aún no está publicado.</p>
          <Link to="/courses" className="student-back-link">
            Volver al catálogo
          </Link>
        </div>
      </AppShell>
    )
  }

  if (!exam) {
    return (
      <AppShell onLogout={handleLogout}>
        <div className="student-empty-state student-detail-empty">
          <h2>Examen no disponible</h2>
          <p>El examen final de este curso aún no está publicado.</p>
          <Link to={`/courses/${course.slug}`} className="student-back-link">
            Volver al curso
          </Link>
        </div>
      </AppShell>
    )
  }

  if (!isExamUnlocked) {
    return (
      <AppShell onLogout={handleLogout}>
        <div className="student-empty-state student-detail-empty">
          <h2>Examen bloqueado</h2>
          <p>{unlockMessage ?? 'Completa todas las lecciones y actividades del curso antes de iniciar el examen final.'}</p>
          <Link to={`/courses/${course.slug}`} className="student-back-link">
            Volver al curso
          </Link>
        </div>
      </AppShell>
    )
  }

  const renderReviewSection = () => {
    if (Object.keys(examReview).length === 0) {
      return null
    }

    return (
      <div className="student-activity-list" style={{ marginTop: '1.5rem' }}>
        {questions.map((question, index) => {
          const reviewEntry = examReview[question.id]
          const selected = answers[question.id]
          const isCorrect = Boolean(reviewEntry && reviewEntry.is_correct)

          return (
            <section className="student-quiz-card" key={question.id}>
              <div className="student-quiz-question-head">
                <span className="student-quiz-index">Pregunta {index + 1}</span>
              </div>
              <h2>{question.prompt}</h2>
              <div className="student-quiz-options">
                {question.options.map((option) => {
                  const isSelected = selected === option.id
                  const isCorrectOption = Boolean(reviewEntry && reviewEntry.correct_option_id === option.id)
                  const isWrongSelected = Boolean(reviewEntry && reviewEntry.selected_option_id === option.id && !reviewEntry.is_correct)
                  const optionClasses = ['student-option']
                  if (isSelected) optionClasses.push('is-selected')
                  if (isCorrectOption) optionClasses.push('is-correct')
                  if (isWrongSelected) optionClasses.push('is-wrong')

                  return (
                    <button key={option.id} type="button" className={optionClasses.join(' ')} disabled>
                      <span>{option.option_text ?? 'Opción sin texto'}</span>
                      {isCorrectOption && <strong style={{ marginLeft: '0.5rem' }}>✓</strong>}
                      {isWrongSelected && <strong style={{ marginLeft: '0.5rem' }}>✕</strong>}
                    </button>
                  )
                })}
              </div>
              {reviewEntry && (
                <div className="student-question-feedback" style={{ marginTop: '0.75rem' }}>
                  <div><strong>Tu respuesta:</strong> {reviewEntry.selected_option_text ?? 'No disponible'}</div>
                  <div style={{ color: isCorrect ? '#19350C' : '#8B1E1E' }}><strong>{isCorrect ? 'Correcta' : 'Incorrecta'}</strong></div>
                  {!isCorrect && reviewEntry.correct_option_text && (
                    <div><strong>Respuesta correcta:</strong> {reviewEntry.correct_option_text}</div>
                  )}
                  {reviewEntry.explanation && (<div><strong>Explicación:</strong> {reviewEntry.explanation}</div>)}
                </div>
              )}
            </section>
          )
        })}
      </div>
    )
  }

  const shouldShowResultView = examPassed || hasSubmittedExam

  if (shouldShowResultView) {
    return (
      <AppShell onLogout={handleLogout}>
        <div className="student-empty-state student-detail-empty">
          <h2>{examPassed ? 'Examen aprobado' : 'Resultado del examen'}</h2>
          <p>
            {bestExamScore !== null
              ? `Calificación final: ${bestExamScore}/100.`
              : submitMessage ?? 'El examen ya quedó registrado en Supabase.'}
          </p>
          <div className="student-lesson-actions">
            {latestAttemptId && (
              <button
                type="button"
                className="student-catalog-action student-catalog-link"
                onClick={() => {
                  setShowExamReview(true)
                  void loadAttemptReview(latestAttemptId)
                }}
                disabled={reviewLoading}
              >
                {reviewLoading ? 'Cargando revisión...' : 'Revisar mi examen'}
              </button>
            )}
            {!examPassed && !showExamReview && (
              <button
                type="button"
                className="student-catalog-action student-catalog-link"
                onClick={() => {
                  setAnswers({})
                  setSubmitMessage(null)
                  setLatestAttemptId(null)
                  setHasSubmittedExam(false)
                  setShowExamReview(false)
                  setExamReview({})
                  setReviewError(null)
                }}
              >
                Reintentar
              </button>
            )}
            <Link to="/my-courses" className="student-catalog-action student-catalog-link">
              Volver a Mis cursos
            </Link>
          </div>
          {reviewError && <p className="student-form-error">{reviewError}</p>}
          {submitMessage && <p className="student-form-success">{submitMessage}</p>}
          {showExamReview && renderReviewSection()}
        </div>
      </AppShell>
    )
  }

  return (
    <AppShell onLogout={handleLogout}>
      <div className="student-exam-page">
        <div className="student-lesson-topbar">
          <Link to={`/courses/${course.slug}`} className="student-back-link">
            ← Volver al curso
          </Link>
          <span className="student-lesson-meta">{user.email ?? 'Estudiante'}</span>
        </div>

        <div className="student-activity-header">
          <div className="student-activity-copy">
            <p className="student-catalog-kicker">Examen final</p>
            <h1>{exam.title ?? 'Examen final'}</h1>
            <p className="student-activity-objective">
              {exam.instructions ?? 'Evalúa los conceptos principales de este módulo.'}
            </p>
          </div>

          <div className="student-activity-visual student-exam-visual" aria-hidden="true">
            <img src={mascot} alt="" />
          </div>
        </div>

        <div className="student-activity-list">
          {questions.map((question, index) => {
            const selectedOptionId = answers[question.id]

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

                    if (isSelected) optionClasses.push('is-selected')

                    return (
                      <button
                        key={option.id}
                        type="button"
                        className={optionClasses.join(' ')}
                        onClick={() => handleOptionSelect(question.id, option.id)}
                        aria-pressed={isSelected}
                      >
                        <span>{option.option_text ?? 'Opción sin texto'}</span>
                      </button>
                    )
                  })}
                </div>

                {question.explanation && (
                  <div className="student-question-feedback">
                    <small>{question.explanation}</small>
                  </div>
                )}
              </section>
            )
          })}
        </div>

        <div className="student-activity-footer">
          <button type="button" className="student-button" onClick={handleSubmit} disabled={!allAnswered}>
            Entregar examen
          </button>

          <button
            type="button"
            className="student-button-secondary"
            onClick={() => {
              setAnswers({})
              setSubmitMessage(null)
            }}
          >
            Reintentar
          </button>
        </div>

        {submitMessage && (
          <div className="student-exam-result">
            <p>{submitMessage}</p>
          </div>
        )}
      </div>
    </AppShell>
  )
}
