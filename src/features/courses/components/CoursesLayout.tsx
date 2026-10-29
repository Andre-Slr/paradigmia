import type { ReactNode } from 'react'
import { Link, NavLink } from 'react-router-dom'
import '../courses.css'

interface CoursesLayoutProps {
  children: ReactNode
}

/** Estructura común de las vistas de cursos: barra superior y contenido. */
export default function CoursesLayout({ children }: CoursesLayoutProps) {
  return (
    <div className="courses">
      <header className="courses-topbar">
        <Link to="/dashboard" className="courses-brand" aria-label="Paradigmia, inicio">
          <span className="courses-brand-mark" aria-hidden="true">P</span>
          Paradigmia
        </Link>
        <nav aria-label="Navegación de cursos">
          <NavLink to="/dashboard">Inicio</NavLink>
          <NavLink to="/cursos">Cursos</NavLink>
        </nav>
      </header>
      <main className="courses-main">{children}</main>
    </div>
  )
}
