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

  const sequence = useMemo(
    () => questions.filter((question) => isVisible(question, answers)),
    [answers],
  )

  const currentIndex = Math.max(
    0,
    sequence.findIndex((question) => question.id === currentId),
  )
  const current = sequence[currentIndex]
  const isLast = currentIndex === sequence.length - 1
  const canAdvance = !current.required || isAnswered(current, answers)

  const initialCount = sequence.filter(
    (question) => question.section === 'inicial',
  ).length
  const isInitial = current.section === 'inicial'
  const phaseTotal = isInitial
    ? Math.max(2, initialCount)
    : sequence.length - initialCount
  const phaseIndex = isInitial
    ? currentIndex + 1
    : currentIndex - initialCount + 1
  const progress = phaseTotal > 0 ? (phaseIndex / phaseTotal) * 100 : 0

  function handleAnswer(id: string, value: AnswerValue) {
    setAnswers((previous) => pruneAnswers({ ...previous, [id]: value }))
  }

  function goBack() {
    if (currentIndex === 0) return
    setCurrentId(sequence[currentIndex - 1].id)
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
    if (!canAdvance || submitting) return
    if (isLast) {
      void finalize()
      return
    }
    setCurrentId(sequence[currentIndex + 1].id)
  }

  return (
    <main className="onboarding">
      <div className="onboarding-shell">
        <header className="onboarding-top">
          <button
            type="button"
            className="onboarding-back"
            onClick={goBack}
            disabled={currentIndex === 0 || submitting}
            aria-label="Atrás"
          >
            <svg
              width="26"
              height="26"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              strokeWidth="2"
              strokeLinecap="round"
              strokeLinejoin="round"
              aria-hidden="true"
            >
              <path d="M19 12H5" />
              <path d="m12 19-7-7 7-7" />
            </svg>
          </button>

          <div className="onboarding-progress">
            <div
              className="onboarding-progress-fill"
              style={{ width: `${progress}%` }}
            />
          </div>

          <span className="onboarding-count">
            {phaseIndex}/{phaseTotal}
          </span>
        </header>

        <section className="onboarding-body">
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
        </section>

        <footer className="onboarding-footer">
          <button
            type="button"
            className="onboarding-continue"
            onClick={goNext}
            disabled={!canAdvance || submitting}
          >
            {isLast ? (submitting ? 'Guardando...' : 'Finalizar') : 'Continuar'}
          </button>
        </footer>
      </div>
    </main>
  )
}
