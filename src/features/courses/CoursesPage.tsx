import { useEffect, useMemo, useState } from 'react'
import { Link } from 'react-router-dom'
import type { User } from '@supabase/supabase-js'
import AppShell from '@/components/layout/AppShell'
import { languageIcons } from '@/features/onboarding/languageIcons'
import { getPublishedCourses, type PublishedCourseRecord } from './courseService'
import { recommendCourses } from '@/features/adaptation/adaptation'
import { useLearnerProfile } from '@/features/adaptation/useLearnerProfile'
import '@/features/adaptation/adaptation.css'

interface CoursesPageProps {
  user: User
  onLogout: () => Promise<string | null>
}

const levelOptions = ['Todos', 'Principiante', 'Básico', 'Intermedio', 'Avanzado'] as const

function normalizeLanguageKey(language: string | null): string {
  const normalized = (language ?? '').trim().toLowerCase()

  if (!normalized) return 'javascript'
  if (normalized.includes('python')) return 'python'
  if (normalized.includes('javascript') || normalized.includes('js')) return 'javascript'
  if (normalized.includes('html')) return 'html'
  if (normalized.includes('css')) return 'css'
  if (normalized.includes('java')) return 'java'
  if (normalized.includes('php')) return 'php'
  if (normalized.includes('c++') || normalized.includes('cpp')) return 'cpp'
  if (normalized.includes('c ')) return 'c'
  if (normalized.includes('c')) return 'c'

  return 'javascript'
}

function normalizeLevel(level: string | null): string {
  const normalized = (level ?? '').trim().toLowerCase()

  if (normalized.includes('principiante') || normalized.includes('beginner')) return 'Principiante'
  if (normalized.includes('básico') || normalized.includes('basic')) return 'Básico'
  if (normalized.includes('intermedio') || normalized.includes('intermediate')) return 'Intermedio'
  if (normalized.includes('avanzado') || normalized.includes('advanced')) return 'Avanzado'

  return 'Principiante'
}

function formatDuration(weeks: number | null): string | null {
  if (weeks === null || weeks === undefined) return null
  return `${weeks} semana${weeks === 1 ? '' : 's'}`
}

