import courseIcon from '@/assets/icons/cursos.png'
import { languageIcons } from '@/features/onboarding/languageIcons'

const languageLabels: Record<string, string> = {
  algorithms: 'Algoritmos',
  backend: 'Backend',
  c: 'C',
  cpp: 'C++',
  css: 'CSS',
  git: 'Git',
  github: 'GitHub',
  html: 'HTML',
  java: 'Java',
  javascript: 'JavaScript',
  nodejs: 'Node.js',
  php: 'PHP',
  python: 'Python',
  react: 'React',
  software: 'Software',
  sql: 'SQL',
  typescript: 'TypeScript',
}

export function normalizeCourseLanguageKey(language: string | null): string {
  const normalized = (language ?? '').trim().toLowerCase()

  if (!normalized) return 'other'
  if (normalized.includes('git')) return normalized.includes('github') ? 'github' : 'git'
  if (normalized.includes('typescript')) return 'typescript'
  if (normalized.includes('react')) return 'react'
  if (normalized.includes('node.js') || normalized.includes('nodejs')) return 'nodejs'
  if (normalized.includes('postgres') || normalized.includes('sql')) return 'sql'
  if (normalized.includes('python')) return 'python'
  if (normalized.includes('javascript') || normalized === 'js') return 'javascript'
  if (normalized.includes('html')) return 'html'
  if (normalized.includes('css')) return 'css'
  if (normalized.includes('java')) return 'java'
  if (normalized.includes('php')) return 'php'
  if (normalized.includes('c++') || normalized.includes('cpp')) return 'cpp'
  if (/^c(?:\s|$)/.test(normalized)) return 'c'
  if (normalized.includes('backend')) return 'backend'
  if (normalized.includes('algorit')) return 'algorithms'
  if (normalized.includes('software')) return 'software'

  return normalized.replace(/[^a-z0-9]+/g, '-') || 'other'
}

export function formatCourseLanguageLabel(languageKey: string): string {
  if (languageKey === 'other') return 'Otro'
  if (languageLabels[languageKey]) return languageLabels[languageKey]

  return languageKey
    .split('-')
    .map((word) => word.charAt(0).toUpperCase() + word.slice(1))
    .join(' ')
}

export function getCourseLanguageIcon(languageKey: string): string {
  return languageIcons[languageKey] ?? courseIcon
}
