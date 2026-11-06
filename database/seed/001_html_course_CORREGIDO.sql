BEGIN;

DO $$
DECLARE
    v_course_id uuid;
    v_lesson_1 uuid;
    v_lesson_2 uuid;
    v_lesson_3 uuid;
    v_lesson_4 uuid;
    v_activity_1 uuid;
    v_activity_2 uuid;
    v_activity_3 uuid;
    v_activity_4 uuid;
    v_exam_id uuid;
    v_q1_id uuid;
    v_q2_id uuid;
    v_q3_id uuid;
    v_q4_id uuid;
    v_q5_id uuid;
    v_q6_id uuid;
    v_q7_id uuid;
    v_q8_id uuid;
    v_q9_id uuid;
    v_q10_id uuid;
    v_q11_id uuid;
    v_q12_id uuid;
    v_q13_id uuid;
    v_q14_id uuid;
    v_q15_id uuid;
    v_q16_id uuid;
    v_q17_id uuid;
    v_q18_id uuid;
    v_q19_id uuid;
    v_q20_id uuid;
    v_q21_id uuid;
    v_q22_id uuid;
    v_q23_id uuid;
    v_q24_id uuid;
    v_q25_id uuid;
    v_q26_id uuid;
    v_q27_id uuid;
    v_q28_id uuid;
    v_q29_id uuid;
    v_q30_id uuid;
    v_q31_id uuid;
    v_q32_id uuid;
