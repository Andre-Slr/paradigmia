export type Nivel = 'principiante' | 'basico' | 'intermedio' | 'avanzado'

export type CodeLanguage = 'python' | 'html' | 'css'

/**
 * Bloques con los que se arma el contenido de una lección.
 * En los textos se puede usar `código en línea` entre comillas invertidas.
 */
export type LessonBlock =
  | { type: 'heading'; text: string }
  | { type: 'text'; text: string }
  | { type: 'list'; items: string[] }
  | {
      type: 'code'
      language: CodeLanguage
      code: string
      caption?: string
      output?: string
    }
  | {
      type: 'callout'
      variant: 'tip' | 'warning' | 'beginner'
      title: string
      text: string
    }
  | {
      type: 'table'
      headers: string[]
      rows: string[][]
    }

export interface QuizOption {
  value: string
  label: string
}

export interface LessonQuiz {
  prompt: string
  code?: string
  options: QuizOption[]
  correct: string
  explanation: string
}

export interface Lesson {
  id: string
  title: string
  minutes: number
  summary: string
  objectives: string[]
  blocks: LessonBlock[]
  keyPoints: string[]
  quiz: LessonQuiz
}

export interface Course {
  id: string
  title: string
  /** Lenguajes que enseña; coinciden con los valores del onboarding. */
  languages: string[]
  level: Nivel
  /** Intereses del onboarding con los que se relaciona el curso. */
  interests: string[]
  icon: string
  tagline: string
  description: string
  whatYouLearn: string[]
  lessons: Lesson[]
}
