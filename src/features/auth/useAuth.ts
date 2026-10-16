import { useEffect, useState } from 'react'
import type { User } from '@supabase/supabase-js'
import { supabase } from '@/lib/supabaseClient'

export interface SignUpData {
  email: string
  password: string
  nombre: string
  nombreUsuario: string
}

export interface SignUpResult {
  error: string | null
  sessionCreated: boolean
}

export function useAuth() {
  const [user, setUser] = useState<User | null>(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    let active = true

    async function loadSession() {
      const { data } = await supabase.auth.getSession()

      if (!active) return

      setUser(data.session?.user ?? null)
      setLoading(false)
    }

    void loadSession()

    const {
      data: { subscription },
    } = supabase.auth.onAuthStateChange((_event, session) => {
      setUser(session?.user ?? null)
    })

    return () => {
      active = false
      subscription.unsubscribe()
    }
  }, [])

  async function signIn(email: string, password: string): Promise<string | null> {
    const { error } = await supabase.auth.signInWithPassword({ email, password })
    return error ? error.message : null
  }

  async function signUp(data: SignUpData): Promise<SignUpResult> {
    const { data: result, error } = await supabase.auth.signUp({
      email: data.email,
      password: data.password,
      options: {
        data: {
          nombre: data.nombre,
          nombre_usuario: data.nombreUsuario,
        },
      },
    })

    if (error) {
      return { error: error.message, sessionCreated: false }
    }

    return { error: null, sessionCreated: Boolean(result.session) }
  }

  async function signOut(): Promise<string | null> {
    const { error } = await supabase.auth.signOut()
    return error ? error.message : null
  }

  return { user, loading, signIn, signUp, signOut }
}
