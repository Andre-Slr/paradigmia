/**
 * Preferencias de apariencia y accesibilidad (datos explícitos 14, 15 y 16).
 *
 * Por acuerdo del equipo se guardan en el navegador (localStorage), separadas
 * por usuario, para no modificar Supabase. Más adelante se pueden pasar a una
 * tabla si hace falta sincronizarlas entre dispositivos.
 *
 * Se aplican como atributos en la etiqueta <html>, y los estilos de
 * settings.css reaccionan a ellos en toda la plataforma.
 */

export type FontSize = 'normal' | 'grande' | 'muy-grande'

export interface Preferences {
  fontSize: FontSize
  highContrast: boolean
  reducedMotion: boolean
}

export const DEFAULT_PREFERENCES: Preferences = {
  fontSize: 'normal',
  highContrast: false,
  reducedMotion: false,
}

const FONT_SIZES: FontSize[] = ['normal', 'grande', 'muy-grande']
const LAST_USER_KEY = 'paradigmia:preferencias:ultimo-usuario'

function storageKey(userId: string) {
  return `paradigmia:preferencias:${userId}`
}

/** Lee las preferencias guardadas; si no hay o están dañadas, usa las de por defecto. */
export function loadPreferences(userId: string | null): Preferences {
  try {
    const id = userId ?? window.localStorage.getItem(LAST_USER_KEY)
    if (!id) return DEFAULT_PREFERENCES
    const raw = window.localStorage.getItem(storageKey(id))
    const parsed = raw ? (JSON.parse(raw) as Partial<Preferences>) : {}
    return {
      fontSize: FONT_SIZES.includes(parsed.fontSize as FontSize)
        ? (parsed.fontSize as FontSize)
        : DEFAULT_PREFERENCES.fontSize,
      highContrast: parsed.highContrast === true,
      reducedMotion: parsed.reducedMotion === true,
    }
  } catch {
    return DEFAULT_PREFERENCES
  }
}

export function savePreferences(userId: string, preferences: Preferences) {
  try {
    window.localStorage.setItem(storageKey(userId), JSON.stringify(preferences))
    // Recordamos al último usuario para aplicar sus preferencias desde la primera pantalla.
    window.localStorage.setItem(LAST_USER_KEY, userId)
  } catch {
    // Si el navegador bloquea el almacenamiento, las preferencias duran solo esta visita.
  }
}

/** Aplica las preferencias a toda la página. */
export function applyPreferences(preferences: Preferences) {
  const root = document.documentElement
  root.dataset.fontSize = preferences.fontSize
  root.dataset.contrast = preferences.highContrast ? 'alto' : 'normal'
  root.dataset.motion = preferences.reducedMotion ? 'reducido' : 'normal'
}
