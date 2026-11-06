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
        WHERE slug = 'typescript'
    ) THEN
        RAISE EXCEPTION 'El slug typescript ya existe en public.courses.';
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
        'typescript',
        'TypeScript',
        'Curso intermedio para aprender tipos, interfaces, genéricos y validación en TypeScript.',
        'TypeScript',
        'Intermedio',
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
        'tipos-e-interfaces',
        'Tipos e interfaces',
        'Definir contratos con seguridad de tipos.',
        '[{"type": "paragraph", "text": "TypeScript añade tipos estáticos para detectar errores temprano."}, {"type": "paragraph", "text": "Las interfaces describen la estructura esperada de un objeto."}, {"type": "code", "text": "interface Usuario { id: number; nombre: string; }"}, {"type": "exercise", "title": "Ejercicio práctico", "steps": ["Define una interfaz Usuario.", "Crea un objeto con sus datos.", "Tipa la constante con la interfaz."]}, {"type": "tip", "title": "Consejo", "text": "Los tipos ayudan a documentar y validar la forma de los datos."}]'::jsonb,
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
        'uniones-e-intersecciones',
        'Uniones e intersecciones',
        'Combinar tipos para construir modelos más flexibles.',
        '[{"type": "paragraph", "text": "Las uniones aceptan varios tipos en una variable."}, {"type": "paragraph", "text": "Las intersecciones combinan varias interfaces en una sola estructura."}, {"type": "code", "text": "type Resultado = string | number; type Persona = { nombre: string }; type Usuario = Persona & { id: number };"}, {"type": "exercise", "title": "Ejercicio práctico", "steps": ["Define un union.", "Crea una intersección.", "Usa ambos en un ejemplo simple."]}, {"type": "warning", "title": "Atención", "text": "Las uniones requieren manejar todos los casos posibles."}]'::jsonb,
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
        'genericos',
        'Genéricos',
        'Crear utilidades reutilizables para distintos tipos.',
        '[{"type": "paragraph", "text": "Los genéricos permiten reutilizar lógica entre diferentes tipos."}, {"type": "paragraph", "text": "Esto mantiene seguridad de tipos sin duplicar funciones."}, {"type": "code", "text": "function identidad<T>(valor: T): T { return valor; }"}, {"type": "exercise", "title": "Ejercicio práctico", "steps": ["Define una función identidad.", "Invócala con string y number.", "Comprueba que mantiene el tipo."]}, {"type": "tip", "title": "Buena práctica", "text": "Los genéricos son útiles cuando la lógica es la misma pero el tipo cambia."}]'::jsonb,
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
        'modulos-y-validacion',
        'Módulos y validación',
        'Organizar código y comprobar entradas externas.',
        '[{"type": "paragraph", "text": "Los módulos permiten separar lógica por responsabilidades."}, {"type": "paragraph", "text": "La validación temprano ayuda a evitar errores por datos inesperados."}, {"type": "code", "text": "function validarEmail(email: string): boolean { return email.includes(''@''); }"}, {"type": "exercise", "title": "Ejercicio práctico", "steps": ["Escribe una función de validación.", "Prueba casos correctos e incorrectos.", "Verifica el retorno esperado."]}, {"type": "warning", "title": "Atención", "text": "No todo dato externo es confiable; siempre conviene validarlo."}]'::jsonb,
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
        'act-ts-tipos',
        'Actividad 1: Tipos e interfaces',
        'Elige la respuesta correcta.',
        'activity',
        70,
        1,
        false
    )
    RETURNING id INTO v_activity_1;

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
        '¿Qué ventaja principal tiene TypeScript?',
        1,
        1
    )
    RETURNING id INTO v_q1_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q1_id, 'Detección de errores en desarrollo', 1), (v_q1_id, 'Compilar HTML', 2), (v_q1_id, 'Eliminar el navegador', 3), (v_q1_id, 'Reducir el tamaño del código', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q1_id, qo.id, 'TypeScript valida tipos antes de ejecutar.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q1_id
      AND qo.position = 1;

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
        '¿Qué es una interfaz?',
        2,
        1
    )
    RETURNING id INTO v_q2_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q2_id, 'Contrato que define la forma de un objeto', 1), (v_q2_id, 'Un comando de terminal', 2), (v_q2_id, 'Un archivo CSS', 3), (v_q2_id, 'Una función asíncrona', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q2_id, qo.id, 'Las interfaces describen una estructura esperada.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q2_id
      AND qo.position = 1;

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
        '¿Qué hace una anotación de tipo?',
        3,
        1
    )
    RETURNING id INTO v_q3_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q3_id, 'Indica qué valores son válidos para una variable', 1), (v_q3_id, 'Genera un archivo', 2), (v_q3_id, 'Crea un evento', 3), (v_q3_id, 'Destruye el navegador', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q3_id, qo.id, 'La anotación define el tipo permitido.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q3_id
      AND qo.position = 1;

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
        '¿Qué significa readonly?',
        4,
        1
    )
    RETURNING id INTO v_q4_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q4_id, 'La propiedad no puede reasignarse', 1), (v_q4_id, 'La propiedad es opcional', 2), (v_q4_id, 'La propiedad es pública', 3), (v_q4_id, 'La propiedad desaparece', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q4_id, qo.id, 'readonly bloquea modificaciones posteriores.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q4_id
      AND qo.position = 1;

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
        '¿Qué opción es correcta para tipar un objeto?',
        5,
        1
    )
    RETURNING id INTO v_q5_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q5_id, 'const usuario: Usuario = { ... }', 1), (v_q5_id, 'const usuario = ''Usuario''', 2), (v_q5_id, 'const usuario: {} = ''''', 3), (v_q5_id, 'const usuario = <Usuario>...', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q5_id, qo.id, 'La sintaxis con : Usuario es la forma común.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q5_id
      AND qo.position = 1;

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
        'act-ts-uniones',
        'Actividad 2: Uniones e intersecciones',
        'Selecciona la respuesta correcta.',
        'activity',
        70,
        2,
        false
    )
    RETURNING id INTO v_activity_2;

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
        '¿Qué es un union type?',
        1,
        1
    )
    RETURNING id INTO v_q6_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q6_id, 'Un tipo que puede ser uno de varios valores', 1), (v_q6_id, 'Un valor constante', 2), (v_q6_id, 'Un método del DOM', 3), (v_q6_id, 'Un bloque try', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q6_id, qo.id, 'Union acepta varios tipos posibles.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q6_id
      AND qo.position = 1;

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
        '¿Qué es una intersection type?',
        2,
        1
    )
    RETURNING id INTO v_q7_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q7_id, 'Combinación de dos tipos en uno', 1), (v_q7_id, 'Un tipo de reporte', 2), (v_q7_id, 'Un selector HTML', 3), (v_q7_id, 'Un comando de bash', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q7_id, qo.id, 'Intersection exige propiedades de ambos tipos.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q7_id
      AND qo.position = 1;

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
        '¿Qué ocurre si una variable tiene type string | number?',
        3,
        1
    )
    RETURNING id INTO v_q8_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q8_id, 'Puede recibir cadenas o números', 1), (v_q8_id, 'Solo cadenas', 2), (v_q8_id, 'Solo números', 3), (v_q8_id, 'Nunca se usa', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q8_id, qo.id, 'Union acepta cualquiera de los tipos incluidos.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q8_id
      AND qo.position = 1;

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
        '¿Qué significa T & U?',
        4,
        1
    )
    RETURNING id INTO v_q9_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q9_id, 'Intersección entre T y U', 1), (v_q9_id, 'Unión entre T y U', 2), (v_q9_id, 'Resta', 3), (v_q9_id, 'Multiplicación', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q9_id, qo.id, 'T & U combina ambos tipos.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q9_id
      AND qo.position = 1;

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
        '¿Por qué usar union types?',
        5,
        1
    )
    RETURNING id INTO v_q10_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q10_id, 'Para representar entradas variables con seguridad', 1), (v_q10_id, 'Para ocultar tipos', 2), (v_q10_id, 'Para borrar interfaces', 3), (v_q10_id, 'Para evitar validación', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q10_id, qo.id, 'Union modela múltiples entradas válidas.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q10_id
      AND qo.position = 1;

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
        'act-ts-genericos',
        'Actividad 3: Genéricos',
        'Elige la respuesta correcta.',
        'activity',
        70,
        3,
        false
    )
    RETURNING id INTO v_activity_3;

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
        '¿Qué es un genérico?',
        1,
        1
    )
    RETURNING id INTO v_q11_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q11_id, 'Tipo parametrizado reutilizable', 1), (v_q11_id, 'Variable global', 2), (v_q11_id, 'Archivo CSS', 3), (v_q11_id, 'Evento DOM', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q11_id, qo.id, 'Los genéricos reutilizan lógica entre tipos distintos.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q11_id
      AND qo.position = 1;

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
        '¿Qué devuelve function identidad<T>(valor: T): T?',
        2,
        1
    )
    RETURNING id INTO v_q12_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q12_id, 'El mismo tipo recibido', 1), (v_q12_id, 'Siempre un string', 2), (v_q12_id, 'Siempre un número', 3), (v_q12_id, 'Un objeto vacío', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q12_id, qo.id, 'La función conserva el tipo de entrada.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q12_id
      AND qo.position = 1;

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
        '¿Qué hace la sintaxis <T> en una función?',
        3,
        1
    )
    RETURNING id INTO v_q13_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q13_id, 'Declara un parámetro genérico', 1), (v_q13_id, 'Crea una promesa', 2), (v_q13_id, 'Define un módulo', 3), (v_q13_id, 'Carga un script', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q13_id, qo.id, 'T representa el tipo determinado al invocar.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q13_id
      AND qo.position = 1;

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
        '¿Cuándo son útiles los genéricos?',
        4,
        1
    )
    RETURNING id INTO v_q14_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q14_id, 'Cuando la lógica es la misma para distintos tipos', 1), (v_q14_id, 'Cuando no hay variables', 2), (v_q14_id, 'Cuando se desea eliminar interfaces', 3), (v_q14_id, 'Cuando se trabaja solo con CSS', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q14_id, qo.id, 'Los genéricos reducen duplicación manteniendo seguridad.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q14_id
      AND qo.position = 1;

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
        '¿Qué beneficio tienen los genéricos?',
        5,
        1
    )
    RETURNING id INTO v_q15_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q15_id, 'Evitar duplicar funciones para distintos tipos', 1), (v_q15_id, 'Aumentar errores', 2), (v_q15_id, 'Cambiar el compilador', 3), (v_q15_id, 'Quitar validación', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q15_id, qo.id, 'Los genéricos reutilizan lógica con seguridad.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q15_id
      AND qo.position = 1;

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
        'act-ts-validacion',
        'Actividad 4: Módulos y validación',
        'Selecciona la respuesta correcta.',
        'activity',
        70,
        4,
        false
    )
    RETURNING id INTO v_activity_4;

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
        '¿Qué ayuda a modularizar el código?',
        1,
        1
    )
    RETURNING id INTO v_q16_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q16_id, 'Módulos', 1), (v_q16_id, 'Variables globales excesivas', 2), (v_q16_id, 'CSS en línea', 3), (v_q16_id, 'HTML sin lógica', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q16_id, qo.id, 'Los módulos separan responsabilidades.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q16_id
      AND qo.position = 1;

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
        '¿Qué ayuda a validar entradas?',
        2,
        1
    )
    RETURNING id INTO v_q17_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q17_id, 'Condiciones y comprobaciones de tipo', 1), (v_q17_id, 'Archivos de estilo', 2), (v_q17_id, 'Funciones vacías', 3), (v_q17_id, 'Bucles infinitos', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q17_id, qo.id, 'La validación evita errores por datos inesperados.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q17_id
      AND qo.position = 1;

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
        '¿Qué hace una función de validación?',
        3,
        1
    )
    RETURNING id INTO v_q18_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q18_id, 'Comprueba si la entrada cumple una regla', 1), (v_q18_id, 'Elimina un módulo', 2), (v_q18_id, 'Crea un componente', 3), (v_q18_id, 'Especifica color CSS', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q18_id, qo.id, 'La validación decide si la entrada es aceptable.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q18_id
      AND qo.position = 1;

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
        '¿Qué ventaja tienen los módulos?',
        4,
        1
    )
    RETURNING id INTO v_q19_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q19_id, 'Más claridad y reutilización', 1), (v_q19_id, 'Menos funciones', 2), (v_q19_id, 'Menos tipos', 3), (v_q19_id, 'Más errores globales', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q19_id, qo.id, 'Los módulos organizan mejor el código.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q19_id
      AND qo.position = 1;

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
        '¿Qué estrategia reduce fallos por entradas externas?',
        5,
        1
    )
    RETURNING id INTO v_q20_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q20_id, 'Tipado fuerte y validación previa', 1), (v_q20_id, 'Ignorar errores', 2), (v_q20_id, 'Usar solo variables globales', 3), (v_q20_id, 'Eliminar funciones', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q20_id, qo.id, 'Tipado y validación son defensas útiles.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q20_id
      AND qo.position = 1;

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
        'exam-typescript',
        'Examen final: TypeScript',
        'Selecciona la respuesta correcta.',
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
        v_exam_id,
        '¿Qué aporta TypeScript?',
        1,
        1
    )
    RETURNING id INTO v_q21_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q21_id, 'Tipos estáticos', 1), (v_q21_id, 'Un navegador', 2), (v_q21_id, 'Bases de datos', 3), (v_q21_id, 'HTML dinámico', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q21_id, qo.id, 'TypeScript añade seguridad de tipos.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q21_id
      AND qo.position = 1;

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
        '¿Qué define una interfaz?',
        2,
        1
    )
    RETURNING id INTO v_q22_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q22_id, 'La forma de un objeto', 1), (v_q22_id, 'La función del navegador', 2), (v_q22_id, 'Una variable global', 3), (v_q22_id, 'Un valor CSS', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q22_id, qo.id, 'La interfaz describe la estructura esperada.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q22_id
      AND qo.position = 1;

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
        '¿Qué es una union type?',
        3,
        1
    )
    RETURNING id INTO v_q23_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q23_id, 'Tipo que acepta varios valores posibles', 1), (v_q23_id, 'Tipo no definido', 2), (v_q23_id, 'Un módulo CSS', 3), (v_q23_id, 'Un selector', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q23_id, qo.id, 'Union representa varias opciones válidas.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q23_id
      AND qo.position = 1;

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
        '¿Qué hace una intersección de tipos?',
        4,
        1
    )
    RETURNING id INTO v_q24_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q24_id, 'Combina requisitos de varios tipos', 1), (v_q24_id, 'Elimina propiedades', 2), (v_q24_id, 'Convierte a string', 3), (v_q24_id, 'Crea un evento', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q24_id, qo.id, 'Intersection exige todas las propiedades.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q24_id
      AND qo.position = 1;

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
        '¿Qué es un genérico?',
        5,
        1
    )
    RETURNING id INTO v_q25_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q25_id, 'Tipo parametrizado reutilizable', 1), (v_q25_id, 'Archivo HTML', 2), (v_q25_id, 'Evento DOM', 3), (v_q25_id, 'Variable sin valor', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q25_id, qo.id, 'Los genéricos mantienen reutilización segura.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q25_id
      AND qo.position = 1;

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
        '¿Qué devuelve function identidad<T>(valor: T): T?',
        6,
        1
    )
    RETURNING id INTO v_q26_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q26_id, 'El mismo tipo recibido', 1), (v_q26_id, 'Siempre un booleano', 2), (v_q26_id, 'Siempre un número', 3), (v_q26_id, 'Un string fijo', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q26_id, qo.id, 'La identidad conserva el tipo original.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q26_id
      AND qo.position = 1;

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
        '¿Qué significa readonly?',
        7,
        1
    )
    RETURNING id INTO v_q27_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q27_id, 'La propiedad no puede cambiarse', 1), (v_q27_id, 'Es una propiedad pública', 2), (v_q27_id, 'Es una variable global', 3), (v_q27_id, 'Es una promesa', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q27_id, qo.id, 'readonly bloquea reasignaciones.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q27_id
      AND qo.position = 1;

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
        '¿Qué permite modularizar código?',
        8,
        1
    )
    RETURNING id INTO v_q28_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q28_id, 'Separar archivos y responsabilidades', 1), (v_q28_id, 'Eliminar funciones', 2), (v_q28_id, 'Reducir validación', 3), (v_q28_id, 'Cambiar el navegador', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q28_id, qo.id, 'Los módulos mejoran organización.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q28_id
      AND qo.position = 1;

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
        '¿Qué permite una función de validación?',
        9,
        1
    )
    RETURNING id INTO v_q29_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q29_id, 'Comprobar si la entrada cumple una regla', 1), (v_q29_id, 'Definir un tipo CSS', 2), (v_q29_id, 'Configurar una variable global', 3), (v_q29_id, 'Destruir un módulo', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q29_id, qo.id, 'La validación asegura la entrada es válida.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q29_id
      AND qo.position = 1;

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
        '¿Qué resulta útil para aceptar varios tipos en la misma variable?',
        10,
        1
    )
    RETURNING id INTO v_q30_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q30_id, 'Union types', 1), (v_q30_id, 'Tipos vacíos', 2), (v_q30_id, 'Archivos CSS', 3), (v_q30_id, 'Variables globales', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q30_id, qo.id, 'Union types permiten varios valores válidos.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q30_id
      AND qo.position = 1;

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
        '¿Qué estrategia ayuda con datos externos?',
        11,
        1
    )
    RETURNING id INTO v_q31_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q31_id, 'Tipado y validación', 1), (v_q31_id, 'Ignorar errores', 2), (v_q31_id, 'Usar números mágicos', 3), (v_q31_id, 'Evitar funciones', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q31_id, qo.id, 'Tipado y validación reducen riesgos.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q31_id
      AND qo.position = 1;

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
        '¿Por qué usar interfaces en TypeScript?',
        12,
        1
    )
    RETURNING id INTO v_q32_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q32_id, 'Documentar la estructura esperada de un objeto', 1), (v_q32_id, 'Cambiar variables a constantes', 2), (v_q32_id, 'Compilar CSS', 3), (v_q32_id, 'Eliminar clases', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q32_id, qo.id, 'Interfaces describen la forma esperada.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q32_id
      AND qo.position = 1;

END $$;

COMMIT;
