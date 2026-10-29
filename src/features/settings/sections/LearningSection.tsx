import { useState } from 'react'
import { useLocation, useNavigate } from 'react-router-dom'
import { questions } from '@/features/onboarding/questions'
import { useLearnerProfile } from '@/features/adaptation/useLearnerProfile'
import type { Nivel } from '@/features/adaptation/adaptation'

const NOMBRE_NIVEL: Record<Nivel, string> = {
  principiante: 'Principiante',
  basico: 'Básico',
  intermedio: 'Intermedio',
  avanzado: 'Avanzado',
}

/** Busca el texto que vio el estudiante en el cuestionario para un valor guardado. */
function optionLabel(questionId: string, value: string): string {
  const question = questions.find((item) => item.id === questionId)
  return question?.options?.find((option) => option.value === value)?.label ?? value
}

/**
 * Preferencias de aprendizaje: muestra el perfil que usa el motor de adaptación.
 * El nivel no se edita a mano: se recalcula volviendo a responder el cuestionario.
 */
export default function LearningSection({ userId }: { userId: string }) {
  const { profile, loading } = useLearnerProfile(userId)
  const [confirming, setConfirming] = useState(false)
  const navigate = useNavigate()
  const location = useLocation()
  const retaken = (location.state as { retaken?: boolean } | null)?.retaken === true

  const intereses = profile.intereses.map((value) => optionLabel('intereses', value))
  const diagnostico = profile.diagnostico
    ? `${profile.diagnostico.aciertos} de ${profile.diagnostico.total} aciertos`
    : 'No aplica'

  return (
    <section className="settings-card" id="aprendizaje" aria-labelledby="aprendizaje-title">
      <div className="settings-card-head">
        <h2 id="aprendizaje-title">Preferencias de aprendizaje</h2>
        <p>
          Con esto Paradigmia elige tus cursos recomendados y en qué lección empezar. Si tus
          intereses cambiaron, vuelve a responder el cuestionario inicial.
        </p>
      </div>

      {loading ? (
        <p className="mb-0">Cargando tu perfil...</p>
      ) : (
        <dl className="settings-facts">
          <div className="settings-fact">
            <dt>Nivel</dt>
            <dd>{profile.nivel ? NOMBRE_NIVEL[profile.nivel] : 'Sin definir'}</dd>
          </div>
          <div className="settings-fact">
            <dt>Intereses</dt>
            <dd>{intereses.length > 0 ? intereses.join(', ') : 'No aplica'}</dd>
          </div>
          <div className="settings-fact">
            <dt>Lenguaje elegido</dt>
            <dd>{profile.lenguaje ? optionLabel('lenguaje', profile.lenguaje) : 'No aplica'}</dd>
          </div>
          <div className="settings-fact">
            <dt>Diagnóstico</dt>
            <dd>{diagnostico}</dd>
          </div>
        </dl>
      )}

      {confirming ? (
        <div className="settings-confirm" role="alert">
          <p>
            Vas a responder de nuevo el cuestionario inicial. Tu nivel y tus recomendaciones se
            recalcularán con tus nuevas respuestas. Tus cursos, lecciones completadas y
            calificaciones se conservan.
          </p>
          <div className="settings-actions">
            <button type="button" className="student-button" onClick={() => navigate('/settings/questionnaire')}>
              Responder de nuevo
            </button>
            <button type="button" className="student-button-secondary" onClick={() => setConfirming(false)}>
              Cancelar
            </button>
          </div>
        </div>
      ) : (
        <button type="button" className="student-button-secondary" onClick={() => setConfirming(true)}>
          Volver a responder el cuestionario
        </button>
      )}

      {retaken && (
        <p className="settings-message is-success" role="status">
          Listo, actualizamos tu perfil. Tus nuevas recomendaciones ya aparecen en Inicio y en Cursos.
        </p>
      )}
    </section>
  )
}
