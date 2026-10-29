import { useCallback, useEffect, useState } from 'react'
import { supabase } from '@/lib/supabaseClient'
import type { Answers } from './types'

export type OnboardingStatus = 'loading' | 'pending' | 'completed'

const NIVEL_POR_EXPERIENCIA: Record<string, string> = {
  principiante: 'principiante',
  basico: 'basico',
  previos: 'intermedio',
  varios: 'avanzado',
}

export function useOnboarding(userId?: string) {
  // Guardamos a qué usuario pertenece el estado. Mientras no coincida con el
  // usuario actual, el estado es 'loading'; así App no redirige antes de tiempo
  // (por ejemplo, al abrir directo una dirección como /cursos).
  const [result, setResult] = useState<{
    userId?: string
    status: OnboardingStatus
  }>({ status: 'pending' })

  const status: OnboardingStatus = !userId
    ? 'pending'
    : result.userId === userId
      ? result.status
      : 'loading'

  useEffect(() => {
    let active = true

    async function load() {
      if (!userId) return

      const { data, error } = await supabase
        .from('onboarding_responses')
        .select('completed_at')
        .eq('user_id', userId)
        .maybeSingle()

      if (!active) return

      if (error) {
        setResult({ userId, status: 'pending' })
        return
      }

      setResult({ userId, status: data?.completed_at ? 'completed' : 'pending' })
    }

    void load()

    return () => {
      active = false
    }
  }, [userId])

  const submit = useCallback(
    async (answers: Answers): Promise<string | null> => {
      if (!userId) return 'No hay una sesión activa.'

      const { error } = await supabase.from('onboarding_responses').upsert({
        user_id: userId,
        answers,
        completed_at: new Date().toISOString(),
      })

      if (error) return error.message

      const experiencia = answers.experiencia
      const nivel =
        typeof experiencia === 'string'
          ? NIVEL_POR_EXPERIENCIA[experiencia]
          : undefined

      if (nivel) {
        const { error: profileError } = await supabase
          .from('perfiles')
          .update({ nivel })
          .eq('id', userId)

        if (profileError) return profileError.message
      }

      setResult({ userId, status: 'completed' })
      return null
    },
    [userId],
  )

  return { status, submit }
}