export default function CoursesPage({ user, onLogout }: CoursesPageProps) {
  const [courses, setCourses] = useState<PublishedCourseRecord[]>([])
  const [query, setQuery] = useState('')
  const [selectedLanguage, setSelectedLanguage] = useState('Todos')
  const [selectedLevel, setSelectedLevel] = useState<(typeof levelOptions)[number]>('Todos')
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const { profile: learnerProfile } = useLearnerProfile(user.id)

  useEffect(() => {
    let active = true

    async function loadCourses() {
      try {
        setLoading(true)
        setError(null)

        const data = await getPublishedCourses()

        if (!active) return
        setCourses(data)
      } catch (loadError) {
        if (!active) return
        const message =
          loadError instanceof Error
            ? loadError.message
            : 'No se pudieron cargar los cursos. Inténtalo de nuevo más tarde.'
        setError(message)
        setCourses([])
      } finally {
        if (active) {
          setLoading(false)
        }
      }
    }

    void loadCourses()

    return () => {
      active = false
    }
  }, [])

  const languageOptions = useMemo(() => {
    const uniqueLanguages = Array.from(
      new Set(
        courses.map((course) => {
          const label = course.language ?? 'Otro'
          return normalizeLanguageKey(label)
        })
      )
    )

    return ['Todos', ...uniqueLanguages]
  }, [courses])

  const filteredCourses = useMemo(() => {
    const normalizedQuery = query.trim().toLowerCase()

    return courses.filter((course) => {
      const courseLanguageKey = normalizeLanguageKey(course.language)
      const courseDisplayName = course.title ?? ''
      const courseDescription = course.description ?? ''
      const courseLevel = normalizeLevel(course.level)

      const matchesQuery =
        !normalizedQuery ||
        courseDisplayName.toLowerCase().includes(normalizedQuery) ||
        courseDescription.toLowerCase().includes(normalizedQuery)

      const matchesLanguage = selectedLanguage === 'Todos' || courseLanguageKey === selectedLanguage
      const matchesLevel = selectedLevel === 'Todos' || courseLevel === selectedLevel

      return matchesQuery && matchesLanguage && matchesLevel
    })
  }, [courses, query, selectedLanguage, selectedLevel])

  // Motor de adaptación: motivos por curso recomendado (reglas R1 a R4).
  const recommendationReasons = useMemo(() => {
    const reasons = new Map<string, string[]>()
    for (const { course, reasons: courseReasons, score } of recommendCourses(learnerProfile, courses)) {
      if (score > 0) reasons.set(course.id, courseReasons)
    }
    return reasons
  }, [learnerProfile, courses])

  async function handleLogout(): Promise<string | null> {
    return onLogout()
  }

  return (
    <AppShell onLogout={handleLogout}>
      <div className="student-catalog-page">
        <header className="student-catalog-header">
          <div>
            <p className="student-catalog-kicker">Catálogo</p>
            <h1>Explora todos los cursos</h1>
          </div>
          <span className="student-catalog-user">{user.email}</span>
        </header>

        <p className="student-catalog-intro">
          Descubre rutas de aprendizaje pensadas para fortalecer tus habilidades y avanzar paso a paso.
        </p>

        <div className="student-catalog-toolbar">
          <label className="student-search-field">
            <span className="sr-only">Buscar curso</span>
            <input
              type="search"
              value={query}
              onChange={(event) => setQuery(event.target.value)}
              placeholder="Buscar por nombre o descripción"
              aria-label="Buscar por nombre o descripción"
            />
          </label>

          <label className="student-filter-field">
            <span>Lenguaje</span>
            <select value={selectedLanguage} onChange={(event) => setSelectedLanguage(event.target.value)}>
              {languageOptions.map((option) => (
                <option key={option} value={option}>
                  {option === 'Todos' ? 'Todos' : option}
                </option>
              ))}
            </select>
          </label>

          <label className="student-filter-field">
            <span>Nivel</span>
            <select
              value={selectedLevel}
              onChange={(event) => setSelectedLevel(event.target.value as (typeof levelOptions)[number])}
            >
              {levelOptions.map((option) => (
                <option key={option} value={option}>
                  {option === 'Todos' ? 'Todos' : option}
                </option>
              ))}
            </select>
          </label>

          <button
            type="button"
            className="student-clear-filters"
            onClick={() => {
              setQuery('')
              setSelectedLanguage('Todos')
              setSelectedLevel('Todos')
            }}
          >
            Limpiar filtros
          </button>
        </div>

        <div className="student-catalog-summary">
          <strong>{filteredCourses.length}</strong>
          <span>curso{filteredCourses.length === 1 ? '' : 's'} disponibles</span>
        </div>

        {loading && (
          <div className="student-empty-state">
            <h2>Cargando cursos</h2>
            <p>Estamos consultando el catálogo disponible en Supabase.</p>
          </div>
        )}

        {!loading && error && (
          <div className="student-catalog-alert" role="alert">
            {error}
          </div>
        )}

        {!loading && !error && filteredCourses.length === 0 && (
          <div className="student-empty-state">
            <h2>No encontramos coincidencias</h2>
            <p>Prueba otros filtros o limpia la búsqueda para ver más cursos disponibles.</p>
          </div>
        )}

        {!loading && !error && filteredCourses.length > 0 && (
          <div className="student-catalog-grid">
            {filteredCourses.map((course) => {
              const languageKey = normalizeLanguageKey(course.language)
              const courseSlug = course.slug
              const displayLevel = normalizeLevel(course.level)
              const durationLabel = formatDuration(course.duration_weeks)
              const reasons = recommendationReasons.get(course.id)

              return (
                <article
                  className={`student-catalog-card ${reasons ? 'is-recommended' : ''}`}
                  key={course.id}
                >
                  {reasons && <span className="student-reco-badge">Recomendado para ti</span>}
                  <div className="student-catalog-card-top">
                    <div className="student-language-icon" aria-label={course.language ?? 'curso'}>
                      <img src={languageIcons[languageKey]} alt={course.language ?? 'curso'} />
                    </div>
                    <span className="student-course-level">{displayLevel}</span>
                  </div>

                  <div className="student-catalog-card-body">
                    <h2>{course.title}</h2>
                    <p>{course.description ?? 'Sin descripción disponible.'}</p>
                  </div>

                  {reasons && (
                    <ul className="student-reco-reasons" aria-label="Por qué te lo recomendamos">
                      {reasons.map((reason) => (
                        <li key={reason}>{reason}</li>
                      ))}
                    </ul>
                  )}

                  <div className="student-catalog-meta">
                    {durationLabel && <span>{durationLabel}</span>}
                    <span>{course.language ?? 'Otro'}</span>
                  </div>

                  <Link to={`/courses/${courseSlug}`} className="student-catalog-action student-catalog-link">
                    Ver curso
                  </Link>
                </article>
              )
            })}
          </div>
        )}
      </div>
    </AppShell>
  )
}
