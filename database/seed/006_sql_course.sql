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
        WHERE slug = 'sql-principiante'
    ) THEN
        RAISE EXCEPTION 'El slug sql-principiante ya existe en public.courses.';
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
        'sql-principiante',
        'SQL para principiantes',
        'Curso introductorio para aprender consultas, filtros, ordenación y uniones en SQL.',
        'SQL',
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
        'introduccion-a-sql',
        'Introducción a SQL',
        'Comprender qué es SQL y para qué sirve en bases de datos relacionales.',
        '[{"type":"paragraph","text":"SQL significa Structured Query Language y se usa para consultar y manipular datos en bases de datos relacionales."},{"type":"paragraph","text":"Con SQL puedes leer tablas, agrupar resultados y aplicar condiciones para obtener exactamente la información que necesitas."},{"type":"code","text":"SELECT id, nombre FROM clientes;"},{"type":"exercise","title":"Ejercicio práctico","steps":["Abre una tabla pequeña.","Selecciona dos columnas.","Comprueba el resultado en la consola."]},{"type":"tip","title":"Consejo","text":"Empieza por consultar columnas concretas antes de usar SELECT * para mantener la salida clara."}]'::jsonb,
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
        'consultas-basicas',
        'Consultas básicas',
        'Aprender a usar SELECT, FROM y WHERE para filtrar información.',
        '[{"type":"paragraph","text":"SELECT define qué columnas se muestran y FROM indica la tabla origen."},{"type":"paragraph","text":"WHERE permite reducir filas según condiciones para buscar registros concretos."},{"type":"code","text":"SELECT nombre, email FROM usuarios WHERE activo = true;"},{"type":"exercise","title":"Ejercicio práctico","steps":["Escribe una consulta con SELECT.","Añade FROM para indicar la tabla.","Usa WHERE para reducir la salida." ]},{"type":"warning","title":"Atención","text":"Un WHERE bien definido ayuda a evitar resultados demasiado amplios y difíciles de interpretar."}]'::jsonb,
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
        'filtros-y-orden',
        'Filtros y orden',
        'Ordenar, filtrar y limitar resultados para obtener reportes útiles.',
        '[{"type":"paragraph","text":"ORDER BY organiza los resultados y LIMIT restringe la cantidad de filas devueltas."},{"type":"paragraph","text":"LIKE facilita la búsqueda de texto parcial y AND/OR combinan condiciones."},{"type":"code","text":"SELECT * FROM pedidos WHERE total > 100 ORDER BY fecha DESC LIMIT 10;"},{"type":"exercise","title":"Ejercicio práctico","steps":["Crea una condición de filtro.","Ordena por fecha descendente.","Usa LIMIT para centrar la salida." ]},{"type":"tip","title":"Buena práctica","text":"El orden del resultado debe ser lógico para que el usuario pueda interpretar la información rápidamente."}]'::jsonb,
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
        'joins-basicos',
        'Joins básicos',
        'Combinar datos de dos tablas relacionadas usando claves comunes.',
        '[{"type":"paragraph","text":"JOIN conecta dos tablas mediante una columna compartida, como una clave primaria y una clave foránea."},{"type":"paragraph","text":"Esto permite relacionar clientes con pedidos, usuarios con perfiles y otros datos que deben mostrarse juntos."},{"type":"code","text":"SELECT c.nombre, o.total FROM clientes c JOIN pedidos o ON c.id = o.cliente_id;"},{"type":"exercise","title":"Ejercicio práctico","steps":["Relaciona dos tablas con una llave común.","Muestra columnas útiles para ambos lados.","Verifica que la unión tenga sentido." ]},{"type":"warning","title":"Atención","text":"La relación debe definirse con una condición consistente para evitar resultados incomprensibles."}]'::jsonb,
        4,
        false
    )
    RETURNING id INTO v_lesson_4;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        v_lesson_1,
        'actividad-sql-introduccion',
        'Actividad 1: Introducción a SQL',
        'Selecciona la respuesta correcta.',
        'activity',
        70,
        1,
        false
    )
    RETURNING id INTO v_activity_1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué instrucción recupera datos de una tabla?', 1, 1)
    RETURNING id INTO v_q1_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q1_id, 'SELECT', 1), (v_q1_id, 'INSERT', 2), (v_q1_id, 'DELETE', 3), (v_q1_id, 'UPDATE', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q1_id, qo.id, 'SELECT se usa para consultar datos de una tabla.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q1_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué palabra clave define la tabla de origen?', 2, 1)
    RETURNING id INTO v_q2_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q2_id, 'FROM', 1), (v_q2_id, 'WHERE', 2), (v_q2_id, 'ORDER', 3), (v_q2_id, 'GROUP', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q2_id, qo.id, 'FROM indica la tabla sobre la que se ejecuta la consulta.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q2_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué hace WHERE?', 3, 1)
    RETURNING id INTO v_q3_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q3_id, 'Filtra filas según una condición', 1), (v_q3_id, 'Crea una nueva tabla', 2), (v_q3_id, 'Ordena columnas', 3), (v_q3_id, 'Elimina registros', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q3_id, qo.id, 'WHERE aplica condiciones para reducir el conjunto de filas.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q3_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué representa una fila de una tabla?', 4, 1)
    RETURNING id INTO v_q4_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q4_id, 'Un registro', 1), (v_q4_id, 'Una columna', 2), (v_q4_id, 'Una vista', 3), (v_q4_id, 'Un índice', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q4_id, qo.id, 'Una fila es un registro individual dentro de la tabla.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q4_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué es una base de datos relacional?', 5, 1)
    RETURNING id INTO v_q5_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q5_id, 'A un conjunto de tablas relacionadas', 1), (v_q5_id, 'A una sola tabla sin conexiones', 2), (v_q5_id, 'A un lenguaje de marcado', 3), (v_q5_id, 'A un navegador web', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q5_id, qo.id, 'Las bases relacionales conectan datos entre tablas mediante relaciones.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q5_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        v_lesson_2,
        'actividad-sql-consultas',
        'Actividad 2: Consultas básicas',
        'Elige la respuesta correcta.',
        'activity',
        70,
        2,
        false
    )
    RETURNING id INTO v_activity_2;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué significa * en SELECT?', 1, 1)
    RETURNING id INTO v_q6_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q6_id, 'Todas las columnas', 1), (v_q6_id, 'Solo la primera fila', 2), (v_q6_id, 'La última columna', 3), (v_q6_id, 'Una suma', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q6_id, qo.id, 'SELECT * devuelve todas las columnas disponibles.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q6_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué hace ORDER BY?', 2, 1)
    RETURNING id INTO v_q7_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q7_id, 'Ordena los resultados', 1), (v_q7_id, 'Crea una tabla', 2), (v_q7_id, 'Filtra columnas', 3), (v_q7_id, 'Elimina duplicados', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q7_id, qo.id, 'ORDER BY define el orden de la salida de la consulta.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q7_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué cláusula limita la cantidad de filas?', 3, 1)
    RETURNING id INTO v_q8_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q8_id, 'LIMIT', 1), (v_q8_id, 'JOIN', 2), (v_q8_id, 'FROM', 3), (v_q8_id, 'DISTINCT', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q8_id, qo.id, 'LIMIT restringe la cantidad máxima de filas devueltas.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q8_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué es un alias?', 4, 1)
    RETURNING id INTO v_q9_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q9_id, 'Un nombre temporal para columnas o tablas', 1), (v_q9_id, 'Un tipo de dato', 2), (v_q9_id, 'Un valor nulo', 3), (v_q9_id, 'Una vista', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q9_id, qo.id, 'Los aliases permiten renombrar columnas o tablas en la salida.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q9_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué devuelve una consulta sin WHERE?', 5, 1)
    RETURNING id INTO v_q10_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q10_id, 'Todas las filas', 1), (v_q10_id, 'Una sola fila', 2), (v_q10_id, 'Ninguna fila', 3), (v_q10_id, 'Un error', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q10_id, qo.id, 'Sin WHERE se consideran todas las filas.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q10_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        v_lesson_3,
        'actividad-sql-filtros',
        'Actividad 3: Filtros y orden',
        'Selecciona la opción correcta.',
        'activity',
        70,
        3,
        false
    )
    RETURNING id INTO v_activity_3;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué orden usa DESC?', 1, 1)
    RETURNING id INTO v_q11_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q11_id, 'Descendente', 1), (v_q11_id, 'Ascendente', 2), (v_q11_id, 'Aleatorio', 3), (v_q11_id, 'Nulo', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q11_id, qo.id, 'DESC ordena de mayor a menor o de Z a A.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q11_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué hace LIMIT?', 2, 1)
    RETURNING id INTO v_q12_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q12_id, 'Reduce el número de filas mostradas', 1), (v_q12_id, 'Crea tablas', 2), (v_q12_id, 'Agrupa columnas', 3), (v_q12_id, 'Copia registros', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q12_id, qo.id, 'LIMIT reduce la cantidad de filas devueltas.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q12_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué operador busca coincidencias parciales?', 3, 1)
    RETURNING id INTO v_q13_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q13_id, 'LIKE', 1), (v_q13_id, 'ORDER', 2), (v_q13_id, 'JOIN', 3), (v_q13_id, 'WHERE', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q13_id, qo.id, 'LIKE permite comparar texto con patrones parciales.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q13_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué significa AND?', 4, 1)
    RETURNING id INTO v_q14_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q14_id, 'Debe cumplirse más de una condición', 1), (v_q14_id, 'Ignora la condición', 2), (v_q14_id, 'Reemplaza WHERE', 3), (v_q14_id, 'Ordena filas', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q14_id, qo.id, 'AND exige que todas las condiciones sean verdaderas.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q14_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué hace DISTINCT?', 5, 1)
    RETURNING id INTO v_q15_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q15_id, 'Elimina duplicados', 1), (v_q15_id, 'Crea una tabla', 2), (v_q15_id, 'Fusiona datos', 3), (v_q15_id, 'Agrupa valores', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q15_id, qo.id, 'DISTINCT elimina filas repetidas del resultado.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q15_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        v_lesson_4,
        'actividad-sql-joins',
        'Actividad 4: Joins básicos',
        'Elige la respuesta correcta.',
        'activity',
        70,
        4,
        false
    )
    RETURNING id INTO v_activity_4;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué hace JOIN?', 1, 1)
    RETURNING id INTO v_q16_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q16_id, 'Combina filas relacionadas de dos tablas', 1), (v_q16_id, 'Elimina columnas', 2), (v_q16_id, 'Filtra por fecha', 3), (v_q16_id, 'Actualiza registros', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q16_id, qo.id, 'JOIN combina filas relacionadas entre tablas.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q16_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Para qué sirve ON en JOIN?', 2, 1)
    RETURNING id INTO v_q17_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q17_id, 'Definir la relación entre tablas', 1), (v_q17_id, 'Ordenar filas', 2), (v_q17_id, 'Cancelar la consulta', 3), (v_q17_id, 'Crear una vista', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q17_id, qo.id, 'ON define la condición que relaciona las dos tablas.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q17_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué devuelve INNER JOIN?', 3, 1)
    RETURNING id INTO v_q18_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q18_id, 'Solo coincidencias en ambas tablas', 1), (v_q18_id, 'Todas las filas de la izquierda', 2), (v_q18_id, 'Todas las filas de la derecha', 3), (v_q18_id, 'Duplicados', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q18_id, qo.id, 'INNER JOIN devuelve solo filas con coincidencia en ambas tablas.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q18_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué hace LEFT JOIN?', 4, 1)
    RETURNING id INTO v_q19_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q19_id, 'Mantiene todas las filas de la tabla izquierda', 1), (v_q19_id, 'Solo devuelve coincidencias', 2), (v_q19_id, 'Elimina datos', 3), (v_q19_id, 'Une todo en una fila', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q19_id, qo.id, 'LEFT JOIN conserva todas las filas de la tabla izquierda aunque no haya coincidencia.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q19_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué es una clave foránea?', 5, 1)
    RETURNING id INTO v_q20_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q20_id, 'Una columna que referencia otra tabla', 1), (v_q20_id, 'Un nombre corto de columna', 2), (v_q20_id, 'Una regla de orden', 3), (v_q20_id, 'Otro nombre para SELECT', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q20_id, qo.id, 'La clave foránea conecta una fila con otra tabla.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q20_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        NULL,
        'examen-final-sql',
        'Examen final: SQL para principiantes',
        'Selecciona la respuesta correcta.',
        'exam',
        70,
        5,
        false
    )
    RETURNING id INTO v_exam_id;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué instrucción consulta datos?', 1, 1)
    RETURNING id INTO v_q21_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q21_id, 'SELECT', 1), (v_q21_id, 'INSERT', 2), (v_q21_id, 'DELETE', 3), (v_q21_id, 'UPDATE', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q21_id, qo.id, 'SELECT es la instrucción de consulta.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q21_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué define FROM?', 2, 1)
    RETURNING id INTO v_q22_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q22_id, 'La tabla origen', 1), (v_q22_id, 'La condición de orden', 2), (v_q22_id, 'La clave primaria', 3), (v_q22_id, 'La vista final', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q22_id, qo.id, 'FROM indica la tabla sobre la cual se consulta.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q22_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué palabra clave filtra filas?', 3, 1)
    RETURNING id INTO v_q23_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q23_id, 'WHERE', 1), (v_q23_id, 'GROUP', 2), (v_q23_id, 'ORDER', 3), (v_q23_id, 'LIMIT', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q23_id, qo.id, 'WHERE aplica condiciones para elegir filas específicas.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q23_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace DISTINCT?', 4, 1)
    RETURNING id INTO v_q24_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q24_id, 'Elimina duplicados', 1), (v_q24_id, 'Crea una tabla', 2), (v_q24_id, 'Ordena por fecha', 3), (v_q24_id, 'Agrupa resultados', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q24_id, qo.id, 'DISTINCT elimina filas repetidas del resultado.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q24_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace DESC?', 5, 1)
    RETURNING id INTO v_q25_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q25_id, 'Orden descendente', 1), (v_q25_id, 'Orden ascendente', 2), (v_q25_id, 'Filtra textos', 3), (v_q25_id, 'Es un alias', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q25_id, qo.id, 'DESC ordena de mayor a menor.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q25_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace LIMIT 5?', 6, 1)
    RETURNING id INTO v_q26_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q26_id, 'Muestra solo cinco filas', 1), (v_q26_id, 'Elimina cinco filas', 2), (v_q26_id, 'Agrupa cinco columnas', 3), (v_q26_id, 'Crea cinco tablas', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q26_id, qo.id, 'LIMIT 5 restringe la cantidad de filas devueltas a cinco.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q26_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué operador hace búsquedas parciales?', 7, 1)
    RETURNING id INTO v_q27_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q27_id, 'LIKE', 1), (v_q27_id, 'AND', 2), (v_q27_id, 'OR', 3), (v_q27_id, 'ORDER', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q27_id, qo.id, 'LIKE permite buscar coincidencias parciales con patrones.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q27_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué significa AND?', 8, 1)
    RETURNING id INTO v_q28_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q28_id, 'Se deben cumplir todas las condiciones', 1), (v_q28_id, 'Se cumple una sola', 2), (v_q28_id, 'Se ignora', 3), (v_q28_id, 'Genera un join', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q28_id, qo.id, 'AND exige que todas las condiciones sean verdaderas.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q28_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué devuelve INNER JOIN?', 9, 1)
    RETURNING id INTO v_q29_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q29_id, 'Coincidencias en ambas tablas', 1), (v_q29_id, 'Todo de la izquierda', 2), (v_q29_id, 'Todo de la derecha', 3), (v_q29_id, 'Duplicados', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q29_id, qo.id, 'INNER JOIN devuelve solo filas con coincidencia en ambas tablas.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q29_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué se usa para relacionar tablas?', 10, 1)
    RETURNING id INTO v_q30_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q30_id, 'ON', 1), (v_q30_id, 'WHERE', 2), (v_q30_id, 'LIMIT', 3), (v_q30_id, 'GROUP', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q30_id, qo.id, 'ON define la condición utilizada para relacionar tablas en un JOIN.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q30_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué es la clave primaria?', 11, 1)
    RETURNING id INTO v_q31_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q31_id, 'Identificador único de la fila', 1), (v_q31_id, 'Un tipo de dato', 2), (v_q31_id, 'Un alias', 3), (v_q31_id, 'Una condición', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q31_id, qo.id, 'La clave primaria identifica de forma única cada fila.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q31_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace GROUP BY?', 12, 1)
    RETURNING id INTO v_q32_id;
    INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q32_id, 'Agrupa filas por valor', 1), (v_q32_id, 'Copia la tabla', 2), (v_q32_id, 'Ordena columnas', 3), (v_q32_id, 'Elimina datos', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q32_id, qo.id, 'GROUP BY reúne filas con el mismo valor de una columna.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q32_id AND qo.position = 1;
END $$;

COMMIT;
