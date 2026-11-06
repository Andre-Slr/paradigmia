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
        WHERE slug = 'react'
    ) THEN
        RAISE EXCEPTION 'El slug react ya existe en public.courses.';
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
        'react',
        'React',
        'Curso intermedio para comprender componentes, estado, props, eventos y renderizado dinámico.',
        'React',
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
        'componentes-y-props',
        'Componentes y props',
        'Crear UI reutilizable con entrada de datos.',
        '[{"type": "paragraph", "text": "React organiza la interfaz en componentes reutilizables."}, {"type": "paragraph", "text": "Las props pasan datos del padre al hijo y mantienen un flujo claro."}, {"type": "code", "text": "function Saludo(props) { return <h1>Hola, {props.nombre}</h1>; }"}, {"type": "exercise", "title": "Ejercicio práctico", "steps": ["Crea un componente Saludo.", "Recibe props.nombre.", "Renderiza el texto en pantalla."]}, {"type": "tip", "title": "Consejo", "text": "Los componentes pequeños son fáciles de analizar y reutilizar."}]'::jsonb,
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
        'estado-y-eventos',
        'Estado y eventos',
        'Responder a la interacción del usuario y actualizar la UI.',
        '[{"type": "paragraph", "text": "El estado guarda información que puede cambiar durante la ejecución."}, {"type": "paragraph", "text": "Los eventos permiten reaccionar a clics, entradas y cambios de valor."}, {"type": "code", "text": "const [contador, setContador] = useState(0); <button onClick={() => setContador(contador + 1)}>Sumar</button>"}, {"type": "exercise", "title": "Ejercicio práctico", "steps": ["Define un contador con useState.", "Asocia onClick al botón.", "Actualiza el valor cada clic."]}, {"type": "warning", "title": "Atención", "text": "Las actualizaciones de estado deben ser predecibles y no mutar el valor previo."}]'::jsonb,
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
        'renderizado-condicional',
        'Renderizado condicional',
        'Mostrar contenido según el estado actual.',
        '[{"type": "paragraph", "text": "El renderizado condicional decide qué parte del interfaz se muestra."}, {"type": "paragraph", "text": "Esto permite construir pantallas dinámicas y más útiles."}, {"type": "code", "text": "{usuario ? <Perfil /> : <Login />} {activo && <Panel />}"}, {"type": "exercise", "title": "Ejercicio práctico", "steps": ["Crea una condición para mostrar Login o Perfil.", "Usa un booleano para cambiar la UI.", "Comprueba el resultado."]}, {"type": "tip", "title": "Buena práctica", "text": "Condiciones claras hacen que la UI sea más fácil de entender."}]'::jsonb,
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
        'listas-y-efectos',
        'Listas y efectos',
        'Recorrer colecciones y sincronizar lógica con useEffect.',
        '[{"type": "paragraph", "text": "Las listas se renderizan con map y requieren keys únicas."}, {"type": "paragraph", "text": "Los efectos permiten ejecutar lógica cuando el componente cambia o se monta."}, {"type": "code", "text": "const items = tareas.map(tarea => <li key={tarea.id}>{tarea.nombre}</li>); useEffect(() => { console.log(''Montado''); }, []);"}, {"type": "exercise", "title": "Ejercicio práctico", "steps": ["Renderiza una lista de tareas.", "Usa keys únicas.", "Define un efecto de montaje con useEffect."]}, {"type": "warning", "title": "Atención", "text": "Las keys deben ser estables para que React renderice correctamente."}]'::jsonb,
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
        'act-react-componentes',
        'Actividad 1: Componentes y props',
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
        '¿Qué es un componente en React?',
        1,
        1
    )
    RETURNING id INTO v_q1_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q1_id, 'Función o clase que devuelve UI', 1), (v_q1_id, 'Variable global', 2), (v_q1_id, 'Archivo CSS', 3), (v_q1_id, 'Servidor local', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q1_id, qo.id, 'Los componentes encapsulan parte de la interfaz.'
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
        '¿Qué son las props?',
        2,
        1
    )
    RETURNING id INTO v_q2_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q2_id, 'Datos pasados del padre al hijo', 1), (v_q2_id, 'Seleccionadores CSS', 2), (v_q2_id, 'Eventos del navegador', 3), (v_q2_id, 'Valores de base de datos', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q2_id, qo.id, 'Props comunican información entre componentes.'
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
        '¿Qué permite React para reutilizar UI?',
        3,
        1
    )
    RETURNING id INTO v_q3_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q3_id, 'Componentes', 1), (v_q3_id, 'SQL', 2), (v_q3_id, 'Módulos de hardware', 3), (v_q3_id, 'CSS puro', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q3_id, qo.id, 'Componentes permiten reutilizar segmentos de la interfaz.'
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
        '¿Qué efecto tiene un componente bien diseñado?',
        4,
        1
    )
    RETURNING id INTO v_q4_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q4_id, 'Más claridad y mantenibilidad', 1), (v_q4_id, 'Menos reutilización', 2), (v_q4_id, 'Más duplicación', 3), (v_q4_id, 'Más errores', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q4_id, qo.id, 'Componentes claros mejoran mantenimiento.'
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
        '¿Qué se usa para renderizar texto dinámico?',
        5,
        1
    )
    RETURNING id INTO v_q5_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q5_id, 'Expresiones dentro de JSX', 1), (v_q5_id, 'Comentarios HTML', 2), (v_q5_id, 'Archivos JSON', 3), (v_q5_id, 'Scripts externos', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q5_id, qo.id, 'JSX permite interpolar valores con llaves.'
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
        'act-react-estado',
        'Actividad 2: Estado y eventos',
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
        '¿Qué es el estado en React?',
        1,
        1
    )
    RETURNING id INTO v_q6_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q6_id, 'Datos internos que pueden cambiar', 1), (v_q6_id, 'Archivo de configuración', 2), (v_q6_id, 'Selector CSS', 3), (v_q6_id, 'Un tipo de prueba', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q6_id, qo.id, 'El estado refleja datos dinámicos del componente.'
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
        '¿Qué hace onClick?',
        2,
        1
    )
    RETURNING id INTO v_q7_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q7_id, 'Responde a un clic del usuario', 1), (v_q7_id, 'Crea una promesa', 2), (v_q7_id, 'Lee un objeto CSS', 3), (v_q7_id, 'Carga un archivo', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q7_id, qo.id, 'onClick responde a interacciones del usuario.'
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
        '¿Qué hace useState?',
        3,
        1
    )
    RETURNING id INTO v_q8_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q8_id, 'Gestiona un valor reactivo dentro del componente', 1), (v_q8_id, 'Redefine CSS', 2), (v_q8_id, 'Crea un fetch', 3), (v_q8_id, 'Ordena arreglos', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q8_id, qo.id, 'useState crea y actualiza estado.'
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
        '¿Qué se recomienda al actualizar el estado?',
        4,
        1
    )
    RETURNING id INTO v_q9_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q9_id, 'Usar la función actualizadora cuando depende del valor anterior', 1), (v_q9_id, 'Mutar el estado directo', 2), (v_q9_id, 'Modificar el DOM manualmente', 3), (v_q9_id, 'Eliminar el valor anterior', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q9_id, qo.id, 'La función actualizadora evita errores de estado desfasado.'
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
        '¿Qué ventaja tiene un estado bien modelado?',
        5,
        1
    )
    RETURNING id INTO v_q10_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q10_id, 'La UI refleja cambios de forma predecible', 1), (v_q10_id, 'El código deja de ser React', 2), (v_q10_id, 'Se evita el renderizado', 3), (v_q10_id, 'Se reemplaza todo por CSS', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q10_id, qo.id, 'Estado claro mejora predictibilidad.'
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
        'act-react-condicional',
        'Actividad 3: Renderizado condicional',
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
        '¿Qué es renderizado condicional?',
        1,
        1
    )
    RETURNING id INTO v_q11_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q11_id, 'Mostrar contenido según una condición', 1), (v_q11_id, 'Un tipo de CSS', 2), (v_q11_id, 'Un endpoint de API', 3), (v_q11_id, 'Un archivo de configuración', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q11_id, qo.id, 'Las condiciones determinan qué UI renderiza.'
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
        '¿Qué hace && en JSX?',
        2,
        1
    )
    RETURNING id INTO v_q12_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q12_id, 'Muestra el bloque si la condición es verdadera', 1), (v_q12_id, 'Genera un fetch', 2), (v_q12_id, 'Crea un objeto', 3), (v_q12_id, 'Instancia un evento', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q12_id, qo.id, '&& permite renderizado condicional.'
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
        '¿Qué opción muestra Login si no hay usuario?',
        3,
        1
    )
    RETURNING id INTO v_q13_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q13_id, 'usuario ? <Perfil /> : <Login />', 1), (v_q13_id, 'usuario && <Perfil />', 2), (v_q13_id, 'usuario + <Login />', 3), (v_q13_id, '<Login /> || <Perfil />', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q13_id, qo.id, 'La ternaria es la manera común de elegir entre dos ramas.'
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
        '¿Qué beneficio aporta un renderizado claro?',
        4,
        1
    )
    RETURNING id INTO v_q14_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q14_id, 'UI más fácil de seguir y depurar', 1), (v_q14_id, 'Menos componentes', 2), (v_q14_id, 'Menos interacciones', 3), (v_q14_id, 'Más variables globales', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q14_id, qo.id, 'Condiciones claras ayudan a leer la UI.'
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
        '¿Qué suele decidir el contenido a renderizar?',
        5,
        1
    )
    RETURNING id INTO v_q15_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q15_id, 'El estado del componente', 1), (v_q15_id, 'El tamaño del archivo', 2), (v_q15_id, 'La versión del navegador', 3), (v_q15_id, 'La presencia de CSS', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q15_id, qo.id, 'El estado orienta el contenido mostrado.'
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
        'act-react-listas',
        'Actividad 4: Listas y efectos',
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
        '¿Qué propiedad es vital en listas renderizadas en React?',
        1,
        1
    )
    RETURNING id INTO v_q16_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q16_id, 'key', 1), (v_q16_id, 'value', 2), (v_q16_id, 'href', 3), (v_q16_id, 'src', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q16_id, qo.id, 'key identifica cada elemento de la lista.'
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
        '¿Qué hace useEffect?',
        2,
        1
    )
    RETURNING id INTO v_q17_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q17_id, 'Sincroniza efectos secundarios con el componente', 1), (v_q17_id, 'Crea un selector CSS', 2), (v_q17_id, 'Configura props', 3), (v_q17_id, 'Clase de navegador', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q17_id, qo.id, 'useEffect ejecuta lógica asociada a cambios.'
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
        '¿Qué es una key única?',
        3,
        1
    )
    RETURNING id INTO v_q18_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q18_id, 'Identificador estable para cada elemento de la lista', 1), (v_q18_id, 'Un valor de estilo', 2), (v_q18_id, 'Un nombre de componente', 3), (v_q18_id, 'Un evento', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q18_id, qo.id, 'Las keys ayudan a React a diferenciar nodos.'
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
        '¿Qué permite map()?',
        4,
        1
    )
    RETURNING id INTO v_q19_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q19_id, 'Generar una lista de elementos React', 1), (v_q19_id, 'Eliminar el estado', 2), (v_q19_id, 'Cambiar el DOM manualmente', 3), (v_q19_id, 'Arreglar CSS', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q19_id, qo.id, 'map() transforma cada elemento en JSX.'
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
        '¿Qué se recomienda en listas para evitar errores?',
        5,
        1
    )
    RETURNING id INTO v_q20_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q20_id, 'Usar keys únicas y estables', 1), (v_q20_id, 'Usar key repetida', 2), (v_q20_id, 'Evitar map()', 3), (v_q20_id, 'Mutar el arreglo original', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q20_id, qo.id, 'Keys estables son esenciales para renderizado correcto.'
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
        'exam-react',
        'Examen final: React',
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
        '¿Qué es un componente en React?',
        1,
        1
    )
    RETURNING id INTO v_q21_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q21_id, 'Bloque reutilizable de interfaz', 1), (v_q21_id, 'Base de datos', 2), (v_q21_id, 'Archivo CSS', 3), (v_q21_id, 'Variable global', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q21_id, qo.id, 'Un componente encapsula una parte de la interfaz.'
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
        '¿Qué son las props?',
        2,
        1
    )
    RETURNING id INTO v_q22_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q22_id, 'Datos enviados desde el padre al hijo', 1), (v_q22_id, 'Acciones del navegador', 2), (v_q22_id, 'Objetos SQL', 3), (v_q22_id, 'Variables globales', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q22_id, qo.id, 'Las props comunican datos entre componentes.'
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
        '¿Qué hace useState?',
        3,
        1
    )
    RETURNING id INTO v_q23_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q23_id, 'Gestiona el estado del componente', 1), (v_q23_id, 'Llama a fetch', 2), (v_q23_id, 'Configura CSS', 3), (v_q23_id, 'Elimina renders', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q23_id, qo.id, 'useState declara y actualiza estado.'
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
        '¿Qué hace onClick?',
        4,
        1
    )
    RETURNING id INTO v_q24_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q24_id, 'Ejecuta una función cuando el usuario hace clic', 1), (v_q24_id, 'Genera un componente', 2), (v_q24_id, 'Cambia variables globales', 3), (v_q24_id, 'Lee archivos', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q24_id, qo.id, 'onClick responde a la interacción del usuario.'
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
        '¿Qué es renderizado condicional?',
        5,
        1
    )
    RETURNING id INTO v_q25_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q25_id, 'Mostrar contenido según una condición', 1), (v_q25_id, 'Un tipo de CSS', 2), (v_q25_id, 'Un endpoint de API', 3), (v_q25_id, 'Un archivo de configuración', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q25_id, qo.id, 'La UI puede variar según estado o condiciones.'
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
        '¿Qué representa && en JSX?',
        6,
        1
    )
    RETURNING id INTO v_q26_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q26_id, 'Renderizar solo si la condición es verdadera', 1), (v_q26_id, 'Concatenar strings', 2), (v_q26_id, 'Importar un módulo', 3), (v_q26_id, 'Definir un evento', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q26_id, qo.id, '&& crea renderizado condicional.'
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
        '¿Qué es una key en una lista?',
        7,
        1
    )
    RETURNING id INTO v_q27_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q27_id, 'Identificador único para cada elemento', 1), (v_q27_id, 'Valor de estilo', 2), (v_q27_id, 'Nombre del componente', 3), (v_q27_id, 'Evento de teclado', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q27_id, qo.id, 'Las keys permiten a React diferenciar elementos.'
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
        '¿Qué hace map() en listas?',
        8,
        1
    )
    RETURNING id INTO v_q28_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q28_id, 'Transforma cada elemento en JSX', 1), (v_q28_id, 'Elimina el estado', 2), (v_q28_id, 'Mutta el DOM directo', 3), (v_q28_id, 'Crea una promesa', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q28_id, qo.id, 'map() genera una lista de elementos.'
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
        '¿Qué usa useEffect?',
        9,
        1
    )
    RETURNING id INTO v_q29_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q29_id, 'Lógica de sincronización con cambios del componente', 1), (v_q29_id, 'Un selector CSS', 2), (v_q29_id, 'Un archivo JSON', 3), (v_q29_id, 'Un formulario HTML', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q29_id, qo.id, 'useEffect usa efectos secundarios y sincronización.'
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
        '¿Qué es una ventaja de componentes pequeños?',
        10,
        1
    )
    RETURNING id INTO v_q30_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q30_id, 'Más claridad y reutilización', 1), (v_q30_id, 'Más variables globales', 2), (v_q30_id, 'Menos lectura de código', 3), (v_q30_id, 'Más duplicación', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q30_id, qo.id, 'Componentes pequeños ayudan a mantener la aplicación.'
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
        '¿Qué debe evitarse al actualizar el estado?',
        11,
        1
    )
    RETURNING id INTO v_q31_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q31_id, 'Mutar el estado directo sin reemplazarlo', 1), (v_q31_id, 'Usar useState', 2), (v_q31_id, 'Crear props', 3), (v_q31_id, 'Usar JSX', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q31_id, qo.id, 'La mutación directa puede producir inconsistencias.'
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
        '¿Qué busca una UI reactiva?',
        12,
        1
    )
    RETURNING id INTO v_q32_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q32_id, 'Responder a eventos y cambios de estado', 1), (v_q32_id, 'Ignorar interacciones', 2), (v_q32_id, 'Eliminar componentes', 3), (v_q32_id, 'Reducir el código a texto', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q32_id, qo.id, 'Reactividad conecta estado con renderizado.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q32_id
      AND qo.position = 1;

END $$;

COMMIT;
