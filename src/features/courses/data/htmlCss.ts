import htmlIcon from '@/assets/languages/html.svg'
import type { Course } from '../types'

export const htmlCssCourse: Course = {
  id: 'html-css-primera-web',
  title: 'HTML y CSS: crea tu primera web',
  languages: ['html', 'css'],
  level: 'principiante',
  interests: ['web'],
  icon: htmlIcon,
  tagline: 'Construye y decora tu primera página web desde cero.',
  description:
    'Toda página web está hecha con HTML, que define su estructura, y CSS, que define su apariencia. En este curso aprenderás a escribir una página completa, agregar textos, enlaces e imágenes, y darle estilo con colores, tamaños y espacios.',
  whatYouLearn: [
    'La estructura básica de un documento HTML',
    'Las etiquetas más usadas y sus atributos',
    'Cómo escribir reglas de CSS',
    'Selectores y el modelo de caja',
  ],
  lessons: [
    {
      id: 'estructura-html',
      title: 'La estructura de una página web',
      minutes: 15,
      summary:
        'Conoce las etiquetas de HTML y arma el esqueleto de tu primera página.',
      objectives: [
        'Identificar las partes de una etiqueta',
        'Escribir la estructura básica de un documento HTML',
        'Usar títulos, párrafos, enlaces e imágenes',
      ],
      blocks: [
        { type: 'heading', text: '¿Qué es HTML?' },
        {
          type: 'text',
          text: 'HTML (HyperText Markup Language) es un lenguaje de marcado: no da instrucciones como Python, sino que describe qué es cada parte de la página: un título, un párrafo, una imagen, etc. Para ello usa etiquetas.',
        },
        { type: 'heading', text: 'Anatomía de una etiqueta' },
        {
          type: 'code',
          language: 'html',
          code: '<p>Hola, soy un párrafo</p>',
        },
        {
          type: 'table',
          codeColumns: [1],
          headers: ['Parte', 'Ejemplo', 'Función'],
          rows: [
            ['Etiqueta de apertura', '<p>', 'Indica dónde empieza el elemento'],
            ['Contenido', 'Hola, soy un párrafo', 'Lo que se muestra'],
            ['Etiqueta de cierre', '</p>', 'Indica dónde termina; lleva una diagonal'],
          ],
        },
        { type: 'heading', text: 'El esqueleto de toda página' },
        {
          type: 'text',
          text: 'Todas las páginas HTML comparten la misma estructura base:',
        },
        {
          type: 'code',
          language: 'html',
          code: '<!DOCTYPE html>\n<html lang="es">\n  <head>\n    <meta charset="UTF-8">\n    <title>Mi primera página</title>\n  </head>\n  <body>\n    <h1>¡Hola, mundo!</h1>\n    <p>Esta es mi primera página web.</p>\n  </body>\n</html>',
        },
        {
          type: 'list',
          items: [
            '`<!DOCTYPE html>` avisa al navegador que el documento usa HTML moderno.',
            '`<html lang="es">` envuelve toda la página e indica que está en español.',
            '`<head>` guarda información que no se ve en la página, como el título que aparece en la pestaña.',
            '`<meta charset="UTF-8">` permite mostrar bien acentos y la letra ñ.',
            '`<body>` contiene todo lo que sí se ve en la página.',
          ],
        },
        {
          type: 'callout',
          variant: 'beginner',
          title: 'Pruébalo tú',
          text: 'Copia el código en un archivo llamado `index.html`, guárdalo y ábrelo con tu navegador. ¡Ya tienes una página web!',
        },
        { type: 'heading', text: 'Etiquetas más usadas' },
        {
          type: 'table',
          codeColumns: [0],
          headers: ['Etiqueta', 'Para qué sirve'],
          rows: [
            ['<h1> a <h6>', 'Títulos, de mayor (h1) a menor importancia (h6)'],
            ['<p>', 'Párrafos de texto'],
            ['<a>', 'Enlaces a otras páginas'],
            ['<img>', 'Imágenes (no lleva etiqueta de cierre)'],
            ['<ul> y <li>', 'Listas con viñetas y sus elementos'],
          ],
        },
        { type: 'heading', text: 'Atributos: información extra' },
        {
          type: 'text',
          text: 'Los atributos se escriben dentro de la etiqueta de apertura y le dan detalles adicionales. Por ejemplo, `href` indica a dónde lleva un enlace y `src` qué imagen mostrar.',
        },
        {
          type: 'code',
          language: 'html',
          code: '<a href="https://www.udg.mx">Visita la UdeG</a>\n<img src="gato.jpg" alt="Un gato dormido sobre un sillón">',
        },
        {
          type: 'callout',
          variant: 'tip',
          title: 'Siempre usa alt en las imágenes',
          text: 'El atributo `alt` describe la imagen. Lo leen los lectores de pantalla que usan personas con discapacidad visual, y se muestra si la imagen no carga.',
        },
      ],
      keyPoints: [
        'HTML describe la estructura de una página usando etiquetas.',
        'La mayoría de las etiquetas tienen apertura y cierre.',
        'head guarda información de la página; body, lo que se ve.',
        'Los atributos como href, src y alt dan detalles extra a una etiqueta.',
      ],
      quiz: {
        prompt: '¿Dentro de qué etiqueta va el contenido que se ve en la página?',
        options: [
          { value: 'head', label: '<head>' },
          { value: 'body', label: '<body>' },
          { value: 'title', label: '<title>' },
        ],
        correct: 'body',
        explanation:
          '<body> contiene todo lo visible. <head> guarda información sobre la página, y <title> solo define el texto de la pestaña del navegador.',
      },
    },
    {
      id: 'estilos-css',
      title: 'Dando estilo con CSS',
      minutes: 20,
      summary:
        'Cambia colores, tamaños y espacios de tu página con reglas de CSS.',
      objectives: [
        'Escribir una regla de CSS',
        'Conectar una hoja de estilos con HTML',
        'Usar selectores de etiqueta, clase e id',
        'Entender margin, border y padding',
      ],
      blocks: [
        { type: 'heading', text: '¿Qué es CSS?' },
        {
          type: 'text',
          text: 'CSS (Cascading Style Sheets) define cómo se ve el HTML: colores, tipos de letra, tamaños y posiciones. Si HTML es el esqueleto de la página, CSS es su ropa.',
        },
        { type: 'heading', text: 'Anatomía de una regla' },
        {
          type: 'code',
          language: 'css',
          code: 'h1 {\n  color: darkgreen;\n  font-size: 32px;\n}',
          caption: 'Esta regla pinta de verde oscuro todos los títulos h1 y les da un tamaño de 32 píxeles.',
        },
        {
          type: 'table',
          codeColumns: [1],
          headers: ['Parte', 'Ejemplo', 'Función'],
          rows: [
            ['Selector', 'h1', 'Elige a qué elementos se aplica'],
            ['Propiedad', 'color', 'Qué característica cambia'],
            ['Valor', 'darkgreen', 'Cómo queda esa característica'],
          ],
        },
        { type: 'heading', text: 'Conectar CSS con tu página' },
        {
          type: 'text',
          text: 'Lo más ordenado es escribir el CSS en un archivo aparte, por ejemplo `estilos.css`, y enlazarlo dentro del `<head>`:',
        },
        {
          type: 'code',
          language: 'html',
          code: '<head>\n  <link rel="stylesheet" href="estilos.css">\n</head>',
        },
        { type: 'heading', text: 'Selectores' },
        {
          type: 'table',
          codeColumns: [1],
          headers: ['Selector', 'Se escribe', 'Afecta a'],
          rows: [
            ['De etiqueta', 'p', 'Todos los párrafos'],
            ['De clase', '.destacado', 'Elementos con class="destacado"'],
            ['De id', '#portada', 'El único elemento con id="portada"'],
          ],
        },
        {
          type: 'text',
          text: 'Las clases son las más usadas porque puedes aplicarlas a varios elementos:',
        },
        {
          type: 'code',
          language: 'html',
          code: '<p class="destacado">Inscripciones abiertas</p>',
        },
        {
          type: 'code',
          language: 'css',
          code: '.destacado {\n  background-color: lightyellow;\n  font-weight: bold;\n}',
        },
        { type: 'heading', text: 'El modelo de caja' },
        {
          type: 'text',
          text: 'Para CSS, cada elemento es una caja formada por cuatro capas, de adentro hacia afuera:',
        },
        {
          type: 'list',
          items: [
            'Contenido: el texto o la imagen.',
            '`padding`: espacio interno entre el contenido y el borde.',
            '`border`: la línea que rodea la caja.',
            '`margin`: espacio externo que separa la caja de otros elementos.',
          ],
        },
        {
          type: 'code',
          language: 'css',
          code: '.tarjeta {\n  padding: 16px;\n  border: 2px solid gray;\n  margin: 24px;\n}',
        },
        {
          type: 'callout',
          variant: 'tip',
          title: 'Truco para recordarlo',
          text: 'padding es el "relleno" de adentro de la caja; margin es la distancia hacia afuera, con los vecinos.',
        },
        {
          type: 'callout',
          variant: 'warning',
          title: 'Cuida la puntuación',
          text: 'Cada declaración termina en punto y coma, y cada regla se cierra con llave. Si falta una llave, las reglas que siguen pueden dejar de funcionar.',
        },
      ],
      keyPoints: [
        'CSS controla la apariencia; HTML, la estructura.',
        'Una regla tiene selector, propiedades y valores.',
        'Las clases (.nombre) permiten reutilizar estilos.',
        'El modelo de caja se compone de contenido, padding, border y margin.',
      ],
      quiz: {
        prompt: '¿Qué selector aplica estilos al siguiente elemento?',
        code: '<p class="aviso">Clase cancelada</p>',
        options: [
          { value: 'aviso', label: 'aviso' },
          { value: 'punto', label: '.aviso' },
          { value: 'gato', label: '#aviso' },
        ],
        correct: 'punto',
        explanation:
          'Las clases se seleccionan con un punto antes del nombre. # se usa para id, y sin símbolo se seleccionarían etiquetas llamadas "aviso", que no existen.',
      },
    },
  ],
}
