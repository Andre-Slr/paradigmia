import { useCallback, useState } from 'react'
import { applyPreferences, loadPreferences, savePreferences } from './preferences'
import type { Preferences } from './preferences'

/** Lee, cambia y aplica las preferencias de apariencia de un usuario. */
export function usePreferences(userId: string) {
  const [preferences, setPreferences] = useState<Preferences>(() => loadPreferences(userId))

  const update = useCallback(
    (changes: Partial<Preferences>) => {
      setPreferences((previous) => {
        const next = { ...previous, ...changes }
        savePreferences(userId, next)
        applyPreferences(next)
        return next
      })
    },
    [userId],
  )

  return { preferences, update }
}
