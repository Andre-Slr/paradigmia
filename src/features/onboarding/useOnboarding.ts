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
  const [status, setStatus] = useState<OnboardingStatus>(
    userId ? 'loading' : 'pending',
  )

  useEffect(() => {
    let active = true

    async function load() {
      if (!userId) {
        setStatus('pending')
        return
      }

      setStatus('loading')

      const { data, error } = await supabase
        .from('onboarding_responses')
        .select('completed_at')
        .eq('user_id', userId)
        .maybeSingle()

      if (!active) return

      if (error) {
        setStatus('pending')
        return
      }

      setStatus(data?.completed_at ? 'completed' : 'pending')
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

      setStatus('completed')
      return null
    },
    [userId],
  )

  return { status, submit }
}
