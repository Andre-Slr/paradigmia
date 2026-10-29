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
  async function handleLogout() {
    if (onLogout) {
      await onLogout()
    }
  }

  return (
    <nav className="student-sidebar" aria-label="Menú del estudiante">
      <div className="student-brand" aria-label="Paradigmia">
        <img src={logo} alt="Paradigmia" className="student-brand-logo" />
        <div className="student-brand-copy">
          <span className="student-brand-name">Paradigmia</span>
          <span className="student-brand-subtitle">Student area</span>
        </div>
      </div>

      <div className="student-nav-group">
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

        <button type="button" className="student-nav-item is-disabled" disabled>
          <span className="student-nav-icon" aria-hidden="true">
            <img src={configIcon} alt="" />
          </span>
          <span>Configuración</span>
        </button>
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
