import { useEffect, useState } from 'react'
import { supabase } from '@/lib/supabaseClient'
import type { Answers } from '@/features/onboarding/types'
import { buildLearnerProfile } from './adaptation'
import type { LearnerProfile } from './adaptation'

/**
 * Lee de Supabase las respuestas del cuestionario inicial y el nivel guardado
 * en el perfil, y los convierte en el perfil que usa el motor de adaptación.
 */
export function useLearnerProfile(userId: string) {
  const [profile, setProfile] = useState<LearnerProfile>(() =>
    buildLearnerProfile(null),
  )
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    let active = true

    async function load() {
      setLoading(true)

      const [respuestas, perfil] = await Promise.all([
        supabase
          .from('onboarding_responses')
          .select('answers')
          .eq('user_id', userId)
          .maybeSingle(),
        supabase.from('perfiles').select('nivel').eq('id', userId).maybeSingle(),
      ])

      if (!active) return

      const answers = (respuestas.data?.answers as Answers | undefined) ?? null
      const nivel = (perfil.data?.nivel as string | undefined) ?? null

      setProfile(buildLearnerProfile(answers, nivel))
      setLoading(false)
    }

    void load()

    return () => {
      active = false
    }
  }, [userId])

  return { profile, loading }
}
