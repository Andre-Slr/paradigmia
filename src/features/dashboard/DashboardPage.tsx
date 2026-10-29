import { useEffect, useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import type { User } from '@supabase/supabase-js'
import '@/styles/student.css'
import AppShell from '@/components/layout/AppShell'
import mascot from '@/assets/branding/mascota-estudiando.png'
import hojasSuperiorIzquierda from '@/assets/decor/hojas-superior-izquierda.png'
import hojasSuperiorDerecha from '@/assets/decor/hojas-superior-derecha.png'
import hojasInferiorIzquierda from '@/assets/decor/hojas-inferior-izquierda.png'
import hojasInferiorDerecha from '@/assets/decor/hojas-inferior-derecha.png'
import { useProfile } from '@/features/profile/useProfile'
import {
  getCourseAcademicProgressForEnrollment,
  getPublishedCourseById,
  getPublishedCourses,
  getUserEnrollments,
} from '@/features/courses/courseService'

interface DashboardPageProps {
  user: User
  onLogout: () => Promise<string | null>
}

interface RecentCourseItem {
  id: string
  title: string
  slug: string
  progress: number
  status: string
  icon: string
}

interface RecommendedCourseItem {
  id: string
  title: string
  description: string
  level: string
  duration: string
  slug: string
}

export default function DashboardPage({ user, onLogout }: DashboardPageProps) {
  const [error, setError] = useState('')
  const [recentCourses, setRecentCourses] = useState<RecentCourseItem[]>([])
  const [recommendedCourses, setRecommendedCourses] = useState<RecommendedCourseItem[]>([])
  const [loading, setLoading] = useState(true)
  const navigate = useNavigate()
  const { profile } = useProfile(user.id)

  useEffect(() => {
    let active = true

    async function loadDashboardData() {
      try {
        setLoading(true)
        setError('')

        const [enrollments, publishedCourses] = await Promise.all([
          getUserEnrollments(user.id),
          getPublishedCourses(),
        ])

        if (!active) return

        const enrolledCourseIds = new Set(enrollments.map((enrollment) => enrollment.course_id))

        const recentCourseData = await Promise.all(
          enrollments.map(async (enrollment) => {
            const course =
              enrollment.courses && !Array.isArray(enrollment.courses)
                ? enrollment.courses
                : await getPublishedCourseById(enrollment.course_id)

            if (!course) {
              return null
            }

            const academicProgress = await getCourseAcademicProgressForEnrollment(enrollment.id, course.id)

            return {
              id: course.id,
              title: course.title,
              slug: course.slug,
              progress: academicProgress.progress,
              status: academicProgress.progress >= 100 ? 'Completado' : 'En curso',
              icon: course.title.slice(0, 2).toUpperCase(),
            } satisfies RecentCourseItem
          })
        )

        const recommendedCourseData = publishedCourses
          .filter((course) => !enrolledCourseIds.has(course.id))
          .slice(0, 3)
          .map((course) => ({
            id: course.id,
            title: course.title,
            description: course.description ?? 'Curso publicado disponible para explorar.',
            level: course.level ?? 'Principiante',
            duration: course.duration_weeks
              ? `${course.duration_weeks} semana${course.duration_weeks === 1 ? '' : 's'}`
              : 'Sin duración definida',
            slug: course.slug,
          }))

        setRecentCourses(recentCourseData.filter(Boolean) as RecentCourseItem[])
        setRecommendedCourses(recommendedCourseData)
      } catch (loadError) {
        if (!active) return
        setRecentCourses([])
        setRecommendedCourses([])
        setError(
          loadError instanceof Error
            ? loadError.message
            : 'No se pudo cargar la información del dashboard en este momento.'
        )
      } finally {
        if (active) {
          setLoading(false)
        }
      }
    }

    void loadDashboardData()

    return () => {
      active = false
    }
  }, [user.id])

  async function handleLogout(): Promise<string | null> {
    setError('')
    const message = await onLogout()
    if (message) setError(message)
    return message
  }

  const nombre = profile?.nombre ?? user.user_metadata.nombre ?? user.email
  const continueLearningTarget = recentCourses.length > 0 ? '/my-courses' : '/courses'

  return (
    <AppShell onLogout={handleLogout}>
      <div className="student-dashboard">
        <header className="student-dashboard-hero">
          <div className="student-banner-decor student-banner-decor-top-left" aria-hidden="true">
            <img src={hojasSuperiorIzquierda} alt="" />
          </div>
          <div className="student-banner-decor student-banner-decor-top-right" aria-hidden="true">
            <img src={hojasSuperiorDerecha} alt="" />
          </div>
          <div className="student-banner-decor student-banner-decor-bottom-left" aria-hidden="true">
            <img src={hojasInferiorIzquierda} alt="" />
          </div>
          <div className="student-banner-decor student-banner-decor-bottom-right" aria-hidden="true">
            <img src={hojasInferiorDerecha} alt="" />
          </div>

          <div className="student-dashboard-copy">
            <div className="student-dashboard-kicker">Bienvenido</div>
            <h1>¡Hola, {nombre}!</h1>
            <p>
              Continúa tu recorrido de aprendizaje y descubre nuevas rutas para crear,
              practicar y crecer como desarrollador.
            </p>

            <div className="student-dashboard-actions">
              <button type="button" className="student-button" onClick={() => navigate(continueLearningTarget)}>
                Continuar aprendizaje
              </button>
              <button type="button" className="student-button-secondary" onClick={() => navigate('/courses')}>
                Explorar cursos
              </button>
            </div>
          </div>

          <div className="student-dashboard-visual" aria-hidden="true">
            <img src={mascot} alt="Mascota de Paradigmia estudiando" />
          </div>
        </header>

        {error && (
          <div className="alert alert-danger py-2 mb-0" role="alert">
            {error}
          </div>
        )}

        <section className="student-section">
          <div className="student-section-header">
            <h2>Cursos recomendados</h2>
            <Link to="/courses" className="student-ghost-button">
              Ver todos
            </Link>
          </div>

          {loading ? (
            <div className="student-empty-state">
              <h2>Cargando recomendaciones</h2>
              <p>Estamos consultando los cursos publicados y tu estado de inscripción.</p>
            </div>
          ) : recommendedCourses.length === 0 ? (
            <div className="student-empty-state">
              <h2>No hay recomendaciones disponibles</h2>
              <p>Ya estás inscrito en todos los cursos publicados o aún no hay cursos disponibles.</p>
            </div>
          ) : (
            <div className="student-course-grid">
              {recommendedCourses.map((course) => (
                <Link to={`/courses/${course.slug}`} className="student-course-card student-course-card-link" key={course.id}>
                  <span className="student-course-badge">{course.level}</span>
                  <h3>{course.title}</h3>
                  <p>{course.description}</p>

                  <div className="student-course-meta">
                    <span>{course.duration}</span>
                    <span className="student-inline-tag">Nuevo</span>
                  </div>
                </Link>
              ))}
            </div>
          )}
        </section>

        <section className="student-section">
          <div className="student-section-header">
            <h2>Cursos recientes</h2>
            <Link to="/my-courses" className="student-ghost-button">
              Ver progreso
            </Link>
          </div>

          {loading ? (
            <div className="student-empty-state">
              <h2>Cargando cursos</h2>
              <p>Estamos consultando tus inscripciones reales y el progreso del estudiante.</p>
            </div>
          ) : recentCourses.length === 0 ? (
            <div className="student-empty-state">
              <h2>Todavía no tienes cursos inscritos</h2>
              <p>Explora el catálogo para comenzar tu aprendizaje.</p>
              <Link to="/courses" className="student-back-link">
                Ver catálogo
              </Link>
            </div>
          ) : (
            <div className="student-progress-list">
              {recentCourses.map((course) => (
                <Link to={`/courses/${course.slug}`} className="student-progress-item student-progress-link" key={course.id}>
                  <div className="student-progress-icon" aria-hidden="true">
                    {course.icon}
                  </div>

                  <div className="student-progress-copy">
                    <div className="student-progress-head">
                      <h3>{course.title}</h3>
                      <span>{course.progress}%</span>
                    </div>

                    <div className="student-progress-bar" aria-hidden="true">
                      <div
                        className="student-progress-fill"
                        style={{ width: `${course.progress}%` }}
                      />
                    </div>
                  </div>

                  <div className="student-content-status">{course.status}</div>
                </Link>
              ))}
            </div>
          )}
        </section>
      </div>
    </AppShell>
  )
}
