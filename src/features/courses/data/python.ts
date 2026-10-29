import pythonIcon from '@/assets/languages/python.svg'
import type { Course } from '../types'

export const pythonCourse: Course = {
  id: 'python-principiantes',
  title: 'Python para principiantes',
  languages: ['python'],
  level: 'principiante',
  interests: ['automatizacion', 'videojuegos', 'apps', 'circuitos'],
  icon: pythonIcon,
  tagline: 'Escribe tus primeros programas con el lenguaje más amigable.',
  description:
    'Python es un lenguaje con una sintaxis clara y fácil de leer. En este curso aprenderás a escribir programas que muestran información, guardan datos en variables y toman decisiones. Es la base para automatizar tareas, crear videojuegos sencillos o programar circuitos.',
  whatYouLearn: [
    'Mostrar mensajes en pantalla con print()',
    'Guardar información en variables',
    'Distinguir los tipos de datos básicos',
    'Tomar decisiones con if, elif y else',
  ],
  lessons: [
    {
      id: 'print-y-variables',
      title: 'Tu primer programa: print y variables',
      minutes: 15,
      summary:
        'Aprende a mostrar mensajes en pantalla y a guardar información en variables.',
      objectives: [
        'Usar print() para mostrar texto y números',
        'Crear variables y cambiar su valor',
        'Reconocer los tipos int, float, str y bool',
      ],
      blocks: [
        { type: 'heading', text: '¿Qué es un programa?' },
        {
          type: 'text',
          text: 'Un programa es una lista de instrucciones que la computadora ejecuta en orden, de arriba hacia abajo. En Python, cada línea suele ser una instrucción.',
        },
        { type: 'heading', text: 'Mostrar mensajes con print()' },
        {
          type: 'text',
          text: 'La función `print()` muestra en la consola lo que pongas dentro de los paréntesis. Es la forma más sencilla de ver qué está haciendo tu programa.',
        },
        {
          type: 'code',
          language: 'python',
          code: 'print("Hola Mundo")\nprint(2026)',
          output: 'Hola Mundo\n2026',
        },
        {
          type: 'callout',
          variant: 'beginner',
          title: '¿Por qué van las comillas?',
          text: 'Las comillas le indican a Python que se trata de texto. Los números se escriben sin comillas.',
        },
        { type: 'heading', text: 'Variables: cajas con nombre' },
        {
          type: 'text',
          text: 'Una variable es como una caja con una etiqueta: guarda un valor para que lo uses después. Se crea escribiendo un nombre, el signo `=` y el valor.',
        },
        {
          type: 'code',
          language: 'python',
          code: 'nombre = "Ana"\nedad = 20\nprint(nombre)\nprint(edad)',
          output: 'Ana\n20',
        },
        {
          type: 'text',
          text: 'En Python no necesitas indicar el tipo de la variable, como se hace en C con `int edad = 10`. Python lo deduce a partir del valor que le asignas.',
        },
        {
          type: 'callout',
          variant: 'warning',
          title: 'Reglas para nombrar variables',
          text: 'El nombre no puede empezar con un número ni tener espacios; usa guion bajo, como `nombre_completo`. Además, Python distingue mayúsculas: `Edad` y `edad` son variables diferentes.',
        },
        { type: 'heading', text: 'Tipos de datos básicos' },
        {
          type: 'table',
          headers: ['Tipo', 'Ejemplo', '¿Para qué sirve?'],
          rows: [
            ['int', '10', 'Números enteros'],
            ['float', '3.14', 'Números con decimales'],
            ['str', '"Hola"', 'Texto (siempre entre comillas)'],
            ['bool', 'True / False', 'Verdadero o falso'],
          ],
        },
        {
          type: 'text',
          text: 'Con la función `type()` puedes preguntarle a Python de qué tipo es un valor:',
        },
        {
          type: 'code',
          language: 'python',
          code: 'print(type(3.14))\nprint(type("3.14"))',
          output: "<class 'float'>\n<class 'str'>",
        },
        {
          type: 'callout',
          variant: 'tip',
          title: 'Ojo con las comillas',
          text: '`3.14` es un número decimal, pero `"3.14"` es texto. Con el texto no puedes hacer operaciones matemáticas.',
        },
        { type: 'heading', text: 'Combinar texto y variables' },
        {
          type: 'text',
          text: 'Si escribes una `f` antes de las comillas, puedes meter variables dentro del texto usando llaves. A esto se le llama f-string.',
        },
        {
          type: 'code',
          language: 'python',
          code: 'nombre = "Ana"\nedad = 20\nprint(f"Hola, soy {nombre} y tengo {edad} años")',
          output: 'Hola, soy Ana y tengo 20 años',
        },
      ],
      keyPoints: [
        'print() muestra información en la consola.',
        'Una variable se crea con nombre = valor.',
        'Los tipos básicos son int, float, str y bool.',
        'Las f-strings permiten insertar variables dentro de un texto.',
      ],
      quiz: {
        prompt: '¿Qué imprime este programa?',
        code: 'x = 5\nx = x + 2\nprint(x)',
        options: [
          { value: '5', label: '5' },
          { value: '7', label: '7' },
          { value: 'texto', label: 'x + 2' },
        ],
        correct: '7',
        explanation:
          'Primero x vale 5. La segunda línea toma el valor actual de x, le suma 2 y guarda el resultado otra vez en x, así que al final vale 7.',
      },
    },
    {
      id: 'condicionales',
      title: 'Tomando decisiones con if, elif y else',
      minutes: 20,
      summary:
        'Haz que tu programa elija qué hacer según se cumpla o no una condición.',
      objectives: [
        'Comparar valores con operadores como == y >=',
        'Escribir condiciones con if, elif y else',
        'Usar la indentación correctamente',
      ],
      blocks: [
        { type: 'heading', text: 'Comparar valores' },
        {
          type: 'text',
          text: 'Para tomar decisiones primero necesitamos hacer preguntas cuya respuesta sea verdadera (`True`) o falsa (`False`). Para eso usamos los operadores de comparación:',
        },
        {
          type: 'table',
          headers: ['Operador', 'Significado', 'Ejemplo', 'Resultado'],
          rows: [
            ['==', 'Igual a', '5 == 5', 'True'],
            ['!=', 'Diferente de', '5 != 3', 'True'],
            ['>', 'Mayor que', '2 > 7', 'False'],
            ['<', 'Menor que', '2 < 7', 'True'],
            ['>=', 'Mayor o igual que', '18 >= 18', 'True'],
            ['<=', 'Menor o igual que', '10 <= 9', 'False'],
          ],
        },
        {
          type: 'callout',
          variant: 'beginner',
          title: 'No confundas = con ==',
          text: 'Un solo `=` guarda un valor en una variable. Dos `==` comparan si dos valores son iguales.',
        },
        { type: 'heading', text: 'La instrucción if' },
        {
          type: 'text',
          text: '`if` ejecuta un bloque de código solo cuando la condición es verdadera. Después de la condición van dos puntos, y las instrucciones del bloque se escriben con sangría.',
        },
        {
          type: 'code',
          language: 'python',
          code: 'edad = 18\nif edad >= 18:\n    print("Eres mayor de edad")',
          output: 'Eres mayor de edad',
        },
        {
          type: 'callout',
          variant: 'warning',
          title: 'La sangría es obligatoria',
          text: 'Python usa la sangría (normalmente 4 espacios) para saber qué líneas pertenecen al if. Si la olvidas, el programa marca un error de indentación y no se ejecuta.',
        },
        { type: 'heading', text: 'Un camino alternativo: else' },
        {
          type: 'text',
          text: '`else` indica qué hacer cuando la condición no se cumple. No lleva condición propia.',
        },
        {
          type: 'code',
          language: 'python',
          code: 'edad = 15\nif edad >= 18:\n    print("Puedes votar")\nelse:\n    print("Aún no puedes votar")',
          output: 'Aún no puedes votar',
        },
        { type: 'heading', text: 'Varias opciones: elif' },
        {
          type: 'text',
          text: '`elif` (abreviatura de "else if") permite revisar otra condición si la anterior fue falsa. Python revisa las condiciones en orden y ejecuta únicamente el primer bloque que sea verdadero.',
        },
        {
          type: 'code',
          language: 'python',
          code: 'calificacion = 85\nif calificacion >= 90:\n    print("Excelente")\nelif calificacion >= 70:\n    print("Aprobado")\nelse:\n    print("Reprobado")',
          output: 'Aprobado',
          caption: '85 no es mayor o igual a 90, pero sí a 70, así que se ejecuta el segundo bloque.',
        },
        { type: 'heading', text: 'Combinar condiciones' },
        {
          type: 'text',
          text: 'Con `and` se deben cumplir ambas condiciones; con `or` basta con que se cumpla una; y `not` invierte el resultado.',
        },
        {
          type: 'code',
          language: 'python',
          code: 'tiene_boleto = True\nedad = 15\nif tiene_boleto and edad >= 12:\n    print("Puedes entrar a la película")',
          output: 'Puedes entrar a la película',
        },
      ],
      keyPoints: [
        'Las comparaciones devuelven True o False.',
        'if ejecuta su bloque solo si la condición es verdadera.',
        'elif revisa otra condición y else cubre todos los demás casos.',
        'La sangría define qué instrucciones pertenecen a cada bloque.',
      ],
      quiz: {
        prompt: '¿Qué imprime este programa?',
        code: 'temperatura = 25\nif temperatura > 30:\n    print("Calor")\nelif temperatura > 20:\n    print("Agradable")\nelse:\n    print("Frío")',
        options: [
          { value: 'calor', label: 'Calor' },
          { value: 'agradable', label: 'Agradable' },
          { value: 'frio', label: 'Frío' },
        ],
        correct: 'agradable',
        explanation:
          '25 no es mayor que 30, así que se descarta el if. Luego se revisa el elif: 25 sí es mayor que 20, por lo que se imprime "Agradable" y el else ya no se evalúa.',
      },
    },
  ],
}
