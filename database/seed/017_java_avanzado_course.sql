BEGIN;

DO $$
DECLARE
    v_course_id uuid;
    v_lesson_1 uuid; v_lesson_2 uuid; v_lesson_3 uuid; v_lesson_4 uuid;
    v_activity_1 uuid; v_activity_2 uuid; v_activity_3 uuid; v_activity_4 uuid;
    v_exam_id uuid;
    v_q1_id uuid; v_q2_id uuid; v_q3_id uuid; v_q4_id uuid; v_q5_id uuid; v_q6_id uuid; v_q7_id uuid; v_q8_id uuid; v_q9_id uuid; v_q10_id uuid; v_q11_id uuid; v_q12_id uuid; v_q13_id uuid; v_q14_id uuid; v_q15_id uuid; v_q16_id uuid; v_q17_id uuid; v_q18_id uuid; v_q19_id uuid; v_q20_id uuid; v_q21_id uuid; v_q22_id uuid; v_q23_id uuid; v_q24_id uuid; v_q25_id uuid; v_q26_id uuid; v_q27_id uuid; v_q28_id uuid; v_q29_id uuid; v_q30_id uuid; v_q31_id uuid; v_q32_id uuid;
BEGIN
    IF EXISTS (SELECT 1 FROM public.courses WHERE slug = 'java-avanzado') THEN
        RAISE EXCEPTION 'El slug java-avanzado ya existe en public.courses.';
    END IF;

    INSERT INTO public.courses (id, slug, title, description, language, level, duration_weeks, position, is_published)
    VALUES (
        gen_random_uuid(),
        'java-avanzado',
        'Java avanzado',
        'Curso avanzado para profundizar en programación orientada a objetos, colecciones, manejo de excepciones e interfaces funcionales en Java.',
        'Java',
        'Avanzado',
        4,
        999,
        false
    )
    RETURNING id INTO v_course_id;


    INSERT INTO public.lessons (id, course_id, slug, title, objective, content, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'colecciones-y-genericos',
        'Colecciones y genéricos',
        'Trabajar con estructuras de datos avanzadas y tipos seguros.',
        '[{"type": "paragraph", "text": "Java ofrece colecciones como List, Set y Map para manipular datos de forma eficiente."}, {"type": "paragraph", "text": "Los genéricos permiten asegurar el tipo de los elementos y reducir errores de conversión."}, {"type": "code", "text": "List<String> nombres = new ArrayList<>(); Map<String, Integer> edades = new HashMap<>();"}, {"type": "exercise", "title": "Ejercicio práctico", "steps": ["Crea una lista de nombres.", "Añade elementos.", "Recorre la colección con un for-each."]}, {"type": "tip", "title": "Consejo", "text": "Usar genéricos evita castings innecesarios y mejora seguridad."}]'::jsonb,
        1,
        false
    )
    RETURNING id INTO v_lesson_1;

    INSERT INTO public.lessons (id, course_id, slug, title, objective, content, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'herencia-e-interfaces',
        'Herencia e interfaces',
        'Modelar sistemas extensibles con contratos claros y jerarquías bien definidas.',
        '[{"type": "paragraph", "text": "La herencia permite reutilizar código entre clases relacionadas, mientras que las interfaces definen comportamientos que deben cumplir varias clases."}, {"type": "paragraph", "text": "Estas dos herramientas son esenciales para construir software mantenible y extensible."}, {"type": "code", "text": "interface Pagable { void pagar(); } class Tarjeta implements Pagable { public void pagar() {} }"}, {"type": "exercise", "title": "Ejercicio práctico", "steps": ["Define una interfaz Pagable.", "Implementa una clase Tarjeta.", "Verifica que la clase cumple el contrato."]}, {"type": "warning", "title": "Atención", "text": "Las interfaces ayudan a desacoplar la lógica y definir requisitos con claridad."}]'::jsonb,
        2,
        false
    )
    RETURNING id INTO v_lesson_2;

    INSERT INTO public.lessons (id, course_id, slug, title, objective, content, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'excepciones-y-streams',
        'Excepciones y streams',
        'Gestionar errores y operar con datos secuenciales de forma funcional.',
        '[{"type": "paragraph", "text": "En Java, las excepciones permiten responder a errores de entrada, archivos o validación."}, {"type": "paragraph", "text": "Los streams y lambdas permiten transformar y procesar colecciones de forma expresiva y ordenada."}, {"type": "code", "text": "try { int x = Integer.parseInt(''abc''); } catch (NumberFormatException e) { System.out.println(''Entrada inválida''); }"}, {"type": "exercise", "title": "Ejercicio práctico", "steps": ["Genera un NumberFormatException.", "Cápturalo con catch.", "Muestra un mensaje útil al usuario."]}, {"type": "tip", "title": "Buena práctica", "text": "Usar streams mejora legibilidad cuando la lógica consiste en transformar datos."}]'::jsonb,
        3,
        false
    )
    RETURNING id INTO v_lesson_3;

    INSERT INTO public.lessons (id, course_id, slug, title, objective, content, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'aplicaciones-y-archivos',
        'Aplicaciones y archivos',
        'Leer, guardar y procesar datos externos en una aplicación Java.',
        '[{"type": "paragraph", "text": "Las aplicaciones Java suelen interactuar con archivos, entradas de usuario o servicios externos."}, {"type": "paragraph", "text": "La lectura segura de archivos y manejo de I/O es clave para construir software robusto."}, {"type": "code", "text": "Files.readAllLines(Path.of(''datos.txt''));"}, {"type": "exercise", "title": "Ejercicio práctico", "steps": ["Define un archivo con texto.", "Usa Files.readAllLines.", "Muestra cada línea por consola."]}, {"type": "warning", "title": "Atención", "text": "Los recursos externos deben gestionarse con cuidado para evitar errores y pérdida de información."}]'::jsonb,
        4,
        false
    )
    RETURNING id INTO v_lesson_4;


    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        v_lesson_1,
        'act-java-colecciones',
        'Actividad 1: Colecciones y genéricos',
        'Elige la respuesta correcta.',
        'activity',
        70,
        1,
        false
    )
    RETURNING id INTO v_activity_1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué es una List en Java?', 1, 1)
    RETURNING id INTO v_q1_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q1_id, 'Una colección ordenada de elementos', 1), (v_q1_id, 'Un tipo de excepción', 2), (v_q1_id, 'Un archivo de recursos', 3), (v_q1_id, 'Un método del sistema', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q1_id, qo.id, 'List mantiene elementos ordenados y repetibles.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q1_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué ventaja tienen los genéricos?', 2, 1)
    RETURNING id INTO v_q2_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q2_id, 'Evitan conversiones inseguras y mejoran seguridad de tipos', 1), (v_q2_id, 'Eliminan todas las excepciones', 2), (v_q2_id, 'Hacen la clase abstracta', 3), (v_q2_id, 'No tienen uso práctico', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q2_id, qo.id, 'Los genéricos evitan castings riesgosos.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q2_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué hace Map<String, Integer>?', 3, 1)
    RETURNING id INTO v_q3_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q3_id, 'Asocia claves tipo String con valores tipo Integer', 1), (v_q3_id, 'Crea una lista de enteros', 2), (v_q3_id, 'Ordena archivos', 3), (v_q3_id, 'Es una interfaz de red', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q3_id, qo.id, 'Map almacena parejas clave-valor.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q3_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué estructura evita duplicados?', 4, 1)
    RETURNING id INTO v_q4_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q4_id, 'Set', 1), (v_q4_id, 'List', 2), (v_q4_id, 'Map', 3), (v_q4_id, 'Array', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q4_id, qo.id, 'Set representa colecciones sin elementos repetidos.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q4_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué mejora el uso de genéricos?', 5, 1)
    RETURNING id INTO v_q5_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q5_id, 'Claridad y seguridad al manipular colecciones', 1), (v_q5_id, 'Menos legibilidad', 2), (v_q5_id, 'Más errores de compilación', 3), (v_q5_id, 'Más conversiones inseguras', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q5_id, qo.id, 'Los genéricos hacen el código más seguro y claro.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q5_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        v_lesson_2,
        'act-java-interfaces',
        'Actividad 2: Herencia e interfaces',
        'Selecciona la respuesta correcta.',
        'activity',
        70,
        2,
        false
    )
    RETURNING id INTO v_activity_2;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué es una interfaz en Java?', 1, 1)
    RETURNING id INTO v_q1_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q1_id, 'Contrato que define métodos que deben implementarse', 1), (v_q1_id, 'Una clase concreta', 2), (v_q1_id, 'Una excepción', 3), (v_q1_id, 'Un archivo de texto', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q1_id, qo.id, 'La interfaz define una API compartida.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q1_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué hace implements?', 2, 1)
    RETURNING id INTO v_q2_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q2_id, 'Hace que una clase cumpla una interfaz', 1), (v_q2_id, 'Define una colección', 2), (v_q2_id, 'Crea un archivo', 3), (v_q2_id, 'Oculta propiedades', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q2_id, qo.id, 'implements obliga a implementar los métodos definidos.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q2_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué ventaja tiene la herencia?', 3, 1)
    RETURNING id INTO v_q3_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q3_id, 'Reutiliza lógica común entre clases relacionadas', 1), (v_q3_id, 'Duplica todo el código', 2), (v_q3_id, 'Elimina interfaces', 3), (v_q3_id, 'No se usa en Java', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q3_id, qo.id, 'La herencia evita duplicar lógica común.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q3_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Cuál es la mejor razón para usar interfaces?', 4, 1)
    RETURNING id INTO v_q4_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q4_id, 'Definir comportamiento común para varios tipos de clases', 1), (v_q4_id, 'No poner métodos', 2), (v_q4_id, 'Reemplazar todas las clases', 3), (v_q4_id, 'Eliminar herencia', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q4_id, qo.id, 'Las interfaces permiten abstraer comportamientos comunes.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q4_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué caracteriza a una clase abstracta?', 5, 1)
    RETURNING id INTO v_q5_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q5_id, 'Puede contener métodos abstractos y concretos', 1), (v_q5_id, 'No puede tener ninguna función', 2), (v_q5_id, 'Solo sirve para datos', 3), (v_q5_id, 'Es siempre final', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q5_id, qo.id, 'Las clases abstractas aportan base común con parte implementada.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q5_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        v_lesson_3,
        'act-java-exceptions',
        'Actividad 3: Excepciones y streams',
        'Elige la respuesta correcta.',
        'activity',
        70,
        3,
        false
    )
    RETURNING id INTO v_activity_3;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué hace try/catch en Java?', 1, 1)
    RETURNING id INTO v_q1_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q1_id, 'Captura y maneja errores durante la ejecución', 1), (v_q1_id, 'Crea objetos', 2), (v_q1_id, 'Genera archivos', 3), (v_q1_id, 'Destruye variables', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q1_id, qo.id, 'try/catch controla fallos previstos.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q1_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué es NumberFormatException?', 2, 1)
    RETURNING id INTO v_q2_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q2_id, 'Error cuando una cadena no puede convertirse a número', 1), (v_q2_id, 'Error de archivo', 2), (v_q2_id, 'Error de conexión', 3), (v_q2_id, 'Error de sintaxis', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q2_id, qo.id, 'Se lanza cuando el parseo numérico falla.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q2_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué permite un stream en Java?', 3, 1)
    RETURNING id INTO v_q3_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q3_id, 'Procesar colecciones de forma declarativa y segura', 1), (v_q3_id, 'Crear bases de datos', 2), (v_q3_id, 'Diseñar layouts', 3), (v_q3_id, 'Reducir variables', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q3_id, qo.id, 'Los streams transforman y filtran datos de forma clara.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q3_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué hace lambda en Java?', 4, 1)
    RETURNING id INTO v_q4_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q4_id, 'Representa una función corta como argumento', 1), (v_q4_id, 'Es un tipo de dato', 2), (v_q4_id, 'Crea una interfaz', 3), (v_q4_id, 'Genera HTML', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q4_id, qo.id, 'Las lambdas permiten expresar lógica concisa.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q4_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué es esencial en manejo de errores?', 5, 1)
    RETURNING id INTO v_q5_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q5_id, 'Informar al usuario con contexto útil', 1), (v_q5_id, 'Ignorar el error', 2), (v_q5_id, 'Detener toda la aplicación', 3), (v_q5_id, 'No capturarlo', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q5_id, qo.id, 'Un buen manejo de errores ayuda a la experiencia y depuración.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q5_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        v_lesson_4,
        'act-java-archivos',
        'Actividad 4: Aplicaciones y archivos',
        'Selecciona la respuesta correcta.',
        'activity',
        70,
        4,
        false
    )
    RETURNING id INTO v_activity_4;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué permite Files.readAllLines?', 1, 1)
    RETURNING id INTO v_q1_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q1_id, 'Leer todas las líneas de un archivo en memoria', 1), (v_q1_id, 'Eliminar un archivo', 2), (v_q1_id, 'Instalar una librería', 3), (v_q1_id, 'Crear una interfaz', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q1_id, qo.id, 'Lee el contenido de un archivo de texto.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q1_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué es importante al acceder a archivos?', 2, 1)
    RETURNING id INTO v_q2_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q2_id, 'Manejar excepciones y rutas', 1), (v_q2_id, 'Nunca cerrar el recurso', 2), (v_q2_id, 'No usar validación', 3), (v_q2_id, 'Evitar IO', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q2_id, qo.id, 'Los archivos requieren manejo seguro de errores.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q2_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué utilidad tienen las rutas Path.of?', 3, 1)
    RETURNING id INTO v_q3_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q3_id, 'Representar ubicaciones de archivos con seguridad', 1), (v_q3_id, 'Crear interfaces', 2), (v_q3_id, 'Elimitar paquetes', 3), (v_q3_id, 'Generar HTML', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q3_id, qo.id, 'Path.of modela rutas de manera segura.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q3_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué hace un sistema robusto al leer archivos?', 4, 1)
    RETURNING id INTO v_q4_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q4_id, 'Controlar errores y preparar entradas válidas', 1), (v_q4_id, 'Ignorar fallos', 2), (v_q4_id, 'No hacer validación', 3), (v_q4_id, 'Usar solo una línea', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q4_id, qo.id, 'Robustez significa manejar errores y rutas con cuidado.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q4_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué mejora la experiencia de una app Java?', 5, 1)
    RETURNING id INTO v_q5_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q5_id, 'Manejo apropiado de archivos y errores', 1), (v_q5_id, 'Desactivar validación', 2), (v_q5_id, 'Ocultar excepciones', 3), (v_q5_id, 'No usar streams', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q5_id, qo.id, 'El manejo de IO y errores mejora confiabilidad.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q5_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        NULL,
        'exam-java-avanzado',
        'Examen final: Java avanzado',
        'Selecciona la respuesta correcta.',
        'exam',
        70,
        5,
        false
    )
    RETURNING id INTO v_exam_id;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué es una List en Java?', 1, 1)
    RETURNING id INTO v_q1_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q1_id, 'Colección ordenada', 1), (v_q1_id, 'Clase abstracta', 2), (v_q1_id, 'Canal de red', 3), (v_q1_id, 'Tipo de exception', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q1_id, qo.id, 'La list mantiene orden y elementos repetibles.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q1_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace un Set?', 2, 1)
    RETURNING id INTO v_q2_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q2_id, 'Evita elementos duplicados', 1), (v_q2_id, 'Permite duplicados', 2), (v_q2_id, 'Es una excepción', 3), (v_q2_id, 'Es un archivo', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q2_id, qo.id, 'Set guarda valores únicos.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q2_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué es un Map?', 3, 1)
    RETURNING id INTO v_q3_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q3_id, 'Colección de clave-valor', 1), (v_q3_id, 'Tipo de dato primitivo', 2), (v_q3_id, 'Librería de UI', 3), (v_q3_id, 'Archivo de texto', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q3_id, qo.id, 'Map asocia claves a valores.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q3_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace una interfaz?', 4, 1)
    RETURNING id INTO v_q4_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q4_id, 'Define un contrato de comportamiento', 1), (v_q4_id, 'Crea objetos concretos', 2), (v_q4_id, 'Es un tipo de excepción', 3), (v_q4_id, 'No tiene métodos', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q4_id, qo.id, 'Interfaces especifican responsabilidades que deben implementar clases.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q4_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué significa implements?', 5, 1)
    RETURNING id INTO v_q5_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q5_id, 'Que una clase cumple una interfaz', 1), (v_q5_id, 'Que se crea un archivo', 2), (v_q5_id, 'Que se termina la ejecución', 3), (v_q5_id, 'Que se elimina una colección', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q5_id, qo.id, 'implements obliga a la clase a cumplir el contrato.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q5_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué es la herencia?', 6, 1)
    RETURNING id INTO v_q6_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q6_id, 'Reutilizar lógica entre clases relacionadas', 1), (v_q6_id, 'Duplicar todo el código', 2), (v_q6_id, 'Eliminar interfaces', 3), (v_q6_id, 'No existe en Java', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q6_id, qo.id, 'La herencia comparte comportamiento común.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q6_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace try/catch?', 7, 1)
    RETURNING id INTO v_q7_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q7_id, 'Captura y controla errores', 1), (v_q7_id, 'Borra valores', 2), (v_q7_id, 'Define clases', 3), (v_q7_id, 'Cambia el compilador', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q7_id, qo.id, 'try/catch responde a errores previsibles.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q7_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué es NumberFormatException?', 8, 1)
    RETURNING id INTO v_q8_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q8_id, 'Error por conversión de cadena a número inválida', 1), (v_q8_id, 'Error de lectura de archivo', 2), (v_q8_id, 'Variable no inicializada', 3), (v_q8_id, 'Error de sintaxis', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q8_id, qo.id, 'Se lanza cuando el parseo numérico falla.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q8_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué es un stream en Java?', 9, 1)
    RETURNING id INTO v_q9_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q9_id, 'Mecanismo para procesar datos secuencialmente', 1), (v_q9_id, 'Un archivo de configuración', 2), (v_q9_id, 'Una interfaz gráfica', 3), (v_q9_id, 'Un método estático', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q9_id, qo.id, 'Los streams procesan datos de forma declarativa.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q9_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace una lambda?', 10, 1)
    RETURNING id INTO v_q10_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q10_id, 'Representa una función corta como valor', 1), (v_q10_id, 'Borra archivos', 2), (v_q10_id, 'Compila clases', 3), (v_q10_id, 'Define una lista', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q10_id, qo.id, 'Las lambdas encapsulan lógica breve.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q10_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué es clave al trabajar con archivos?', 11, 1)
    RETURNING id INTO v_q11_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q11_id, 'Manejar rutas y excepciones de forma segura', 1), (v_q11_id, 'Ignorar errores', 2), (v_q11_id, 'No cerrar recursos', 3), (v_q11_id, 'Usar solo textos cortos', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q11_id, qo.id, 'Los archivos requieren control cuidadoso para evitar fallos.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q11_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace que una app Java sea robusta?', 12, 1)
    RETURNING id INTO v_q12_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q12_id, 'Manejo correcto de errores, archivos y tipos', 1), (v_q12_id, 'Ocultar excepciones', 2), (v_q12_id, 'Ignorar validación', 3), (v_q12_id, 'Evitar el uso de clases', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q12_id, qo.id, 'Robustez se logra con manejo apropiado de errores y datos.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q12_id AND qo.position = 1;

END $$;

COMMIT;
