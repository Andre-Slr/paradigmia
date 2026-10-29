export interface LessonContent {
  id: string
  title: string
  objective: string
  content: string[]
  code?: string
}

export interface QuestionOption {
  id: string
  label: string
  explanation: string
}

export interface QuestionContent {
  id: string
  prompt: string
  options: QuestionOption[]
  correctOptionId: string
}

export interface ActivityContent {
  id: string
  title: string
  objective: string
  instructions: string
  questions: QuestionContent[]
}

export interface ExamQuestion extends QuestionContent {}

export interface CourseModuleContent {
  lessons: LessonContent[]
  activities: ActivityContent[]
  exam: ExamQuestion[]
}

export const courseLessons: Record<string, LessonContent[]> = {
  'python-basico': [
    {
      id: 'variables-y-tipos-de-datos',
      title: 'Variables y tipos de datos',
      objective: 'Comprender cómo guardar información en Python y usar los tipos básicos del lenguaje.',
      content: [
        'Las variables permiten guardar datos para utilizarlos más adelante en un programa. En Python, no necesitas declarar el tipo de la variable explícitamente; el lenguaje lo infiere según el valor que le asignes.',
        'Los tipos básicos más comunes son cadenas de texto, números enteros, decimales y valores booleanos. Aprender a identificarlos te ayudará a controlar el flujo y la lógica del programa.',
        'Cuando combinas variables y operadores, puedes crear expresiones sencillas que forman la base de problemas más complejos.',
      ],
      code: `nombre = "Ana"
edad = 21
altura = 1.68
estudiante = True

print(nombre)
print(edad)
print(type(altura))`,
    },
    {
      id: 'condicionales',
      title: 'Condicionales',
      objective: 'Tomar decisiones dentro del código según una condición o comparación.',
      content: [
        'Los condicionales permiten ejecutar bloques de instrucciones solo si se cumple una condición. En Python esto se hace con if, elif y else.',
        'Un ejemplo sencillo es validar si un usuario tiene acceso o si un número es mayor que otro. Esto es la base de cualquier lógica interactiva.',
        'Puedes combinar condicionales con operadores lógicos para construir decisiones más completas y bien estructuradas.',
      ],
      code: `edad = 18

if edad >= 18:
    print("Eres mayor de edad")
else:
    print("Aún no eres mayor de edad")`,
    },
  ],
  'desarrollo-web': [
    {
      id: 'estructura-basica-html',
      title: 'Estructura básica de HTML',
      objective: 'Organizar una página web con los elementos semánticos principales.',
      content: [
        'HTML define la estructura de una página. Con etiquetas como header, main, section, article y footer creamos bloques claros y comprensibles para el navegador y para los lectores.',
        'Las etiquetas semánticas ayudan a crear sitios más accesibles y mantenibles. También facilitan el trabajo con CSS y JavaScript.',
        'Una buena estructura empieza con un documento base que incluye doctype, html, head y body.',
      ],
      code: `<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <title>Mi sitio</title>
  </head>
  <body>
    <header>
      <h1>Paradigmia</h1>
    </header>
    <main>
      <p>Contenido principal.</p>
    </main>
  </body>
</html>`,
    },
    {
      id: 'introduccion-a-css',
      title: 'Introducción a CSS',
      objective: 'Aplicar estilos para mejorar la apariencia y la legibilidad de una interfaz.',
      content: [
        'CSS controla el diseño visual de los elementos HTML. Con él puedes cambiar colores, tipografías, márgenes, tamaños y distribución.',
        'Los selectores permiten apuntar a elementos específicos o grupos de elementos. Esto ayuda a construir diseños consistentes y reutilizables.',
        'Una práctica común es separar la estructura HTML del estilo CSS para mantener el código más limpio y escalable.',
      ],
      code: `body {
  font-family: 'Inter', sans-serif;
  background: #f6f1ea;
  color: #19350C;
}

h1 {
  color: #687D31;
  font-family: 'Nunito', sans-serif;
}`,
    },
  ],
}

