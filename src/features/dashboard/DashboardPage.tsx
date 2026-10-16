import { useMemo, useState } from 'react'
import type { User } from '@supabase/supabase-js'
import { useProfile } from '@/features/profile/useProfile'

interface DashboardPageProps {
  user: User
  onLogout: () => Promise<string | null>
}

type Course = {
  icon: string
  iconClass: string
  level: string
  title: string
  description: string
  duration: string
  modules: string
  progress: number
  category: string
}

const recommendedCourses: Course[] = [
  {
    icon: 'JS',
    iconClass: 'javascript',
    level: 'Principiante',
    title: 'JavaScript desde cero',
    description: 'Aprende los fundamentos de JavaScript y crea tus primeros proyectos web.',
    duration: '8 horas',
    modules: '12 módulos',
    progress: 60,
    category: 'Frontend',
  },
  {
    icon: '🐍',
    iconClass: 'python',
    level: 'Principiante',
    title: 'Python para principiantes',
    description: 'Domina la sintaxis de Python y comienza a resolver problemas reales.',
    duration: '10 horas',
    modules: '15 módulos',
    progress: 25,
    category: 'Datos',
  },
  {
    icon: '⚛',
    iconClass: 'react',
    level: 'Intermedio',
    title: 'React: Componentes y Hooks',
    description: 'Construye interfaces modernas con React y aprende a usar Hooks.',
    duration: '12 horas',
    modules: '18 módulos',
    progress: 0,
    category: 'Frontend',
  },
  {
    icon: 'JS',
    iconClass: 'node',
    level: 'Intermedio',
    title: 'Node.js y Express',
    description: 'Crea APIs y aplicaciones del lado del servidor con Node.js y Express.',
    duration: '14 horas',
    modules: '20 módulos',
    progress: 0,
    category: 'Backend',
  },
]

const popularCourses = [
  { icon: '🌐', title: 'HTML y CSS: crea tu primera web', category: 'Frontend', level: 'Principiante' },
  { icon: '🗄️', title: 'SQL y bases de datos', category: 'Datos', level: 'Principiante' },
  { icon: '⚙️', title: 'Git y GitHub práctico', category: 'Herramientas', level: 'Principiante' },
  { icon: '📱', title: 'Desarrollo de apps móviles', category: 'Móvil', level: 'Intermedio' },
]

const categories = [
  { icon: '▣', name: 'Frontend' },
  { icon: '▤', name: 'Backend' },
  { icon: '◇', name: 'Full Stack' },
  { icon: '▯', name: 'Móvil' },
  { icon: '◉', name: 'Datos' },
  { icon: '∞', name: 'DevOps' },
]

