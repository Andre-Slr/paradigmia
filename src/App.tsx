import { useEffect, useState } from 'react'
import type { FormEvent } from 'react'
import type { User } from '@supabase/supabase-js'
import { supabase } from './lib/supabaseClient'

export default function App() {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [fullName, setFullName] = useState('')
  const [username, setUsername] = useState('')
  const [confirmPassword, setConfirmPassword] = useState('')
  const [user, setUser] = useState<User | null>(null)
  const [loading, setLoading] = useState(true)
  const [submitting, setSubmitting] = useState(false)
  const [registerMode, setRegisterMode] = useState(false)
  const [message, setMessage] = useState('')
  const [error, setError] = useState('')

  useEffect(() => {
    let active = true

    async function loadSession() {
      const { data, error } = await supabase.auth.getSession()

      if (!active) return

      if (error) {
        setError(error.message)
      } else {
        setUser(data.session?.user ?? null)
      }

      setLoading(false)
    }

    void loadSession()

    const {
      data: { subscription },
    } = supabase.auth.onAuthStateChange((_event, session) => {
      setUser(session?.user ?? null)
    })

    return () => {
      active = false
      subscription.unsubscribe()
    }
  }, [])

  function resetFeedback() {
    setError('')
    setMessage('')
  }

  function toggleMode() {
    setRegisterMode((current) => !current)
    resetFeedback()
    setPassword('')
    setConfirmPassword('')
  }

  async function handleSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault()
    resetFeedback()

    const normalizedEmail = email.trim()

    if (registerMode) {
      if (
        !fullName.trim() ||
        !normalizedEmail ||
        !username.trim() ||
        !password ||
        !confirmPassword
      ) {
        setError('Completa todos los campos.')
        return
      }

      if (password !== confirmPassword) {
        setError('Las contraseñas no coinciden.')
        return
      }
    } else if (!normalizedEmail || !password) {
      setError('Escribe tu usuario/correo y contraseña.')
      return
    }

    setSubmitting(true)

    try {
      if (registerMode) {
        const { data, error } = await supabase.auth.signUp({
          email: normalizedEmail,
          password,
          options: {
            data: {
              nombre: fullName.trim(),
              nombre_usuario: username.trim(),
            },
          },
        })

        if (error) throw error

        if (data.session) {
          setMessage('Cuenta creada. Ya has iniciado sesión.')
        } else {
          setMessage(
            'Cuenta creada. Revisa la configuración de confirmación de correo.'
          )
        }
      } else {
        const { error } = await supabase.auth.signInWithPassword({
          email: normalizedEmail,
          password,
        })

        if (error) throw error

        setMessage('Inicio de sesión correcto.')
      }
    } catch (err: unknown) {
      setError(
        err instanceof Error
          ? err.message
          : 'Ocurrió un error inesperado.'
      )
    } finally {
      setSubmitting(false)
    }
  }

  async function handleLogout() {
    resetFeedback()

    const { error } = await supabase.auth.signOut()

    if (error) {
      setError(error.message)
    } else {
      setPassword('')
      setMessage('Has cerrado la sesión.')
    }
  }

  if (loading) {
    return (
      <main className="auth">
        <div className="d-flex flex-grow-1 align-items-center justify-content-center">
          <p className="subtitle mb-0">Comprobando sesión...</p>
        </div>
      </main>
    )
  }

  if (user) {
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
                <strong>{user.email}</strong>
              </div>

              {message && (
                <div className="alert alert-success py-2 mb-0 mt-3" role="status">
                  {message}
                </div>
              )}

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

  return (
    <main className="auth">
      <div className="row g-0 flex-grow-1">
        {/* Panel izquierdo */}
        <div
          className="col-12 col-md-6 auth-visual d-none d-md-flex"
          aria-hidden="true"
          style={{ backgroundImage: 'url(https://images.pexels.com/photos/39520964/pexels-photo-39520964.jpeg)', backgroundSize: 'cover', backgroundPosition: 'center' }}
        >
        </div>

        {/* Panel derecho */}
        <div className="col-12 col-md-6 auth-form-panel">
          <section className="auth-form">
            <p className="text-center text-primary mb-10 fs-2 fw-bold">
              Paradigmia
            </p>

            <form className="d-grid gap-3" onSubmit={handleSubmit}>
              {registerMode ? (
                <>
                  <input
                    type="text"
                    className="form-control"
                    value={fullName}
                    onChange={(event) => setFullName(event.target.value)}
                    placeholder="Nombre"
                    autoComplete="name"
                    aria-label="Nombre"
                  />
                  <input
                    type="email"
                    className="form-control"
                    value={email}
                    onChange={(event) => setEmail(event.target.value)}
                    placeholder="Correo electrónico"
                    autoComplete="email"
                    aria-label="Correo electrónico"
                  />
                  <input
                    type="text"
                    className="form-control"
                    value={username}
                    onChange={(event) => setUsername(event.target.value)}
                    placeholder="Nombre de usuario"
                    autoComplete="username"
                    aria-label="Nombre de usuario"
                  />
                  <input
                    type="password"
                    className="form-control"
                    value={password}
                    onChange={(event) => setPassword(event.target.value)}
                    placeholder="Contraseña"
                    autoComplete="new-password"
                    aria-label="Contraseña"
                  />
                  <input
                    type="password"
                    className="form-control"
                    value={confirmPassword}
                    onChange={(event) =>
                      setConfirmPassword(event.target.value)
                    }
                    placeholder="Confirmar contraseña"
                    autoComplete="new-password"
                    aria-label="Confirmar contraseña"
                  />
                </>
              ) : (
                <>
                  <input
                    type="email"
                    className="form-control"
                    value={email}
                    onChange={(event) => setEmail(event.target.value)}
                    placeholder="Usuario / correo"
                    autoComplete="username"
                    aria-label="Usuario o correo"
                  />
                  <input
                    type="password"
                    className="form-control"
                    value={password}
                    onChange={(event) => setPassword(event.target.value)}
                    placeholder="Contraseña"
                    autoComplete="current-password"
                    aria-label="Contraseña"
                  />
                </>
              )}

              {error && (
                <div className="alert alert-danger py-2 mb-0" role="alert">
                  {error}
                </div>
              )}

              {message && (
                <div className="alert alert-success py-2 mb-0" role="status">
                  {message}
                </div>
              )}

              <button
                className="btn btn-primary w-100 mt-2"
                type="submit"
                disabled={submitting}
              >
                {submitting
                  ? 'Procesando...'
                  : registerMode
                    ? 'Crear cuenta'
                    : 'Iniciar sesión'}
              </button>
            </form>

            <p className="text-center text-secondary mt-3 mb-0">
              {registerMode ? '¿Ya tienes una cuenta? ' : ''}
              <button
                type="button"
                className="text-button"
                onClick={toggleMode}
              >
                {registerMode ? 'Inicia sesión' : 'Crear cuenta'}
              </button>
            </p>
          </section>
        </div>
      </div>
    </main>
  )
}
