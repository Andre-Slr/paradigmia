import { useEffect, useMemo, useState } from 'react'
import { Link, useParams } from 'react-router-dom'
import AppShell from '@/components/layout/AppShell'
import {
  buildCourseLearningSequence,
  completeLesson,
  getCourseAcademicProgressForEnrollment,
  getCourseEnrollment,
  getLessonProgressStatus,
  getPublishedCourseAssessments,
  getPublishedCourseBySlug,
  getPublishedCourseLessons,
  type PublishedCourseRecord,
  type PublishedLessonRecord,
} from './courseService'
import LessonCallout from '@/features/adaptation/LessonCallout'
import { isCalloutType } from '@/features/adaptation/calloutTypes'
import { showBeginnerHelp } from '@/features/adaptation/adaptation'
import { useLearnerProfile } from '@/features/adaptation/useLearnerProfile'
import '@/features/adaptation/adaptation.css'

interface LessonPageProps {
  user: {
    id: string
    email?: string | null
  }
  onLogout: () => Promise<string | null>
}

function normalizeContentBlocks(content: PublishedLessonRecord['content']): Array<{ type?: string; text?: string; language?: string; title?: string }> {
  if (!content) return []

  if (Array.isArray(content)) {
    return content.map((block) => {
      if (typeof block === 'string') {
        return { type: 'paragraph', text: block }
      }

      const text = typeof block?.text === 'string' ? block.text : typeof block?.content === 'string' ? block.content : ''
      return {
        type: typeof block?.type === 'string' ? block.type : 'paragraph',
        text,
        language: typeof block?.language === 'string' ? block.language : undefined,
        title: typeof (block as { title?: unknown })?.title === 'string' ? (block as { title: string }).title : undefined,
      }
    })
  }

  if (typeof content === 'string') {
    return [{ type: 'paragraph', text: content }]
  }

  return []
}

