import { useEffect } from 'react'

export interface StudentToastMessage {
  id: number
  message: string
  type: 'success' | 'error'
}

interface ToastProps {
  toast: StudentToastMessage | null
  onDismiss: () => void
}

export default function Toast({ toast, onDismiss }: ToastProps) {
  useEffect(() => {
    if (!toast) return
    const timeoutId = window.setTimeout(onDismiss, 4500)
    return () => window.clearTimeout(timeoutId)
  }, [onDismiss, toast])

  if (!toast) return null

  return (
    <div
      className={`student-toast is-${toast.type}`}
      role={toast.type === 'error' ? 'alert' : 'status'}
      aria-live={toast.type === 'error' ? 'assertive' : 'polite'}
      aria-atomic="true"
    >
      <span>{toast.message}</span>
      <button type="button" onClick={onDismiss} aria-label="Cerrar notificación">
        ×
      </button>
    </div>
  )
}
