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
/** R12: "auto" = modo noche de 20:00 a 6:00; "siempre" y "nunca" lo fijan a mano. */
export type NightMode = 'auto' | 'siempre' | 'nunca'

export interface Preferences {
  fontSize: FontSize
  highContrast: boolean
  reducedMotion: boolean
  nightMode: NightMode
}

export const DEFAULT_PREFERENCES: Preferences = {
  fontSize: 'normal',
  highContrast: false,
  reducedMotion: false,
  nightMode: 'auto',
}

const FONT_SIZES: FontSize[] = ['normal', 'grande', 'muy-grande']
const NIGHT_MODES: NightMode[] = ['auto', 'siempre', 'nunca']
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
      nightMode: NIGHT_MODES.includes(parsed.nightMode as NightMode)
        ? (parsed.nightMode as NightMode)
        : DEFAULT_PREFERENCES.nightMode,
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
  // useEnvironmentRules (R12) lee esta preferencia y decide si activa el modo noche.
  root.dataset.nightPref = preferences.nightMode
}
