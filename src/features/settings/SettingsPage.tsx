import { useEffect } from 'react'
import { useLocation } from 'react-router-dom'
import type { User } from '@supabase/supabase-js'
import '@/styles/student.css'
import AppShell from '@/components/layout/AppShell'
import mascot from '@/assets/branding/mascota-serpiente.png'
import hojasSuperiorIzquierda from '@/assets/decor/hojas-superior-izquierda.png'
import hojasInferiorDerecha from '@/assets/decor/hojas-inferior-derecha.png'
import AccountSection from './sections/AccountSection'
import AppearanceSection from './sections/AppearanceSection'
import DataSection from './sections/DataSection'
import LearningSection from './sections/LearningSection'
import { usePreferences } from './usePreferences'

interface SettingsPageProps {
  user: User
  onLogout: () => Promise<string | null>
}

const SECTIONS = [
  { id: 'apariencia', label: 'Apariencia' },
  { id: 'aprendizaje', label: 'Aprendizaje' },
  { id: 'cuenta', label: 'Cuenta' },
  { id: 'datos', label: 'Mis datos' },
]

/**
 * Configuración: personaliza la experiencia (adaptabilidad) sin cambiar las
 * decisiones del motor de adaptación ni el progreso del estudiante.
 */
export default function SettingsPage({ user, onLogout }: SettingsPageProps) {
  const { preferences, update } = usePreferences(user.id)
  const { hash } = useLocation()

  // Al llegar con una sección en la dirección (por ejemplo, #aprendizaje), se desplaza hasta ella.
  useEffect(() => {
    if (hash) document.getElementById(hash.slice(1))?.scrollIntoView()
  }, [hash])

  return (
    <AppShell onLogout={onLogout}>
      <div className="settings-page">
        <header className="student-dashboard-hero settings-hero">
          <div className="student-banner-decor student-banner-decor-top-left" aria-hidden="true">
            <img src={hojasSuperiorIzquierda} alt="" />
          </div>
          <div className="student-banner-decor student-banner-decor-bottom-right" aria-hidden="true">
            <img src={hojasInferiorDerecha} alt="" />
          </div>

          <div className="student-dashboard-copy">
            <div className="student-dashboard-kicker">Configuración</div>
            <h1>Ajusta Paradigmia a tu manera</h1>
            <p>
              Cambia cómo ves la plataforma, revisa tu perfil de aprendizaje y administra tu cuenta.
              Tus cursos y tu progreso no cambian.
            </p>
          </div>

          <div className="student-dashboard-visual" aria-hidden="true">
            <img src={mascot} alt="" />
          </div>
        </header>

        <nav className="settings-nav" aria-label="Secciones de configuración">
          {SECTIONS.map((section) => (
            <a key={section.id} href={`#${section.id}`}>
              {section.label}
            </a>
          ))}
        </nav>

        <AppearanceSection preferences={preferences} onChange={update} />
        <LearningSection userId={user.id} />
        <AccountSection user={user} />
        <DataSection user={user} preferences={preferences} />
      </div>
    </AppShell>
  )
}
