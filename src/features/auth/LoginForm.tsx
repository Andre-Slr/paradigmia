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

    if (!normalizedEmail || !password) {
      setError('Escribe tu usuario/correo y contraseña.')
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
