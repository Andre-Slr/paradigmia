import type { Answers, Question } from './types'

const esPrincipiante = (a: Answers) => a.experiencia === 'principiante'
const noEsPrincipiante = (a: Answers) =>
  typeof a.experiencia === 'string' && a.experiencia !== 'principiante'
const eligioPython = (a: Answers) => a.lenguaje === 'python'

export const questions: Question[] = [
  {
    id: 'experiencia',
    section: 'inicial',
    type: 'single',
    required: true,
    prompt: '¿Cuánto sabes de programación?',
    help: 'Selecciona la opción que mejor describa tu experiencia.',
    options: [
      { value: 'principiante', label: 'Apenas estoy empezando', icon: 'cap' },
      { value: 'basico', label: 'Sé lo básico', icon: 'chart' },
      { value: 'previos', label: 'Tengo conocimientos previos', icon: 'doc' },
      { value: 'varios', label: 'Conozco varios lenguajes', icon: 'code' },
    ],
  },
  {
    id: 'intereses',
    section: 'inicial',
    type: 'multiple',
    required: true,
    showIf: esPrincipiante,
    prompt: '¿Qué te gustaría aprender?',
    help: 'Puedes elegir una o varias opciones.',
    options: [
      { value: 'web', label: 'Páginas web' },
      { value: 'videojuegos', label: 'Videojuegos' },
      { value: 'apps', label: 'Aplicaciones' },
      { value: 'circuitos', label: 'Circuitos' },
      { value: 'automatizacion', label: 'Automatización de tareas' },
    ],
  },
  {
    id: 'lenguaje',
    section: 'inicial',
    type: 'single',
    required: true,
    layout: 'grid',
    showIf: noEsPrincipiante,
    prompt: '¿Qué lenguaje quieres aprender?',
    help: 'Selecciona el lenguaje principal.',
    options: [
      { value: 'c', label: 'C', icon: 'lang' },
      { value: 'cpp', label: 'C++', icon: 'lang' },
      { value: 'python', label: 'Python', icon: 'lang' },
      { value: 'java', label: 'Java', icon: 'lang' },
      { value: 'css', label: 'CSS', icon: 'lang' },
      { value: 'html', label: 'HTML', icon: 'lang' },
      { value: 'php', label: 'php', icon: 'lang' },
      { value: 'javascript', label: 'JavaScript', icon: 'lang' },
    ],
  },
  {
    id: 'py_q1',
    section: 'diagnostico',
    type: 'multiple',
    required: true,
    layout: 'cards',
    showIf: eligioPython,
    prompt: 'Selecciona algunas de las características de Python:',
    options: [
      {
        value: 'sintaxis',
        label: 'Sintaxis sencilla y legible',
        description:
          'La sintaxis de Python es clara y sencilla, lo que lo hace accesible para principiantes y eficiente para programadores experimentados.',
      },
      {
        value: 'bibliotecas',
        label: 'Amplias bibliotecas y marcos',
        description:
          'Bibliotecas como NumPy, Pandas y Django amplían la funcionalidad de Python para tareas especializadas en ciencia de datos, desarrollo web y mucho más.',
      },
    ],
    correct: ['sintaxis', 'bibliotecas'],
  },
  {
    id: 'py_q2',
    section: 'diagnostico',
    type: 'single',
    required: true,
    showIf: eligioPython,
    prompt:
      '¿Cuál es la forma correcta de imprimir el texto "Hola Mundo" en la consola usando Python?',
    options: [
      { value: 'echo', label: 'echo("Hola Mundo")' },
      { value: 'print', label: 'print("Hola Mundo")' },
      { value: 'console_log', label: 'console.log("Hola Mundo")' },
    ],
    correct: 'print',
  },
  {
    id: 'py_q3',
    section: 'diagnostico',
    type: 'single',
    required: true,
    showIf: eligioPython,
    prompt:
      '¿Cómo se asigna correctamente el valor numérico 10 a una variable llamada edad?',
    options: [
      { value: 'python_style', label: 'edad = 10' },
      { value: 'c_style', label: 'int edad = 10' },
      { value: 'js_style', label: 'let edad = 10;' },
    ],
    correct: 'python_style',
  },
  {
    id: 'py_q4',
    section: 'diagnostico',
    type: 'single',
    required: true,
    showIf: eligioPython,
    prompt:
      '¿Qué palabra clave se utiliza en Python para agregar una condición alternativa si la primera condición de un if es falsa?',
    options: [
      { value: 'else_if', label: 'else if' },
      { value: 'else', label: 'else' },
      { value: 'elif', label: 'elif' },
    ],
    correct: 'elif',
  },
  {
    id: 'py_q5',
    section: 'diagnostico',
    type: 'single',
    required: true,
    showIf: eligioPython,
    prompt: '¿Qué tipo de dato representa el valor "3.14" en Python?',
    options: [
      { value: 'bool', label: 'Booleano (bool)' },
      { value: 'float', label: 'Número decimal (float)' },
      { value: 'str', label: 'Cadena de texto (str)' },
    ],
    correct: 'float',
  },
  {
    id: 'py_q6',
    section: 'diagnostico',
    type: 'single',
    required: true,
    showIf: eligioPython,
    prompt:
      'Dada la lista colores = ["rojo", "verde", "azul"], ¿qué expresión debes usar para obtener el valor "verde"?',
    options: [
      { value: 'index_2', label: 'colores[2]' },
      { value: 'index_1', label: 'colores[1]' },
      { value: 'key_string', label: 'colores["verde"]' },
    ],
    correct: 'index_1',
  },
  {
    id: 'py_q7',
    section: 'diagnostico',
    type: 'single',
    required: true,
    showIf: eligioPython,
    prompt:
      '¿Qué números imprimirá en consola el bucle for i in range(3): print(i)?',
    options: [
      { value: 'range_1_3', label: '1, 2, 3' },
      { value: 'range_0_2', label: '0, 1, 2' },
      { value: 'range_0_3', label: '0, 1, 2, 3' },
    ],
    correct: 'range_0_2',
  },
  {
    id: 'py_q8',
    section: 'diagnostico',
    type: 'single',
    required: true,
    showIf: eligioPython,
    prompt:
      '¿Cuál de las siguientes sintaxis es la correcta para crear un diccionario vacío en Python?',
    options: [
      { value: 'curly_braces', label: 'diccionario = {}' },
      { value: 'square_brackets', label: 'diccionario = []' },
      { value: 'parentheses', label: 'diccionario = ()' },
    ],
    correct: 'curly_braces',
  },
  {
    id: 'py_q9',
    section: 'diagnostico',
    type: 'single',
    required: true,
    showIf: eligioPython,
    prompt:
      '¿Qué palabra reservada se usa obligatoriamente para definir una función personalizada en Python?',
    options: [
      { value: 'def', label: 'def' },
      { value: 'create', label: 'create' },
      { value: 'function', label: 'function' },
    ],
    correct: 'def',
  },
  {
    id: 'py_q10',
    section: 'diagnostico',
    type: 'single',
    required: true,
    showIf: eligioPython,
    prompt: '¿Por qué el siguiente código generará un error de sintaxis?',
    code: 'if True:\nprint("Hola")',
    options: [
      {
        value: 'missing_semicolon',
        label: 'Falta un punto y coma al final del print.',
      },
      {
        value: 'true_lowercase',
        label: 'La palabra True debe de ser completamente en minúsculas.',
      },
      {
        value: 'missing_indent',
        label: 'Falta la indentación antes de la función print.',
      },
    ],
    correct: 'missing_indent',
  },
]
