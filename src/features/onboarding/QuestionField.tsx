import QuestionIcon from './QuestionIcon'
import type { AnswerValue, Question, QuestionOption } from './types'

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
  const {
    id,
    type,
    prompt,
    help,
    code,
    options = [],
    layout = 'pills',
  } = question

  const isChoice = type === 'single' || type === 'multiple'
  const inputType = type === 'multiple' ? 'checkbox' : 'radio'

  function isSelected(optionValue: string): boolean {
    if (type === 'multiple') {
      return Array.isArray(value) && value.includes(optionValue)
    }
    return value === optionValue
  }

  function select(optionValue: string) {
    if (type === 'multiple') {
      const current = Array.isArray(value) ? value : []
      onChange(
        current.includes(optionValue)
          ? current.filter((item) => item !== optionValue)
          : [...current, optionValue],
      )
      return
    }
    onChange(optionValue)
  }

  function renderControl(option: QuestionOption) {
    return (
      <input
        type={inputType}
        name={id}
        value={option.value}
        checked={isSelected(option.value)}
        onChange={() => select(option.value)}
        className="visually-hidden"
      />
    )
  }

  return (
    <div>
      <h2 className="onboarding-title">{prompt}</h2>
      {help && <p className="onboarding-help">{help}</p>}
      {code && <pre className="onboarding-code">{code}</pre>}

      {isChoice && layout === 'grid' && (
        <div className="onboarding-grid">
          {options.map((option) => (
            <label
              key={option.value}
              className={`onboarding-lang-card${isSelected(option.value) ? ' is-selected' : ''}`}
            >
              {renderControl(option)}
              {option.icon && <QuestionIcon name={option.icon} size={44} />}
              <span>{option.label}</span>
            </label>
          ))}
        </div>
      )}

      {isChoice && layout === 'cards' && (
        <div className="onboarding-cards">
          {options.map((option) => (
            <label
              key={option.value}
              className={`onboarding-card-option${isSelected(option.value) ? ' is-selected' : ''}`}
            >
              {renderControl(option)}
              <span className="onboarding-card-title">{option.label}: </span>
              <span>{option.description}</span>
            </label>
          ))}
        </div>
      )}

      {isChoice && layout === 'pills' && (
        <div className="onboarding-options">
          {options.map((option) => (
            <label
              key={option.value}
              className={`onboarding-option${isSelected(option.value) ? ' is-selected' : ''}`}
            >
              {renderControl(option)}
              {option.icon && (
                <span className="onboarding-option-icon">
                  <QuestionIcon name={option.icon} />
                </span>
              )}
              <span className="onboarding-option-label">{option.label}</span>
              <span
                className={`onboarding-indicator${
                  type === 'multiple' ? ' is-square' : ''
                }${isSelected(option.value) ? ' is-selected' : ''}`}
              />
            </label>
          ))}
        </div>
      )}

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
