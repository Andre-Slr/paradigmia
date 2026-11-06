BEGIN;

DO $$
DECLARE
    v_course_id uuid;
    v_lesson_1 uuid; v_lesson_2 uuid; v_lesson_3 uuid; v_lesson_4 uuid;
    v_activity_1 uuid; v_activity_2 uuid; v_activity_3 uuid; v_activity_4 uuid;
    v_exam_id uuid;
    v_q1_id uuid; v_q2_id uuid; v_q3_id uuid; v_q4_id uuid; v_q5_id uuid; v_q6_id uuid; v_q7_id uuid; v_q8_id uuid; v_q9_id uuid; v_q10_id uuid; v_q11_id uuid; v_q12_id uuid; v_q13_id uuid; v_q14_id uuid; v_q15_id uuid; v_q16_id uuid; v_q17_id uuid; v_q18_id uuid; v_q19_id uuid; v_q20_id uuid; v_q21_id uuid; v_q22_id uuid; v_q23_id uuid; v_q24_id uuid; v_q25_id uuid; v_q26_id uuid; v_q27_id uuid; v_q28_id uuid; v_q29_id uuid; v_q30_id uuid; v_q31_id uuid; v_q32_id uuid;
BEGIN
    IF EXISTS (SELECT 1 FROM public.courses WHERE slug = 'postgresql-intermedio') THEN
        RAISE EXCEPTION 'El slug postgresql-intermedio ya existe en public.courses.';
    END IF;

    INSERT INTO public.courses (id, slug, title, description, language, level, duration_weeks, position, is_published)
    VALUES (
        gen_random_uuid(),
        'postgresql-intermedio',
        'PostgreSQL intermedio',
        'Curso intermedio para profundizar en consultas complejas, funciones, joins y optimización de consultas en PostgreSQL.',
        'SQL',
        'Intermedio',
        4,
        999,
        false
    )
    RETURNING id INTO v_course_id;


    INSERT INTO public.lessons (id, course_id, slug, title, objective, content, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'consultas-avanzadas',
        'Consultas avanzadas',
        'Diseñar consultas con filtros, agrupaciones y cálculos complejos.',
        '[{"type": "paragraph", "text": "Las consultas avanzadas permiten combinar condiciones, funciones agregadas y filtros de negocio."}, {"type": "paragraph", "text": "Con SQL intermedio se realizan análisis más complejos sin perder claridad en la lectura."}, {"type": "code", "text": "SELECT categoria, COUNT(*) FROM productos GROUP BY categoria HAVING COUNT(*) > 5;"}, {"type": "exercise", "title": "Ejercicio práctico", "steps": ["Agrupa productos por categoría.", "Cuenta registros por grupo.", "Filtra categorías con más de cinco elementos."]}, {"type": "tip", "title": "Consejo", "text": "Las funciones agregadas se usan para resumir información y detectar patrones."}]'::jsonb,
        1,
        false
    )
    RETURNING id INTO v_lesson_1;

    INSERT INTO public.lessons (id, course_id, slug, title, objective, content, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'joins-y-relaciones',
        'Joins y relaciones',
        'Combinar tablas con lógica de relaciones y filtrado de datos.',
        '[{"type": "paragraph", "text": "Los joins permiten combinar filas relacionadas entre tablas con una clave común."}, {"type": "paragraph", "text": "La elección correcta del tipo de join depende de si necesitas elementos coincidentes o también no coincidentes."}, {"type": "code", "text": "SELECT c.nombre, o.total FROM clientes c LEFT JOIN pedidos o ON c.id = o.cliente_id;"}, {"type": "exercise", "title": "Ejercicio práctico", "steps": ["Conecta clientes con pedidos.", "Verifica qué clientes no tienen pedidos.", "Usa LEFT JOIN para comparar resultados."]}, {"type": "warning", "title": "Atención", "text": "El tipo de join define qué registros se incluyen y cuáles quedan fuera."}]'::jsonb,
        2,
        false
    )
    RETURNING id INTO v_lesson_2;

    INSERT INTO public.lessons (id, course_id, slug, title, objective, content, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'funciones-y-subconsultas',
        'Funciones y subconsultas',
        'Reutilizar lógica y transformar resultados en pasos intermedios.',
        '[{"type": "paragraph", "text": "Las funciones y subconsultas permiten encapsular cálculos y particionar la lógica de la consulta."}, {"type": "paragraph", "text": "Esto hace más clara la lectura y reduce la repetición de expresiones complejas."}, {"type": "code", "text": "SELECT nombre FROM clientes WHERE id IN (SELECT cliente_id FROM pedidos WHERE total > 500);"}, {"type": "exercise", "title": "Ejercicio práctico", "steps": ["Escribe una subconsulta que devuelva clientes activos.", "Usa la subconsulta en WHERE.", "Verifica el límite y el resultado final."]}, {"type": "tip", "title": "Buena práctica", "text": "Cuando la lógica es compleja, divide la consulta en pasos claros."}]'::jsonb,
        3,
        false
    )
    RETURNING id INTO v_lesson_3;

    INSERT INTO public.lessons (id, course_id, slug, title, objective, content, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'indices-y-optimizacion',
        'Índices y optimización',
        'Entender cómo mejorar el rendimiento de consultas frecuentes.',
        '[{"type": "paragraph", "text": "Los índices reducen el volumen de datos que debe revisarse en búsquedas comunes."}, {"type": "paragraph", "text": "Un diseño con índices bien pensados mejora la experiencia sin sacrificar claridad."}, {"type": "code", "text": "CREATE INDEX idx_pedidos_cliente_id ON pedidos (cliente_id);"}, {"type": "exercise", "title": "Ejercicio práctico", "steps": ["Define una consulta que filtre por cliente.", "Comenta qué columna necesita indexación.", "Describe por qué ayuda en búsquedas repetidas."]}, {"type": "warning", "title": "Atención", "text": "No todo índice es útil; se debe elegir según el patrón de consulta real."}]'::jsonb,
        4,
        false
    )
    RETURNING id INTO v_lesson_4;


    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        v_lesson_1,
        'act-pg-queries',
        'Actividad 1: Consultas avanzadas',
        'Selecciona la respuesta correcta.',
        'activity',
        70,
        1,
        false
    )
    RETURNING id INTO v_activity_1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué hace GROUP BY en SQL?', 1, 1)
    RETURNING id INTO v_q1_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q1_id, 'Agrupa filas por un campo para resumir datos', 1), (v_q1_id, 'Elimina duplicados', 2), (v_q1_id, 'Crea una tabla nueva', 3), (v_q1_id, 'Importa datos', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q1_id, qo.id, 'GROUP BY agrupa registros según un criterio común.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q1_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué función suele usarse para contar filas por grupo?', 2, 1)
    RETURNING id INTO v_q2_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q2_id, 'COUNT(*)', 1), (v_q2_id, 'SUM()', 2), (v_q2_id, 'MIN()', 3), (v_q2_id, 'AVG()', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q2_id, qo.id, 'COUNT(*) cuenta filas dentro de cada grupo.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q2_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué hace HAVING?', 3, 1)
    RETURNING id INTO v_q3_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q3_id, 'Filtra resultados agrupados', 1), (v_q3_id, 'Ordena columnas', 2), (v_q3_id, 'Crea una clave primaria', 3), (v_q3_id, 'Actualiza datos', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q3_id, qo.id, 'HAVING aplica condiciones sobre grupos ya agregados.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q3_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué ventaja tiene agrupar datos?', 4, 1)
    RETURNING id INTO v_q4_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q4_id, 'Resumir información útil para análisis', 1), (v_q4_id, 'Eliminar tablas', 2), (v_q4_id, 'Crear índices automáticamente', 3), (v_q4_id, 'Especificar permisos', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q4_id, qo.id, 'La agregación facilita análisis y reportes.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q4_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Cuál es la mejor práctica para consultas complejas?', 5, 1)
    RETURNING id INTO v_q5_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q5_id, 'Leer la consulta en pasos y verificar cada filtro', 1), (v_q5_id, 'Escribir todo en una línea sin revisar', 2), (v_q5_id, 'Evitar SELECT', 3), (v_q5_id, 'Ignorar GROUP BY', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q5_id, qo.id, 'Descomponer la lógica mejora claridad y depuración.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q5_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        v_lesson_2,
        'act-pg-joins',
        'Actividad 2: Joins y relaciones',
        'Elige la respuesta correcta.',
        'activity',
        70,
        2,
        false
    )
    RETURNING id INTO v_activity_2;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué hace LEFT JOIN?', 1, 1)
    RETURNING id INTO v_q1_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q1_id, 'Mantiene todos los registros de la tabla izquierda', 1), (v_q1_id, 'Elimina duplicados', 2), (v_q1_id, 'Crea un índice', 3), (v_q1_id, 'Borra filas', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q1_id, qo.id, 'LEFT JOIN conserva la tabla izquierda aunque no haya coincidencias.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q1_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué es una clave foránea?', 2, 1)
    RETURNING id INTO v_q2_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q2_id, 'Campo que referencia una clave en otra tabla', 1), (v_q2_id, 'Nombre de índice', 2), (v_q2_id, 'Condición de orden', 3), (v_q2_id, 'Función matemática', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q2_id, qo.id, 'La clave foránea vincula filas entre tablas relacionadas.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q2_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué tipo de join aporta filas coincidentes en ambos lados?', 3, 1)
    RETURNING id INTO v_q3_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q3_id, 'INNER JOIN', 1), (v_q3_id, 'LEFT JOIN', 2), (v_q3_id, 'FULL JOIN', 3), (v_q3_id, 'CROSS JOIN', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q3_id, qo.id, 'INNER JOIN devuelve solo coincidencias entre ambos conjuntos.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q3_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué implica una relación bien diseñada?', 4, 1)
    RETURNING id INTO v_q4_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q4_id, 'Que se use una columna compartida entre tablas', 1), (v_q4_id, 'Que todo quede en una sola tabla', 2), (v_q4_id, 'Que no existan llaves', 3), (v_q4_id, 'Que no haya filtros', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q4_id, qo.id, 'Las relaciones se basan en columnas compartidas o claves.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q4_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué es útil para detectar filas sin coincidencia?', 5, 1)
    RETURNING id INTO v_q5_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q5_id, 'LEFT JOIN con condición IS NULL', 1), (v_q5_id, 'ORDER BY DESC', 2), (v_q5_id, 'COUNT(*)', 3), (v_q5_id, 'SELECT DISTINCT', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q5_id, qo.id, 'LEFT JOIN + IS NULL permite encontrar elementos sin relación.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q5_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        v_lesson_3,
        'act-pg-subqueries',
        'Actividad 3: Funciones y subconsultas',
        'Selecciona la respuesta correcta.',
        'activity',
        70,
        3,
        false
    )
    RETURNING id INTO v_activity_3;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué es una subconsulta?', 1, 1)
    RETURNING id INTO v_q1_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q1_id, 'Una consulta dentro de otra consulta', 1), (v_q1_id, 'Una vista materializada', 2), (v_q1_id, 'Una tabla temporal', 3), (v_q1_id, 'Un trigger', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q1_id, qo.id, 'Las subconsultas se usan dentro de otra sentencia SQL.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q1_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Para qué sirve IN (SELECT ...)?', 2, 1)
    RETURNING id INTO v_q2_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q2_id, 'Comparar un valor con un conjunto de resultados', 1), (v_q2_id, 'Agrupar datos', 2), (v_q2_id, 'Crear una llave primaria', 3), (v_q2_id, 'Insertar filas', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q2_id, qo.id, 'IN comprueba si el valor está en el conjunto resultante.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q2_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué ventaja tienen las funciones SQL?', 3, 1)
    RETURNING id INTO v_q3_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q3_id, 'Reutilizar cálculos en varias consultas', 1), (v_q3_id, 'Reducir la seguridad', 2), (v_q3_id, 'Eliminar joins', 3), (v_q3_id, 'Cambiar el esquema', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q3_id, qo.id, 'Las funciones encapsulan lógica repetible.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q3_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué hace una subconsulta escalar?', 4, 1)
    RETURNING id INTO v_q4_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q4_id, 'Devuelve un único valor', 1), (v_q4_id, 'Devuelve varias tablas', 2), (v_q4_id, 'Elimina filas', 3), (v_q4_id, 'Actualiza restricciones', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q4_id, qo.id, 'Una subconsulta escalar produce un único resultado.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q4_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué mejora la legibilidad de una consulta compleja?', 5, 1)
    RETURNING id INTO v_q5_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q5_id, 'Dividirla en subconsultas y pasos claros', 1), (v_q5_id, 'Escribir todas las condiciones juntas', 2), (v_q5_id, 'Eliminar alias', 3), (v_q5_id, 'Usar solo SELECT *', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q5_id, qo.id, 'La segmentación ayuda a entender la lógica.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q5_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        v_lesson_4,
        'act-pg-indexes',
        'Actividad 4: Índices y optimización',
        'Elige la respuesta correcta.',
        'activity',
        70,
        4,
        false
    )
    RETURNING id INTO v_activity_4;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué objetivo tienen los índices?', 1, 1)
    RETURNING id INTO v_q1_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q1_id, 'Acelerar búsquedas frecuentes', 1), (v_q1_id, 'Reducir la seguridad', 2), (v_q1_id, 'Cambiar tipos de datos', 3), (v_q1_id, 'Crear claves foráneas', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q1_id, qo.id, 'Los índices pesan menos al buscar filas relevantes.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q1_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué es una columna típica para indexar?', 2, 1)
    RETURNING id INTO v_q2_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q2_id, 'Una usada en WHERE o JOIN con frecuencia', 1), (v_q2_id, 'Una columna de texto sin uso', 2), (v_q2_id, 'Una tabla temporal', 3), (v_q2_id, 'Una función de vista', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q2_id, qo.id, 'Los índices se usan en columnas con búsquedas repetidas.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q2_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué puede pasar si se indexan demasiadas columnas?', 3, 1)
    RETURNING id INTO v_q3_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q3_id, 'Se puede afectar el rendimiento de escritura y mantenimiento', 1), (v_q3_id, 'Se elimina la base de datos', 2), (v_q3_id, 'No hay impacto', 3), (v_q3_id, 'Se bloquean todas las consultas', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q3_id, qo.id, 'Demasiados índices aumentan costo de mantenimiento.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q3_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué es clave antes de crear un índice?', 4, 1)
    RETURNING id INTO v_q4_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q4_id, 'Conocer el patrón real de consultas', 1), (v_q4_id, 'Ignorar el tipo de dato', 2), (v_q4_id, 'Crear índices sobre todo', 3), (v_q4_id, 'Evitar pruebas de rendimiento', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q4_id, qo.id, 'El patrón de uso guía la necesidad del índice.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q4_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué permite un buen diseño de índices?', 5, 1)
    RETURNING id INTO v_q5_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q5_id, 'Consultas más rápidas sin un modelo caótico', 1), (v_q5_id, 'Usar solo una tabla', 2), (v_q5_id, 'Eliminar joins', 3), (v_q5_id, 'Duplicar columnas', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q5_id, qo.id, 'Los índices aportan rendimiento cuando se usan con criterio.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q5_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        NULL,
        'exam-postgresql-intermedio',
        'Examen final: PostgreSQL intermedio',
        'Selecciona la respuesta correcta.',
        'exam',
        70,
        5,
        false
    )
    RETURNING id INTO v_exam_id;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace GROUP BY?', 1, 1)
    RETURNING id INTO v_q1_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q1_id, 'Agrega filas según un criterio común', 1), (v_q1_id, 'Elimina columnas', 2), (v_q1_id, 'Ordena filas aleatoriamente', 3), (v_q1_id, 'Crea una vista', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q1_id, qo.id, 'GROUP BY agrupa filas para resumir.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q1_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace HAVING?', 2, 1)
    RETURNING id INTO v_q2_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q2_id, 'Filtra resultados agrupados', 1), (v_q2_id, 'Filtra columnas', 2), (v_q2_id, 'Ordena índices', 3), (v_q2_id, 'Borra campos', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q2_id, qo.id, 'HAVING actúa sobre resultados agregados.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q2_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué devuelve INNER JOIN?', 3, 1)
    RETURNING id INTO v_q3_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q3_id, 'Solo filas con coincidencia en ambas tablas', 1), (v_q3_id, 'Todas las filas de la izquierda', 2), (v_q3_id, 'Todas las filas de la derecha', 3), (v_q3_id, 'Solo filas sin coincidencia', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q3_id, qo.id, 'INNER JOIN incluye solo coincidencias.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q3_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace LEFT JOIN?', 4, 1)
    RETURNING id INTO v_q4_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q4_id, 'Mantiene todas las filas de la izquierda', 1), (v_q4_id, 'Mantiene solo filas de la derecha', 2), (v_q4_id, 'Borra filas duplicadas', 3), (v_q4_id, 'Crea índices', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q4_id, qo.id, 'LEFT JOIN conserva la tabla izquierda.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q4_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué es una subconsulta?', 5, 1)
    RETURNING id INTO v_q5_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q5_id, 'Consulta anidada dentro de otra', 1), (v_q5_id, 'Una constraint', 2), (v_q5_id, 'Un tipo de índice', 3), (v_q5_id, 'Un trigger', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q5_id, qo.id, 'Las subconsultas se insertan dentro de otra instrucción.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q5_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué usa IN con una subconsulta?', 6, 1)
    RETURNING id INTO v_q6_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q6_id, 'Comparar con un conjunto de valores', 1), (v_q6_id, 'Guardar transacciones', 2), (v_q6_id, 'Crear una tabla', 3), (v_q6_id, 'Eliminar columnas', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q6_id, qo.id, 'IN comprueba pertenencia al conjunto.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q6_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué es una clave foránea?', 7, 1)
    RETURNING id INTO v_q7_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q7_id, 'Referencia a una clave primaria de otra tabla', 1), (v_q7_id, 'Un tipo de dato', 2), (v_q7_id, 'Una función agregada', 3), (v_q7_id, 'Un alias', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q7_id, qo.id, 'La clave foránea liga relaciones entre tablas.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q7_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace COUNT(*)?', 8, 1)
    RETURNING id INTO v_q8_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q8_id, 'Cuenta filas', 1), (v_q8_id, 'Suma valores', 2), (v_q8_id, 'Calcula promedio', 3), (v_q8_id, 'Busca mínimo', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q8_id, qo.id, 'COUNT(*) cuenta el número de filas.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q8_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué es un índice útil?', 9, 1)
    RETURNING id INTO v_q9_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q9_id, 'Uno en columnas consultadas con frecuencia', 1), (v_q9_id, 'Uno en todas las columnas', 2), (v_q9_id, 'Uno en columnas vacías', 3), (v_q9_id, 'Uno en tablas temporales', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q9_id, qo.id, 'Los índices se usan donde más se consulta.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q9_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué puede pasar con demasiados índices?', 10, 1)
    RETURNING id INTO v_q10_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q10_id, 'Aumentar costos de mantenimiento y escritura', 1), (v_q10_id, 'Reducir la calidad del código', 2), (v_q10_id, 'Eliminar joins', 3), (v_q10_id, 'Cambiar valores de datos', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q10_id, qo.id, 'Más índices no siempre significa mejor rendimiento.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q10_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué es mejor antes de crear un índice?', 11, 1)
    RETURNING id INTO v_q11_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q11_id, 'Analizar el patrón real de consulta', 1), (v_q11_id, 'Ignorar datos de producción', 2), (v_q11_id, 'Crear índices aleatoriamente', 3), (v_q11_id, 'No usar joins', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q11_id, qo.id, 'La observación del uso real guía la decisión.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q11_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué mejora la claridad de consultas complejas?', 12, 1)
    RETURNING id INTO v_q12_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q12_id, 'Dividirlas en pasos y entender cada parte', 1), (v_q12_id, 'Escribir SELECT * en todo lugar', 2), (v_q12_id, 'Eliminar filtros', 3), (v_q12_id, 'Usar solo una tabla', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q12_id, qo.id, 'La descomposición ayuda a diagnosticar errores y entender resultados.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q12_id AND qo.position = 1;

END $$;

COMMIT;
