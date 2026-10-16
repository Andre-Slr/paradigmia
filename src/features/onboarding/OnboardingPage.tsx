import { useMemo, useState } from 'react'
import QuestionField from './QuestionField'
import { questions } from './questions'
import type { AnswerValue, Answers, Question } from './types'

interface OnboardingPageProps {
  onSubmit: (answers: Answers) => Promise<string | null>
}

function isVisible(question: Question, answers: Answers): boolean {
  return !question.showIf || question.showIf(answers)
}

function isAnswered(question: Question, answers: Answers): boolean {
  const value = answers[question.id]
  if (question.type === 'multiple') {
    return Array.isArray(value) && value.length > 0
  }
  return typeof value === 'string' && value.trim().length > 0
}

function pruneAnswers(next: Answers): Answers {
  const result: Answers = {}
  for (const question of questions) {
    if (question.id in next && isVisible(question, next)) {
      result[question.id] = next[question.id]
    }
  }
  return result
}

export default function OnboardingPage({ onSubmit }: OnboardingPageProps) {
  const [answers, setAnswers] = useState<Answers>({})
  const [currentId, setCurrentId] = useState<string>(questions[0].id)
  const [submitting, setSubmitting] = useState(false)
  const [error, setError] = useState('')

  const visible = useMemo(
    () => questions.filter((question) => isVisible(question, answers)),
    [answers],
  )

  const currentIndex = Math.max(
    0,
    visible.findIndex((question) => question.id === currentId),
  )
  const current = visible[currentIndex]
  const isLast = currentIndex === visible.length - 1
  const canAdvance = !current.required || isAnswered(current, answers)

  function handleAnswer(id: string, value: AnswerValue) {
    setAnswers((previous) => pruneAnswers({ ...previous, [id]: value }))
  }

  function goBack() {
    if (currentIndex === 0) return
    setCurrentId(visible[currentIndex - 1].id)
  }

  async function finalize() {
    setError('')
    setSubmitting(true)
    try {
      const message = await onSubmit(answers)
      if (message) setError(message)
    } finally {
      setSubmitting(false)
    }
  }

  function goNext() {
    if (!canAdvance) return
    if (isLast) {
      void finalize()
      return
    }
    setCurrentId(visible[currentIndex + 1].id)
  }

  return (
    <main className="onboarding">
      <section className="onboarding-card">
        <p className="onboarding-progress">
          Paso {currentIndex + 1} de {visible.length}
        </p>

        <QuestionField
          question={current}
          value={answers[current.id]}
          onChange={(value) => handleAnswer(current.id, value)}
        />

        {error && (
          <div className="alert alert-danger py-2 mb-0 mt-3" role="alert">
            {error}
          </div>
        )}

        <div className="d-flex justify-content-between mt-4">
          <button
            className="btn btn-light"
            type="button"
            onClick={goBack}
            disabled={currentIndex === 0 || submitting}
          >
            Atrás
          </button>
          <button
            className="btn btn-primary"
            type="button"
            onClick={goNext}
            disabled={!canAdvance || submitting}
          >
            {isLast ? (submitting ? 'Guardando...' : 'Finalizar') : 'Siguiente'}
          </button>
        </div>
      </section>
    </main>
  )
}
