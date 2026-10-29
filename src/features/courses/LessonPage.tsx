import { useState } from 'react'
import type { User } from '@supabase/supabase-js'
import { Link, Navigate, useNavigate, useParams } from 'react-router-dom'
import { showBeginnerHelp } from './adaptation'
import CoursesLayout from './components/CoursesLayout'
import LessonBlockView from './components/LessonBlockView'
import LessonQuizView from './components/LessonQuizView'
import { findCourse } from './data'
import { useLearnerProfile } from './useLearnerProfile'
import { useProgress } from './useProgress'

interface LessonPageProps {
  user: User
}

export default function LessonPage({ user }: LessonPageProps) {
  const { courseId, lessonId } = useParams()
  const navigate = useNavigate()
  const course = findCourse(courseId)
  const { profile, loading } = useLearnerProfile(user.id)
  const { isCompleted, markCompleted } = useProgress(user.id)
  const [passedLessonId, setPassedLessonId] = useState<string | null>(null)

  const index = course?.lessons.findIndex((lesson) => lesson.id === lessonId) ?? -1
  if (!course || index === -1) {
    return <Navigate to={course ? `/cursos/${course.id}` : '/cursos'} replace />
  }

  const lesson = course.lessons[index]
  const previous = course.lessons[index - 1]
  const next = course.lessons[index + 1]
  const done = isCompleted(course.id, lesson.id)
  const quizPassed = passedLessonId === lesson.id
  const progress = ((index + 1) / course.lessons.length) * 100

  function finish() {
    if (!course) return
    markCompleted(course.id, lesson.id)
    navigate(next ? `/cursos/${course.id}/lecciones/${next.id}` : `/cursos/${course.id}`)
  }

  return (
    <CoursesLayout>
      <div className="lesson-top">
        <Link to={`/cursos/${course.id}`} className="courses-link">
          {course.title}
        </Link>
        <div
          className="lesson-progress"
          role="progressbar"
          aria-valuenow={index + 1}
          aria-valuemin={1}
          aria-valuemax={course.lessons.length}
          aria-label="Avance en el curso"
        >
          <div className="lesson-progress-fill" style={{ width: `${progress}%` }} />
        </div>
        <span className="lesson-count">
          Lección {index + 1} de {course.lessons.length}
        </span>
      </div>

      <article className="lesson-article">
        <header className="lesson-header">
          <span className="courses-pill">{lesson.minutes} minutos</span>
          <h1>{lesson.title}</h1>
          <p>{lesson.summary}</p>
        </header>

        <section className="lesson-objectives">
          <h2>Al terminar esta lección podrás:</h2>
          <ul>
            {lesson.objectives.map((objective) => (
              <li key={objective}>{objective}</li>
            ))}
          </ul>
        </section>

        <div className="lesson-content">
          {!loading &&
            lesson.blocks.map((block, blockIndex) => (
              <LessonBlockView
                key={`${lesson.id}-${blockIndex}`}
                block={block}
                beginnerHelpOpen={showBeginnerHelp(profile)}
              />
            ))}

          <section className="lesson-keypoints">
            <h2>Puntos clave</h2>
            <ul>
              {lesson.keyPoints.map((point) => (
                <li key={point}>{point}</li>
              ))}
            </ul>
          </section>

          <LessonQuizView
            key={lesson.id}
            quiz={lesson.quiz}
            onAnswered={(correct) => correct && setPassedLessonId(lesson.id)}
          />
        </div>

        <footer className="lesson-footer">
          {previous ? (
            <Link to={`/cursos/${course.id}/lecciones/${previous.id}`} className="courses-link">
              Anterior: {previous.title}
            </Link>
          ) : (
            <span />
          )}

          <div className="d-flex align-items-center gap-3 flex-wrap">
            {done && <span className="lesson-done-note">Lección completada</span>}
            <button
              type="button"
              className="courses-cta"
              onClick={finish}
              disabled={!done && !quizPassed}
              title={!done && !quizPassed ? 'Responde correctamente el ejercicio para continuar' : undefined}
            >
              {next ? 'Completar y seguir' : 'Completar curso'}
            </button>
          </div>
        </footer>
        {!done && !quizPassed && (
          <p className="text-end subtitle mt-2 mb-0">
            Responde correctamente el ejercicio para completar la lección.
          </p>
        )}
      </article>
    </CoursesLayout>
  )
}
