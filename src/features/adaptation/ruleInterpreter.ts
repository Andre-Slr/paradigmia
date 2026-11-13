import rulesConfig from './adaptationRules.json'
import type { AdaptableCourse, Nivel } from './adaptation'

type Facts = Record<string, unknown>

interface RuleCondition {
  field: string
  operator: string
  value?: unknown
}

interface RuleDefinition {
  id: string
  priority: number
  enabled: boolean
  condition: RuleCondition
  action: Record<string, unknown>
}

interface CourseScore {
  score: number
  reasons: string[]
}

export interface RuleInput<C extends AdaptableCourse> {
  experienceAnswer: string | null
  initialLevel: Nivel | null
  interests: string[]
  preferredLanguage: string | null
  diagnosticScore: number | null
  courses: C[]
}

export interface RuleRecommendation<C extends AdaptableCourse> {
  course: C
  reasons: string[]
  score: number
}

export interface RuleOutput<C extends AdaptableCourse> {
  computedLevel: Nivel
  recommendedCourses: RuleRecommendation<C>[]
  suggestedStartLesson: 1 | 2
  openHintsByDefault: boolean
}

const SUPPORTED_RULES = new Set(['R1', 'R2', 'R3', 'R4', 'R5', 'R6'])
const LEVEL_ORDER: Nivel[] = ['principiante', 'basico', 'intermedio', 'avanzado']
const LEVEL_RANK: Record<Nivel, number> = {
  principiante: 1,
  basico: 2,
  intermedio: 3,
  avanzado: 4,
}

const LANGUAGE_NAMES: Record<string, string> = {
  c: 'C',
  cpp: 'C++',
  python: 'Python',
  java: 'Java',
  css: 'CSS',
  html: 'HTML',
  php: 'PHP',
  javascript: 'JavaScript',
}

const INTEREST_NAMES: Record<string, string> = {
  web: 'las páginas web',
  videojuegos: 'los videojuegos',
  apps: 'las aplicaciones',
  circuitos: 'los circuitos',
  automatizacion: 'la automatización de tareas',
}

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === 'object' && value !== null && !Array.isArray(value)
}

function isRuleDefinition(value: unknown): value is RuleDefinition {
  return (
    isRecord(value) &&
    typeof value.id === 'string' &&
    typeof value.priority === 'number' &&
    typeof value.enabled === 'boolean' &&
    isRecord(value.condition) &&
    typeof value.condition.field === 'string' &&
    typeof value.condition.operator === 'string' &&
    isRecord(value.action)
  )
}

function getRules(): RuleDefinition[] {
  if (!Array.isArray(rulesConfig.rules)) {
    throw new Error('La configuración de reglas de adaptación no contiene una lista de reglas.')
  }

  const rules = rulesConfig.rules.map((rule, index) => {
    if (!isRuleDefinition(rule)) {
      throw new Error(`La regla de adaptación en la posición ${index} tiene un formato inválido.`)
    }
    return rule
  })

  return rules
    .filter((rule) => rule.enabled && SUPPORTED_RULES.has(rule.id))
    .sort((a, b) => b.priority - a.priority)
}

function matchesCondition(condition: RuleCondition, facts: Facts): boolean {
  const actual = facts[condition.field]

  switch (condition.operator) {
    case 'exists':
      return actual !== undefined && actual !== null && actual !== ''
    case 'not_empty':
      return Array.isArray(actual) && actual.length > 0
    case '==':
      return actual === condition.value
    case '>=':
      return typeof actual === 'number' &&
        typeof condition.value === 'number' &&
        actual >= condition.value
    case 'in':
      return Array.isArray(condition.value) && condition.value.includes(actual)
    default:
      return false
  }
}

function normalizeLanguage(language: string | null): string | null {
  const value = (language ?? '').trim().toLowerCase()
  if (!value) return null
  if (value.includes('javascript') || value === 'js') return 'javascript'
  if (value.includes('python')) return 'python'
  if (value.includes('html')) return 'html'
  if (value.includes('css')) return 'css'
  if (value.includes('java')) return 'java'
  if (value.includes('php')) return 'php'
  if (value.includes('c++') || value.includes('cpp')) return 'cpp'
  if (value === 'c') return 'c'
  return value
}

function normalizeLevel(level: string | null): Nivel {
  const value = (level ?? '').trim().toLowerCase()
  if (value.includes('avanz')) return 'avanzado'
  if (value.includes('interm')) return 'intermedio'
  if (value.includes('básico') || value.includes('basico') || value.includes('basic')) {
    return 'basico'
  }
  return 'principiante'
}

function isNivel(value: unknown): value is Nivel {
  return typeof value === 'string' && LEVEL_ORDER.includes(value as Nivel)
}

function getString(value: unknown): string | null {
  return typeof value === 'string' ? value : null
}

function getNumber(value: unknown): number | null {
  return typeof value === 'number' && Number.isFinite(value) ? value : null
}

function getStringArray(value: unknown): string[] {
  return Array.isArray(value) ? value.filter((item): item is string => typeof item === 'string') : []
}

function getPosition(course: AdaptableCourse): number | null {
  if ('position' in course && typeof course.position === 'number') return course.position
  return null
}

function getInterestMatches(
  interests: string[],
  interestMap: Record<string, unknown>,
  courseLanguage: string,
): string[] {
  return interests.filter((interest) => {
    const mappedLanguages = getStringArray(interestMap[interest.toLowerCase()])
    return mappedLanguages.some(
      (language) => normalizeLanguage(language) === courseLanguage,
    )
  })
}

