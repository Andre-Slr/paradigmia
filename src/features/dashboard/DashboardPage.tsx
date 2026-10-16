import { useState } from 'react'
import type { User } from '@supabase/supabase-js'
import { useProfile } from '@/features/profile/useProfile'

interface DashboardPageProps {
  user: User
  onLogout: () => Promise<string | null>
}

export default function DashboardPage({ user, onLogout }: DashboardPageProps) {
  const [error, setError] = useState('')
  const { profile } = useProfile(user.id)

  async function handleLogout() {
    setError('')
    const message = await onLogout()
    if (message) setError(message)
  }

  const nombre = profile?.nombre ?? user.user_metadata.nombre ?? user.email

  return (
    <main className="auth">
      <div className="row g-0 flex-grow-1">
        <div className="col-12 auth-form-panel">
          <section className="auth-form">
            <div className="brand-icon">✓</div>
            <h1 className="mt-3 mb-1">¡Bienvenido!</h1>
            <p className="subtitle">Has iniciado sesión correctamente.</p>

            <div className="user-info">
              <span>Sesión iniciada como</span>
              <strong>{nombre}</strong>
            </div>

            {error && (
              <div className="alert alert-danger py-2 mb-0 mt-3" role="alert">
                {error}
              </div>
            )}

            <button
              className="btn btn-light w-100 mt-3"
              type="button"
              onClick={handleLogout}
            >
              Cerrar sesión
            </button>
          </section>
        </div>
      </div>
    </main>
  )
}
