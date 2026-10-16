import { useState } from 'react'
import type { FormEvent } from 'react'
import { Link } from 'react-router-dom'
import type { SignUpData, SignUpResult } from './useAuth'

interface RegisterFormProps {
  onSignUp: (data: SignUpData) => Promise<SignUpResult>
}

export default function RegisterForm({ onSignUp }: RegisterFormProps) {
  const [fullName, setFullName] = useState('')
  const [email, setEmail] = useState('')
  const [username, setUsername] = useState('')
  const [password, setPassword] = useState('')
  const [confirmPassword, setConfirmPassword] = useState('')
  const [submitting, setSubmitting] = useState(false)
  const [message, setMessage] = useState('')
  const [error, setError] = useState('')

  async function handleSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault()
    setError('')
    setMessage('')

    const normalizedEmail = email.trim()

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

    setSubmitting(true)

    try {
      const result = await onSignUp({
        email: normalizedEmail,
        password,
        nombre: fullName.trim(),
        nombreUsuario: username.trim(),
      })

      if (result.error) {
        setError(result.error)
      } else if (!result.sessionCreated) {
        setMessage(
          'Cuenta creada. Revisa la configuración de confirmación de correo.'
        )
      }
    } finally {
      setSubmitting(false)
    }
  }

  return (
    <>
      <form className="d-grid gap-3" onSubmit={handleSubmit}>
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
          onChange={(event) => setConfirmPassword(event.target.value)}
          placeholder="Confirmar contraseña"
          autoComplete="new-password"
          aria-label="Confirmar contraseña"
        />

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
          {submitting ? 'Procesando...' : 'Crear cuenta'}
        </button>
      </form>

      <p className="text-center text-secondary mt-3 mb-0">
        ¿Ya tienes una cuenta?{' '}
        <Link to="/login" className="text-button">
          Inicia sesión
        </Link>
      </p>
    </>
  )
}
