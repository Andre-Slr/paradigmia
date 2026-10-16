export type QuestionType = 'single' | 'multiple' | 'text' | 'textarea'

export interface QuestionOption {
  value: string
  label: string
  description?: string
}

export type AnswerValue = string | string[]
export type Answers = Record<string, AnswerValue>

export interface Question {
  id: string
  type: QuestionType
  section: 'inicial' | 'diagnostico'
  prompt: string
  options?: QuestionOption[]
  code?: string
  required?: boolean
  correct?: string | string[]
  showIf?: (answers: Answers) => boolean
}
