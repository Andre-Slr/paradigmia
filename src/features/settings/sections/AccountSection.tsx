import { useState } from 'react'
import type { FormEvent } from 'react'
import type { User } from '@supabase/supabase-js'
import avatar from '@/assets/icons/perfil-serpiente.png'
import { supabase } from '@/lib/supabaseClient'
import { useProfile } from '@/features/profile/useProfile'

type Message = { type: 'success' | 'error'; text: string } | null

function MessageLine({ message }: { message: Message }) {
  if (!message) return null
  return (
    <p className={`settings-message is-${message.type}`} role={message.type === 'error' ? 'alert' : 'status'}>
      {message.text}
    </p>
  )
}

function ProfileForm({ user, nombre, usuario }: { user: User; nombre: string; usuario: string }) {
  const [name, setName] = useState(nombre)
  const [username, setUsername] = useState(usuario)
  const [saving, setSaving] = useState(false)
  const [message, setMessage] = useState<Message>(null)

  async function handleSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault()
    setMessage(null)

    if (!name.trim() || !username.trim()) {
      setMessage({ type: 'error', text: 'Escribe tu nombre y tu nombre de usuario.' })
      return
    }

    setSaving(true)
    const { error } = await supabase
      .from('perfiles')
      .update({ nombre: name.trim(), usuario: username.trim() })
      .eq('id', user.id)

    if (!error) {
      // También se actualizan los datos de la cuenta, que se usan como respaldo.
      await supabase.auth.updateUser({ data: { nombre: name.trim(), nombre_usuario: username.trim() } })
    }

    setSaving(false)
    setMessage(
      error
        ? { type: 'error', text: `No se pudieron guardar los cambios: ${error.message}` }
        : { type: 'success', text: 'Guardamos tu nombre y tu nombre de usuario.' },
    )
  }

  return (
    <form className="settings-form" onSubmit={handleSubmit}>
      <label className="settings-field">
        <span>Correo electrónico</span>
        <input type="email" value={user.email ?? ''} readOnly />
        <small>El correo identifica tu cuenta y no se puede cambiar desde aquí.</small>
      </label>
      <label className="settings-field">
        <span>Nombre</span>
        <input type="text" value={name} onChange={(event) => setName(event.target.value)} autoComplete="name" />
      </label>
      <label className="settings-field">
        <span>Nombre de usuario</span>
        <input
          type="text"
          value={username}
          onChange={(event) => setUsername(event.target.value)}
          autoComplete="username"
        />
      </label>
      <div>
        <button type="submit" className="student-button" disabled={saving}>
          {saving ? 'Guardando...' : 'Guardar cambios'}
        </button>
        <MessageLine message={message} />
      </div>
    </form>
  )
}

function PasswordForm() {
  const [password, setPassword] = useState('')
  const [confirm, setConfirm] = useState('')
  const [saving, setSaving] = useState(false)
  const [message, setMessage] = useState<Message>(null)

  async function handleSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault()
    setMessage(null)

    if (password.length < 6) {
      setMessage({ type: 'error', text: 'La contraseña debe tener al menos 6 caracteres.' })
      return
    }
    if (password !== confirm) {
      setMessage({ type: 'error', text: 'Las contraseñas no coinciden.' })
      return
    }

    setSaving(true)
    const { error } = await supabase.auth.updateUser({ password })
    setSaving(false)

    if (error) {
      setMessage({ type: 'error', text: `No se pudo cambiar la contraseña: ${error.message}` })
      return
    }
    setPassword('')
    setConfirm('')
    setMessage({ type: 'success', text: 'Cambiamos tu contraseña. Úsala la próxima vez que inicies sesión.' })
  }

  return (
    <form className="settings-form" onSubmit={handleSubmit}>
      <h3>Cambiar contraseña</h3>
      <label className="settings-field">
        <span>Nueva contraseña</span>
        <input
          type="password"
          value={password}
          onChange={(event) => setPassword(event.target.value)}
          autoComplete="new-password"
        />
        <small>Mínimo 6 caracteres.</small>
      </label>
      <label className="settings-field">
        <span>Confirmar nueva contraseña</span>
        <input
          type="password"
          value={confirm}
          onChange={(event) => setConfirm(event.target.value)}
          autoComplete="new-password"
        />
      </label>
      <div>
        <button type="submit" className="student-button-secondary" disabled={saving}>
          {saving ? 'Cambiando...' : 'Cambiar contraseña'}
        </button>
        <MessageLine message={message} />
      </div>
    </form>
  )
}

/** Cuenta: nombre, nombre de usuario y contraseña. */
export default function AccountSection({ user }: { user: User }) {
  const { profile, loading } = useProfile(user.id)

  const nombre = profile?.nombre ?? String(user.user_metadata.nombre ?? '')
  const usuario = profile?.usuario ?? String(user.user_metadata.nombre_usuario ?? '')

  return (
    <section className="settings-card" id="cuenta" aria-labelledby="cuenta-title">
      <div className="settings-card-head">
        <h2 id="cuenta-title">Cuenta</h2>
        <p>Actualiza cómo te mostramos en la plataforma y tu contraseña.</p>
      </div>

      <div className="settings-account">
        <img src={avatar} alt="" className="settings-avatar" />
        <div className="d-grid gap-4">
          {loading ? (
            <p className="mb-0">Cargando tu cuenta...</p>
          ) : (
            <ProfileForm key={profile?.id ?? user.id} user={user} nombre={nombre} usuario={usuario} />
          )}
          <PasswordForm />
        </div>
      </div>
    </section>
  )
}