export default function LessonPage({ user, onLogout }: LessonPageProps) {
  const { courseId, lessonId } = useParams()
  const [course, setCourse] = useState<PublishedCourseRecord | null>(null)
  const [lesson, setLesson] = useState<PublishedLessonRecord | null>(null)
  const [lessonSequence, setLessonSequence] = useState<ReturnType<typeof buildCourseLearningSequence>>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [isEnrolled, setIsEnrolled] = useState(false)
  const [isCompleted, setIsCompleted] = useState(false)
  const [completedLessonIds, setCompletedLessonIds] = useState<string[]>([])
  const [passedActivityIds, setPassedActivityIds] = useState<string[]>([])
  const [examPassed, setExamPassed] = useState(false)
  const [saving, setSaving] = useState(false)
  const [saveMessage, setSaveMessage] = useState<string | null>(null)

  useEffect(() => {
    const currentCourseSlug = courseId ?? ''
    const currentLessonSlug = lessonId ?? ''

    if (!currentCourseSlug || !currentLessonSlug) {
      setCourse(null)
      setLesson(null)
      setLessonSequence([])
      setLoading(false)
      setError('No se recibió una referencia válida de la lección.')
      return
    }

    let active = true

    async function loadLesson() {
      try {
        setLoading(true)
        setError(null)
        setSaveMessage(null)

        const courseData = await getPublishedCourseBySlug(currentCourseSlug)
        if (!active) return

        if (!courseData) {
          setCourse(null)
          setLesson(null)
          setLessonSequence([])
          return
        }

        setCourse(courseData)

        const [lessonData, assessmentData] = await Promise.all([
          getPublishedCourseLessons(courseData.id),
          getPublishedCourseAssessments(courseData.id),
        ])

        const matchedLesson = lessonData.find((item) => (item.slug ?? item.id) === currentLessonSlug) ?? null

        if (!active) return

        if (!matchedLesson) {
          setLesson(null)
          setLessonSequence([])
          return
        }

        setLesson(matchedLesson)
        setLessonSequence(buildCourseLearningSequence(lessonData, assessmentData, courseData.slug))

        if (user.id) {
          const enrollment = await getCourseEnrollment(user.id, courseData.id)
          const [completed, academicProgress] = enrollment
            ? await Promise.all([
                getLessonProgressStatus(user.id, courseData.id, matchedLesson.id),
                getCourseAcademicProgressForEnrollment(enrollment.id, courseData.id),
              ])
            : [false, null]

          if (!active) return
          setIsEnrolled(Boolean(enrollment))
          setIsCompleted(Boolean(completed))
          setCompletedLessonIds(academicProgress?.completedLessonIds ?? [])
          setPassedActivityIds(academicProgress?.passedActivityIds ?? [])
          setExamPassed(Boolean(academicProgress?.examPassed))
        } else {
          setIsEnrolled(false)
          setIsCompleted(false)
          setCompletedLessonIds([])
          setPassedActivityIds([])
          setExamPassed(false)
        }
      } catch (loadError) {
        if (!active) return
        setError(
          loadError instanceof Error
            ? loadError.message
            : 'No se pudo cargar la lección en este momento.'
        )
        setCourse(null)
        setLesson(null)
        setLessonSequence([])
        setIsEnrolled(false)
        setIsCompleted(false)
        setCompletedLessonIds([])
        setPassedActivityIds([])
        setExamPassed(false)
      } finally {
        if (active) {
          setLoading(false)
        }
      }
    }

    void loadLesson()

    return () => {
      active = false
    }
  }, [courseId, lessonId, user.id])

  const lessonBlocks = useMemo(() => normalizeContentBlocks(lesson?.content ?? null), [lesson])
  // Motor de adaptación, regla R6: ayudas para principiantes abiertas o cerradas según el nivel.
  const { profile: learnerProfile, loading: learnerLoading } = useLearnerProfile(user.id)
  const currentSequenceIndex = lesson ? lessonSequence.findIndex((item) => item.type === 'lesson' && item.id === lesson.id) : -1
  const previousStep = currentSequenceIndex > 0 ? lessonSequence[currentSequenceIndex - 1] ?? null : null
  const nextStep = currentSequenceIndex >= 0 ? lessonSequence[currentSequenceIndex + 1] ?? null : null

  const previousStepCompleted = previousStep
    ? previousStep.type === 'lesson'
      ? completedLessonIds.includes(previousStep.id)
      : previousStep.type === 'activity'
        ? passedActivityIds.includes(previousStep.id)
        : examPassed
    : true

  const isBlockedByPrerequisite = Boolean(previousStep) && !previousStepCompleted

  async function handleLogout(): Promise<string | null> {
    return onLogout()
  }

  async function handleCompleteLesson(): Promise<void> {
    if (!lesson || !course) {
      setSaveMessage('La lección no está disponible para completar.')
      return
    }

    if (!user.id) {
      setSaveMessage('Debes iniciar sesión para completar una lección.')
      return
    }

    if (!isEnrolled) {
      setSaveMessage('Debes inscribirte en este curso antes de marcar la lección como completada.')
      return
    }

    if (isBlockedByPrerequisite) {
      setSaveMessage(`Primero debes completar "${previousStep?.title ?? 'el contenido anterior'}" para continuar.`)
      return
    }

    if (isCompleted) {
      setSaveMessage('Lección completada.')
      return
    }

    try {
      setSaving(true)
      setSaveMessage(null)
      await completeLesson(lesson.id)
      setIsCompleted(true)
      setCompletedLessonIds((current) => Array.from(new Set([...current, lesson.id])))
      setSaveMessage('Lección completada correctamente.')
    } catch (completeError) {
      setSaveMessage(
        completeError instanceof Error
          ? completeError.message
          : 'No se pudo guardar el progreso de la lección.'
      )
    } finally {
      setSaving(false)
    }
  }

  if (loading) {
    return (
      <AppShell onLogout={handleLogout}>
        <div className="student-empty-state student-detail-empty">
          <h2>Cargando lección</h2>
          <p>Estamos consultando el contenido real de la lección publicada.</p>
        </div>
      </AppShell>
    )
  }

  if (error) {
    return (
      <AppShell onLogout={handleLogout}>
        <div className="student-empty-state student-detail-empty">
          <h2>No se pudo cargar la lección</h2>
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
          <p>El curso asociado a esta lección no existe o todavía no está publicado.</p>
          <Link to="/courses" className="student-back-link">
            Volver al catálogo
          </Link>
        </div>
      </AppShell>
    )
  }

  if (!lesson) {
    return (
      <AppShell onLogout={handleLogout}>
        <div className="student-empty-state student-detail-empty">
          <h2>Lección no disponible</h2>
          <p>La lección solicitada no existe, no está publicada o no pertenece a este curso.</p>
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
            Debes completar <strong>{previousStep?.title ?? 'el contenido anterior'}</strong> antes de acceder a esta lección.
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
      <div className="student-lesson-page">
        <div className="student-lesson-topbar">
          <Link to={`/courses/${course.slug}`} className="student-back-link">
            ← Volver al curso
          </Link>
          <span className="student-lesson-meta">{user.email ?? 'Estudiante'}</span>
        </div>

        <article className="student-lesson-card">
          <p className="student-catalog-kicker">Lección</p>
          <h1>{lesson.title ?? 'Lección sin título'}</h1>
          <h2 className="student-lesson-course-name">{course.title}</h2>

          <div className="student-lesson-objective">
            <strong>Objetivo</strong>
            <p>{lesson.objective ?? 'Este contenido no incluye un objetivo definido.'}</p>
          </div>

          <div className="student-lesson-body">
            {lessonBlocks.length === 0 ? (
              <p>Este contenido todavía no tiene bloques publicados.</p>
            ) : (
              lessonBlocks.map((block, index) => {
                const key = `${block.type}-${index}`

                if (block.type === 'heading') {
                  return <h3 key={key} className="student-lesson-heading">{block.text}</h3>
                }

                if (block.type === 'code') {
                  return (
                    <pre key={key} className="student-lesson-code" style={{ whiteSpace: 'pre-wrap' }}>
                      <code>{block.text ?? ''}</code>
                    </pre>
                  )
                }

                if (isCalloutType(block.type)) {
                  if (learnerLoading) return null
                  return (
                    <LessonCallout
                      key={key}
                      type={block.type}
                      title={block.title}
                      text={block.text ?? ''}
                      beginnerOpen={showBeginnerHelp(learnerProfile)}
                    />
                  )
                }

                return <p key={key}>{block.text ?? ''}</p>
              })
            )}
          </div>

          <div className="student-lesson-actions">
            {saveMessage && (
              <p className={`student-lesson-save-message ${isCompleted || saveMessage.includes('correctamente') ? 'is-success' : 'is-error'}`}>
                {saveMessage}
              </p>
            )}

            <button
              type="button"
              className="student-catalog-action student-catalog-link"
              onClick={() => void handleCompleteLesson()}
              disabled={saving || !isEnrolled || isCompleted}
            >
              {saving ? 'Guardando...' : isCompleted ? 'Lección completada' : 'Marcar como completada'}
            </button>

            {nextStep ? (
              <Link
                to={nextStep.url}
                className="student-catalog-action student-catalog-link"
                onClick={(event) => {
                  if (!isCompleted) {
                    event.preventDefault()
                  }
                }}
                aria-disabled={!isCompleted}
              >
                {isCompleted ? `Siguiente: ${nextStep.title}` : 'Completa la lección para continuar'}
              </Link>
            ) : null}
          </div>
        </article>
      </div>
    </AppShell>
  )
}
