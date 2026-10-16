import { useEffect, useState } from 'react'
import { supabase } from '@/lib/supabaseClient'

export interface Profile {
  id: string
  nombre: string | null
  usuario: string | null
  nivel: string | null
}

export function useProfile(userId: string) {
  const [profile, setProfile] = useState<Profile | null>(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    let active = true

    async function load() {
      setLoading(true)

      const { data, error } = await supabase
        .from('perfiles')
        .select('id, nombre, usuario, nivel')
        .eq('id', userId)
        .maybeSingle()

      if (!active) return

      if (!error) setProfile((data as Profile | null) ?? null)
      setLoading(false)
    }

    void load()

    return () => {
      active = false
    }
  }, [userId])

  return { profile, loading }
}
