export type CourseLevel = 'Básico' | 'Intermedio' | 'Avanzado'

export interface CourseItem {
  id: string
  name: string
  description: string
  level: CourseLevel
  language: 'python' | 'javascript' | 'html' | 'css' | 'java' | 'php' | 'cpp' | 'c'
  category: string
  duration?: string
  lessons?: number
  plannedLessons?: number
}

export const courseCatalog: CourseItem[] = [
  {
    id: 'python-basico',
    name: 'Python Básico',
    description: 'Aprende fundamentos de programación con variables, condicionales, funciones y estructuras básicas.',
    level: 'Básico',
    language: 'python',
    category: 'Programación',
    duration: '4 semanas',
    lessons: 2,
    plannedLessons: 12,
  },
  {
    id: 'desarrollo-web',
    name: 'Desarrollo Web',
    description: 'Explora HTML, CSS y JavaScript para construir páginas navegables y experiencias web modernas.',
    level: 'Intermedio',
    language: 'javascript',
    category: 'Frontend',
    duration: '6 semanas',
    lessons: 2,
    plannedLessons: 16,
  },
  {
    id: 'html-visual',
    name: 'HTML y estructura web',
    description: 'Diseña la base semántica de tus páginas con contenido, formularios y accesibilidad.',
    level: 'Básico',
    language: 'html',
    category: 'Frontend',
    duration: '3 semanas',
    lessons: 9,
  },
  {
    id: 'css-estilos',
    name: 'CSS para interfaces',
    description: 'Domina layouts, diseño visual, responsividad y componentes reutilizables para interfaces limpias.',
    level: 'Intermedio',
    language: 'css',
    category: 'Frontend',
    duration: '5 semanas',
    lessons: 14,
  },
  {
    id: 'java-introduccion',
    name: 'Introducción a Java',
    description: 'Aprende conceptos orientados a objetos, clases y buenas prácticas para aplicaciones más robustas.',
    level: 'Intermedio',
    language: 'java',
    category: 'Backend',
    duration: '5 semanas',
    lessons: 13,
  },
  {
    id: 'php-backend',
    name: 'PHP para backend',
    description: 'Construye aplicaciones web con lógica del servidor, formularios y flujo de datos.',
    level: 'Avanzado',
    language: 'php',
    category: 'Backend',
    duration: '7 semanas',
    lessons: 18,
  },
  {
    id: 'c-fundamentos',
    name: 'Fundamentos de C',
    description: 'Entiende memoria, algoritmos y lógica de bajo nivel con un enfoque de programación estructurada.',
    level: 'Avanzado',
    language: 'c',
    category: 'Algoritmia',
    duration: '6 semanas',
    lessons: 15,
  },
  {
    id: 'cpp-objetos',
    name: 'C++ orientado a objetos',
    description: 'Aprende clases, herencia y encapsulamiento para resolver problemas con mayor organización.',
    level: 'Avanzado',
    language: 'cpp',
    category: 'Algoritmia',
    duration: '8 semanas',
    lessons: 19,
  },
]

export const demoCourseNote =
  'Catálogo provisional de demostración. Reemplazar por datos reales de Supabase cuando estén disponibles.'
