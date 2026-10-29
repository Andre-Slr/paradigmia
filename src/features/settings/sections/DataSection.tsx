import { useEffect, useState } from 'react'
import type { User } from '@supabase/supabase-js'
import { getUserEnrollments } from '@/features/courses/courseService'
import { useLearnerProfile } from '@/features/adaptation/useLearnerProfile'
import type { Preferences } from '../preferences'

type Origin = 'explicit' | 'implicit'

interface DataItem {
  label: string
  value: string
  origin: Origin
}

const ORIGIN_TEXT: Record<Origin, string> = {
  explicit: 'Lo diste tú',
  implicit: 'Lo calcula Paradigmia',
}

const FONT_TEXT: Record<Preferences['fontSize'], string> = {
  normal: 'Normal',
  grande: 'Grande',
  'muy-grande': 'Muy grande',
}

function formatDate(value?: string | null): string {
  if (!value) return 'Sin registro'
  return new Date(value).toLocaleString('es-MX', { dateStyle: 'long', timeStyle: 'short' })
}

function DataGroup({ title, place, items }: { title: string; place: string; items: DataItem[] }) {
  return (
    <div className="settings-data-group">
      <h3>{title}</h3>
      <p className="mb-2 small">{place}</p>
      <ul>
        {items.map((item) => (
          <li key={item.label}>
            <span>
              {item.label}
              <span className={`settings-data-tag is-${item.origin}`}>{ORIGIN_TEXT[item.origin]}</span>
            </span>
            <strong>{item.value}</strong>
          </li>
        ))}
      </ul>
    </div>
  )
}

interface DataSectionProps {
  user: User
  preferences: Preferences
}

/**
 * Mis datos: muestra al estudiante qué información guarda Paradigmia sobre él,
 * separada en datos explícitos (los dio él) e implícitos (los calcula el sistema).
 */
export default function DataSection({ user, preferences }: DataSectionProps) {
  const { profile } = useLearnerProfile(user.id)
  const [enrolled, setEnrolled] = useState<number | null>(null)

  useEffect(() => {
    let active = true
    getUserEnrollments(user.id)
      .then((enrollments) => active && setEnrolled(enrollments.length))
      .catch(() => active && setEnrolled(null))
    return () => {
      active = false
    }
  }, [user.id])

  const account: DataItem[] = [
    { label: 'Correo electrónico', value: user.email ?? 'Sin correo', origin: 'explicit' },
    { label: 'Nombre', value: String(user.user_metadata.nombre ?? 'Sin nombre'), origin: 'explicit' },
    { label: 'Fecha de registro', value: formatDate(user.created_at), origin: 'implicit' },
    { label: 'Último acceso', value: formatDate(user.last_sign_in_at), origin: 'implicit' },
  ]

  const learning: DataItem[] = [
    {
      label: 'Respuestas del cuestionario inicial',
      value: profile.nivel ? 'Guardadas' : 'Sin responder',
      origin: 'explicit',
    },
    {
      label: 'Nivel',
      value: profile.nivel ? profile.nivel.charAt(0).toUpperCase() + profile.nivel.slice(1) : 'Sin definir',
      origin: 'implicit',
    },
    {
      label: 'Puntaje del diagnóstico',
      value: profile.diagnostico
        ? `${profile.diagnostico.aciertos} de ${profile.diagnostico.total}`
        : 'No aplica',
      origin: 'implicit',
    },
    {
      label: 'Cursos inscritos',
      value: enrolled === null ? 'Consultando...' : String(enrolled),
      origin: 'explicit',
    },
  ]

  const browser: DataItem[] = [
    { label: 'Tamaño de letra', value: FONT_TEXT[preferences.fontSize], origin: 'explicit' },
    { label: 'Alto contraste', value: preferences.highContrast ? 'Activado' : 'Desactivado', origin: 'explicit' },
    { label: 'Reducir animaciones', value: preferences.reducedMotion ? 'Activado' : 'Desactivado', origin: 'explicit' },
  ]

  return (
    <section className="settings-card" id="datos" aria-labelledby="datos-title">
      <div className="settings-card-head">
        <h2 id="datos-title">Mis datos</h2>
        <p>
          Esta es la información que Paradigmia guarda sobre ti y para qué la usa: adaptar tus
          recomendaciones, tu ruta en cada curso y la forma en que ves la plataforma.
        </p>
      </div>

      <p className="settings-legend">
        <span>
          <span className="settings-data-tag is-explicit">Lo diste tú</span> datos explícitos
        </span>
        <span>
          <span className="settings-data-tag is-implicit">Lo calcula Paradigmia</span> datos implícitos
        </span>
      </p>

      <div className="settings-data">
        <DataGroup title="Tu cuenta" place="Guardado en Supabase" items={account} />
        <DataGroup title="Tu aprendizaje" place="Guardado en Supabase" items={learning} />
        <DataGroup title="Tus preferencias" place="Guardado solo en este navegador" items={browser} />
      </div>
    </section>
  )
}
