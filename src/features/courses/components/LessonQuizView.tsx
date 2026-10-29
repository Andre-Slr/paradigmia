import { useState } from 'react'
import type { LessonQuiz } from '../types'

interface LessonQuizViewProps {
  quiz: LessonQuiz
  onAnswered: (correct: boolean) => void
}

/** Ejercicio de opción múltiple al final de la lección. Reutiliza el estilo del onboarding. */
export default function LessonQuizView({ quiz, onAnswered }: LessonQuizViewProps) {
  const [selected, setSelected] = useState<string | null>(null)
  const [checked, setChecked] = useState(false)

  const isCorrect = selected === quiz.correct
  // Al revisar la respuesta, las opciones se bloquean. Si falló, puede
  // desbloquearlas con el botón "Intentar de nuevo".
  const locked = checked

  function check() {
    if (!selected) return
    setChecked(true)
    onAnswered(selected === quiz.correct)
  }

  function choose(value: string) {
    if (locked) return
    setSelected(value)
  }

  function retry() {
    setSelected(null)
    setChecked(false)
  }

  return (
    <section className="lesson-quiz" aria-labelledby="quiz-title">
      <h2 id="quiz-title">Pon a prueba lo que aprendiste</h2>
      <p>{quiz.prompt}</p>

      {quiz.code && (
        <figure className="code-block">
          <pre>
            <code>{quiz.code}</code>
          </pre>
        </figure>
      )}

      <div className="onboarding-options" role="radiogroup" aria-label={quiz.prompt}>
        {quiz.options.map((option) => {
          const isSelected = selected === option.value
          return (
            <button
              key={option.value}
              type="button"
              role="radio"
              aria-checked={isSelected}
              className={`onboarding-option text-start ${isSelected ? 'is-selected' : ''}`}
              onClick={() => choose(option.value)}
              disabled={locked && !isSelected}
            >
              <span className="onboarding-option-label">
                <code className="inline-code">{option.label}</code>
              </span>
              <span
                className={`onboarding-indicator ${isSelected ? 'is-selected' : ''}`}
                aria-hidden="true"
              />
            </button>
          )
        })}
      </div>

      {checked ? (
        <div className={`quiz-feedback ${isCorrect ? '' : 'is-wrong'}`} role="status">
          <strong>{isCorrect ? '¡Correcto!' : 'Esa no es la respuesta'}</strong>
          <p>
            {isCorrect
              ? quiz.explanation
              : 'Repasa los puntos clave de arriba y vuelve a intentarlo.'}
          </p>
          {!isCorrect && (
            <button type="button" className="quiz-retry" onClick={retry}>
              Intentar de nuevo
            </button>
          )}
        </div>
      ) : (
        <button type="button" className="courses-cta mt-3" onClick={check} disabled={!selected}>
          Revisar respuesta
        </button>
      )}
    </section>
  )
}