export const courseActivities: Record<string, ActivityContent[]> = {
  'python-basico': [
    {
      id: 'ejercicios-variables',
      title: 'Actividad 1: Ejercicios sobre variables',
      objective: 'Identificar el uso correcto de variables y tipos de datos.',
      instructions: 'Selecciona la opción correcta para cada enunciado y revisa tu puntuación al terminar.',
      questions: [
        {
          id: 'q1',
          prompt: '¿Qué tipo de dato representa "Paradigmia"?',
          options: [
            { id: 'a', label: 'int', explanation: 'Los números enteros se usan para cantidades, no para textos.' },
            { id: 'b', label: 'str', explanation: 'Correcto: las cadenas de texto se escriben entre comillas.' },
            { id: 'c', label: 'bool', explanation: 'Los booleanos representan verdadero o falso.' },
          ],
          correctOptionId: 'b',
        },
        {
          id: 'q2',
          prompt: '¿Cuál de estas variables tiene un valor booleano?',
          options: [
            { id: 'a', label: 'edad = 20', explanation: 'Ese valor es un número entero.' },
            { id: 'b', label: 'curso = "Python"', explanation: 'Ese valor es una cadena de texto.' },
            { id: 'c', label: 'aprobado = True', explanation: 'Correcto: True y False son valores booleanos.' },
          ],
          correctOptionId: 'c',
        },
        {
          id: 'q3',
          prompt: '¿Qué ocurre si sumas 5 + 3 en Python?',
          options: [
            { id: 'a', label: 'Genera una cadena "53"', explanation: 'Eso ocurre si concatenas texto, no si sumas números.' },
            { id: 'b', label: 'Obtiene 8', explanation: 'Correcto: la suma entre enteros devuelve otro número entero.' },
            { id: 'c', label: 'Da un error porque no se puede sumar', explanation: 'Python sí permite sumar enteros.' },
          ],
          correctOptionId: 'b',
        },
      ],
    },
    {
      id: 'ejercicios-condicionales',
      title: 'Actividad 2: Ejercicios sobre condicionales',
      objective: 'Interpretar decisiones con if, elif y else.',
      instructions: 'Selecciona la respuesta que mejor describa el resultado del código.',
      questions: [
        {
          id: 'q1',
          prompt: 'Si edad = 17, ¿qué se imprime en un if edad >= 18?',
          options: [
            { id: 'a', label: 'Eres mayor de edad', explanation: 'Eso sólo se imprime si la condición es verdadera.' },
            { id: 'b', label: 'No se imprime ninguna condición', explanation: 'Correcto: la condición falla y el bloque else se ejecuta si está definido.' },
            { id: 'c', label: 'Se produce un error', explanation: 'Python no falla por una comparación simple.' },
          ],
          correctOptionId: 'b',
        },
        {
          id: 'q2',
          prompt: '¿Qué significa elif?',
          options: [
            { id: 'a', label: 'Una variable vacía', explanation: 'No es una estructura de control.' },
            { id: 'b', label: 'Una condición alternativa', explanation: 'Correcto: elif permite evaluar otra condición si la anterior no se cumple.' },
            { id: 'c', label: 'Un comentario', explanation: 'Los comentarios se escriben con #.' },
          ],
          correctOptionId: 'b',
        },
        {
          id: 'q3',
          prompt: '¿Cuál es la función principal de una condición?',
          options: [
            { id: 'a', label: 'Definir una variable', explanation: 'Eso se hace con el signo igual.' },
            { id: 'b', label: 'Tomar decisiones en el flujo del programa', explanation: 'Correcto: decide qué bloque de código ejecutar.' },
            { id: 'c', label: 'Guardar texto en memoria', explanation: 'Eso es el trabajo de una variable.' },
          ],
          correctOptionId: 'b',
        },
      ],
    },
  ],
  'desarrollo-web': [
    {
      id: 'identificar-etiquetas-html',
      title: 'Actividad 1: Identificar etiquetas HTML',
      objective: 'Reconocer la finalidad de las etiquetas principales del lenguaje HTML.',
      instructions: 'Elige la opción correcta según la etiqueta y su función.',
      questions: [
        {
          id: 'q1',
          prompt: '¿Qué etiqueta se usa para crear el título principal de una página?',
          options: [
            { id: 'a', label: '<h1>', explanation: 'Correcto: se usa para el encabezado principal.' },
            { id: 'b', label: '<p>', explanation: 'Define un párrafo de texto.' },
            { id: 'c', label: '<div>', explanation: 'Es un contenedor general, no el título principal.' },
          ],
          correctOptionId: 'a',
        },
        {
          id: 'q2',
          prompt: '¿Qué etiquetaestructura un párrafo?',
          options: [
            { id: 'a', label: '<strong>', explanation: 'Resalta el texto, pero no crea un párrafo.' },
            { id: 'b', label: '<p>', explanation: 'Correcto: representa un párrafo.' },
            { id: 'c', label: '<section>', explanation: 'Se usa para agrupar contenido de una sección.' },
          ],
          correctOptionId: 'b',
        },
        {
          id: 'q3',
          prompt: '¿Qué etiqueta define la estructura principal del contenido?',
          options: [
            { id: 'a', label: '<main>', explanation: 'Correcto: agrupa el contenido principal de la página.' },
            { id: 'b', label: '<footer>', explanation: 'Se usa para el pie de página.' },
            { id: 'c', label: '<li>', explanation: 'Es un elemento de lista.' },
          ],
          correctOptionId: 'a',
        },
      ],
    },
    {
      id: 'selectores-y-propiedades-css',
      title: 'Actividad 2: Selectores y propiedades CSS',
      objective: 'Relacionar selectores con propiedades de estilo.',
      instructions: 'Selecciona la mejor opción para cada caso.',
      questions: [
        {
          id: 'q1',
          prompt: '¿Qué propiedad cambiaría el color del texto?',
          options: [
            { id: 'a', label: 'margin', explanation: 'Establece espacio externo.' },
            { id: 'b', label: 'color', explanation: 'Correcto: determina el color del texto.' },
            { id: 'c', label: 'display', explanation: 'Controla el tipo de caja.' },
          ],
          correctOptionId: 'b',
        },
        {
          id: 'q2',
          prompt: '¿Qué selector aplica estilo a todos los elementos <p> de la página?',
          options: [
            { id: 'a', label: 'p { ... }', explanation: 'Correcto: selecciona todos los párrafos.' },
            { id: 'b', label: '#p { ... }', explanation: 'Selecciona un único elemento con ese id.' },
            { id: 'c', label: '.p { ... }', explanation: 'Selecciona elementos con esa clase.' },
          ],
          correctOptionId: 'a',
        },
        {
          id: 'q3',
          prompt: '¿Qué propiedad ajusta el espacio interno de un elemento?',
          options: [
            { id: 'a', label: 'padding', explanation: 'Correcto: define el espacio interno.' },
            { id: 'b', label: 'border', explanation: 'Define el borde del elemento.' },
            { id: 'c', label: 'font-size', explanation: 'Ajusta el tamaño del texto.' },
          ],
          correctOptionId: 'a',
        },
      ],
    },
  ],
}

