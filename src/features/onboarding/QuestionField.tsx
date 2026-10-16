import type { AnswerValue, Question } from './types'

interface QuestionFieldProps {
  question: Question
  value: AnswerValue | undefined
  onChange: (value: AnswerValue) => void
}

export default function QuestionField({
  question,
  value,
  onChange,
}: QuestionFieldProps) {
  const { id, type, prompt, options, code } = question

  function toggleMultiple(optionValue: string, checked: boolean) {
    const current = Array.isArray(value) ? value : []
    onChange(
      checked
        ? [...current, optionValue]
        : current.filter((item) => item !== optionValue),
    )
  }

  return (
    <div>
      <h2 className="onboarding-question">{prompt}</h2>

      {code && <pre className="onboarding-code">{code}</pre>}

      {type === 'single' &&
        options?.map((option) => (
          <label key={option.value} className="form-check onboarding-option">
            <input
              type="radio"
              className="form-check-input"
              name={id}
              value={option.value}
              checked={value === option.value}
              onChange={() => onChange(option.value)}
            />
            <span className="form-check-label">
              {option.label}
              {option.description && (
                <span className="onboarding-option-description d-block">
                  {option.description}
                </span>
              )}
            </span>
          </label>
        ))}

      {type === 'multiple' &&
        options?.map((option) => (
          <label key={option.value} className="form-check onboarding-option">
            <input
              type="checkbox"
              className="form-check-input"
              value={option.value}
              checked={Array.isArray(value) && value.includes(option.value)}
              onChange={(event) =>
                toggleMultiple(option.value, event.target.checked)
              }
            />
            <span className="form-check-label">
              {option.label}
              {option.description && (
                <span className="onboarding-option-description d-block">
                  {option.description}
                </span>
              )}
            </span>
          </label>
        ))}

      {type === 'text' && (
        <input
          type="text"
          className="form-control"
          value={typeof value === 'string' ? value : ''}
          onChange={(event) => onChange(event.target.value)}
        />
      )}

      {type === 'textarea' && (
        <textarea
          className="form-control"
          rows={4}
          value={typeof value === 'string' ? value : ''}
          onChange={(event) => onChange(event.target.value)}
        />
      )}
    </div>
  )
}
