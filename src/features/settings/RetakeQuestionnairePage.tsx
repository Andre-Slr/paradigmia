import { Link, useNavigate } from 'react-router-dom'
import OnboardingPage from '@/features/onboarding/OnboardingPage'
import type { Answers } from '@/features/onboarding/types'

interface RetakeQuestionnairePageProps {
  /** El mismo `submit` de useOnboarding que usa el registro: guarda respuestas y nivel. */
  onSubmit: (answers: Answers) => Promise<string | null>
}

/**
 * Vuelve a mostrar el cuestionario inicial desde Configuración.
 * Reutiliza OnboardingPage tal como está, así el flujo de registro no cambia.
 */
export default function RetakeQuestionnairePage({ onSubmit }: RetakeQuestionnairePageProps) {
  const navigate = useNavigate()

  async function handleSubmit(answers: Answers) {
    const message = await onSubmit(answers)
    if (!message) navigate('/settings#aprendizaje', { state: { retaken: true } })
    return message
  }

  return (
    <>
      <div className="retake-bar">
        <Link to="/settings#aprendizaje" className="student-button-secondary text-decoration-none d-inline-block">
          Cancelar y volver a Configuración
        </Link>
      </div>
      <OnboardingPage onSubmit={handleSubmit} />
    </>
  )
}
