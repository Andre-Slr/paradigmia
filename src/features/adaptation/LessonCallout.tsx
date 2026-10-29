import { useState } from 'react'
import type { CalloutType } from './calloutTypes'

const DEFAULT_TITLE: Record<CalloutType, string> = {
  tip: 'Consejo',
  warning: 'Atención',
  beginner: 'Para principiantes',
}

const ICON: Record<CalloutType, string> = {
  tip: '💡',
  warning: '⚠️',
  beginner: '🌱',
}

interface LessonCalloutProps {
  type: CalloutType
  title?: string
  text: string
  /** Regla R6: si es false, la ayuda para principiantes empieza cerrada. */
  beginnerOpen: boolean
}

/**
 * Recuadro destacado dentro de una lección. En Supabase se guarda en el
 * contenido de la lección como {"type": "tip" | "warning" | "beginner", "title": "...", "text": "..."}.
 */
export default function LessonCallout({ type, title, text, beginnerOpen }: LessonCalloutProps) {
  const [open, setOpen] = useState(beginnerOpen)
  const heading = title || DEFAULT_TITLE[type]

  if (type === 'beginner' && !open) {
    return (
      <div className="student-lesson-callout">
        <button type="button" className="student-callout-toggle" onClick={() => setOpen(true)}>
          {ICON.beginner} Mostrar ayuda: {heading}
        </button>
      </div>
    )
  }

  return (
    <aside className={`student-lesson-callout is-${type}`}>
      <strong>
        <span aria-hidden="true">{ICON[type]} </span>
        {heading}
      </strong>
      <p>{text}</p>
    </aside>
  )
}
