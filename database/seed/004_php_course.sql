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
        WHERE slug = 'php-basico-principiante'
    ) THEN
        RAISE EXCEPTION 'El slug php-basico-principiante ya existe en public.courses.';
    END IF;

    INSERT INTO public.courses (id, slug, title, description, language, level, duration_weeks, position, is_published)
    VALUES (
        gen_random_uuid(),
        'php-basico-principiante',
        'PHP y desarrollo web',
        'Aprende a crear lógica del servidor, formularios y scripts con PHP.',
        'PHP',
        'Principiante',
        4,
        999,
        false
    )
    RETURNING id INTO v_course_id;

    INSERT INTO public.lessons (id, course_id, slug, title, objective, content, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'introduccion-a-php',
        'Introducción a PHP',
        'Entender para qué sirve PHP en el desarrollo web.',
        '[{"type":"paragraph","text":"PHP se ejecuta en el servidor y puede generar HTML dinámico."},{"type":"paragraph","text":"Es especialmente útil para servir páginas y formularios."},{"type":"code","text":"<?php\n$nombre = \"Ana\";\necho \"Hola, $nombre\";\n?>"},{"type":"exercise","title":"Ejercicio práctico","steps":["Crea un script PHP.","Declara una variable.","Muéstrala con echo."]},{"type":"tip","title":"Consejo","text":"PHP combina lógica del servidor con salida HTML fácil de renderizar."}]'::jsonb,
        1,
        false
    )
    RETURNING id INTO v_lesson_1;

    INSERT INTO public.lessons (id, course_id, slug, title, objective, content, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'variables-y-arreglos',
        'Variables y arreglos',
        'Trabajar con valores y colecciones.',
        '[{"type":"paragraph","text":"Las variables permiten guardar datos en un script."},{"type":"paragraph","text":"Los arreglos agrupan varios valores en una misma estructura."},{"type":"code","text":"$edad = 25;\n$colores = [\"rojo\", \"verde\", \"azul\"];\nforeach ($colores as $color) { echo $color; }"},{"type":"exercise","title":"Ejercicio práctico","steps":["Crea un arreglo con tres elementos.","Recórrelo con foreach.","Muestra cada valor."]},{"type":"warning","title":"Atención","text":"Los arreglos permiten organizar datos relacionados en una sola estructura."}]'::jsonb,
        2,
        false
    )
    RETURNING id INTO v_lesson_2;

    INSERT INTO public.lessons (id, course_id, slug, title, objective, content, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'formularios-y-metodos',
        'Formularios y métodos HTTP',
        'Procesar datos enviados por el navegador.',
        '[{"type":"paragraph","text":"Los formularios permiten recopilar información del usuario."},{"type":"paragraph","text":"GET y POST son métodos comunes para enviar los datos."},{"type":"code","text":"<form method=\"post\" action=\"procesar.php\">\n  <input type=\"text\" name=\"nombre\">\n  <button type=\"submit\">Enviar</button>\n</form>"},{"type":"exercise","title":"Ejercicio práctico","steps":["Crea un formulario básico.","Usa method=\"post\".","Lee el valor con $_POST."]},{"type":"tip","title":"Buena práctica","text":"Escoge el método adecuado según la sensibilidad del dato que se envía."}]'::jsonb,
        3,
        false
    )
    RETURNING id INTO v_lesson_3;

    INSERT INTO public.lessons (id, course_id, slug, title, objective, content, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'funciones-y-sesiones',
        'Funciones y sesiones',
        'Reutilizar lógica y recordar información.',
        '[{"type":"paragraph","text":"Las funciones simplifican código repetido y favorecen la reutilización."},{"type":"paragraph","text":"Las sesiones permiten guardar información del usuario durante varias peticiones."},{"type":"code","text":"function saludar($nombre) { return \"Hola, $nombre\"; }\nsession_start();\n$_SESSION[\"usuario\"] = \"Ana\";"},{"type":"exercise","title":"Ejercicio práctico","steps":["Define una función simple.","Inicia sesión.","Guarda un valor en $_SESSION."]},{"type":"tip","title":"Consejo","text":"La sesión ayuda a mantener contexto del usuario entre visitas del sitio."}]'::jsonb,
        4,
        false
    )
    RETURNING id INTO v_lesson_4;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published) VALUES (gen_random_uuid(), v_course_id, v_lesson_1, 'actividad-php-basico', 'Actividad 1: PHP básico', 'Selecciona la opción correcta.', 'activity', 70, 1, false) RETURNING id INTO v_activity_1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_1, '¿Qué palabra clave se usa para mostrar contenido en PHP?', 1, 1) RETURNING id INTO v_q1_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q1_id, 'echo', 1), (v_q1_id, 'print_r', 2), (v_q1_id, 'switch', 3), (v_q1_id, 'const', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q1_id, qo.id, 'echo imprime texto o variables en la salida.' FROM public.question_options qo WHERE qo.question_id = v_q1_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_1, '¿Cómo se declara una variable en PHP?', 2, 1) RETURNING id INTO v_q2_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q2_id, '$nombre = "Ana";', 1), (v_q2_id, 'let nombre = "Ana";', 2), (v_q2_id, 'var nombre = "Ana";', 3), (v_q2_id, 'string nombre = "Ana";', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q2_id, qo.id, 'Las variables en PHP empiezan con $.' FROM public.question_options qo WHERE qo.question_id = v_q2_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_1, '¿Qué símbolo identifica el inicio de un script PHP?', 3, 1) RETURNING id INTO v_q3_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q3_id, '<?php', 1), (v_q3_id, '<script>', 2), (v_q3_id, '<php>', 3), (v_q3_id, '<?=', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q3_id, qo.id, 'PHP se abre con la etiqueta <?php.' FROM public.question_options qo WHERE qo.question_id = v_q3_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_1, '¿Qué estructura recorre un arreglo?', 4, 1) RETURNING id INTO v_q4_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q4_id, 'foreach', 1), (v_q4_id, 'if', 2), (v_q4_id, 'for', 3), (v_q4_id, 'switch', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q4_id, qo.id, 'foreach itera los elementos de un arreglo.' FROM public.question_options qo WHERE qo.question_id = v_q4_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_1, '¿Qué hace el operador . en PHP?', 5, 1) RETURNING id INTO v_q5_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q5_id, 'Concatena cadenas', 1), (v_q5_id, 'Multiplica valores', 2), (v_q5_id, 'Compara igualdad', 3), (v_q5_id, 'Divide números', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q5_id, qo.id, 'El punto concatena cadenas de texto.' FROM public.question_options qo WHERE qo.question_id = v_q5_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published) VALUES (gen_random_uuid(), v_course_id, v_lesson_2, 'actividad-php-arreglos', 'Actividad 2: Arreglos', 'Elige la mejor respuesta.', 'activity', 70, 2, false) RETURNING id INTO v_activity_2;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_2, '¿Qué estructura almacena varios valores en una sola variable?', 1, 1) RETURNING id INTO v_q6_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q6_id, 'Arreglo', 1), (v_q6_id, 'Objeto', 2), (v_q6_id, 'Bucle', 3), (v_q6_id, 'Comentario', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q6_id, qo.id, 'Un arreglo agrupa varios valores.' FROM public.question_options qo WHERE qo.question_id = v_q6_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_2, '¿Cómo se define un arreglo indexado?', 2, 1) RETURNING id INTO v_q7_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q7_id, '$colores = ["rojo", "azul"];', 1), (v_q7_id, 'array = ["rojo", "azul"];', 2), (v_q7_id, '[] $colores', 3), (v_q7_id, 'list = {"rojo", "azul"};', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q7_id, qo.id, 'PHP usa corchetes para definir arreglos.' FROM public.question_options qo WHERE qo.question_id = v_q7_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_2, '¿Qué instrucción recorre cada elemento del arreglo?', 3, 1) RETURNING id INTO v_q8_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q8_id, 'foreach', 1), (v_q8_id, 'continue', 2), (v_q8_id, 'return', 3), (v_q8_id, 'case', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q8_id, qo.id, 'foreach recorre cada valor en un arreglo.' FROM public.question_options qo WHERE qo.question_id = v_q8_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_2, '¿Qué es un arreglo asociativo?', 4, 1) RETURNING id INTO v_q9_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q9_id, 'Un arreglo con claves y valores', 1), (v_q9_id, 'Un valor booleano', 2), (v_q9_id, 'Un bloque HTML', 3), (v_q9_id, 'Una función', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q9_id, qo.id, 'Los arreglos asociativos usan claves para cada valor.' FROM public.question_options qo WHERE qo.question_id = v_q9_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_2, '¿Qué superglobal se usa para datos enviados por formulario?', 5, 1) RETURNING id INTO v_q10_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q10_id, '$_POST', 1), (v_q10_id, '$GLOBALS', 2), (v_q10_id, '$SESSION', 3), (v_q10_id, '$SERVER', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q10_id, qo.id, '$_POST guarda datos enviados con POST.' FROM public.question_options qo WHERE qo.question_id = v_q10_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published) VALUES (gen_random_uuid(), v_course_id, v_lesson_3, 'actividad-php-formularios', 'Actividad 3: Formularios', 'Selecciona la respuesta correcta.', 'activity', 70, 3, false) RETURNING id INTO v_activity_3;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_3, '¿Qué atributo del formulario indica cómo se envían los datos?', 1, 1) RETURNING id INTO v_q11_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q11_id, 'method', 1), (v_q11_id, 'action', 2), (v_q11_id, 'name', 3), (v_q11_id, 'id', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q11_id, qo.id, 'method define si el envío es GET o POST.' FROM public.question_options qo WHERE qo.question_id = v_q11_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_3, '¿Qué valor usa un formulario para enviar datos sin mostrar la URL?', 2, 1) RETURNING id INTO v_q12_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q12_id, 'post', 1), (v_q12_id, 'get', 2), (v_q12_id, 'hidden', 3), (v_q12_id, 'delete', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q12_id, qo.id, 'POST envía datos en el cuerpo de la petición.' FROM public.question_options qo WHERE qo.question_id = v_q12_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_3, '¿Qué superglobal lee datos de un formulario con POST?', 3, 1) RETURNING id INTO v_q13_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q13_id, '$_POST', 1), (v_q13_id, '$_GET', 2), (v_q13_id, '$_SESSION', 3), (v_q13_id, '$FILE', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q13_id, qo.id, '$_POST contiene los datos del formulario enviado.' FROM public.question_options qo WHERE qo.question_id = v_q13_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_3, '¿Qué atributo indica a qué archivo se manda el formulario?', 4, 1) RETURNING id INTO v_q14_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q14_id, 'action', 1), (v_q14_id, 'method', 2), (v_q14_id, 'type', 3), (v_q14_id, 'value', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q14_id, qo.id, 'action indica la URL o archivo de destino.' FROM public.question_options qo WHERE qo.question_id = v_q14_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_3, '¿Qué elemento crea un campo de texto?', 5, 1) RETURNING id INTO v_q15_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q15_id, '<input type="text">', 1), (v_q15_id, '<button>', 2), (v_q15_id, '<img>', 3), (v_q15_id, '<select>', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q15_id, qo.id, 'input type="text" crea un campo de texto.' FROM public.question_options qo WHERE qo.question_id = v_q15_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published) VALUES (gen_random_uuid(), v_course_id, v_lesson_4, 'actividad-php-funciones', 'Actividad 4: Funciones y sesiones', 'Elige la opción correcta.', 'activity', 70, 4, false) RETURNING id INTO v_activity_4;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_4, '¿Qué es una función en PHP?', 1, 1) RETURNING id INTO v_q16_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q16_id, 'Bloque reutilizable de código', 1), (v_q16_id, 'Archivo de configuración', 2), (v_q16_id, 'Etiqueta HTML', 3), (v_q16_id, 'Variable global', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q16_id, qo.id, 'Las funciones encapsulan lógica reutilizable.' FROM public.question_options qo WHERE qo.question_id = v_q16_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_4, '¿Qué instrucción inicia una sesión?', 2, 1) RETURNING id INTO v_q17_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q17_id, 'session_start();', 1), (v_q17_id, 'start_session();', 2), (v_q17_id, 'init_session();', 3), (v_q17_id, 'open_session();', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q17_id, qo.id, 'session_start() inicia la sesión del navegador.' FROM public.question_options qo WHERE qo.question_id = v_q17_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_4, '¿Qué superglobal guarda información de sesión?', 3, 1) RETURNING id INTO v_q18_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q18_id, '$_SESSION', 1), (v_q18_id, '$_POST', 2), (v_q18_id, '$_GET', 3), (v_q18_id, '$_SERVER', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q18_id, qo.id, '$_SESSION almacena datos del usuario en sesión.' FROM public.question_options qo WHERE qo.question_id = v_q18_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_4, '¿Qué devuelve una función si no usa return?', 4, 1) RETURNING id INTO v_q19_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q19_id, 'null', 1), (v_q19_id, 'false', 2), (v_q19_id, '0', 3), (v_q19_id, 'error', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q19_id, qo.id, 'Si no hay return, la función puede devolver null.' FROM public.question_options qo WHERE qo.question_id = v_q19_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_4, '¿Qué ventaja tiene encapsular lógica en funciones?', 5, 1) RETURNING id INTO v_q20_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q20_id, 'Reutilización y orden del código', 1), (v_q20_id, 'Menos seguridad', 2), (v_q20_id, 'Más HTML', 3), (v_q20_id, 'Más errores de sintaxis', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q20_id, qo.id, 'Las funciones mejoran legibilidad y reutilización.' FROM public.question_options qo WHERE qo.question_id = v_q20_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published) VALUES (gen_random_uuid(), v_course_id, NULL, 'examen-final-php', 'Examen final: PHP y desarrollo web', 'Responde cada pregunta con la opción correcta.', 'exam', 70, 5, false) RETURNING id INTO v_exam_id;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué etiqueta inicia un bloque PHP?', 1, 1) RETURNING id INTO v_q21_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q21_id, '<?php', 1), (v_q21_id, '<php>', 2), (v_q21_id, '<script>', 3), (v_q21_id, '<?>', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q21_id, qo.id, 'PHP se abre con <?php.' FROM public.question_options qo WHERE qo.question_id = v_q21_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué superglobal recibe datos enviados con GET?', 2, 1) RETURNING id INTO v_q22_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q22_id, '$_GET', 1), (v_q22_id, '$_POST', 2), (v_q22_id, '$_SESSION', 3), (v_q22_id, '$_SERVER', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q22_id, qo.id, '$_GET recibe parámetros de la URL.' FROM public.question_options qo WHERE qo.question_id = v_q22_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué operador concatena cadenas?', 3, 1) RETURNING id INTO v_q23_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q23_id, '.', 1), (v_q23_id, '+', 2), (v_q23_id, '/', 3), (v_q23_id, '*', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q23_id, qo.id, 'El punto concatena cadenas.' FROM public.question_options qo WHERE qo.question_id = v_q23_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué estructura recorre un arreglo?', 4, 1) RETURNING id INTO v_q24_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q24_id, 'foreach', 1), (v_q24_id, 'if', 2), (v_q24_id, 'switch', 3), (v_q24_id, 'return', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q24_id, qo.id, 'foreach recorre elementos del arreglo.' FROM public.question_options qo WHERE qo.question_id = v_q24_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué tipo de input crea un campo de texto?', 5, 1) RETURNING id INTO v_q25_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q25_id, 'type="text"', 1), (v_q25_id, 'method="text"', 2), (v_q25_id, 'name="text"', 3), (v_q25_id, 'value="text"', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q25_id, qo.id, 'type="text" crea un campo de texto.' FROM public.question_options qo WHERE qo.question_id = v_q25_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué valor pasa por GET en la URL?', 6, 1) RETURNING id INTO v_q26_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q26_id, 'Parámetros visibles', 1), (v_q26_id, 'Datos secretos', 2), (v_q26_id, 'Scripts PHP', 3), (v_q26_id, 'Archivos de sesión', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q26_id, qo.id, 'GET expone parámetros en la URL.' FROM public.question_options qo WHERE qo.question_id = v_q26_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué función imprime texto?', 7, 1) RETURNING id INTO v_q27_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q27_id, 'echo', 1), (v_q27_id, 'return', 2), (v_q27_id, 'int', 3), (v_q27_id, 'class', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q27_id, qo.id, 'echo muestra texto o variables.' FROM public.question_options qo WHERE qo.question_id = v_q27_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué sirve para guardar información del usuario entre peticiones?', 8, 1) RETURNING id INTO v_q28_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q28_id, '$_SESSION', 1), (v_q28_id, '$GLOBALS', 2), (v_q28_id, '$POST', 3), (v_q28_id, '$HEADER', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q28_id, qo.id, '$_SESSION conserva la sesión del usuario.' FROM public.question_options qo WHERE qo.question_id = v_q28_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué instrucción finaliza ejecución del script?', 9, 1) RETURNING id INTO v_q29_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q29_id, 'exit', 1), (v_q29_id, 'return', 2), (v_q29_id, 'switch', 3), (v_q29_id, 'echo', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q29_id, qo.id, 'exit corta inmediatamente la ejecución.' FROM public.question_options qo WHERE qo.question_id = v_q29_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué es una función?', 10, 1) RETURNING id INTO v_q30_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q30_id, 'Bloque reutilizable de código', 1), (v_q30_id, 'Etiqueta HTML', 2), (v_q30_id, 'Base de datos', 3), (v_q30_id, 'Variable constante', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q30_id, qo.id, 'Las funciones encapsulan lógica reutilizable.' FROM public.question_options qo WHERE qo.question_id = v_q30_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué atributo indica la ruta del procesamiento del formulario?', 11, 1) RETURNING id INTO v_q31_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q31_id, 'action', 1), (v_q31_id, 'method', 2), (v_q31_id, 'type', 3), (v_q31_id, 'name', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q31_id, qo.id, 'action define la URL o script que procesa el formulario.' FROM public.question_options qo WHERE qo.question_id = v_q31_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué contiene $_SERVER?', 12, 1) RETURNING id INTO v_q32_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q32_id, 'Información del entorno del servidor', 1), (v_q32_id, 'Datos del usuario', 2), (v_q32_id, 'Claves del formulario', 3), (v_q32_id, 'Variables de la base de datos', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q32_id, qo.id, '$_SERVER guarda información del entorno y la solicitud actual.' FROM public.question_options qo WHERE qo.question_id = v_q32_id AND qo.position = 1;
END $$;

COMMIT;