export default function DashboardPage({ user, onLogout }: DashboardPageProps) {
  const [search, setSearch] = useState('')
  const [error, setError] = useState('')
  const { profile } = useProfile(user.id)

  const nombre = String(profile?.nombre ?? user.user_metadata.nombre ?? user.email ?? 'estudiante')
  const inicial = nombre.charAt(0).toUpperCase()

  const filteredCourses = useMemo(() => {
    const query = search.trim().toLowerCase()
    if (!query) return recommendedCourses
    return recommendedCourses.filter((course) =>
      `${course.title} ${course.description} ${course.category} ${course.level}`.toLowerCase().includes(query),
    )
  }, [search])

  async function handleLogout() {
    setError('')
    const message = await onLogout()
    if (message) setError(message)
  }

  return (
    <main className="dashboard">
      <header className="dashboard-topbar d-flex align-items-center flex-wrap gap-3 px-3 px-lg-4 py-2">
        <a className="dashboard-brand d-flex align-items-center gap-2" href="/dashboard" aria-label="Paradigmia, inicio">
          <span className="dashboard-brand-mark">&lt;/&gt;</span>
          <span>Paradigmia <small>Tech</small></span>
        </a>

        <label className="dashboard-search input-group ms-md-2">
          <span className="input-group-text border-end-0 rounded-start-pill" aria-hidden="true">⌕</span>
          <input
            type="search"
            className="form-control border-start-0 rounded-end-pill"
            value={search}
            onChange={(event) => setSearch(event.target.value)}
            placeholder="Buscar cursos, tecnologías..."
            aria-label="Buscar cursos"
          />
        </label>

        <div className="ms-auto d-flex align-items-center gap-3">
          <div className="d-flex align-items-center gap-2">
            <span className="dashboard-avatar" aria-hidden="true">{inicial}</span>
            <span className="d-none d-sm-inline text-secondary">{nombre}</span>
          </div>
          <button className="btn btn-outline-secondary btn-sm" type="button" onClick={handleLogout}>
            Cerrar sesión
          </button>
        </div>
      </header>

      <div className="container-fluid px-0">
        <div className="row g-0">
          <aside className="dashboard-sidebar col-12 col-md-auto p-3">
            <nav className="dashboard-nav" aria-label="Navegación principal">
              <a className="dashboard-nav-link active" href="#inicio"><span className="dashboard-nav-icon">⌂</span>Inicio</a>
              <a className="dashboard-nav-link" href="#recomendados"><span className="dashboard-nav-icon">▣</span>Cursos</a>
              <a className="dashboard-nav-link" href="#categorias"><span className="dashboard-nav-icon">◇</span>Rutas de aprendizaje</a>
              <a className="dashboard-nav-link" href="#populares"><span className="dashboard-nav-icon">▤</span>Recursos</a>
              <a className="dashboard-nav-link" href="#comunidad"><span className="dashboard-nav-icon">♧</span>Comunidad</a>
              <a className="dashboard-nav-link" href="#progreso"><span className="dashboard-nav-icon">▥</span>Mi progreso</a>
            </nav>
            <div className="dashboard-note d-none d-md-block">
              <strong className="small"><span className="dashboard-dot" />Tu próximo nivel</strong>
              <p className="text-secondary small mb-0 mt-2">Un poco de práctica cada día hace la diferencia.</p>
            </div>
          </aside>

          <main className="dashboard-main col px-3 px-lg-4 py-4">
            {error && (
              <div className="alert alert-danger py-2" role="alert">
                {error}
              </div>
            )}

            <section className="dashboard-hero p-4 p-lg-5" id="inicio">
              <div className="row align-items-center g-4">
                <div className="col-12 col-lg-7">
                  <p className="dashboard-hero-eyebrow text-uppercase fw-bold mb-2">Tu aprendizaje, a tu ritmo</p>
                  <h1 className="fw-bold mb-3">Tu camino en la <span className="dashboard-accent">programación</span> empieza aquí</h1>
                  <p className="mb-4 opacity-75">
                    Aprende a tu ritmo, con cursos prácticos, proyectos reales y una comunidad que te acompaña.
                  </p>
                  <a className="btn btn-mustard px-4" href="#recomendados">Explorar cursos <span aria-hidden="true">→</span></a>
                  <div className="d-flex flex-wrap gap-4 mt-4 small">
                    <span><b className="dashboard-accent me-1">&lt;/&gt;</b> +200 cursos</span>
                    <span><b className="dashboard-accent me-1">♧</b> Comunidad activa</span>
                    <span><b className="dashboard-accent me-1">★</b> Certificados</span>
                  </div>
                </div>
                <div className="col-12 col-lg-5">
                  <div className="dashboard-art" role="img" aria-label="Ilustración de programación">
                    <span className="dashboard-art-bubble">&lt;/&gt;</span>
                    <div className="dashboard-mascot">
                      <span className="dashboard-mascot-antenna left" />
                      <span className="dashboard-mascot-antenna right" />
                      <span className="dashboard-mascot-head">
                        <span className="dashboard-mascot-eye" />
                        <span className="dashboard-mascot-eye" />
                      </span>
                    </div>
                    <span className="dashboard-laptop">&lt;/&gt;</span>
                  </div>
                </div>
              </div>
            </section>

            <section className="mt-5" id="recomendados">
              <div className="d-flex align-items-end justify-content-between gap-3 mb-3">
                <div>
                  <h2 className="h4 fw-bold mb-1">Recomendado para ti</h2>
                  <p className="text-secondary small mb-0">Basado en tu progreso y en tus intereses.</p>
                </div>
                <a href="#populares" className="link-mustard small text-nowrap">Ver todos →</a>
              </div>

              <div className="row row-cols-1 row-cols-md-2 row-cols-xl-4 g-3">
                {filteredCourses.map((course) => (
                  <div className="col" key={course.title}>
                    <article className="dashboard-course-card">
                      <div className="d-flex align-items-start justify-content-between gap-2">
                        <div className={`dashboard-course-icon ${course.iconClass}`}>{course.icon}</div>
                        <span className="badge dashboard-level-badge">{course.level}</span>
                      </div>
                      <h3 className="h6 fw-bold mt-3 mb-2">{course.title}</h3>
                      <p className="text-secondary small mb-0 flex-grow-1">{course.description}</p>
                      <div className="d-flex flex-wrap gap-3 text-secondary small mt-3">
                        <span>◷ {course.duration}</span>
                        <span>▤ {course.modules}</span>
                      </div>
                      <div className="d-flex align-items-center gap-2 mt-3">
                        <div
                          className="progress flex-grow-1"
                          role="progressbar"
                          aria-label={`${course.progress}% completado`}
                          aria-valuenow={course.progress}
                          aria-valuemin={0}
                          aria-valuemax={100}
                        >
                          <div className="progress-bar dashboard-progress-bar" style={{ width: `${course.progress}%` }} />
                        </div>
                        <span className="text-secondary" style={{ fontSize: '0.75rem' }}>{course.progress}%</span>
                      </div>
                    </article>
                  </div>
                ))}
              </div>

              {filteredCourses.length === 0 && (
                <p className="text-secondary mb-0" role="status">
                  No se encontraron cursos recomendados para “{search}”. Prueba otra búsqueda.
                </p>
              )}
            </section>

            <section className="mt-5" id="categorias">
              <div className="mb-3">
                <h2 className="h4 fw-bold mb-1">Explora por categoría</h2>
                <p className="text-secondary small mb-0">Encuentra el área que más te interesa.</p>
              </div>
              <div className="row row-cols-2 row-cols-md-3 row-cols-lg-6 g-3">
                {categories.map((category) => (
                  <div className="col" key={category.name}>
                    <a href="#populares" className="dashboard-category h-100">
                      <span className="dashboard-category-icon">{category.icon}</span>
                      <strong className="small text-truncate">{category.name}</strong>
                      <span className="ms-auto text-secondary">›</span>
                    </a>
                  </div>
                ))}
              </div>
            </section>

            <section className="mt-5" id="populares">
              <div className="d-flex align-items-end justify-content-between gap-3 mb-3">
                <div>
                  <h2 className="h4 fw-bold mb-1">Cursos populares</h2>
                  <p className="text-secondary small mb-0">Continúa desarrollando habilidades útiles.</p>
                </div>
                <a href="#recomendados" className="link-mustard small text-nowrap">Ver todos →</a>
              </div>
              <div className="row row-cols-1 row-cols-md-2 row-cols-xl-4 g-3">
                {popularCourses.map((course) => (
                  <div className="col" key={course.title}>
                    <article className="dashboard-popular-card h-100">
                      <span className="dashboard-popular-icon">{course.icon}</span>
                      <div>
                        <span className="text-secondary small">{course.category} · {course.level}</span>
                        <h3 className="h6 fw-bold my-2">{course.title}</h3>
                        <a href="#recomendados" className="link-mustard small">Explorar curso →</a>
                      </div>
                    </article>
                  </div>
                ))}
              </div>
            </section>

            <section
              className="dashboard-hero d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3 p-4 mt-5"
              id="comunidad"
            >
              <div>
                <p className="dashboard-hero-eyebrow text-uppercase fw-bold mb-2">Aprende en comunidad</p>
                <h2 className="h4 fw-bold mb-2">El siguiente paso de tu carrera empieza hoy.</h2>
                <p className="mb-0 opacity-75">Practica, crea proyectos y celebra cada avance.</p>
              </div>
              <a href="#recomendados" className="btn btn-mustard px-4 text-nowrap">Continuar aprendiendo →</a>
            </section>

            <footer className="d-flex flex-column flex-sm-row justify-content-between gap-2 text-secondary small pt-4">
              <span>© 2026 Paradigmia Tech</span>
              <span>Aprende · Practica · Construye</span>
            </footer>
          </main>
        </div>
      </div>
    </main>
  )
}
