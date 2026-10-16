import { useMemo, useState } from 'react'

type DashboardUser = {
  email?: string
} | null

type DashboardPageProps = {
  user?: DashboardUser
  onLogout?: () => void
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

const styles = `
:root {
  --dp-bg: #061c15;
  --dp-panel: #0b2a20;
  --dp-panel-2: #103629;
  --dp-green: #57d992;
  --dp-green-bright: #79e9a7;
  --dp-text: #eaf6ef;
  --dp-muted: #aec9bb;
  --dp-line: rgba(143, 222, 176, .15);
}
.dashboard-page, .dashboard-page * { box-sizing: border-box; }
.dashboard-page {
  min-height: 100vh; color: var(--dp-text); background: var(--dp-bg);
  font-family: Inter, ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
}
.dashboard-page a { color: inherit; text-decoration: none; }
.dashboard-page button, .dashboard-page input { font: inherit; }
.dp-topbar {
  min-height: 70px; display: flex; align-items: center; gap: 26px; padding: 12px 28px;
  background: #071f17; border-bottom: 1px solid var(--dp-line);
}
.dp-brand { display: flex; align-items: center; gap: 9px; min-width: 205px; color: var(--dp-green-bright); font-size: 23px; font-weight: 800; letter-spacing: -.7px; }
.dp-brand-mark { font-size: 18px; color: #a5f4c5; }
.dp-brand small { color: #d3e9dc; font-size: 13px; letter-spacing: 0; }
.dp-search { display: flex; align-items: center; gap: 10px; width: min(460px, 40vw); padding: 10px 14px; border: 1px solid var(--dp-line); border-radius: 22px; background: #103528; color: var(--dp-muted); }
.dp-search input { width: 100%; min-width: 0; outline: none; border: 0; background: transparent; color: var(--dp-text); }
.dp-search input::placeholder { color: #9db9aa; }
.dp-actions { margin-left: auto; display: flex; align-items: center; gap: 10px; color: var(--dp-muted); }
.dp-user { display: flex; align-items: center; gap: 9px; }
.dp-avatar { width: 35px; height: 35px; display: grid; place-items: center; border-radius: 50%; color: #052016; background: var(--dp-green); font-weight: 800; }
.dp-logout { border: 1px solid var(--dp-line); border-radius: 9px; padding: 8px 11px; color: var(--dp-text); background: transparent; cursor: pointer; }
.dp-layout { display: grid; grid-template-columns: 230px minmax(0, 1fr); }
.dp-sidebar { min-height: calc(100vh - 70px); padding: 24px 15px; border-right: 1px solid var(--dp-line); background: #071f17; display: flex; flex-direction: column; }
.dp-nav { display: grid; gap: 7px; }
.dp-nav a { display: flex; align-items: center; gap: 13px; padding: 12px 14px; border-radius: 10px; color: #c4d9ce; }
.dp-nav a span { width: 20px; text-align: center; color: var(--dp-green); font-size: 19px; }
.dp-nav a.active, .dp-nav a:hover { background: #174531; color: #fff; }
.dp-sidebar-note { margin-top: auto; padding: 15px; border: 1px solid var(--dp-line); border-radius: 13px; background: #0b2a20; }
.dp-sidebar-note strong { font-size: 13px; }
.dp-sidebar-note p { margin: 8px 0 0; color: var(--dp-muted); font-size: 12px; line-height: 1.6; }
.dp-dot { display: inline-block; width: 7px; height: 7px; margin-right: 7px; border-radius: 50%; background: var(--dp-green); }
.dp-main { min-width: 0; padding: 27px 28px 18px; }
.dp-hero { display: grid; grid-template-columns: minmax(0, 1.1fr) minmax(260px, .9fr); gap: 25px; align-items: center; min-height: 300px; padding: 24px 25px; overflow: hidden; border: 1px solid var(--dp-line); border-radius: 18px; background: linear-gradient(120deg, #0c3022, #09251b 72%); }
.dp-eyebrow { margin: 0 0 12px; color: var(--dp-green); font-size: 11px; font-weight: 800; letter-spacing: 1.6px; }
.dp-hero h1 { max-width: 620px; margin: 0; font-size: clamp(30px, 3.1vw, 48px); line-height: 1.12; letter-spacing: -1.3px; }
.dp-hero h1 span { color: var(--dp-green-bright); }
.dp-hero-description { max-width: 540px; margin: 17px 0 21px; color: #c0d8cb; font-size: 15px; line-height: 1.7; }
.dp-primary { display: inline-flex; align-items: center; gap: 17px; padding: 13px 19px; border: 0; border-radius: 10px; background: var(--dp-green); color: #062216 !important; font-weight: 800; }
.dp-stats { display: flex; flex-wrap: wrap; gap: 22px; margin-top: 25px; color: #c6dfd1; font-size: 12px; }
.dp-stats b { margin-right: 7px; color: var(--dp-green-bright); font-size: 17px; }
.dp-art { position: relative; min-height: 235px; display: grid; place-items: center; overflow: hidden; border-radius: 18px; background: radial-gradient(ellipse at center, #164a32 0, #0d3424 48%, transparent 72%); }
.dp-art-circle { position: absolute; width: 230px; height: 190px; border-radius: 48% 52% 45% 55%; background: #17452f; }
.dp-code-bubble { position: absolute; top: 17px; right: 25px; padding: 13px 17px; border-radius: 13px 13px 13px 2px; background: #225b3d; color: var(--dp-green-bright); font-size: 20px; font-weight: 800; }
.dp-mascot { position: absolute; top: 37px; left: 50%; width: 150px; height: 125px; transform: translateX(-50%); }
.dp-head { position: absolute; top: 24px; left: 10px; right: 10px; height: 86px; display: flex; justify-content: center; align-items: center; gap: 13px; border: 5px solid #0a2118; border-radius: 43% 43% 35% 35%; background: #55d88e; box-shadow: inset 0 -8px 0 rgba(0,0,0,.1); }
.dp-eye { width: 39px; height: 43px; display: grid; place-items: center; border: 4px solid #16402b; border-radius: 50%; background: #effff5; }
.dp-eye:after { content: ""; width: 12px; height: 15px; border-radius: 50%; background: #0a2b1c; }
.dp-antenna { position: absolute; top: 0; width: 6px; height: 35px; border-radius: 5px; background: #42c77e; }
.dp-antenna:after { content: ""; position: absolute; top: -5px; left: -5px; width: 16px; height: 16px; border-radius: 50%; background: #70e5a1; }
.dp-antenna.left { left: 37px; transform: rotate(-23deg); }
.dp-antenna.right { right: 36px; transform: rotate(23deg); }
.dp-laptop { position: absolute; z-index: 2; bottom: 15px; left: 50%; width: 190px; height: 84px; display: grid; place-items: center; transform: translateX(-50%) perspective(220px) rotateX(-4deg); border: 5px solid #163e2b; border-radius: 10px 10px 5px 5px; background: #123c29; color: var(--dp-green-bright); font-size: 31px; font-weight: 800; box-shadow: 0 10px 0 #092519; }
.dp-books { position: absolute; right: 13px; bottom: 22px; display: grid; gap: 4px; }
.dp-books span { width: 70px; height: 16px; border: 2px solid #28784c; border-radius: 4px; background: #61d992; }
.dp-books span:nth-child(2) { width: 83px; background: #b0efc5; }
.dp-plant { position: absolute; right: 8px; top: 88px; width: 32px; height: 58px; border-bottom: 23px solid #226341; border-left: 5px solid transparent; border-right: 5px solid transparent; }
.dp-plant:before, .dp-plant:after { content: ""; position: absolute; top: -18px; width: 18px; height: 30px; border-radius: 100% 0 100% 0; background: #53c982; }
.dp-plant:before { left: -15px; transform: rotate(-24deg); }
.dp-plant:after { right: -13px; transform: rotate(35deg) scaleX(-1); }
.dp-section { margin-top: 29px; }
.dp-section-heading { display: flex; align-items: end; justify-content: space-between; gap: 16px; margin-bottom: 15px; }
.dp-section-heading h2 { margin: 0; font-size: 23px; letter-spacing: -.5px; }
.dp-section-heading p { margin: 6px 0 0; color: var(--dp-muted); font-size: 13px; }
.dp-text-link { color: var(--dp-green-bright) !important; font-size: 13px; white-space: nowrap; }
.dp-course-grid { display: grid; grid-template-columns: repeat(4, minmax(0, 1fr)); gap: 15px; }
.dp-course-card { position: relative; min-width: 0; padding: 17px; border: 1px solid var(--dp-line); border-radius: 14px; background: linear-gradient(145deg, #0d3023, #0a251b); }
.dp-course-top { display: flex; align-items: start; justify-content: space-between; gap: 7px; }
.dp-course-icon { width: 43px; height: 43px; display: grid; place-items: center; border-radius: 10px; font-size: 20px; font-weight: 900; }
.dp-course-icon.javascript { background: #f4d94e; color: #151b12; }
.dp-course-icon.python { background: #225f87; color: #ffe17c; }
.dp-course-icon.react { background: #123f39; color: #64e9e5; font-size: 29px; }
.dp-course-icon.node { background: #214a32; color: #81e29c; }
.dp-level { padding: 5px 8px; border-radius: 20px; background: #194c35; color: #a8f1c1; font-size: 10px; white-space: nowrap; }
.dp-course-card h3 { margin: 15px 0 8px; font-size: 15px; line-height: 1.35; }
.dp-course-description { min-height: 58px; margin: 0; color: var(--dp-muted); font-size: 12px; line-height: 1.6; }
.dp-meta { display: flex; flex-wrap: wrap; gap: 12px; margin-top: 14px; color: #bdd5c8; font-size: 11px; }
.dp-progress-row { display: flex; align-items: center; gap: 9px; margin-top: 13px; color: #d6e8de; font-size: 10px; }
.dp-progress-track { height: 7px; flex: 1; overflow: hidden; border-radius: 8px; background: #234c39; }
.dp-progress-track span { display: block; height: 100%; border-radius: inherit; background: var(--dp-green); }
.dp-category-grid { display: grid; grid-template-columns: repeat(6, minmax(0, 1fr)); gap: 12px; }
.dp-category { display: flex; align-items: center; gap: 10px; min-width: 0; padding: 15px 13px; border: 1px solid var(--dp-line); border-radius: 12px; background: #0c2b20; }
.dp-category-icon { color: var(--dp-green); font-size: 22px; }
.dp-category strong { overflow: hidden; font-size: 12px; text-overflow: ellipsis; }
.dp-category-arrow { margin-left: auto; color: var(--dp-muted); }
.dp-popular-grid { display: grid; grid-template-columns: repeat(4, minmax(0, 1fr)); gap: 15px; }
.dp-popular-card { display: flex; align-items: start; gap: 12px; padding: 16px; border: 1px solid var(--dp-line); border-radius: 13px; background: #0b2a20; }
.dp-popular-icon { width: 39px; height: 39px; flex: 0 0 39px; display: grid; place-items: center; border-radius: 10px; background: #174832; font-size: 20px; }
.dp-popular-category { color: var(--dp-green); font-size: 10px; }
.dp-popular-card h3 { margin: 7px 0 10px; font-size: 13px; line-height: 1.45; }
.dp-popular-card a { color: var(--dp-green-bright); font-size: 11px; }
.dp-community { display: flex; align-items: center; justify-content: space-between; gap: 20px; margin-top: 30px; padding: 24px; border: 1px solid var(--dp-line); border-radius: 15px; background: #0c3022; }
.dp-community h2 { margin: 0; font-size: 21px; }
.dp-community p:last-child { margin: 8px 0 0; color: var(--dp-muted); font-size: 13px; }
.dp-footer { display: flex; justify-content: space-between; gap: 15px; padding: 24px 2px 8px; color: #789989; font-size: 11px; }
@media (max-width: 1150px) {
  .dp-layout { grid-template-columns: 190px minmax(0, 1fr); }
  .dp-course-grid, .dp-popular-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); }
  .dp-category-grid { grid-template-columns: repeat(3, minmax(0, 1fr)); }
  .dp-main { padding: 22px; }
  .dp-brand { min-width: auto; }
}
@media (max-width: 760px) {
  .dp-topbar { flex-wrap: wrap; gap: 12px; padding: 13px 16px; }
  .dp-brand { flex: 1; }
  .dp-search { order: 3; width: 100%; }
  .dp-user-name { display: none; }
  .dp-layout { display: block; }
  .dp-sidebar { min-height: 0; padding: 10px; border-right: 0; border-bottom: 1px solid var(--dp-line); }
  .dp-nav { display: flex; overflow-x: auto; }
  .dp-nav a { flex: 0 0 auto; padding: 10px; font-size: 12px; }
  .dp-nav a span { display: none; }
  .dp-sidebar-note { display: none; }
  .dp-main { padding: 16px; }
  .dp-hero { grid-template-columns: 1fr; padding: 22px; }
  .dp-art { min-height: 210px; }
  .dp-course-grid, .dp-popular-grid { grid-template-columns: 1fr; }
  .dp-category-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); }
  .dp-community, .dp-footer { align-items: start; flex-direction: column; }
  .dp-section-heading h2 { font-size: 20px; }
}
`

export default function MainPage({ user, onLogout }: DashboardPageProps) {
  const [search, setSearch] = useState('')
  const firstName = user?.email?.split('@')[0] || 'estudiante'

  const filteredCourses = useMemo(() => {
    const query = search.trim().toLowerCase()
    if (!query) return recommendedCourses
    return recommendedCourses.filter((course) =>
      `${course.title} ${course.description} ${course.category} ${course.level}`.toLowerCase().includes(query),
    )
  }, [search])

  return (
    <div className="dashboard-page">
      <style>{styles}</style>
      <header className="dp-topbar">
        <a className="dp-brand" href="/dashboard" aria-label="Paradigmia, inicio">
          <span className="dp-brand-mark">&lt;/&gt;</span>
          <span>Paradigmia <small>Tech</small></span>
        </a>

        <label className="dp-search">
          <span aria-hidden="true">⌕</span>
          <input
            type="search"
            value={search}
            onChange={(event) => setSearch(event.target.value)}
            placeholder="Buscar cursos, tecnologías..."
            aria-label="Buscar cursos"
          />
        </label>

        <div className="dp-actions">
          <span aria-hidden="true">♧</span>
          <div className="dp-user">
            <span className="dp-avatar" aria-hidden="true">{firstName.charAt(0).toUpperCase()}</span>
            <span className="dp-user-name">{firstName}</span>
          </div>
          {onLogout && <button className="dp-logout" type="button" onClick={onLogout}>Cerrar sesión</button>}
        </div>
      </header>

      <div className="dp-layout">
        <aside className="dp-sidebar">
          <nav className="dp-nav" aria-label="Navegación principal">
            <a className="active" href="/dashboard"><span>⌂</span>Inicio</a>
            <a href="#recomendados"><span>▣</span>Cursos</a>
            <a href="#categorias"><span>◇</span>Rutas de aprendizaje</a>
            <a href="#populares"><span>▤</span>Recursos</a>
            <a href="#comunidad"><span>♧</span>Comunidad</a>
            <a href="#progreso"><span>▥</span>Mi progreso</a>
          </nav>
          <div className="dp-sidebar-note">
            <strong><span className="dp-dot" />Tu próximo nivel</strong>
            <p>Un poco de práctica cada día hace la diferencia.</p>
          </div>
        </aside>

        <main className="dp-main">
          <section className="dp-hero">
            <div>
              <p className="dp-eyebrow">TU APRENDIZAJE, A TU RITMO</p>
              <h1>Tu camino en la <span>programación</span> empieza aquí</h1>
              <p className="dp-hero-description">
                Aprende a tu ritmo, con cursos prácticos, proyectos reales y una comunidad que te acompaña.
              </p>
              <a className="dp-primary" href="#recomendados">Explorar cursos <span aria-hidden="true">→</span></a>
              <div className="dp-stats">
                <span><b>&lt;/&gt;</b> +200 cursos</span>
                <span><b>♧</b> Comunidad activa</span>
                <span><b>★</b> Certificados</span>
              </div>
            </div>
            <div className="dp-art" aria-label="Ilustración estática de programación" role="img">
              <div className="dp-art-circle" />
              <div className="dp-code-bubble">&lt;/&gt;</div>
              <div className="dp-plant" />
              <div className="dp-books"><span /><span /><span /></div>
              <div className="dp-mascot">
                <div className="dp-antenna left" />
                <div className="dp-antenna right" />
                <div className="dp-head"><span className="dp-eye" /><span className="dp-eye" /></div>
              </div>
              <div className="dp-laptop">&lt;/&gt;</div>
            </div>
          </section>

          <section className="dp-section" id="recomendados">
            <div className="dp-section-heading">
              <div>
                <h2>Recomendado para ti</h2>
                <p>Basado en tu progreso y en tus intereses.</p>
              </div>
              <a href="#populares" className="dp-text-link">Ver todos →</a>
            </div>

            <div className="dp-course-grid">
              {filteredCourses.map((course) => (
                <article className="dp-course-card" key={course.title}>
                  <div className="dp-course-top">
                    <div className={`dp-course-icon ${course.iconClass}`}>{course.icon}</div>
                    <span className="dp-level">{course.level}</span>
                  </div>
                  <h3>{course.title}</h3>
                  <p className="dp-course-description">{course.description}</p>
                  <div className="dp-meta"><span>◷ {course.duration}</span><span>▤ {course.modules}</span></div>
                  <div className="dp-progress-row" id="progreso">
                    <div className="dp-progress-track" aria-label={`${course.progress}% completado`}>
                      <span style={{ width: `${course.progress}%` }} />
                    </div>
                    <span>{course.progress}%</span>
                  </div>
                </article>
              ))}
              {filteredCourses.length === 0 && (
                <p role="status">No se encontraron cursos recomendados para “{search}”. Prueba otra búsqueda.</p>
              )}
            </div>
          </section>

          <section className="dp-section" id="categorias">
            <div className="dp-section-heading">
              <div><h2>Explora por categoría</h2><p>Encuentra el área que más te interesa.</p></div>
            </div>
            <div className="dp-category-grid">
              {categories.map((category) => (
                <a href="#populares" className="dp-category" key={category.name}>
                  <span className="dp-category-icon">{category.icon}</span>
                  <strong>{category.name}</strong>
                  <span className="dp-category-arrow">›</span>
                </a>
              ))}
            </div>
          </section>

          <section className="dp-section" id="populares">
            <div className="dp-section-heading">
              <div><h2>Cursos populares</h2><p>Continúa desarrollando habilidades útiles.</p></div>
              <a href="#recomendados" className="dp-text-link">Ver todos →</a>
            </div>
            <div className="dp-popular-grid">
              {popularCourses.map((course) => (
                <article className="dp-popular-card" key={course.title}>
                  <span className="dp-popular-icon">{course.icon}</span>
                  <div>
                    <span className="dp-popular-category">{course.category} · {course.level}</span>
                    <h3>{course.title}</h3>
                    <a href="#recomendados">Explorar curso →</a>
                  </div>
                </article>
              ))}
            </div>
          </section>

          <section className="dp-community" id="comunidad">
            <div>
              <p className="dp-eyebrow">APRENDE EN COMUNIDAD</p>
              <h2>El siguiente paso de tu carrera empieza hoy.</h2>
              <p>Practica, crea proyectos y celebra cada avance.</p>
            </div>
            <a href="#recomendados" className="dp-primary">Continuar aprendiendo →</a>
          </section>

          <footer className="dp-footer">
            <span>© 2026 Paradigmia Tech</span>
            <span>Aprende · Practica · Construye</span>
          </footer>
        </main>
      </div>
    </div>
  )
}
