import { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import type { User } from '@supabase/supabase-js'
import AppShell from '@/components/layout/AppShell'
import { languageIcons } from '@/features/onboarding/languageIcons'
import {
  getBestExamScore,
  getCourseAcademicProgressForEnrollment,
  getPublishedCourseById,
  getUserEnrollments,
} from './courseService'

interface MyCoursesPageProps {
  user: User
  onLogout: () => Promise<string | null>
}

interface EnrolledCourse {
  id: string
  slug: string
  name: string
  description: string
  level: string
  language: string
  duration?: string
  lessons?: number
  progress: number
  lessonsCompleted: number
  examScore: number | null
  examPassed: boolean
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

export default function MyCoursesPage({ user, onLogout }: MyCoursesPageProps) {
  const [enrolledCourses, setEnrolledCourses] = useState<EnrolledCourse[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    let active = true

    async function loadMyCourses() {
      try {
        setLoading(true)
        setError(null)

        const enrollments = await getUserEnrollments(user.id)
        if (!active) return

        const courseCards = await Promise.allSettled(
          enrollments.map(async (enrollment) => {
            const course = enrollment.courses && !Array.isArray(enrollment.courses)
              ? enrollment.courses
              : await getPublishedCourseById(enrollment.course_id)

            if (!course) {
              return null
            }

            const academicProgress = await getCourseAcademicProgressForEnrollment(enrollment.id, course.id)

            let bestExamScore: number | null = null
            try {
              bestExamScore = await getBestExamScore(enrollment.id, course.id)
            } catch (scoreError) {
              setError(
                scoreError instanceof Error
                  ? `Se cargaron tus cursos, pero no se pudo consultar la nota del examen: ${scoreError.message}`
                  : 'Se cargaron tus cursos, pero no se pudo consultar la nota del examen.'
              )
            }

            return {
              id: course.id,
              slug: course.slug,
              name: course.title,
              description: course.description ?? 'Sin descripción disponible.',
              level: course.level ?? 'Principiante',
              language: course.language ?? 'JavaScript',
              duration: course.duration_weeks ? `${course.duration_weeks} semana${course.duration_weeks === 1 ? '' : 's'}` : undefined,
              lessons: academicProgress.totalLessons,
              progress: academicProgress.progress,
              lessonsCompleted: academicProgress.completedLessons,
              examScore: bestExamScore,
              examPassed: bestExamScore !== null && bestExamScore >= 70,
            }
          })
        )

        if (!active) return

        const resolvedCourses = courseCards.flatMap((item) => {
          if (item.status === 'fulfilled') {
            return item.value ? [item.value] : []
          }

          return []
        })

        setEnrolledCourses(resolvedCourses)
      } catch (loadError) {
        if (!active) return
        const message =
          loadError instanceof Error
            ? loadError.message
            : 'No se pudo cargar tu lista de cursos inscritos en este momento.'
        setError(message)
        setEnrolledCourses([])
      } finally {
        if (active) {
          setLoading(false)
        }
      }
    }

    void loadMyCourses()

    return () => {
      active = false
    }
  }, [user.id])

  async function handleLogout(): Promise<string | null> {
    return onLogout()
  }

  return (
    <AppShell onLogout={handleLogout}>
      <div className="student-my-courses-page">
        <header className="student-catalog-header">
          <div>
            <p className="student-catalog-kicker">Mis cursos</p>
            <h1>Tu aprendizaje actual</h1>
          </div>
          <span className="student-catalog-user">{user.email}</span>
        </header>

        <p className="student-catalog-intro">
          Revisa tus cursos activos y el avance de cada ruta de formación.
        </p>

        {error ? (
          <div className="student-catalog-alert student-catalog-alert-error">{error}</div>
        ) : null}

        {loading ? (
          <div className="student-empty-state">
            <h2>Cargando tus cursos</h2>
            <p>Estamos consultando tus inscripciones reales en Supabase.</p>
          </div>
        ) : enrolledCourses.length === 0 ? (
          <div className="student-empty-state">
            <h2>No tienes cursos inscritos aún</h2>
            <p>Explora el catálogo para encontrar rutas de aprendizaje adecuadas para tu progreso.</p>
            <Link to="/courses" className="student-back-link">
              Ir al catálogo
            </Link>
          </div>
        ) : (
          <div className="student-my-courses-grid">
            {enrolledCourses.map((course) => {
              const normalizedLanguageKey = normalizeLanguageKey(course.language)

              return (
                <article className="student-my-course-card" key={course.id}>
                  <div className="student-catalog-card-top">
                    <div className="student-language-icon" aria-label={course.language}>
                      <img src={languageIcons[normalizedLanguageKey]} alt={course.language} />
                    </div>
                    <span className="student-course-level">{course.level}</span>
                  </div>

                  <div className="student-catalog-card-body">
                    <h2>{course.name}</h2>
                    <p>{course.description}</p>
                  </div>

                  <div className="student-catalog-meta">
                    {course.duration && <span>{course.duration}</span>}
                    {course.lessons && <span>{course.lessons} lecciones</span>}
                    {course.examScore !== null && <span>{course.examPassed ? 'Aprobado' : 'Examen: ' + course.examScore + '%'}</span>}
                  </div>

                  <div className="student-progress-group">
                    <div className="student-progress-head student-progress-header-inline">
                      <span>Progreso</span>
                      <strong>{course.progress}%</strong>
                    </div>
                    <div className="student-progress-bar" aria-hidden="true">
                      <div className="student-progress-fill" style={{ width: `${course.progress}%` }} />
                    </div>
                    <div className="student-progress-meta">
                      <span>{course.lessonsCompleted} lecciones completadas</span>
                    </div>
                  </div>

                  <Link to={`/courses/${course.slug}`} className="student-catalog-action student-catalog-link">
                    Ver curso
                  </Link>
                </article>
              )
            })}
          </div>
        )}
      </div>
    </AppShell>
  )
}
