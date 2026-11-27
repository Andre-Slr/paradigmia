import { useState } from 'react'
import { NavLink } from 'react-router-dom'
import logo from '@/assets/branding/logo-paradigmia.png'
import homeIcon from '@/assets/icons/inicio.png'
import courseIcon from '@/assets/icons/cursos.png'
import configIcon from '@/assets/icons/configuracion.png'
import logoutIcon from '@/assets/icons/salir.png'

interface SidebarProps {
  onLogout?: () => Promise<string | null> | string | null | void
}

export default function Sidebar({ onLogout }: SidebarProps) {
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false)

  async function handleLogout() {
    const confirmed = window.confirm('¿Estás seguro de que deseas salir?')
    if (!confirmed) return

    if (onLogout) {
      await onLogout()
    }
  }

  return (
    <nav
      className={`student-sidebar${isMobileMenuOpen ? ' is-mobile-open' : ''}`}
      aria-label="Menú del estudiante"
    >
      <div className="student-brand" aria-label="Paradigmia">
        <img src={logo} alt="Paradigmia" className="student-brand-logo" />
        <button
          type="button"
          className="student-menu-toggle"
          aria-label={isMobileMenuOpen ? 'Contraer menú' : 'Expandir menú'}
          aria-expanded={isMobileMenuOpen}
          aria-controls="student-navigation-links"
          onClick={() => setIsMobileMenuOpen((isOpen) => !isOpen)}
        >
          <span />
          <span />
          <span />
        </button>
      </div>

      <div
        id="student-navigation-links"
        className="student-nav-group"
        onClick={() => setIsMobileMenuOpen(false)}
      >
        <NavLink
          to="/dashboard"
          className={({ isActive }) =>
            `student-nav-item${isActive ? ' is-active' : ''}`
          }
        >
          <span className="student-nav-icon" aria-hidden="true">
            <img src={homeIcon} alt="" />
          </span>
          <span>Inicio</span>
        </NavLink>

        <div className="student-nav-group courses-group">
          <div className="student-nav-label">Cursos</div>
          <div className="student-courses-list">
            <NavLink
              to="/courses"
              className={({ isActive }) =>
                `student-nav-item student-subitem${isActive ? ' is-active' : ''}`
              }
            >
              <span className="student-nav-icon" aria-hidden="true">
                <img src={courseIcon} alt="" />
              </span>
              <span>Todos</span>
            </NavLink>
            <NavLink
              to="/my-courses"
              className={({ isActive }) =>
                `student-nav-item student-subitem${isActive ? ' is-active' : ''}`
              }
            >
              <span className="student-nav-icon" aria-hidden="true">
                <img src={courseIcon} alt="" />
              </span>
              <span>Mis cursos</span>
            </NavLink>
          </div>
        </div>

        <NavLink
          to="/settings"
          className={({ isActive }) =>
            `student-nav-item${isActive ? ' is-active' : ''}`
          }
        >
          <span className="student-nav-icon" aria-hidden="true">
            <img src={configIcon} alt="" />
          </span>
          <span>Configuración</span>
        </NavLink>
      </div>

      <button type="button" className="student-logout" onClick={handleLogout}>
        <span className="student-nav-icon" aria-hidden="true">
          <img src={logoutIcon} alt="" />
        </span>
        <span>Salir</span>
      </button>
    </nav>
  )
}