export function runJsonAdaptationEngine<C extends AdaptableCourse>(
  input: RuleInput<C>,
): RuleOutput<C> {
  const facts: Facts = {
    experienceAnswer: input.experienceAnswer,
    computedLevel: input.initialLevel ?? 'principiante',
    interests: input.interests,
    preferredLanguage: input.preferredLanguage,
    diagnosticScore: input.diagnosticScore,
  }
  let eligibleCourses = [...input.courses]
  let suggestedStartLesson: 1 | 2 = 1
  let openHintsByDefault = false
  const courseScores = new Map<string, CourseScore>(
    input.courses.map((course) => [course.id, { score: 0, reasons: [] }]),
  )

  for (const rule of getRules()) {
    if (!matchesCondition(rule.condition, facts)) continue

    switch (rule.action.type) {
      case 'SET_LEVEL': {
        const mapping = isRecord(rule.action.mapping) ? rule.action.mapping : {}
        const experience = getString(facts.experienceAnswer)
        const mappedLevel = experience ? mapping[experience] : undefined
        const defaultLevel = rule.action.default
        facts.computedLevel = isNivel(mappedLevel)
          ? mappedLevel
          : isNivel(defaultLevel)
            ? defaultLevel
            : 'principiante'
        break
      }

      case 'FILTER_COURSE_LEVEL': {
        const userLevel = isNivel(facts.computedLevel) ? facts.computedLevel : 'principiante'
        const maxLevelDelta = getNumber(rule.action.maxLevelDelta) ?? 0
        const filtered = eligibleCourses.filter(
          (course) =>
            LEVEL_RANK[normalizeLevel(course.level)] <= LEVEL_RANK[userLevel] + maxLevelDelta,
        )
        if (filtered.length > 0) {
          eligibleCourses = filtered
        } else {
          const fallbackLevel = getString(rule.action.fallbackLevel)
          eligibleCourses = eligibleCourses.filter(
            (course) => normalizeLevel(course.level) === normalizeLevel(fallbackLevel),
          )
        }
        break
      }

      case 'SCORE_COURSE_BY_LANGUAGE': {
        const preferredLanguage = normalizeLanguage(getString(facts.preferredLanguage))
        const points = getNumber(rule.action.points) ?? 0
        if (!preferredLanguage) break

        for (const course of eligibleCourses) {
          if (normalizeLanguage(course.language) !== preferredLanguage) continue
          const entry = courseScores.get(course.id)
          if (!entry) continue
          entry.score += points
          entry.reasons.push(
            `Elegiste aprender ${LANGUAGE_NAMES[preferredLanguage] ?? preferredLanguage}`,
          )
        }
        break
      }

      case 'SCORE_COURSE_BY_INTEREST': {
        if (!isRecord(rule.action.interestMap)) break
        const points = getNumber(rule.action.points) ?? 0

        for (const course of eligibleCourses) {
          const courseLanguage = normalizeLanguage(course.language)
          if (!courseLanguage) continue
          const matches = getInterestMatches(
            input.interests,
            rule.action.interestMap,
            courseLanguage,
          )
          const entry = courseScores.get(course.id)
          if (matches.length === 0 || !entry) continue
          entry.score += points
          entry.reasons.push(
            `Te interesan ${matches.map((interest) => INTEREST_NAMES[interest] ?? interest).join(', ')}`,
          )
        }
        break
      }

      case 'SET_START_LESSON': {
        suggestedStartLesson = getNumber(rule.action.onTrue) === 2 ? 2 : 1
        break
      }

      case 'SET_HINTS_VISIBILITY':
        openHintsByDefault = rule.action.onTrue === true
        break
    }
  }

  const userLevel = isNivel(facts.computedLevel) ? facts.computedLevel : 'principiante'
  for (const course of eligibleCourses) {
    const entry = courseScores.get(course.id)
    if (!entry || entry.score === 0) continue
    const levelGap = LEVEL_RANK[normalizeLevel(course.level)] - LEVEL_RANK[userLevel]
    if (levelGap >= -1) {
      entry.reasons.push('Va de acuerdo con tu nivel')
      entry.score += 1
    } else {
      entry.reasons.push('Te sirve como repaso de los fundamentos')
    }
  }

  let recommendedCourses = eligibleCourses
    .map((course, index) => ({
      course,
      reasons: courseScores.get(course.id)?.reasons ?? [],
      score: courseScores.get(course.id)?.score ?? 0,
      index,
    }))
    .sort(
      (a, b) =>
        b.score - a.score ||
        (getPosition(a.course) ?? a.index) - (getPosition(b.course) ?? b.index),
    )
    .map(({ course, reasons, score }) => ({ course, reasons, score }))

  if (recommendedCourses.every(({ score }) => score === 0)) {
    const fallbackCourses = eligibleCourses.filter(
      (course) => LEVEL_RANK[normalizeLevel(course.level)] <= LEVEL_RANK.basico,
    )
    recommendedCourses = fallbackCourses.map((course) => ({
      course,
      reasons: [
        input.preferredLanguage
          ? `Mientras preparamos el curso de ${
              LANGUAGE_NAMES[normalizeLanguage(input.preferredLanguage) ?? ''] ??
              input.preferredLanguage
            }, este te da bases que te servirán`
          : 'Es un buen punto de partida para empezar a programar',
      ],
      score: 0,
    }))
  }

  return {
    computedLevel: isNivel(facts.computedLevel) ? facts.computedLevel : 'principiante',
    recommendedCourses,
    suggestedStartLesson,
    openHintsByDefault,
  }
}
