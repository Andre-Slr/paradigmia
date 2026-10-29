import type { User } from '@supabase/supabase-js'
import { Link, Navigate, useParams } from 'react-router-dom'
import { NOMBRE_NIVEL, nextLesson, planCourse } from './adaptation'
import CoursesLayout from './components/CoursesLayout'
import { findCourse } from './data'
import { useLearnerProfile } from './useLearnerProfile'
import { useProgress } from './useProgress'

interface CoursePageProps {
  user: User
}

const TAG_TEXT = {
  repaso: 'Repaso opcional',
  sugerida: 'Empieza aquí',
}

export default function CoursePage({ user }: CoursePageProps) {
  const { courseId } = useParams()
  const course = findCourse(courseId)
  const { profile } = useLearnerProfile(user.id)
  const { completed } = useProgress(user.id)

  if (!course) return <Navigate to="/cursos" replace />

  const plan = planCourse(course, profile)
  const next = nextLesson(course, plan, completed)
  const minutes = course.lessons.reduce((total, lesson) => total + lesson.minutes, 0)
  const doneCount = course.lessons.filter((lesson) =>
    completed.has(`${course.id}/${lesson.id}`),
  ).length

  const ctaText = next.finished
    ? 'Repasar el curso'
    : next.started
      ? 'Continuar curso'
      : 'Empezar curso'

  return (
    <CoursesLayout>
      <Link to="/cursos" className="courses-link">
        Volver a cursos
      </Link>

      <section className="course-hero mt-3">
        <div className="course-hero-icon">
          <img src={course.icon} alt="" />
        </div>
        <div>
          <h1>{course.title}</h1>
          <p>{course.tagline}</p>
          <div className="course-meta">
            <span className="courses-pill">{NOMBRE_NIVEL[course.level]}</span>
            <span className="courses-pill">{course.lessons.length} lecciones</span>
            <span className="courses-pill">{minutes} minutos</span>
            {doneCount > 0 && (
              <span className="courses-pill is-done">
                {doneCount} de {course.lessons.length} completadas
              </span>
            )}
          </div>
        </div>
      </section>

      {plan.message && (
        <div className="adaptive-note" role="note">
          <span aria-hidden="true">🎯</span>
          <span>{plan.message}</span>
        </div>
      )}

      <div className="course-layout">
        <section className="course-panel">
          <h2 className="courses-section-title">Sobre este curso</h2>
          <p>{course.description}</p>
          <h3 className="h5 fw-bold mt-4">Lo que aprenderás</h3>
          <ul className="course-learn">
            {course.whatYouLearn.map((item) => (
              <li key={item}>{item}</li>
            ))}
          </ul>
        </section>

        <section className="course-panel">
          <h2 className="courses-section-title">Lecciones</h2>
          <ol className="lesson-list">
            {course.lessons.map((lesson) => {
              const done = completed.has(`${course.id}/${lesson.id}`)
              const tag = plan.tags[lesson.id]
              return (
                <li key={lesson.id}>
                  <Link
                    to={`/cursos/${course.id}/lecciones/${lesson.id}`}
                    className={`lesson-item ${done ? 'is-done' : ''}`}
                  >
                    <span className="lesson-item-body">
                      <strong>{lesson.title}</strong>
                      <span>
                        {lesson.minutes} min. {lesson.summary}
                      </span>
                    </span>
                    {done ? (
                      <span className="courses-pill is-done">Completada</span>
                    ) : (
                      tag && <span className={`courses-pill is-${tag}`}>{TAG_TEXT[tag]}</span>
                    )}
                  </Link>
                </li>
              )
            })}
          </ol>
          <Link to={`/cursos/${course.id}/lecciones/${next.lessonId}`} className="courses-cta">
            {ctaText}
          </Link>
        </section>
      </div>
    </CoursesLayout>
  )
}
