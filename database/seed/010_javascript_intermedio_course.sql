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
        WHERE slug = 'javascript-intermedio'
    ) THEN
        RAISE EXCEPTION 'El slug javascript-intermedio ya existe en public.courses.';
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
        'javascript-intermedio',
        'JavaScript intermedio',
        'Curso intermedio para profundizar en funciones, arreglos, asincronía y manejo de errores.',
        'JavaScript',
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
        'funciones-y-alcance',
        'Funciones y alcance',
        'Entender funciones, parámetros y alcance de variables.',
        '[{"type": "paragraph", "text": "Las funciones encapsulan tareas reutilizables y mejoran la legibilidad del código."}, {"type": "paragraph", "text": "El alcance define dónde una variable es visible y evita efectos colaterales inesperados."}, {"type": "code", "text": "function sumar(a, b) { return a + b; }"}, {"type": "exercise", "title": "Ejercicio práctico", "steps": ["Crea una función que multiplique dos números.", "Llama a la función.", "Muestra el resultado."]}, {"type": "tip", "title": "Consejo", "text": "Usa nombres claros para mejorar la mantenibilidad."}]'::jsonb,
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
        'arreglos-y-objetos',
        'Arreglos y objetos',
        'Trabajar con colecciones y estructuras de datos.',
        '[{"type": "paragraph", "text": "Los arreglos almacenan colecciones ordenadas y se usan con map, filter y reduce."}, {"type": "paragraph", "text": "Los objetos agrupan propiedades y representan entidades reales."}, {"type": "code", "text": "const user = { nombre: ''Ana'', activo: true };"}, {"type": "exercise", "title": "Ejercicio práctico", "steps": ["Crea un arreglo de usuarios.", "Accede a una propiedad.", "Muestra los resultados."]}, {"type": "warning", "title": "Atención", "text": "Mantén una estructura consistente para evitar errores de lectura."}]'::jsonb,
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
        'asincronia-y-promesas',
        'Asincronía y promesas',
        'Entender tareas asíncronas y manejo de resultados futuros.',
        '[{"type": "paragraph", "text": "La asincronía permite seguir ejecutando código mientras un proceso tarda en resolverse."}, {"type": "paragraph", "text": "Las promesas representan el resultado futuro de una operación."}, {"type": "code", "text": "fetch(''/api/data'').then(res => res.json())"}, {"type": "exercise", "title": "Ejercicio práctico", "steps": ["Haz una petición fetch.", "Procesa la respuesta con then.", "Muestra la data nueva."]}, {"type": "tip", "title": "Buena práctica", "text": "Maneja estados de carga, éxito y error para mejorar UX."}]'::jsonb,
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
        'errores-y-validacion',
        'Errores y validación',
        'Detectar fallos y responder con mensajes claros.',
        '[{"type": "paragraph", "text": "Los errores pueden producirse por entradas inválidas o respuestas inesperadas."}, {"type": "paragraph", "text": "try/catch y validaciones ayudan a mantener la app estable."}, {"type": "code", "text": "try { JSON.parse(''{invalido}''); } catch (error) { console.error(error); }"}, {"type": "exercise", "title": "Ejercicio práctico", "steps": ["Escribe un bloque try/catch.", "Genera un error intencional.", "Muestra un mensaje útil."]}, {"type": "warning", "title": "Atención", "text": "La validación previa ayuda a evitar incidentes de datos inesperados."}]'::jsonb,
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
        'act-js-funciones',
        'Actividad 1: Funciones y alcance',
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
        '¿Qué es una función en JavaScript?',
        1,
        1
    )
    RETURNING id INTO v_q1_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q1_id, 'Un bloque reutilizable de código', 1), (v_q1_id, 'Un archivo HTML', 2), (v_q1_id, 'Un tipo de dato primitivo', 3), (v_q1_id, 'Un selector CSS', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q1_id, qo.id, 'Las funciones encapsulan lógica reutilizable.'
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
        '¿Qué define el alcance de una variable?',
        2,
        1
    )
    RETURNING id INTO v_q2_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q2_id, 'El contexto donde puede accederse a ella', 1), (v_q2_id, 'Su nombre', 2), (v_q2_id, 'Su contenido textual', 3), (v_q2_id, 'Su longitud', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q2_id, qo.id, 'El alcance determina la visibilidad de la variable.'
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
        '¿Qué hace return?',
        3,
        1
    )
    RETURNING id INTO v_q3_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q3_id, 'Devuelve un valor al invocador', 1), (v_q3_id, 'Inicia una iteración', 2), (v_q3_id, 'Crea un arreglo', 3), (v_q3_id, 'Cierra la aplicación', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q3_id, qo.id, 'return devuelve el resultado de la función.'
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
        '¿Qué palabra clave es útil para limitar el alcance a bloque?',
        4,
        1
    )
    RETURNING id INTO v_q4_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q4_id, 'let', 1), (v_q4_id, 'var', 2), (v_q4_id, 'const', 3), (v_q4_id, 'function', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q4_id, qo.id, 'let tiene alcance de bloque.'
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
        '¿Qué describe mejor una función pura?',
        5,
        1
    )
    RETURNING id INTO v_q5_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q5_id, 'No modifica estado externo y devuelve un valor según sus argumentos', 1), (v_q5_id, 'Depende del DOM para ejecutarse', 2), (v_q5_id, 'Siempre escribe en consola', 3), (v_q5_id, 'No recibe parámetros', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q5_id, qo.id, 'Una función pura depende solo de sus entradas.'
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
        'act-js-arreglos',
        'Actividad 2: Arreglos y objetos',
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
        '¿Qué es un arreglo?',
        1,
        1
    )
    RETURNING id INTO v_q6_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q6_id, 'Una colección ordenada de elementos', 1), (v_q6_id, 'Un tipo de promesa', 2), (v_q6_id, 'Una etiqueta HTML', 3), (v_q6_id, 'Una sentencia SQL', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q6_id, qo.id, 'Los arreglos guardan varios elementos en orden.'
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
        '¿Qué hace map()?',
        2,
        1
    )
    RETURNING id INTO v_q7_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q7_id, 'Transforma cada elemento y devuelve un nuevo arreglo', 1), (v_q7_id, 'Reemplaza un objeto', 2), (v_q7_id, 'Crea un efecto', 3), (v_q7_id, 'Cambia el DOM manualmente', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q7_id, qo.id, 'map() itera y transforma cada elemento.'
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
        '¿Qué es un objeto?',
        3,
        1
    )
    RETURNING id INTO v_q8_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q8_id, 'Un conjunto de propiedades y valores', 1), (v_q8_id, 'Un método de fetch', 2), (v_q8_id, 'Un tipo de formulario', 3), (v_q8_id, 'Un bloque try/catch', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q8_id, qo.id, 'Los objetos agrupan datos bajo una entidad.'
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
        '¿Cómo se accede a la propiedad nombre de un objeto?',
        4,
        1
    )
    RETURNING id INTO v_q9_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q9_id, 'usuario.nombre', 1), (v_q9_id, 'usuario[nombre]', 2), (v_q9_id, 'usuario->nombre', 3), (v_q9_id, 'usuario / nombre', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q9_id, qo.id, 'La notación por punto es la forma típica.'
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
        '¿Qué devuelve filter()?',
        5,
        1
    )
    RETURNING id INTO v_q10_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q10_id, 'Un arreglo con los elementos que cumplen la condición', 1), (v_q10_id, 'Un valor único', 2), (v_q10_id, 'Un texto JSON', 3), (v_q10_id, 'Un error', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q10_id, qo.id, 'filter() conserva solo los elementos válidos.'
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
        'act-js-asincronia',
        'Actividad 3: Asincronía y promesas',
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
        '¿Qué hace forEach()?',
        1,
        1
    )
    RETURNING id INTO v_q11_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q11_id, 'Recorre cada elemento del arreglo', 1), (v_q11_id, 'Elimina el arreglo', 2), (v_q11_id, 'Hace una petición HTTP', 3), (v_q11_id, 'Crea una variable global', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q11_id, qo.id, 'forEach() ejecuta una acción por cada elemento.'
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
        '¿Qué es una promesa?',
        2,
        1
    )
    RETURNING id INTO v_q12_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q12_id, 'Resultado futuro de una operación asíncrona', 1), (v_q12_id, 'Tipo de variable', 2), (v_q12_id, 'Selección de CSS', 3), (v_q12_id, 'Archivo HTML', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q12_id, qo.id, 'Una promesa representa un valor eventual.'
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
        '¿Qué método procesa el resultado de una promesa?',
        3,
        1
    )
    RETURNING id INTO v_q13_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q13_id, 'then()', 1), (v_q13_id, 'if()', 2), (v_q13_id, 'read()', 3), (v_q13_id, 'catch()', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q13_id, qo.id, 'then() maneja la resolución satisfactoria.'
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
        '¿Qué hace Promise.all()?',
        4,
        1
    )
    RETURNING id INTO v_q14_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q14_id, 'Ejecuta varias promesas y espera todas', 1), (v_q14_id, 'Convierte strings en números', 2), (v_q14_id, 'Ordena objetos', 3), (v_q14_id, 'Crea arrays vacíos', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q14_id, qo.id, 'Promise.all() espera a todas las promesas.'
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
        '¿Qué es asincronía?',
        5,
        1
    )
    RETURNING id INTO v_q15_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q15_id, 'Ejecución que continúa sin bloquear el hilo principal', 1), (v_q15_id, 'Un tipo de CSS', 2), (v_q15_id, 'Un componente de React', 3), (v_q15_id, 'Una variable local', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q15_id, qo.id, 'La asincronía permite seguir ejecutando mientras resuelve.'
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
        'act-js-errores',
        'Actividad 4: Errores y validación',
        'Seleccione la respuesta correcta.',
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
        '¿Qué bloque captura errores?',
        1,
        1
    )
    RETURNING id INTO v_q16_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q16_id, 'try/catch', 1), (v_q16_id, 'for/of', 2), (v_q16_id, 'if/else', 3), (v_q16_id, 'switch/case', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q16_id, qo.id, 'try/catch captura excepciones del flujo.'
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
        '¿Qué hace catch(error)?',
        2,
        1
    )
    RETURNING id INTO v_q17_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q17_id, 'Recupera el error para manejarlo', 1), (v_q17_id, 'Define una función', 2), (v_q17_id, 'Crea un arreglo', 3), (v_q17_id, 'Inicia un fetch', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q17_id, qo.id, 'catch() recibe la excepción.'
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
        '¿Qué es útil para evitar errores por entrada inválida?',
        3,
        1
    )
    RETURNING id INTO v_q18_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q18_id, 'Validación previa', 1), (v_q18_id, 'Ignorar errores', 2), (v_q18_id, 'Eliminar funciones', 3), (v_q18_id, 'Usar variables globales', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q18_id, qo.id, 'La validación reduce errores por datos incorrectos.'
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
        '¿Qué se recomienda cuando ocurre un error?',
        4,
        1
    )
    RETURNING id INTO v_q19_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q19_id, 'Mostrar un mensaje claro y mantener la experiencia', 1), (v_q19_id, 'Ignorar el problema', 2), (v_q19_id, 'Detener la app sin contexto', 3), (v_q19_id, 'Eliminar el bloque try', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q19_id, qo.id, 'Un mensaje claro mejora la experiencia del usuario.'
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
        '¿Qué hace finally?',
        5,
        1
    )
    RETURNING id INTO v_q20_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q20_id, 'Se ejecuta siempre después de try/catch', 1), (v_q20_id, 'Solo si hay éxito', 2), (v_q20_id, 'Solo si hay error', 3), (v_q20_id, 'Nunca se ejecuta', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q20_id, qo.id, 'finally se ejecuta aunque haya error.'
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
        'exam-js-intermedio',
        'Examen final: JavaScript intermedio',
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
        '¿Qué devuelve una función cuando ejecuta return?',
        1,
        1
    )
    RETURNING id INTO v_q21_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q21_id, 'Un valor', 1), (v_q21_id, 'Un archivo', 2), (v_q21_id, 'Un selector', 3), (v_q21_id, 'Una promesa', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q21_id, qo.id, 'return da el resultado de la función.'
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
        '¿Qué se usa para declarar una variable que no puede reasignarse?',
        2,
        1
    )
    RETURNING id INTO v_q22_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q22_id, 'const', 1), (v_q22_id, 'let', 2), (v_q22_id, 'var', 3), (v_q22_id, 'function', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q22_id, qo.id, 'const evita reasignaciones.'
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
        '¿Qué hace reduce()?',
        3,
        1
    )
    RETURNING id INTO v_q23_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q23_id, 'Acumula valores de un arreglo en una salida final', 1), (v_q23_id, 'Diseña una interface', 2), (v_q23_id, 'Crea HTML', 3), (v_q23_id, 'Vuelve a cargar la página', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q23_id, qo.id, 'reduce() combina los elementos en un único valor.'
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
        '¿Qué es un callback?',
        4,
        1
    )
    RETURNING id INTO v_q24_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q24_id, 'Función que se pasa como argumento y se ejecuta después', 1), (v_q24_id, 'Tipo de fetch', 2), (v_q24_id, 'Archivo CSS', 3), (v_q24_id, 'Llave de objeto', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q24_id, qo.id, 'Callback ejecuta una función posterior.'
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
        '¿Qué hace fetch()?',
        5,
        1
    )
    RETURNING id INTO v_q25_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q25_id, 'Realiza una solicitud HTTP', 1), (v_q25_id, 'Crea una variable local', 2), (v_q25_id, 'Borra la consola', 3), (v_q25_id, 'Ordena un arreglo', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q25_id, qo.id, 'fetch() realiza una petición.'
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
        '¿Qué hace finally en try/catch?',
        6,
        1
    )
    RETURNING id INTO v_q26_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q26_id, 'Se ejecuta siempre al terminar', 1), (v_q26_id, 'Solo si falla', 2), (v_q26_id, 'Solo si tiene éxito', 3), (v_q26_id, 'No se ejecuta', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q26_id, qo.id, 'finally se ejecuta siempre al final.'
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
        '¿Qué describe mejor un objeto?',
        7,
        1
    )
    RETURNING id INTO v_q27_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q27_id, 'Colección de propiedades y métodos', 1), (v_q27_id, 'Archivo HTML', 2), (v_q27_id, 'Bloque de CSS', 3), (v_q27_id, 'Consulta SQL', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q27_id, qo.id, 'Un objeto agrupa datos y comportamiento.'
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
        '¿Qué hace map() sobre un arreglo?',
        8,
        1
    )
    RETURNING id INTO v_q28_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q28_id, 'Genera otro arreglo transformado', 1), (v_q28_id, 'Elimina todos los elementos', 2), (v_q28_id, 'Crea un nuevo objeto', 3), (v_q28_id, 'Borra la memoria', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q28_id, qo.id, 'map() genera un arreglo nuevo.'
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
        '¿Qué es una promesa?',
        9,
        1
    )
    RETURNING id INTO v_q29_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q29_id, 'Representa un valor futuro', 1), (v_q29_id, 'Una clase HTML', 2), (v_q29_id, 'Un módulo de CSS', 3), (v_q29_id, 'Una variable global', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q29_id, qo.id, 'La promesa modela un resultado eventual.'
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
        '¿Qué permite Promise.all()?',
        10,
        1
    )
    RETURNING id INTO v_q30_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q30_id, 'Esperar múltiples promesas en paralelo', 1), (v_q30_id, 'Borrar eventos', 2), (v_q30_id, 'Actualizar CSS', 3), (v_q30_id, 'Iniciar DOM', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q30_id, qo.id, 'Promise.all() espera todas las promesas.'
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
        '¿Qué estrategia reduce errores por datos incorrectos?',
        11,
        1
    )
    RETURNING id INTO v_q31_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q31_id, 'Validación previa', 1), (v_q31_id, 'Ignorar la entrada', 2), (v_q31_id, 'Repetir eventos', 3), (v_q31_id, 'Eliminar funciones', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q31_id, qo.id, 'Validar antes de operar mejora estabilidad.'
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
        '¿Qué hace try/catch?',
        12,
        1
    )
    RETURNING id INTO v_q32_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q32_id, 'Controla errores de ejecución', 1), (v_q32_id, 'Elimina el DOM', 2), (v_q32_id, 'Configura props', 3), (v_q32_id, 'Compila código', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q32_id, qo.id, 'try/catch evita fallos no controlados.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q32_id
      AND qo.position = 1;

END $$;

COMMIT;
