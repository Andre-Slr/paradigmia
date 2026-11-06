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
        WHERE slug = 'css-fundamentos-principiante'
    ) THEN
        RAISE EXCEPTION 'El slug css-fundamentos-principiante ya existe en public.courses.';
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
        'css-fundamentos-principiante',
        'CSS y fundamentos visuales',
        'Aprende a diseñar interfaces web con estilos, layout, tipografía y responsividad.',
        'CSS',
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
        'introduccion-a-css',
        'Introducción a CSS',
        'Comprender qué es CSS y cómo se conecta con HTML.',
        '[{"type":"paragraph","text":"CSS controla la apariencia visual de una página: color, tipografía, espaciado y disposición."},{"type":"paragraph","text":"Se usa para separar contenido y diseño, manteniendo el HTML más estructurado."},{"type":"code","text":"p {\n  color: #19350C;\n  font-size: 16px;\n}"},{"type":"exercise","title":"Ejercicio práctico","steps":["Crea un archivo CSS.","Aplica color a un párrafo.","Enlázalo desde HTML."]},{"type":"tip","title":"Consejo","text":"El CSS mejora la legibilidad y la consistencia visual de la interfaz."}]'::jsonb,
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
        'selectores-y-clases',
        'Selectores y clases',
        'Aplicar estilos a elementos específicos.',
        '[{"type":"paragraph","text":"Los selectores identifican elementos por nombre, clase o id."},{"type":"paragraph","text":"Las clases permiten reutilizar el mismo estilo en varios elementos."},{"type":"code","text":".boton {\n  background: #687D31;\n  color: white;\n  border-radius: 10px;\n}"},{"type":"exercise","title":"Ejercicio práctico","steps":["Crea una clase para tarjetas.","Aplica estilos a varios elementos.","Comprueba la reutilización."]},{"type":"warning","title":"Atención","text":"Usa clases para estilos reutilizables y ids solo cuando necesites un elemento único."}]'::jsonb,
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
        'modelo-de-caja',
        'Modelo de caja',
        'Entender padding, border y margin.',
        '[{"type":"paragraph","text":"Cada elemento tiene contenido, padding, border y margin."},{"type":"paragraph","text":"Este modelo define cómo se organiza y separa visualmente cada bloque."},{"type":"code","text":".card {\n  width: 220px;\n  padding: 16px;\n  border: 1px solid #D5D3CC;\n  margin: 12px;\n}"},{"type":"exercise","title":"Ejercicio práctico","steps":["Diseña una tarjeta.","Agrega padding y margin.","Observa el cambio visual."]},{"type":"tip","title":"Consejo","text":"El margen separa bloques entre sí; el padding separa contenido del borde."}]'::jsonb,
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
        'layout-y-responsividad',
        'Layout y responsividad',
        'Crear diseños adaptados a pantallas pequeñas.',
        '[{"type":"paragraph","text":"Flexbox y media queries permiten adaptar un diseño a móviles, tablet y escritorio."},{"type":"paragraph","text":"La responsividad ayuda a que el contenido se vea bien en distintas resoluciones."},{"type":"code","text":".menu { display: flex; gap: 16px; }\n@media (max-width: 640px) { .menu { flex-direction: column; } }"},{"type":"exercise","title":"Ejercicio práctico","steps":["Crea un contenedor flexible.","Añade una media query.","Observa el cambio en móvil."]},{"type":"tip","title":"Buena práctica","text":"Diseña primero para móvil y luego escala el layout para pantallas grandes."}]'::jsonb,
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
        'actividad-css-introduccion',
        'Actividad 1: CSS básico',
        'Selecciona la mejor opción en cada caso.',
        'activity',
        70,
        1,
        false
    )
    RETURNING id INTO v_activity_1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué propiedad cambia el color del texto?', 1, 1)
    RETURNING id INTO v_q1_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES
        (v_q1_id, 'color', 1),
        (v_q1_id, 'background', 2),
        (v_q1_id, 'margin', 3),
        (v_q1_id, 'padding', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q1_id, qo.id, 'La propiedad color define el color del texto.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q1_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué selector aplica estilo a todos los párrafos?', 2, 1)
    RETURNING id INTO v_q2_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES
        (v_q2_id, 'p { ... }', 1),
        (v_q2_id, '.p { ... }', 2),
        (v_q2_id, '#p { ... }', 3),
        (v_q2_id, 'p[] { ... }', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q2_id, qo.id, 'El selector p selecciona todos los elementos párrafo.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q2_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué propiedad agrega espacio interno?', 3, 1)
    RETURNING id INTO v_q3_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES
        (v_q3_id, 'padding', 1),
        (v_q3_id, 'margin', 2),
        (v_q3_id, 'border', 3),
        (v_q3_id, 'display', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q3_id, qo.id, 'padding crea espacio dentro del contenido y el borde.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q3_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué selector usa una clase?', 4, 1)
    RETURNING id INTO v_q4_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES
        (v_q4_id, '.tarjeta', 1),
        (v_q4_id, '#tarjeta', 2),
        (v_q4_id, 'tarjeta', 3),
        (v_q4_id, 'tarjeta[]', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q4_id, qo.id, 'Una clase se selecciona con un punto.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q4_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué archivo suele contener los estilos?', 5, 1)
    RETURNING id INTO v_q5_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES
        (v_q5_id, 'style.css', 1),
        (v_q5_id, 'script.js', 2),
        (v_q5_id, 'index.html', 3),
        (v_q5_id, 'package.json', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q5_id, qo.id, 'Un archivo CSS externo suele llamarse style.css.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q5_id AND qo.position = 1;

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
        'actividad-css-selectores',
        'Actividad 2: Selectores',
        'Identifica la opción adecuada.',
        'activity',
        70,
        2,
        false
    )
    RETURNING id INTO v_activity_2;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué selector identifica un único elemento por id?', 1, 1)
    RETURNING id INTO v_q6_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES
        (v_q6_id, '#menu', 1),
        (v_q6_id, '.menu', 2),
        (v_q6_id, 'menu', 3),
        (v_q6_id, 'menu[]', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q6_id, qo.id, 'El atributo id se selecciona con #.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q6_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué propiedad cambia el fondo?', 2, 1)
    RETURNING id INTO v_q7_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES
        (v_q7_id, 'background-color', 1),
        (v_q7_id, 'text-align', 2),
        (v_q7_id, 'font-size', 3),
        (v_q7_id, 'border-radius', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q7_id, qo.id, 'background-color modifica el fondo del elemento.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q7_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué propiedad centra texto horizontalmente?', 3, 1)
    RETURNING id INTO v_q8_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES
        (v_q8_id, 'text-align: center', 1),
        (v_q8_id, 'margin: 0 auto', 2),
        (v_q8_id, 'padding: center', 3),
        (v_q8_id, 'color: center', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q8_id, qo.id, 'text-align: center alinea el texto en el bloque.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q8_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué es más útil para reutilizar estilos?', 4, 1)
    RETURNING id INTO v_q9_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES
        (v_q9_id, 'Clases', 1),
        (v_q9_id, 'Ids', 2),
        (v_q9_id, 'Comentarios', 3),
        (v_q9_id, 'Atributos', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q9_id, qo.id, 'Las clases permiten reutilizar estilos en varios elementos.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q9_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué valor hace que un contenedor sea flexible?', 5, 1)
    RETURNING id INTO v_q10_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES
        (v_q10_id, 'display: flex', 1),
        (v_q10_id, 'position: fixed', 2),
        (v_q10_id, 'display: block', 3),
        (v_q10_id, 'overflow: hidden', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q10_id, qo.id, 'display: flex crea un contenedor flexible.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q10_id AND qo.position = 1;

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
        'actividad-css-caja',
        'Actividad 3: Modelo de caja',
        'Relaciona cada propiedad con su función.',
        'activity',
        70,
        3,
        false
    )
    RETURNING id INTO v_activity_3;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué propiedad crea separación externa?', 1, 1)
    RETURNING id INTO v_q11_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES
        (v_q11_id, 'margin', 1),
        (v_q11_id, 'padding', 2),
        (v_q11_id, 'border', 3),
        (v_q11_id, 'background', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q11_id, qo.id, 'margin añade espacio fuera del elemento.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q11_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué propiedad redondea las esquinas?', 2, 1)
    RETURNING id INTO v_q12_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES
        (v_q12_id, 'border-radius', 1),
        (v_q12_id, 'font-weight', 2),
        (v_q12_id, 'background-color', 3),
        (v_q12_id, 'text-decoration', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q12_id, qo.id, 'border-radius redondea los bordes.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q12_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué propiedad define el ancho del elemento?', 3, 1)
    RETURNING id INTO v_q13_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES
        (v_q13_id, 'width', 1),
        (v_q13_id, 'font-size', 2),
        (v_q13_id, 'line-height', 3),
        (v_q13_id, 'margin', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q13_id, qo.id, 'width establece el ancho del contenido.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q13_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué describe mejor border?', 4, 1)
    RETURNING id INTO v_q14_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES
        (v_q14_id, 'Línea visible alrededor del bloque', 1),
        (v_q14_id, 'El texto del documento', 2),
        (v_q14_id, 'El eje principal del flex', 3),
        (v_q14_id, 'La URL del enlace', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q14_id, qo.id, 'border define el borde visible del elemento.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q14_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué ayuda a centrar un bloque con ancho fijo?', 5, 1)
    RETURNING id INTO v_q15_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES
        (v_q15_id, 'margin: 0 auto', 1),
        (v_q15_id, 'padding: 0 auto', 2),
        (v_q15_id, 'display: center', 3),
        (v_q15_id, 'color: auto', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q15_id, qo.id, 'margin: 0 auto centra un bloque horizontalmente cuando tiene width definido.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q15_id AND qo.position = 1;

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
        'actividad-css-responsive',
        'Actividad 4: Layout responsivo',
        'Elige la opción correcta para cada caso.',
        'activity',
        70,
        4,
        false
    )
    RETURNING id INTO v_activity_4;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué técnica ayuda a distribuir elementos en fila o columna?', 1, 1)
    RETURNING id INTO v_q16_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES
        (v_q16_id, 'Flexbox', 1),
        (v_q16_id, 'JavaScript', 2),
        (v_q16_id, 'SQL', 3),
        (v_q16_id, 'HTML', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q16_id, qo.id, 'Flexbox organiza elementos en un eje principal.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q16_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué regla permite cambiar estilos en móviles?', 2, 1)
    RETURNING id INTO v_q17_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES
        (v_q17_id, '@media (max-width: 640px)', 1),
        (v_q17_id, '@font-face', 2),
        (v_q17_id, '.mobile { ... }', 3),
        (v_q17_id, 'document.querySelector()', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q17_id, qo.id, 'Las media queries usan @media para adaptar estilos.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q17_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué propiedad separa elementos dentro de flex?', 3, 1)
    RETURNING id INTO v_q18_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES
        (v_q18_id, 'gap', 1),
        (v_q18_id, 'size', 2),
        (v_q18_id, 'padding-top', 3),
        (v_q18_id, 'font-size', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q18_id, qo.id, 'gap añade separación entre elementos del contenedor flex.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q18_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué hace flex-direction: column?', 4, 1)
    RETURNING id INTO v_q19_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES
        (v_q19_id, 'Ordena elementos en columna', 1),
        (v_q19_id, 'Cambia el color', 2),
        (v_q19_id, 'Oculta el contenido', 3),
        (v_q19_id, 'Elimina el margen', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q19_id, qo.id, 'column cambia la dirección principal a vertical.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q19_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué mejora la experiencia en pantallas pequeñas?', 5, 1)
    RETURNING id INTO v_q20_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES
        (v_q20_id, 'Diseño responsivo', 1),
        (v_q20_id, 'Más comentarios HTML', 2),
        (v_q20_id, 'Menos estilos', 3),
        (v_q20_id, 'Más animaciones sin sentido', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q20_id, qo.id, 'El diseño responsivo adapta la interfaz a distintos tamaños.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q20_id AND qo.position = 1;

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
        'examen-final-css',
        'Examen final: CSS y fundamentos visuales',
        'Responde con la opción correcta.',
        'exam',
        70,
        5,
        false
    )
    RETURNING id INTO v_exam_id;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué propiedad define el tamaño de la fuente?', 1, 1)
    RETURNING id INTO v_q21_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES
        (v_q21_id, 'font-size', 1),
        (v_q21_id, 'padding', 2),
        (v_q21_id, 'margin', 3),
        (v_q21_id, 'color', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q21_id, qo.id, 'font-size controla el tamaño del texto.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q21_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué propiedad cambia la altura de línea?', 2, 1)
    RETURNING id INTO v_q22_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES
        (v_q22_id, 'line-height', 1),
        (v_q22_id, 'font-weight', 2),
        (v_q22_id, 'border', 3),
        (v_q22_id, 'width', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q22_id, qo.id, 'line-height controla la separación entre líneas.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q22_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué selector usa una clase?', 3, 1)
    RETURNING id INTO v_q23_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES
        (v_q23_id, '.boton', 1),
        (v_q23_id, '#boton', 2),
        (v_q23_id, 'boton', 3),
        (v_q23_id, 'boton[]', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q23_id, qo.id, 'Las clases se usan con punto.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q23_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué propiedad crea un borde?', 4, 1)
    RETURNING id INTO v_q24_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES
        (v_q24_id, 'border', 1),
        (v_q24_id, 'padding', 2),
        (v_q24_id, 'background', 3),
        (v_q24_id, 'flex', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q24_id, qo.id, 'border define el borde del elemento.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q24_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué propiedad suele generar separaciones externas?', 5, 1)
    RETURNING id INTO v_q25_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES
        (v_q25_id, 'margin', 1),
        (v_q25_id, 'width', 2),
        (v_q25_id, 'height', 3),
        (v_q25_id, 'color', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q25_id, qo.id, 'margin define espacio externo.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q25_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué valor activa flexbox?', 6, 1)
    RETURNING id INTO v_q26_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES
        (v_q26_id, 'display: flex', 1),
        (v_q26_id, 'display: block', 2),
        (v_q26_id, 'position: fixed', 3),
        (v_q26_id, 'overflow: hidden', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q26_id, qo.id, 'display: flex habilita el layout flexible.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q26_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué regla aplica estilos según ancho de pantalla?', 7, 1)
    RETURNING id INTO v_q27_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES
        (v_q27_id, '@media', 1),
        (v_q27_id, '@import', 2),
        (v_q27_id, '@supports', 3),
        (v_q27_id, '@keyframes', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q27_id, qo.id, '@media permite adaptar estilos según pantalla.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q27_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué propiedad redondea esquinas?', 8, 1)
    RETURNING id INTO v_q28_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES
        (v_q28_id, 'border-radius', 1),
        (v_q28_id, 'font-family', 2),
        (v_q28_id, 'text-transform', 3),
        (v_q28_id, 'background-image', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q28_id, qo.id, 'border-radius redondea los bordes del elemento.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q28_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace justify-content: center?', 9, 1)
    RETURNING id INTO v_q29_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES
        (v_q29_id, 'Centra elementos a lo largo del eje principal', 1),
        (v_q29_id, 'Cambia el color', 2),
        (v_q29_id, 'Oculta el contenedor', 3),
        (v_q29_id, 'Añade margen', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q29_id, qo.id, 'justify-content alinea en el eje principal.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q29_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué propiedad define la tipografía?', 10, 1)
    RETURNING id INTO v_q30_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES
        (v_q30_id, 'font-family', 1),
        (v_q30_id, 'line-height', 2),
        (v_q30_id, 'padding', 3),
        (v_q30_id, 'border-radius', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q30_id, qo.id, 'font-family escoges la familia tipográfica.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q30_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace margin: 0 auto?', 11, 1)
    RETURNING id INTO v_q31_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES
        (v_q31_id, 'Centra horizontalmente un bloque con ancho definido', 1),
        (v_q31_id, 'Oculta el bloque', 2),
        (v_q31_id, 'Sirve para color', 3),
        (v_q31_id, 'Crea un borde', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q31_id, qo.id, 'margin: 0 auto centra un elemento en horizontal.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q31_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué mejora la legibilidad en dispositivos pequeños?', 12, 1)
    RETURNING id INTO v_q32_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES
        (v_q32_id, 'line-height y font-size adecuados', 1),
        (v_q32_id, 'bordes inexistentes', 2),
        (v_q32_id, 'ocultar el texto', 3),
        (v_q32_id, 'menos código', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q32_id, qo.id, 'Ajustar tamaño y altura de línea mejora la legibilidad en móvil.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q32_id AND qo.position = 1;

END $$;

COMMIT;
