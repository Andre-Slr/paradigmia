import { useEffect, useState } from 'react'
import { decideLiteMode, isNightTime, type LiteModeDecision } from './ruleInterpreter'

/**
 * Reglas del entorno que dependen del navegador, no de Supabase:
 *  - R12 (horario nocturno): usa la hora local del dispositivo.
 *  - R13 (conexión débil): usa la Network Information API (Chrome, Edge y
 *    Android). En navegadores que no la tienen, se asume conexión normal.
 */

interface NetworkInformationLike extends EventTarget {
  effectiveType?: string
  saveData?: boolean
}

function getConnection(): NetworkInformationLike | null {
  const nav = navigator as Navigator & { connection?: NetworkInformationLike }
  return nav.connection ?? null
}

/** Conexión débil = 2G, "slow-2g" o el ahorro de datos encendido. */
export function readWeakConnection(): boolean {
  const connection = getConnection()
  if (!connection) return false
  return (
    connection.saveData === true ||
    connection.effectiveType === 'slow-2g' ||
    connection.effectiveType === '2g'
  )
}

/** R13: decisión de modo ligero, actualizada cuando cambia la conexión. */
export function useLiteMode(): LiteModeDecision {
  const [weak, setWeak] = useState(readWeakConnection)

  useEffect(() => {
    const connection = getConnection()
    if (!connection) return
    const update = () => setWeak(readWeakConnection())
    connection.addEventListener('change', update)
    return () => connection.removeEventListener('change', update)
  }, [])

  return decideLiteMode(weak)
}

/** R12: ¿es de noche ahora? Se revisa cada minuto. */
export function useNightTime(): boolean {
  const [night, setNight] = useState(() => isNightTime(new Date().getHours()))

  useEffect(() => {
    const timer = window.setInterval(() => setNight(isNightTime(new Date().getHours())), 60_000)
    return () => window.clearInterval(timer)
  }, [])

  return night
}

/**
 * Aplica R12 y R13 a toda la página con atributos en <html>, igual que las
 * preferencias de apariencia: data-night="on" y data-lite="on". El modo noche
 * respeta lo que el usuario eligió en Configuración (data-night-pref).
 */
export function useEnvironmentRules() {
  const night = useNightTime()
  const { lite, hideDecorativeFoliage } = useLiteMode()

  useEffect(() => {
    const root = document.documentElement
    const apply = () => {
      const preference = root.dataset.nightPref ?? 'auto'
      const nightOn = preference === 'siempre' || (preference === 'auto' && night)
      root.dataset.night = nightOn ? 'on' : 'off'
    }
    apply()

    // Si el usuario cambia la preferencia en Configuración, se vuelve a aplicar.
    const observer = new MutationObserver(apply)
    observer.observe(root, { attributes: true, attributeFilter: ['data-night-pref'] })
    return () => observer.disconnect()
  }, [night])

  useEffect(() => {
    const root = document.documentElement
    root.dataset.lite = lite && hideDecorativeFoliage ? 'on' : 'off'
  }, [lite, hideDecorativeFoliage])
}
