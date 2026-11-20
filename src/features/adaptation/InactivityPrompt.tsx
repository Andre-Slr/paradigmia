import { useEffect, useRef, useState } from 'react'
import { getInactivityRule, isInactive } from './ruleInterpreter'

const ACTIVITY_EVENTS = ['mousemove', 'mousedown', 'keydown', 'scroll', 'touchstart'] as const

/** Evento que avisa a cualquier temporizador de estudio que debe pausarse o reanudarse. */
export const STUDY_TIMER_EVENT = 'paradigmia:study-timer'

// La regla se lee una vez del JSON al cargar la página.
const rule = getInactivityRule()

/**
 * R14 · Inactividad: si el estudiante no mueve el mouse, no escribe ni hace
 * scroll durante los minutos que dice la regla, se muestra "¿Sigues ahí?" y se
 * avisa con un evento para pausar el tiempo de estudio.
 */
export default function InactivityPrompt() {
  const [inactive, setInactive] = useState(false)
  const lastActivity = useRef(0)

  useEffect(() => {
    if (!rule) return
    lastActivity.current = Date.now()

    const markActive = () => {
      lastActivity.current = Date.now()
    }
    for (const eventName of ACTIVITY_EVENTS) {
      window.addEventListener(eventName, markActive, { passive: true })
    }

    const timer = window.setInterval(() => {
      const minutes = (Date.now() - lastActivity.current) / 60_000
      if (isInactive(minutes)) {
        setInactive((wasInactive) => {
          if (!wasInactive) {
            window.dispatchEvent(new CustomEvent(STUDY_TIMER_EVENT, { detail: { paused: true } }))
          }
          return true
        })
      }
    }, 15_000)

    return () => {
      window.clearInterval(timer)
      for (const eventName of ACTIVITY_EVENTS) {
        window.removeEventListener(eventName, markActive)
      }
    }
  }, [])

  if (!rule || !inactive) return null

  function resume() {
    lastActivity.current = Date.now()
    setInactive(false)
    window.dispatchEvent(new CustomEvent(STUDY_TIMER_EVENT, { detail: { paused: false } }))
  }

  return (
    <div className="student-inactivity-backdrop" role="dialog" aria-modal="true" aria-labelledby="inactivity-title">
      <div className="student-inactivity-card">
        <h2 id="inactivity-title">{rule.message}</h2>
        <p>
          Llevas más de {rule.minutes} minutos sin actividad, así que pausamos tu tiempo de estudio.
        </p>
        <button type="button" className="student-button" onClick={resume} autoFocus>
          Sí, continuar
        </button>
      </div>
    </div>
  )
}