export const courseExams: Record<string, ExamQuestion[]> = {
  'python-basico': [
    {
      id: 'q1',
      prompt: '¿Qué tipo de dato es 42?',
      options: [
        { id: 'a', label: 'str', explanation: 'Las cadenas son textos.' },
        { id: 'b', label: 'int', explanation: 'Correcto: 42 es un número entero.' },
        { id: 'c', label: 'bool', explanation: 'Es un valor verdadero/falso, no un número.' },
      ],
      correctOptionId: 'b',
    },
    {
      id: 'q2',
      prompt: '¿Cuál es la salida de: print(10 > 8)?',
      options: [
        { id: 'a', label: '10', explanation: 'La comparación devuelve un valor booleano.' },
        { id: 'b', label: 'True', explanation: 'Correcto: 10 es mayor que 8.' },
        { id: 'c', label: 'False', explanation: 'Eso sería si la comparación fuera falsa.' },
      ],
      correctOptionId: 'b',
    },
    {
      id: 'q3',
      prompt: '¿Para qué sirve un if?',
      options: [
        { id: 'a', label: 'Crear listas', explanation: 'No es el propósito de if.' },
        { id: 'b', label: 'Tomar decisiones según condiciones', explanation: 'Correcto: if ejecuta bloques según una condición.' },
        { id: 'c', label: 'Mostrar una imagen', explanation: 'Eso se hace con interfaces o recursos gráficos.' },
      ],
      correctOptionId: 'b',
    },
    {
      id: 'q4',
      prompt: '¿Qué se imprime con: if 3 == 3: print("igual")?',
      options: [
        { id: 'a', label: 'igual', explanation: 'Correcto: la condición es verdadera.' },
        { id: 'b', label: 'diferente', explanation: 'Eso sería si la comparación no fuera cierta.' },
        { id: 'c', label: 'Nada', explanation: 'La condición sí se cumple.' },
      ],
      correctOptionId: 'a',
    },
    {
      id: 'q5',
      prompt: '¿Qué representa una variable?',
      options: [
        { id: 'a', label: 'Un nombre para guardar datos', explanation: 'Correcto: permite referenciar un valor más adelante.' },
        { id: 'b', label: 'Una función de entrada', explanation: 'Eso es otra construcción del lenguaje.' },
        { id: 'c', label: 'Un archivo de texto', explanation: 'No es la misma cosa.' },
      ],
      correctOptionId: 'a',
    },
  ],
  'desarrollo-web': [
    {
      id: 'q1',
      prompt: '¿Qué etiqueta se usa para un encabezado principal?',
      options: [
        { id: 'a', label: '<h1>', explanation: 'Correcto: es el encabezado principal.' },
        { id: 'b', label: '<p>', explanation: 'Crea un párrafo.' },
        { id: 'c', label: '<header>', explanation: 'Define la cabecera de la página, no el título principal dentro del documento.' },
      ],
      correctOptionId: 'a',
    },
    {
      id: 'q2',
      prompt: '¿Qué etiqueta define el contenido principal de la página?',
      options: [
        { id: 'a', label: '<main>', explanation: 'Correcto: es el contenido principal del documento.' },
        { id: 'b', label: '<nav>', explanation: 'Se usa para la navegación.' },
        { id: 'c', label: '<footer>', explanation: 'Se usa para el pie de página.' },
      ],
      correctOptionId: 'a',
    },
    {
      id: 'q3',
      prompt: '¿Qué propiedad cambia el color del texto?',
      options: [
        { id: 'a', label: 'padding', explanation: 'Ajusta espacio interno.' },
        { id: 'b', label: 'color', explanation: 'Correcto: define el color del contenido textual.' },
        { id: 'c', label: 'background', explanation: 'Cambia el fondo, no el texto.' },
      ],
      correctOptionId: 'b',
    },
    {
      id: 'q4',
      prompt: '¿Qué selector CSS aplica estilos a una clase?',
      options: [
        { id: 'a', label: '.nombre', explanation: 'Correcto: usa punto para seleccionar clases.' },
        { id: 'b', label: '#nombre', explanation: 'Selecciona un id.' },
        { id: 'c', label: 'nombre', explanation: 'Eso no es un selector válido.' },
      ],
      correctOptionId: 'a',
    },
    {
      id: 'q5',
      prompt: '¿Qué hace la propiedad margin?',
      options: [
        { id: 'a', label: 'Añade espacio fuera del cuadro', explanation: 'Correcto: crea separación externa del elemento.' },
        { id: 'b', label: 'Cambia el texto a negrita', explanation: 'Eso se hace con font-weight o strong.' },
        { id: 'c', label: 'Oculta el contenido', explanation: 'No se usa para eso.' },
      ],
      correctOptionId: 'a',
    },
  ],
}

export const provisionalCourseContentNote =
  'Contenido provisional de demostración. Se sustituirá por datos de Supabase cuando estén disponibles.'
