import type { User } from '@supabase/supabase-js'
import { Link } from 'react-router-dom'
import { NOMBRE_NIVEL, recommendCourses } from './adaptation'
import CoursesLayout from './components/CoursesLayout'
import { courses } from './data'
import type { Course } from './types'
import { useLearnerProfile } from './useLearnerProfile'
import { useProgress } from './useProgress'

interface CoursesPageProps {
  user: User
}

function CourseCard({
  course,
  reasons,
  doneCount,
}: {
  course: Course
  reasons?: string[]
  doneCount: number
}) {
  const minutes = course.lessons.reduce((total, lesson) => total + lesson.minutes, 0)

  return (
    <Link
      to={`/cursos/${course.id}`}
      className={`course-card ${reasons ? 'is-recommended' : ''}`}
    >
      <div className="course-card-head">
        <img src={course.icon} alt="" className="course-card-icon" />
        <div>
          <span className="courses-pill">{NOMBRE_NIVEL[course.level]}</span>
          <h3 className="mt-1">{course.title}</h3>
        </div>
      </div>
      <p>{course.tagline}</p>
      {reasons && reasons.length > 0 && (
        <ul className="course-reasons" aria-label="Por qué te lo recomendamos">
          {reasons.map((reason) => (
            <li key={reason}>{reason}</li>
          ))}
        </ul>
      )}
      <span className="course-card-meta">
        {course.lessons.length} lecciones, {minutes} min
        {doneCount > 0 && `. Completaste ${doneCount} de ${course.lessons.length}`}
      </span>
    </Link>
  )
}

export default function CoursesPage({ user }: CoursesPageProps) {
  const { profile, loading } = useLearnerProfile(user.id)
  const { completed } = useProgress(user.id)
  const recommendations = recommendCourses(profile, courses)

  const doneIn = (course: Course) =>
    course.lessons.filter((lesson) => completed.has(`${course.id}/${lesson.id}`)).length

  return (
    <CoursesLayout>
      <section className="catalog-intro">
        <h1>Cursos</h1>
        <p className="subtitle mb-0">
          Elegimos estos cursos a partir de lo que nos contaste al empezar: tu
          experiencia, lo que te interesa y tu resultado en el diagnóstico.
        </p>
      </section>

      <h2 className="courses-section-title">Recomendados para ti</h2>
      {loading ? (
        <p className="subtitle">Cargando tus recomendaciones...</p>
      ) : (
        <div className="catalog-grid">
          {recommendations.map(({ course, reasons }) => (
            <CourseCard
              key={course.id}
              course={course}
              reasons={reasons}
              doneCount={doneIn(course)}
            />
          ))}
        </div>
      )}

      <h2 className="courses-section-title">Todos los cursos</h2>
      <div className="catalog-grid">
        {courses.map((course) => (
          <CourseCard key={course.id} course={course} doneCount={doneIn(course)} />
        ))}
      </div>
    </CoursesLayout>
  )
}