BEGIN
    IF EXISTS (
        SELECT 1
        FROM public.courses
        WHERE slug = 'html-estructura-web-principiante'
    ) THEN
        RAISE EXCEPTION 'El slug html-estructura-web-principiante ya existe en public.courses.';
    END IF;

    INSERT INTO public.courses (
        id,
        slug,
        title,
        description,
        language,
        level,
        duration_weeks,
        position,
        is_published
    )
    VALUES (
        gen_random_uuid(),
        'html-estructura-web-principiante',
        'HTML y estructura web',
        'Curso introductorio para aprender la estructura, semántica y formularios de HTML con ejemplos reales y accesibles.',
        'HTML',
        'Principiante',
        4,
        999,
        false
    )
    RETURNING id INTO v_course_id;

    INSERT INTO public.lessons (
        id,
        course_id,
        slug,
        title,
        objective,
        content,
        position,
        is_published
    )
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'introduccion-a-html',
        'Introducción a HTML',
        'Comprender qué es HTML y cómo se organiza un documento web básico.',
        '[
            {"type":"paragraph","text":"HTML es el lenguaje base para estructurar contenido en la web. Permite describir qué es cada parte de la página: encabezados, texto, enlaces, imágenes y formularios."},
            {"type":"paragraph","text":"Un documento HTML tiene una estructura básica: html, head y body. En head se guardan metadatos como el título y la codificación; en body se coloca lo que el usuario ve."},
            {"type":"code","text":"<!DOCTYPE html>\n<html lang=\"es\">\n  <head>\n    <meta charset=\"UTF-8\" />\n    <title>Mi primera página</title>\n  </head>\n  <body>\n    <h1>Hola, mundo</h1>\n    <p>Bienvenido a mi sitio.</p>\n  </body>\n</html>"},
            {"type":"exercise","title":"Ejercicio práctico","steps":["Crea un archivo HTML simple.","Añade html, head y body.","Incluye un título y un encabezado principal.","Guarda el archivo y ábrelo en el navegador."]},
            {"type":"tip","title":"Consejo","text":"Usa una estructura ordenada desde el principio para facilitar el mantenimiento del código y la lectura del documento."}
        ]'::jsonb,
        1,
        false
    )
    RETURNING id INTO v_lesson_1;

    INSERT INTO public.lessons (
        id,
        course_id,
        slug,
        title,
        objective,
        content,
        position,
        is_published
    )
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'elementos-de-contenido',
        'Elementos de contenido',
        'Aprender a estructurar texto, listas, enlaces e imágenes dentro de una página.',
        '[
            {"type":"paragraph","text":"Los elementos de contenido permiten organizar la información para que sea clara y legible. Los más usados son encabezados, párrafos, listas, enlaces e imágenes."},
            {"type":"paragraph","text":"Un buen diseño visual empieza por una semántica clara. Cada bloque cumple una función y ayuda a organizar la jerarquía del contenido."},
            {"type":"code","text":"<h1>Bienvenidos</h1>\n<p>Este es un párrafo introductorio.</p>\n<ul>\n  <li>Primero</li>\n  <li>Segundo</li>\n  <li>Tercero</li>\n</ul>\n<a href=\"https://example.com\">Ver ejemplo</a>\n<img src=\"/imagen.jpg\" alt=\"Paisaje montañoso\" />"},
            {"type":"exercise","title":"Ejercicio práctico","steps":["Crea un encabezado principal y dos subtítulos.","Añade un párrafo con información útil.","Incluye una lista con tres elementos.","Inserta un enlace y una imagen con texto alternativo."]},
            {"type":"warning","title":"Atención","text":"La imagen necesita un atributo alt para mejorar la accesibilidad y ayudar a usuarios que no pueden verla."}
        ]'::jsonb,
        2,
        false
    )
    RETURNING id INTO v_lesson_2;

    INSERT INTO public.lessons (
        id,
        course_id,
        slug,
        title,
        objective,
        content,
        position,
        is_published
    )
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'html-semantico',
        'HTML semántico',
        'Organizar la estructura de la página con regiones semánticas y buenas prácticas de accesibilidad.',
        '[
            {"type":"paragraph","text":"El HTML semántico usa elementos con significado concreto. En lugar de construir todo con div, se pueden emplear header, nav, main, section, article y footer para separar bloques con una intención clara."},
            {"type":"paragraph","text":"Esto mejora la legibilidad del código, la accesibilidad para usuarios con tecnologías asistivas y la capacidad de mantenimiento del sitio."},
            {"type":"code","text":"<header>\n  <h1>Mi sitio</h1>\n</header>\n<nav>\n  <a href=\"#inicio\">Inicio</a>\n  <a href=\"#servicios\">Servicios</a>\n</nav>\n<main>\n  <section>\n    <article>\n      <h2>Artículo principal</h2>\n      <p>Contenido relevante para la página.</p>\n    </article>\n  </section>\n</main>\n<footer>Pie de página</footer>"},
            {"type":"exercise","title":"Ejercicio práctico","steps":["Diseña una estructura de página con cabecera, menú, contenido principal y pie.","Agrupa el contenido principal dentro de main.","Escribe un artículo corto con título y texto."]},
            {"type":"tip","title":"Buena práctica","text":"La semántica ayuda a que el navegador, los lectores de pantalla y otros desarrolladores comprendan mejor la estructura de la página."}
        ]'::jsonb,
        3,
        false
    )
    RETURNING id INTO v_lesson_3;

    INSERT INTO public.lessons (
        id,
        course_id,
        slug,
        title,
        objective,
        content,
        position,
        is_published
    )
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'formularios',
        'Formularios',
        'Crear formularios básicos con etiquetas, entradas y validación simple.',
        '[
            {"type":"paragraph","text":"Los formularios permiten recopilar datos del usuario. Se usan elementos como input, label, select, textarea y button para crear experiencias de interacción."},
            {"type":"paragraph","text":"Cada campo debe estar claramente asociado a su etiqueta para que el formulario sea entendible y accesible. Además, el tipo de entrada correcto facilita la validación y mejora la experiencia del usuario."},
            {"type":"code","text":"<form>\n  <label for=\"nombre\">Nombre</label>\n  <input id=\"nombre\" type=\"text\" name=\"nombre\" />\n\n  <label for=\"email\">Correo</label>\n  <input id=\"email\" type=\"email\" name=\"email\" />\n\n  <label for=\"pais\">País</label>\n  <select id=\"pais\" name=\"pais\">\n    <option value=\"mx\">México</option>\n    <option value=\"es\">España</option>\n  </select>\n\n  <button type=\"submit\">Enviar</button>\n</form>"},
            {"type":"exercise","title":"Ejercicio práctico","steps":["Crea un formulario de contacto con nombre y correo.","Usa etiquetas para cada campo.","Añade un campo de texto largo para comentarios.","Incluye un botón de envío."]},
            {"type":"tip","title":"Consejo","text":"Usa tipos de entrada adecuados como email, password, number o date para guiar mejor al usuario y validar datos de forma natural."}
        ]'::jsonb,
        4,
        false
    )
    RETURNING id INTO v_lesson_4;

    INSERT INTO public.assessments (
        id,
        course_id,
        lesson_id,
        slug,
        title,
        instructions,
        kind,
        passing_score,
        position,
        is_published
    )
    VALUES (
        gen_random_uuid(),
        v_course_id,
        v_lesson_1,
        'actividad-introduccion-html',
        'Actividad 1: Introducción a HTML',
        'Selecciona la opción correcta en cada caso y revisa tus respuestas al final.',
        'activity',
        70,
        1,
        false
    )
    RETURNING id INTO v_activity_1;

    INSERT INTO public.assessments (
        id,
        course_id,
        lesson_id,
        slug,
        title,
        instructions,
        kind,
        passing_score,
        position,
        is_published
    )
    VALUES (
        gen_random_uuid(),
        v_course_id,
        v_lesson_2,
        'actividad-elementos-de-contenido',
        'Actividad 2: Elementos de contenido',
        'Identifica la etiqueta o estructura correcta para cada ejemplo.',
        'activity',
        70,
        2,
        false
    )
    RETURNING id INTO v_activity_2;

    INSERT INTO public.assessments (
        id,
        course_id,
        lesson_id,
        slug,
        title,
        instructions,
        kind,
        passing_score,
        position,
        is_published
    )
    VALUES (
        gen_random_uuid(),
        v_course_id,
        v_lesson_3,
        'actividad-html-semantico',
        'Actividad 3: HTML semántico',
        'Relaciona cada bloque con su propósito semántico.',
        'activity',
        70,
        3,
        false
    )
    RETURNING id INTO v_activity_3;

    INSERT INTO public.assessments (
        id,
        course_id,
        lesson_id,
        slug,
        title,
        instructions,
        kind,
        passing_score,
        position,
        is_published
    )
    VALUES (
        gen_random_uuid(),
        v_course_id,
        v_lesson_4,
        'actividad-formularios',
        'Actividad 4: Formularios',
        'Selecciona la opción que mejor resuelve cada requisito del formulario.',
        'activity',
        70,
        4,
        false
    )
    RETURNING id INTO v_activity_4;

    INSERT INTO public.assessments (
        id,
        course_id,
        lesson_id,
        slug,
        title,
        instructions,
        kind,
        passing_score,
        position,
        is_published
    )
    VALUES (
        gen_random_uuid(),
        v_course_id,
        NULL,
        'examen-final-html',
        'Examen final: HTML y estructura web',
        'Responde el examen final con atención. Debes completar todas las preguntas.',
        'exam',
        70,
        5,
        false
    )
    RETURNING id INTO v_exam_id;

    INSERT INTO public.questions (
        id,
        assessment_id,
        prompt,
        position,
        points
    )
    VALUES (
        gen_random_uuid(),
        v_activity_1,
        '¿Qué elemento define el título que aparece en la pestaña del navegador?',
        1,
        1
    )
    RETURNING id INTO v_q1_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES
        
        (v_q1_id, '<title>', 1),
        (v_q1_id, '<header>', 2),
        (v_q1_id, '<body>', 3),
        (v_q1_id, '<h1>', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q1_id, qo.id, 'El título de la página debe ir dentro de <title> para aparecer en la pestaña del navegador.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q1_id AND qo.position = 1;

    INSERT INTO public.questions (
        id,
        assessment_id,
        prompt,
        position,
        points
    )
    VALUES (
        gen_random_uuid(),
        v_activity_1,
        '¿Dónde debe ir el contenido visible de la página?',
        2,
        1
    )
    RETURNING id INTO v_q2_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES
        
        (v_q2_id, '<head>', 1),
        (v_q2_id, '<body>', 2),
        (v_q2_id, '<meta>', 3),
        (v_q2_id, '<link>', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q2_id, qo.id, 'El contenido que el usuario ve se ubica dentro de <body>.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q2_id AND qo.position = 2;

    INSERT INTO public.questions (
        id,
        assessment_id,
        prompt,
        position,
        points
    )
    VALUES (
        gen_random_uuid(),
        v_activity_1,
        '¿Qué etiqueta se usa para el encabezado principal?',
        3,
        1
    )
    RETURNING id INTO v_q3_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES
        
        (v_q3_id, '<p>', 1),
        (v_q3_id, '<main>', 2),
        (v_q3_id, '<h1>', 3),
        (v_q3_id, '<header>', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q3_id, qo.id, 'El encabezado principal del contenido se representa con <h1>.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q3_id AND qo.position = 3;

    INSERT INTO public.questions (
        id,
        assessment_id,
        prompt,
        position,
        points
    )
    VALUES (
        gen_random_uuid(),
        v_activity_1,
        '¿Qué atributo define el idioma del documento?',
        4,
        1
    )
    RETURNING id INTO v_q4_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES
        
        (v_q4_id, 'href', 1),
        (v_q4_id, 'src', 2),
        (v_q4_id, 'type', 3),
        (v_q4_id, 'lang', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q4_id, qo.id, 'El atributo lang indica el idioma principal del documento HTML.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q4_id AND qo.position = 4;

    INSERT INTO public.questions (
        id,
        assessment_id,
        prompt,
        position,
        points
    )
    VALUES (
        gen_random_uuid(),
        v_activity_1,
        '¿Qué etiqueta inserta un salto de línea?',
        5,
        1
    )
    RETURNING id INTO v_q5_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES
        
        (v_q5_id, '<br>', 1),
        (v_q5_id, '<hr>', 2),
        (v_q5_id, '<p>', 3),
        (v_q5_id, '<li>', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q5_id, qo.id, 'La etiqueta <br> fuerza un salto de línea dentro del flujo del texto.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q5_id AND qo.position = 1;

    INSERT INTO public.questions (
        id,
        assessment_id,
        prompt,
        position,
        points
    )
    VALUES (
        gen_random_uuid(),
        v_activity_2,
        '¿Qué etiqueta define un párrafo?',
        1,
        1
    )
    RETURNING id INTO v_q6_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES
        
        (v_q6_id, '<h2>', 1),
        (v_q6_id, '<p>', 2),
        (v_q6_id, '<li>', 3),
        (v_q6_id, '<img>', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q6_id, qo.id, 'Los párrafos se crean con la etiqueta <p>.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q6_id AND qo.position = 2;

    INSERT INTO public.questions (
        id,
        assessment_id,
        prompt,
        position,
        points
    )
    VALUES (
        gen_random_uuid(),
        v_activity_2,
        '¿Qué estructura crea una lista no ordenada?',
        2,
        1
    )
    RETURNING id INTO v_q7_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES
        
        (v_q7_id, '<ol>', 1),
        (v_q7_id, '<li>', 2),
        (v_q7_id, '<ul>', 3),
        (v_q7_id, '<dl>', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q7_id, qo.id, 'Las listas no ordenadas se construyen con <ul> y cada elemento con <li>.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q7_id AND qo.position = 3;

    INSERT INTO public.questions (
        id,
        assessment_id,
        prompt,
        position,
        points
    )
    VALUES (
        gen_random_uuid(),
        v_activity_2,
        '¿Qué atributo indica la dirección de un enlace?',
        3,
        1
    )
    RETURNING id INTO v_q8_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES
        
        (v_q8_id, 'src', 1),
        (v_q8_id, 'alt', 2),
        (v_q8_id, 'id', 3),
        (v_q8_id, 'href', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q8_id, qo.id, 'El atributo href especifica la URL o destino del enlace.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q8_id AND qo.position = 4;

    INSERT INTO public.questions (
        id,
        assessment_id,
        prompt,
        position,
        points
    )
    VALUES (
        gen_random_uuid(),
        v_activity_2,
        '¿Qué atributo describe una imagen para accesibilidad?',
        4,
        1
    )
    RETURNING id INTO v_q9_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES
        
        (v_q9_id, 'alt', 1),
        (v_q9_id, 'href', 2),
        (v_q9_id, 'class', 3),
        (v_q9_id, 'title', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q9_id, qo.id, 'El atributo alt ofrece un texto alternativo para describir la imagen.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q9_id AND qo.position = 1;

    INSERT INTO public.questions (
        id,
        assessment_id,
        prompt,
        position,
        points
    )
    VALUES (
        gen_random_uuid(),
        v_activity_2,
        '¿Qué etiqueta inserta una imagen en la página?',
        5,
        1
    )
    RETURNING id INTO v_q10_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES
        
        (v_q10_id, '<picture>', 1),
        (v_q10_id, '<img>', 2),
        (v_q10_id, '<figure>', 3),
        (v_q10_id, '<image>', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q10_id, qo.id, 'La etiqueta <img> es la forma correcta de incrustar una imagen.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q10_id AND qo.position = 2;

    INSERT INTO public.questions (
        id,
        assessment_id,
        prompt,
        position,
        points
    )
    VALUES (
        gen_random_uuid(),
        v_activity_3,
        '¿Qué etiqueta define la cabecera general del sitio?',
        1,
        1
    )
    RETURNING id INTO v_q11_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES
        
        (v_q11_id, '<section>', 1),
        (v_q11_id, '<article>', 2),
        (v_q11_id, '<header>', 3),
        (v_q11_id, '<nav>', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q11_id, qo.id, 'La cabecera de la página o de una sección se representa con <header>.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q11_id AND qo.position = 3;

    INSERT INTO public.questions (
        id,
        assessment_id,
        prompt,
        position,
        points
    )
    VALUES (
        gen_random_uuid(),
        v_activity_3,
        '¿Qué elemento representa el contenido principal de la página?',
        2,
        1
    )
    RETURNING id INTO v_q12_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES
        
        (v_q12_id, '<nav>', 1),
        (v_q12_id, '<aside>', 2),
        (v_q12_id, '<footer>', 3),
        (v_q12_id, '<main>', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q12_id, qo.id, 'El contenido principal del documento se encapsula en <main>.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q12_id AND qo.position = 4;

    INSERT INTO public.questions (
        id,
        assessment_id,
        prompt,
        position,
        points
    )
    VALUES (
        gen_random_uuid(),
        v_activity_3,
        '¿Qué etiqueta es la más apropiada para un artículo independiente dentro de la página?',
        3,
        1
    )
    RETURNING id INTO v_q13_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES
        
        (v_q13_id, '<article>', 1),
        (v_q13_id, '<span>', 2),
        (v_q13_id, '<label>', 3),
        (v_q13_id, '<button>', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q13_id, qo.id, 'Los contenidos autónomos e independientes se usan dentro de <article>.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q13_id AND qo.position = 1;

    INSERT INTO public.questions (
        id,
        assessment_id,
        prompt,
        position,
        points
    )
    VALUES (
        gen_random_uuid(),
        v_activity_3,
        '¿Qué bloque se usa para la navegación principal?',
        4,
        1
    )
    RETURNING id INTO v_q14_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES
        
        (v_q14_id, '<section>', 1),
        (v_q14_id, '<nav>', 2),
        (v_q14_id, '<p>', 3),
        (v_q14_id, '<form>', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q14_id, qo.id, 'La navegación principal se agrupa en <nav>.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q14_id AND qo.position = 2;

    INSERT INTO public.questions (
        id,
        assessment_id,
        prompt,
        position,
        points
    )
    VALUES (
        gen_random_uuid(),
        v_activity_3,
        '¿Qué elemento suele cerrar la sección o el sitio con información final?',
        5,
        1
    )
    RETURNING id INTO v_q15_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES
        
        (v_q15_id, '<aside>', 1),
        (v_q15_id, '<button>', 2),
        (v_q15_id, '<footer>', 3),
        (v_q15_id, '<label>', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q15_id, qo.id, 'El pie de página o cierre de contenido suele ser <footer>.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q15_id AND qo.position = 3;

    INSERT INTO public.questions (
        id,
        assessment_id,
        prompt,
        position,
        points
    )
    VALUES (
        gen_random_uuid(),
        v_activity_4,
        '¿Qué etiqueta define un campo de texto simple?',
        1,
        1
    )
    RETURNING id INTO v_q16_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES
        
        (v_q16_id, '<textarea>', 1),
        (v_q16_id, '<select>', 2),
        (v_q16_id, '<button>', 3),
        (v_q16_id, '<input type="text">', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q16_id, qo.id, 'Un campo de texto simple se representa con <input type="text">.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q16_id AND qo.position = 4;

    INSERT INTO public.questions (
        id,
        assessment_id,
        prompt,
        position,
        points
    )
    VALUES (
        gen_random_uuid(),
        v_activity_4,
        '¿Qué elemento acompaña a un campo para describirlo?',
        2,
        1
    )
    RETURNING id INTO v_q17_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES
        
        (v_q17_id, '<label>', 1),
        (v_q17_id, '<input>', 2),
        (v_q17_id, '<button>', 3),
        (v_q17_id, '<form>', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q17_id, qo.id, 'La etiqueta <label> identifica visual y semánticamente el campo del formulario.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q17_id AND qo.position = 1;

    INSERT INTO public.questions (
        id,
        assessment_id,
        prompt,
        position,
        points
    )
    VALUES (
        gen_random_uuid(),
        v_activity_4,
        '¿Qué tipo de entrada valida un correo electrónico?',
        3,
        1
    )
    RETURNING id INTO v_q18_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES
        
        (v_q18_id, 'text', 1),
        (v_q18_id, 'email', 2),
        (v_q18_id, 'password', 3),
        (v_q18_id, 'date', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q18_id, qo.id, 'El tipo email valida un formato de correo electrónico correcto.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q18_id AND qo.position = 2;

    INSERT INTO public.questions (
        id,
        assessment_id,
        prompt,
        position,
        points
    )
    VALUES (
        gen_random_uuid(),
        v_activity_4,
        '¿Qué etiqueta crea una lista desplegable?',
        4,
        1
    )
    RETURNING id INTO v_q19_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES
        
        (v_q19_id, '<textarea>', 1),
        (v_q19_id, '<button>', 2),
        (v_q19_id, '<select>', 3),
        (v_q19_id, '<checkbox>', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q19_id, qo.id, 'La lista desplegable se crea con <select>, y cada opción es un <option>.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q19_id AND qo.position = 3;

    INSERT INTO public.questions (
        id,
        assessment_id,
        prompt,
        position,
        points
    )
    VALUES (
        gen_random_uuid(),
        v_activity_4,
        '¿Qué elemento envía el formulario?',
        5,
        1
    )
    RETURNING id INTO v_q20_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES
        
        (v_q20_id, '<input type="hidden">', 1),
        (v_q20_id, '<label>', 2),
        (v_q20_id, '<textarea>', 3),
        (v_q20_id, '<button type="submit">', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q20_id, qo.id, 'El botón con type="submit" es el que envía los datos del formulario.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q20_id AND qo.position = 4;

    INSERT INTO public.questions (
        id,
        assessment_id,
        prompt,
        position,
        points
    )
    VALUES (
        gen_random_uuid(),
        v_exam_id,
        '¿Qué instrucción indica al navegador el tipo de documento y la versión de HTML?',
        1,
        1
    )
    RETURNING id INTO v_q21_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES
        
        (v_q21_id, '<!DOCTYPE html>', 1),
        (v_q21_id, '<html>', 2),
        (v_q21_id, '<body>', 3),
        (v_q21_id, '<head>', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q21_id, qo.id, 'DOCTYPE no es una etiqueta HTML, sino una instrucción que indica al navegador el tipo de documento y la versión de HTML.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q21_id AND qo.position = 1;

    INSERT INTO public.questions (
        id,
        assessment_id,
        prompt,
        position,
        points
    )
    VALUES (
        gen_random_uuid(),
        v_exam_id,
        '¿Qué sección del documento contiene metadatos como el título y la codificación?',
        2,
        1
    )
    RETURNING id INTO v_q22_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES
        
        (v_q22_id, '<main>', 1),
        (v_q22_id, '<head>', 2),
        (v_q22_id, '<nav>', 3),
        (v_q22_id, '<footer>', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q22_id, qo.id, 'head almacena metadatos del documento, como título y configuración técnica.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q22_id AND qo.position = 2;

    INSERT INTO public.questions (
        id,
        assessment_id,
        prompt,
        position,
        points
    )
    VALUES (
        gen_random_uuid(),
        v_exam_id,
        '¿Qué elemento encapsula el contenido principal de la página?',
        3,
        1
    )
    RETURNING id INTO v_q23_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES
        
        (v_q23_id, '<header>', 1),
        (v_q23_id, '<aside>', 2),
        (v_q23_id, '<main>', 3),
        (v_q23_id, '<article>', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q23_id, qo.id, 'main representa el contenido principal y único del documento.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q23_id AND qo.position = 3;

    INSERT INTO public.questions (
        id,
        assessment_id,
        prompt,
        position,
        points
    )
    VALUES (
        gen_random_uuid(),
        v_exam_id,
        '¿Qué etiqueta crea un enlace a otra página?',
        4,
        1
    )
    RETURNING id INTO v_q24_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES
        
        (v_q24_id, '<link href="...">', 1),
        (v_q24_id, '<img src="...">', 2),
        (v_q24_id, '<button>', 3),
        (v_q24_id, '<a href="...">', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q24_id, qo.id, 'La etiqueta <a> con href crea un enlace y define su destino.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q24_id AND qo.position = 4;

    INSERT INTO public.questions (
        id,
        assessment_id,
        prompt,
        position,
        points
    )
    VALUES (
        gen_random_uuid(),
        v_exam_id,
        '¿Qué etiqueta crea una lista ordenada?',
        5,
        1
    )
    RETURNING id INTO v_q25_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES
        
        (v_q25_id, '<ol>', 1),
        (v_q25_id, '<ul>', 2),
        (v_q25_id, '<li>', 3),
        (v_q25_id, '<dl>', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q25_id, qo.id, 'Las listas ordenadas se crean con <ol> y cada elemento con <li>.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q25_id AND qo.position = 1;

    INSERT INTO public.questions (
        id,
        assessment_id,
        prompt,
        position,
        points
    )
    VALUES (
        gen_random_uuid(),
        v_exam_id,
        '¿Qué atributo describe una imagen para lectores de pantalla?',
        6,
        1
    )
    RETURNING id INTO v_q26_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES
        
        (v_q26_id, 'lang', 1),
        (v_q26_id, 'alt', 2),
        (v_q26_id, 'id', 3),
        (v_q26_id, 'title', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q26_id, qo.id, 'alt describe la imagen para personas que no la pueden ver o para lectores de pantalla.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q26_id AND qo.position = 2;

    INSERT INTO public.questions (
        id,
        assessment_id,
        prompt,
        position,
        points
    )
    VALUES (
        gen_random_uuid(),
        v_exam_id,
        '¿Qué elemento es ideal para publicar un artículo independiente?',
        7,
        1
    )
    RETURNING id INTO v_q27_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES
        
        (v_q27_id, '<div>', 1),
        (v_q27_id, '<label>', 2),
        (v_q27_id, '<article>', 3),
        (v_q27_id, '<button>', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q27_id, qo.id, 'article es el elemento semántico para contenido independiente y completo.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q27_id AND qo.position = 3;

    INSERT INTO public.questions (
        id,
        assessment_id,
        prompt,
        position,
        points
    )
    VALUES (
        gen_random_uuid(),
        v_exam_id,
        '¿Qué etiqueta agrupa la navegación principal?',
        8,
        1
    )
    RETURNING id INTO v_q28_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES
        
        (v_q28_id, '<label>', 1),
        (v_q28_id, '<section>', 2),
        (v_q28_id, '<figure>', 3),
        (v_q28_id, '<nav>', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q28_id, qo.id, 'La navegación principal se define con <nav>.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q28_id AND qo.position = 4;

    INSERT INTO public.questions (
        id,
        assessment_id,
        prompt,
        position,
        points
    )
    VALUES (
        gen_random_uuid(),
        v_exam_id,
        '¿Qué tipo de entrada es adecuado para un correo electrónico?',
        9,
        1
    )
    RETURNING id INTO v_q29_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES
        
        (v_q29_id, 'email', 1),
        (v_q29_id, 'text', 2),
        (v_q29_id, 'range', 3),
        (v_q29_id, 'color', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q29_id, qo.id, 'Para un correo electrónico el tipo correcto es email.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q29_id AND qo.position = 1;

    INSERT INTO public.questions (
        id,
        assessment_id,
        prompt,
        position,
        points
    )
    VALUES (
        gen_random_uuid(),
        v_exam_id,
        '¿Qué elemento permite escribir varias líneas de texto?',
        10,
        1
    )
    RETURNING id INTO v_q30_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES
        
        (v_q30_id, '<text>', 1),
        (v_q30_id, '<textarea>', 2),
        (v_q30_id, '<input>', 3),
        (v_q30_id, '<select>', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q30_id, qo.id, 'textarea permite introducir texto con varias líneas.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q30_id AND qo.position = 2;

    INSERT INTO public.questions (
        id,
        assessment_id,
        prompt,
        position,
        points
    )
    VALUES (
        gen_random_uuid(),
        v_exam_id,
        '¿Cuál es la función principal de una etiqueta <label> en un formulario?',
        11,
        1
    )
    RETURNING id INTO v_q31_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES
        
        (v_q31_id, 'Insertar una imagen', 1),
        (v_q31_id, 'Crear un enlace', 2),
        (v_q31_id, 'Asociar texto descriptivo al campo', 3),
        (v_q31_id, 'Cambiar el color del texto', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q31_id, qo.id, 'La etiqueta label describe y asocia un texto explicativo con el control del formulario.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q31_id AND qo.position = 3;

    INSERT INTO public.questions (
        id,
        assessment_id,
        prompt,
        position,
        points
    )
    VALUES (
        gen_random_uuid(),
        v_exam_id,
        '¿Qué práctica mejora la accesibilidad del contenido visual?',
        12,
        1
    )
    RETURNING id INTO v_q32_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES
        
        (v_q32_id, 'Evitar todas las etiquetas', 1),
        (v_q32_id, 'Usar solo divs y spans', 2),
        (v_q32_id, 'No poner título en la página', 3),
        (v_q32_id, 'Usar texto alternativo y etiquetas semánticas', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q32_id, qo.id, 'El texto alternativo y la semántica mejoran la accesibilidad y la comprensión del contenido.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q32_id AND qo.position = 4;
END $$;

COMMIT;
