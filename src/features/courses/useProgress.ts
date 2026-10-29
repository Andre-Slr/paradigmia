import { useCallback, useState } from 'react'

/**
 * Guarda qué lecciones completó el estudiante.
 *
 * Por ahora vive en el almacenamiento del navegador (localStorage), separado por
 * usuario. Más adelante se puede mover a una tabla de Supabase sin cambiar las
 * vistas, porque estas solo usan `completed`, `isCompleted` y `markCompleted`.
 */
function storageKey(userId: string) {
  return `paradigmia:progreso:${userId}`
}

function readProgress(userId: string): Set<string> {
  try {
    const raw = window.localStorage.getItem(storageKey(userId))
    const parsed: unknown = raw ? JSON.parse(raw) : []
    return new Set(Array.isArray(parsed) ? parsed.map(String) : [])
  } catch {
    return new Set()
  }
}

export function useProgress(userId: string) {
  const [completed, setCompleted] = useState<Set<string>>(() => readProgress(userId))

  const markCompleted = useCallback(
    (courseId: string, lessonId: string) => {
      setCompleted((previous) => {
        const next = new Set(previous)
        next.add(`${courseId}/${lessonId}`)
        try {
          window.localStorage.setItem(storageKey(userId), JSON.stringify([...next]))
        } catch {
          // Si el navegador bloquea el almacenamiento, el progreso dura solo esta visita.
        }
        return next
      })
    },
    [userId],
  )

  const isCompleted = useCallback(
    (courseId: string, lessonId: string) => completed.has(`${courseId}/${lessonId}`),
    [completed],
  )

  return { completed, isCompleted, markCompleted }
}
