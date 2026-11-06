import { useState } from 'react'
import type { FormEvent } from 'react'
import { Link } from 'react-router-dom'

interface LoginFormProps {
  onSignIn: (email: string, password: string) => Promise<string | null>
}

export default function LoginForm({ onSignIn }: LoginFormProps) {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [submitting, setSubmitting] = useState(false)
  const [error, setError] = useState('')

  async function handleSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault()
    setError('')

    const normalizedEmail = email.trim()

    if (!normalizedEmail) {
      setError('Escribe tu correo.')
      return
    }

    if (!password) {
      setError('Escribe tu contraseña.')
      return
    }

    setSubmitting(true)

    try {
      const message = await onSignIn(normalizedEmail, password)
      if (message) setError(message)
    } finally {
      setSubmitting(false)
    }
  }

  return (
    <>
      <form className="d-grid gap-3" onSubmit={handleSubmit}>
        <div className="form-field">
          <label htmlFor="login-email" className="form-label">
            Correo
          </label>
          <input
            id="login-email"
            type="email"
            className="form-control"
            value={email}
            onChange={(event) => setEmail(event.target.value)}
            placeholder="ejemplo@gmail.com"
            autoComplete="username"
          />
        </div>
        <div className="form-field">
          <label htmlFor="login-password" className="form-label">
            Contraseña
          </label>
          <input
            id="login-password"
            type="password"
            className="form-control"
            value={password}
            onChange={(event) => setPassword(event.target.value)}
            placeholder="*****"
            autoComplete="current-password"
          />
        </div>

        {error && (
          <div className="alert alert-danger py-2 mb-0" role="alert">
            {error}
          </div>
        )}

        <button
          className="btn btn-primary w-100 mt-2"
          type="submit"
          disabled={submitting}
        >
          {submitting ? 'Procesando...' : 'Iniciar sesión'}
        </button>
      </form>

      <p className="text-center text-secondary mt-3 mb-0">
        <Link to="/register" className="text-button">
          Crear cuenta
        </Link>
      </p>
    </>
  )
}
