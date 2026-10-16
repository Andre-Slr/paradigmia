export type QuestionType = 'single' | 'multiple' | 'text' | 'textarea'
export type QuestionLayout = 'pills' | 'grid' | 'cards'

export interface QuestionOption {
  value: string
  label: string
  description?: string
  icon?: string
}

export type AnswerValue = string | string[]
export type Answers = Record<string, AnswerValue>

export interface Question {
  id: string
  type: QuestionType
  section: 'inicial' | 'diagnostico'
  prompt: string
  help?: string
  layout?: QuestionLayout
  options?: QuestionOption[]
  code?: string
  required?: boolean
  correct?: string | string[]
  showIf?: (answers: Answers) => boolean
}
