
import { useEffect, useState } from 'react'
import type { FormEvent } from 'react'
import type { User } from '@supabase/supabase-js'
import { supabase } from './lib/supabaseClient'
import './index.css'

export default function App() {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
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

  async function handleSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault()
    setError('')
    setMessage('')

    const normalizedEmail = email.trim()

    if (!normalizedEmail || !password) {
      setError('Escribe tu correo y contraseña.')
      return
    }

    setSubmitting(true)

    try {
      if (registerMode) {
        const { data, error } = await supabase.auth.signUp({
          email: normalizedEmail,
          password,
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
    setError('')
    setMessage('')

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
      <main className="page">
        <section className="card">
          <p>Comprobando sesión...</p>
        </section>
      </main>
    )
  }

  if (user) {
    return (
      <main className="page">
        <section className="card">
          <div className="brand-icon">✓</div>
          <p className="eyebrow">MI PROYECTO</p>
          <h1>¡Bienvenido!</h1>
          <p className="subtitle">
            Has iniciado sesión correctamente.
          </p>

          <div className="user-info">
            <span>Sesión iniciada como</span>
            <strong>{user.email}</strong>
          </div>

          {message && (
            <p className="success" role="status">{message}</p>
          )}

          {error && (
            <p className="error" role="alert">{error}</p>
          )}

          <button
            className="button secondary"
            type="button"
            onClick={handleLogout}
          >
            Cerrar sesión
          </button>
        </section>
      </main>
    )
  }

  return (
    <main className="page">
      <section className="card">
        <div className="brand-icon">S</div>
        <p className="eyebrow">MI PROYECTO REACT</p>

        <h1>
          {registerMode ? 'Crear cuenta' : 'Bienvenido de nuevo'}
        </h1>

        <p className="subtitle">
          {registerMode
            ? 'Crea tu cuenta para comenzar.'
            : 'Ingresa tus datos para continuar.'}
        </p>

        <form onSubmit={handleSubmit}>
          <label htmlFor="email">Correo electrónico</label>
          <input
            id="email"
            type="email"
            value={email}
            onChange={(event) => setEmail(event.target.value)}
            placeholder="tu@correo.com"
            autoComplete="email"
            required
          />

          <label htmlFor="password">Contraseña</label>
          <input
            id="password"
            type="password"
            value={password}
            onChange={(event) => setPassword(event.target.value)}
            placeholder="Mínimo 6 caracteres"
            autoComplete={
              registerMode ? 'new-password' : 'current-password'
            }
            minLength={6}
            required
          />

          {error && (
            <p className="error" role="alert">{error}</p>
          )}

          {message && (
            <p className="success" role="status">{message}</p>
          )}

          <button
            className="button"
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

        <p className="switch-mode">
          {registerMode
            ? '¿Ya tienes una cuenta?'
            : '¿No tienes una cuenta?'}
          {' '}
          <button
            type="button"
            className="text-button"
            onClick={() => {
              setRegisterMode((current) => !current)
              setMessage('')
              setError('')
            }}
          >
            {registerMode ? 'Inicia sesión' : 'Regístrate'}
          </button>
        </p>
      </section>
    </main>
  )
}
