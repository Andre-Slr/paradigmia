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
        WHERE slug = 'fundamentos-algoritmos-principiante'
    ) THEN
        RAISE EXCEPTION 'El slug fundamentos-algoritmos-principiante ya existe en public.courses.';
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
        'fundamentos-algoritmos-principiante',
        'Fundamentos de algoritmos',
        'Curso introductorio para entender pasos, decisiones, bucles y análisis de eficiencia en algoritmos.',
        'Algoritmos',
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
        'que-es-un-algoritmo',
        'Qué es un algoritmo',
        'Entender cómo una secuencia de pasos resuelve un problema.',
        '[{"type":"paragraph","text":"Un algoritmo es una secuencia ordenada de pasos para resolver un problema."},{"type":"paragraph","text":"La lógica debe ser clara, repetible y verificable para producir una solución consistente."},{"type":"code","text":"Inicio\n  Leer numero\n  Si numero > 0 entonces mostrar \"positivo\"\nFin"},{"type":"exercise","title":"Ejercicio práctico","steps":["Define un problema simple.","Escribe los pasos necesarios.","Comprueba que la salida esperada sea clara." ]},{"type":"tip","title":"Consejo","text":"Una solución precisa comienza con un problema bien definido y una secuencia ordenada."}]'::jsonb,
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
        'pseudocodigo-y-flujo',
        'Pseudocódigo y flujo',
        'Modelar decisiones y caminos de ejecución con claridad.',
        '[{"type":"paragraph","text":"El pseudocódigo ayuda a describir la lógica sin depender de un lenguaje concreto."},{"type":"paragraph","text":"Las decisiones permiten elegir caminos distintos según una condición."},{"type":"code","text":"Si edad >= 18\n  Mostrar \"Mayor\"\nSino\n  Mostrar \"Menor\""},{"type":"exercise","title":"Ejercicio práctico","steps":["Escribe una condición.","Define dos rutas posibles.","Explica el resultado de cada camino." ]},{"type":"warning","title":"Atención","text":"Las decisiones deben estar bien formuladas para que la lógica sea determinista."}]'::jsonb,
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
        'bucles-y-arreglos',
        'Bucles y arreglos',
        'Repetir tareas y agrupar datos para simplificar procesos.',
        '[{"type":"paragraph","text":"Los bucles repiten una acción varias veces sin duplicar el mismo bloque de código."},{"type":"paragraph","text":"Los arreglos agrupan varios elementos bajo una misma estructura para trabajar con colecciones."},{"type":"code","text":"Para cada numero en lista\n  Sumar numero\nFin para"},{"type":"exercise","title":"Ejercicio práctico","steps":["Define un arreglo simple.","Repite una operación con un bucle.","Muestra el valor final." ]},{"type":"tip","title":"Buena práctica","text":"Usa bucles y arreglos cuando varias operaciones tienen el mismo patrón lógico."}]'::jsonb,
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
        'complejidad-y-eficiencia',
        'Complejidad y eficiencia',
        'Analizar el costo de una solución y elegir la más eficiente.',
        '[{"type":"paragraph","text":"La complejidad ayuda a entender cómo crece el costo del algoritmo al aumentar la entrada."},{"type":"paragraph","text":"La eficiencia mide si una solución realiza más trabajo del necesario y permite elegir la alternativa más adecuada."},{"type":"code","text":"Para i desde 1 hasta n\n  Realizar operacion\nFin para"},{"type":"exercise","title":"Ejercicio práctico","steps":["Compara dos soluciones pequeñas.","Identifica cuál necesita menos pasos.","Explica la diferencia de costo." ]},{"type":"warning","title":"Atención","text":"No siempre la solución más larga es la mejor; el punto clave es la eficiencia y la claridad."}]'::jsonb,
        4,
        false
    )
    RETURNING id INTO v_lesson_4;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (gen_random_uuid(), v_course_id, v_lesson_1, 'actividad-algoritmos-introduccion', 'Actividad 1: Qué es un algoritmo', 'Selecciona la mejor respuesta.', 'activity', 70, 1, false)
    RETURNING id INTO v_activity_1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_1, '¿Qué es un algoritmo?', 1, 1) RETURNING id INTO v_q1_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q1_id, 'Secuencia ordenada de pasos', 1), (v_q1_id, 'Una base de datos', 2), (v_q1_id, 'Un navegador web', 3), (v_q1_id, 'Un tipo de archivo', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q1_id, qo.id, 'Un algoritmo es una secuencia ordenada de pasos para resolver un problema.' FROM public.question_options qo WHERE qo.question_id = v_q1_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_1, '¿Qué hace un algoritmo?', 2, 1) RETURNING id INTO v_q2_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q2_id, 'Transforma entradas en resultados esperados', 1), (v_q2_id, 'Elimina datos de la memoria', 2), (v_q2_id, 'Crea archivos aleatorios', 3), (v_q2_id, 'Define una tabla', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q2_id, qo.id, 'La función principal del algoritmo es producir una salida válida a partir de entradas.' FROM public.question_options qo WHERE qo.question_id = v_q2_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_1, '¿Qué es un paso dentro de un algoritmo?', 3, 1) RETURNING id INTO v_q3_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q3_id, 'Una acción concreta', 1), (v_q3_id, 'Un archivo de configuración', 2), (v_q3_id, 'Un string vacío', 3), (v_q3_id, 'Un valor nulo', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q3_id, qo.id, 'Cada paso representa una acción puntual y precisa.' FROM public.question_options qo WHERE qo.question_id = v_q3_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_1, '¿Qué hace más claro un algoritmo?', 4, 1) RETURNING id INTO v_q4_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q4_id, 'Orden y claridad', 1), (v_q4_id, 'Aleatoriedad', 2), (v_q4_id, 'Falta de condiciones', 3), (v_q4_id, 'Cantidad sin sentido', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q4_id, qo.id, 'Un algoritmo claro y ordenado es más fácil de comprender y ejecutar.' FROM public.question_options qo WHERE qo.question_id = v_q4_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_1, '¿Qué se espera al ejecutar un algoritmo?', 5, 1) RETURNING id INTO v_q5_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q5_id, 'La solución del problema', 1), (v_q5_id, 'Un conflicto de configuración', 2), (v_q5_id, 'Un error esperado', 3), (v_q5_id, 'Una estructura HTML', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q5_id, qo.id, 'El objetivo del algoritmo es producir la solución esperada del problema.' FROM public.question_options qo WHERE qo.question_id = v_q5_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (gen_random_uuid(), v_course_id, v_lesson_2, 'actividad-algoritmos-flujo', 'Actividad 2: Pseudocódigo y flujo', 'Elige la respuesta correcta.', 'activity', 70, 2, false)
    RETURNING id INTO v_activity_2;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_2, '¿Qué es pseudocódigo?', 1, 1) RETURNING id INTO v_q6_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q6_id, 'Descripción informal del algoritmo', 1), (v_q6_id, 'Un archivo ejecutable', 2), (v_q6_id, 'Una base de datos relacional', 3), (v_q6_id, 'Un comando SQL', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q6_id, qo.id, 'El pseudocódigo expresa la lógica del algoritmo sin depender de un lenguaje específico.' FROM public.question_options qo WHERE qo.question_id = v_q6_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_2, '¿Qué representa una decisión?', 2, 1) RETURNING id INTO v_q7_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q7_id, 'Una condición', 1), (v_q7_id, 'Un valor constante', 2), (v_q7_id, 'Un arreglo vacío', 3), (v_q7_id, 'Un archivo remoto', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q7_id, qo.id, 'Una decisión evalúa una condición y divide el flujo.' FROM public.question_options qo WHERE qo.question_id = v_q7_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_2, '¿Qué ocurre si la condición es verdadera?', 3, 1) RETURNING id INTO v_q8_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q8_id, 'Se ejecuta una ruta del algoritmo', 1), (v_q8_id, 'Se ignora todo', 2), (v_q8_id, 'Se borra la entrada', 3), (v_q8_id, 'Se produce un conflicto', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q8_id, qo.id, 'Cuando la condición es verdadera, se toma la ruta asociada a ese caso.' FROM public.question_options qo WHERE qo.question_id = v_q8_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_2, '¿Qué facilita entender un flujo?', 4, 1) RETURNING id INTO v_q9_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q9_id, 'El pseudocódigo', 1), (v_q9_id, 'El texto aleatorio', 2), (v_q9_id, 'La base de datos', 3), (v_q9_id, 'Las librerías externas', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q9_id, qo.id, 'El pseudocódigo hace visible la lógica del flujo.' FROM public.question_options qo WHERE qo.question_id = v_q9_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_2, '¿Qué hace una estructura condicional?', 5, 1) RETURNING id INTO v_q10_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q10_id, 'Evalúa si se ejecuta una acción', 1), (v_q10_id, 'Crea tablas', 2), (v_q10_id, 'Lee archivos', 3), (v_q10_id, 'Actualiza bases', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q10_id, qo.id, 'La estructura condicional determina si una acción se ejecuta o no.' FROM public.question_options qo WHERE qo.question_id = v_q10_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (gen_random_uuid(), v_course_id, v_lesson_3, 'actividad-algoritmos-bucles', 'Actividad 3: Bucles y arreglos', 'Selecciona la opción correcta.', 'activity', 70, 3, false)
    RETURNING id INTO v_activity_3;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_3, '¿Qué es un bucle?', 1, 1) RETURNING id INTO v_q11_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q11_id, 'Repetición de una acción', 1), (v_q11_id, 'Otro nombre de una tabla', 2), (v_q11_id, 'Una condición fija', 3), (v_q11_id, 'Un servidor', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q11_id, qo.id, 'Un bucle ejecuta un bloque varias veces.' FROM public.question_options qo WHERE qo.question_id = v_q11_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_3, '¿Qué estructura guarda varios datos juntos?', 2, 1) RETURNING id INTO v_q12_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q12_id, 'Arreglo', 1), (v_q12_id, 'Servidor', 2), (v_q12_id, 'Archivo', 3), (v_q12_id, 'Vista', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q12_id, qo.id, 'Un arreglo agrupa diversas entradas bajo una misma estructura.' FROM public.question_options qo WHERE qo.question_id = v_q12_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_3, '¿Qué hace un for?', 3, 1) RETURNING id INTO v_q13_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q13_id, 'Repite un número determinado de veces', 1), (v_q13_id, 'Crea un algoritmo', 2), (v_q13_id, 'Resuelve una consulta', 3), (v_q13_id, 'Define un diccionario', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q13_id, qo.id, 'Un for repite la misma operación una cantidad fija de iteraciones.' FROM public.question_options qo WHERE qo.question_id = v_q13_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_3, '¿Qué es una iteración?', 4, 1) RETURNING id INTO v_q14_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q14_id, 'Una ejecución del cuerpo del bucle', 1), (v_q14_id, 'Un tipo de archivo', 2), (v_q14_id, 'Una estructura de SQL', 3), (v_q14_id, 'Un navegador', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q14_id, qo.id, 'Cada vuelta del bucle representa una iteración.' FROM public.question_options qo WHERE qo.question_id = v_q14_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_3, '¿Qué ventaja tienen los arreglos?', 5, 1) RETURNING id INTO v_q15_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q15_id, 'Organizar muchos datos', 1), (v_q15_id, 'Cambiar el lenguaje', 2), (v_q15_id, 'Eliminar lógica', 3), (v_q15_id, 'Reducir bases', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q15_id, qo.id, 'Los arreglos permiten almacenar y gestionar colecciones de datos de forma ordenada.' FROM public.question_options qo WHERE qo.question_id = v_q15_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (gen_random_uuid(), v_course_id, v_lesson_4, 'actividad-algoritmos-eficiencia', 'Actividad 4: Complejidad y eficiencia', 'Elige la respuesta correcta.', 'activity', 70, 4, false)
    RETURNING id INTO v_activity_4;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_4, '¿Qué mide la complejidad?', 1, 1) RETURNING id INTO v_q16_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q16_id, 'Cómo crece el costo con la entrada', 1), (v_q16_id, 'La cantidad de archivos', 2), (v_q16_id, 'El tamaño del navegador', 3), (v_q16_id, 'La velocidad del sistema', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q16_id, qo.id, 'La complejidad describe cómo cambia el costo conforme aumenta la entrada.' FROM public.question_options qo WHERE qo.question_id = v_q16_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_4, '¿Qué algoritmo suele ser más eficiente?', 2, 1) RETURNING id INTO v_q17_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q17_id, 'El que hace menos operaciones repetidas', 1), (v_q17_id, 'El que usa más pasos', 2), (v_q17_id, 'El que usa más comentarios', 3), (v_q17_id, 'El que ignora la entrada', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q17_id, qo.id, 'La eficiencia se relaciona con un menor trabajo innecesario.' FROM public.question_options qo WHERE qo.question_id = v_q17_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_4, '¿Qué ayuda a comparar soluciones?', 3, 1) RETURNING id INTO v_q18_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q18_id, 'Tiempo y operaciones', 1), (v_q18_id, 'Paleta de colores', 2), (v_q18_id, 'Marca del navegador', 3), (v_q18_id, 'Nombre del archivo', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q18_id, qo.id, 'La comparación de soluciones suele hacerse por tiempo y operaciones necesarias.' FROM public.question_options qo WHERE qo.question_id = v_q18_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_4, '¿Qué facilita elegir una solución?', 4, 1) RETURNING id INTO v_q19_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q19_id, 'Analizar la complejidad', 1), (v_q19_id, 'Ignorar casos de prueba', 2), (v_q19_id, 'Crear datos aleatorios', 3), (v_q19_id, 'Cambiar de lenguaje sin razón', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q19_id, qo.id, 'Analizar la complejidad ayuda a seleccionar la mejor alternativa.' FROM public.question_options qo WHERE qo.question_id = v_q19_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_4, '¿Qué es eficiencia?', 5, 1) RETURNING id INTO v_q20_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q20_id, 'Resolver con el menor trabajo innecesario', 1), (v_q20_id, 'Escribir menos sin pensar', 2), (v_q20_id, 'Ocultar errores', 3), (v_q20_id, 'Usar varias líneas sin sentido', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q20_id, qo.id, 'La eficiencia busca resolver la tarea con el mínimo esfuerzo redundante.' FROM public.question_options qo WHERE qo.question_id = v_q20_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (gen_random_uuid(), v_course_id, NULL, 'examen-final-algoritmos', 'Examen final: Fundamentos de algoritmos', 'Selecciona la respuesta correcta.', 'exam', 70, 5, false)
    RETURNING id INTO v_exam_id;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué es un algoritmo?', 1, 1) RETURNING id INTO v_q21_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q21_id, 'Secuencia ordenada de pasos', 1), (v_q21_id, 'Un archivo de texto', 2), (v_q21_id, 'Un sistema operativo', 3), (v_q21_id, 'Un compilador', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q21_id, qo.id, 'Un algoritmo es la secuencia ordenada de una solución.' FROM public.question_options qo WHERE qo.question_id = v_q21_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué representa una decisión?', 2, 1) RETURNING id INTO v_q22_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q22_id, 'Una condición', 1), (v_q22_id, 'Un valor constante', 2), (v_q22_id, 'Un prototipo', 3), (v_q22_id, 'Una cadena', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q22_id, qo.id, 'Una decisión analiza una condición para escoger una ruta.' FROM public.question_options qo WHERE qo.question_id = v_q22_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué estructura repite instrucciones?', 3, 1) RETURNING id INTO v_q23_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q23_id, 'Bucle', 1), (v_q23_id, 'Modelo', 2), (v_q23_id, 'Servidor', 3), (v_q23_id, 'Archivo', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q23_id, qo.id, 'Un bucle repite un bloque de instrucciones.' FROM public.question_options qo WHERE qo.question_id = v_q23_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué define un paso del algoritmo?', 4, 1) RETURNING id INTO v_q24_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q24_id, 'Una acción concreta', 1), (v_q24_id, 'Un tipo de dato', 2), (v_q24_id, 'Una tabla', 3), (v_q24_id, 'Un módulo', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q24_id, qo.id, 'Cada paso representa una acción puntual del proceso.' FROM public.question_options qo WHERE qo.question_id = v_q24_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué facilita visualizar la lógica?', 5, 1) RETURNING id INTO v_q25_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q25_id, 'Pseudocódigo', 1), (v_q25_id, 'Mensajes del sistema', 2), (v_q25_id, 'Base de datos', 3), (v_q25_id, 'Menú de consola', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q25_id, qo.id, 'El pseudocódigo visualiza la lógica sin depender del lenguaje exacto.' FROM public.question_options qo WHERE qo.question_id = v_q25_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace if?', 6, 1) RETURNING id INTO v_q26_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q26_id, 'Evalúa una condición y decide', 1), (v_q26_id, 'Guarda datos', 2), (v_q26_id, 'Crea variables', 3), (v_q26_id, 'Muestra texto', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q26_id, qo.id, 'if decide qué camino tomar según la condición.' FROM public.question_options qo WHERE qo.question_id = v_q26_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué es un arreglo?', 7, 1) RETURNING id INTO v_q27_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q27_id, 'Colección ordenada de datos', 1), (v_q27_id, 'Un tipo de navegador', 2), (v_q27_id, 'Un comando de Git', 3), (v_q27_id, 'Un módulo', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q27_id, qo.id, 'Los arreglos agrupan datos relacionados de forma ordenada.' FROM public.question_options qo WHERE qo.question_id = v_q27_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué busca la eficiencia?', 8, 1) RETURNING id INTO v_q28_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q28_id, 'Menor trabajo innecesario', 1), (v_q28_id, 'Más instrucciones redundantes', 2), (v_q28_id, 'Más archivos vacíos', 3), (v_q28_id, 'Más comentarios sin valor', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q28_id, qo.id, 'La eficiencia busca reducir trabajo superfluo.' FROM public.question_options qo WHERE qo.question_id = v_q28_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué mide la complejidad?', 9, 1) RETURNING id INTO v_q29_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q29_id, 'Costo con respecto a la entrada', 1), (v_q29_id, 'Número de archivos', 2), (v_q29_id, 'Velocidad de internet', 3), (v_q29_id, 'Tamaño de la pantalla', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q29_id, qo.id, 'La complejidad mide cómo crece el costo en función de la entrada.' FROM public.question_options qo WHERE qo.question_id = v_q29_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué es una iteración?', 10, 1) RETURNING id INTO v_q30_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q30_id, 'Una vuelta del bucle', 1), (v_q30_id, 'Un tipo de variable', 2), (v_q30_id, 'Una rama de git', 3), (v_q30_id, 'Un archivo HTML', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q30_id, qo.id, 'Una iteración es cada ejecución del bloque repetido.' FROM public.question_options qo WHERE qo.question_id = v_q30_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué importa más en un algoritmo ordenado?', 11, 1) RETURNING id INTO v_q31_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q31_id, 'El orden de pasos', 1), (v_q31_id, 'El nombre aleatorio', 2), (v_q31_id, 'La cantidad de comentarios', 3), (v_q31_id, 'El formato visual', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q31_id, qo.id, 'El orden de pasos es clave para garantizar la lógica correcta.' FROM public.question_options qo WHERE qo.question_id = v_q31_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué busca una solución eficiente?', 12, 1) RETURNING id INTO v_q32_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q32_id, 'Menor costo posible', 1), (v_q32_id, 'Más complejidad artificial', 2), (v_q32_id, 'Más redundancia', 3), (v_q32_id, 'Más aleatoriedad', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q32_id, qo.id, 'Una solución eficiente reduce trabajo innecesario y costo.' FROM public.question_options qo WHERE qo.question_id = v_q32_id AND qo.position = 1;
END $$;

COMMIT;
