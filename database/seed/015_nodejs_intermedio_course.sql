BEGIN;

DO $$
DECLARE
    v_course_id uuid;
    v_lesson_1 uuid; v_lesson_2 uuid; v_lesson_3 uuid; v_lesson_4 uuid;
    v_activity_1 uuid; v_activity_2 uuid; v_activity_3 uuid; v_activity_4 uuid;
    v_exam_id uuid;
    v_q1_id uuid; v_q2_id uuid; v_q3_id uuid; v_q4_id uuid; v_q5_id uuid; v_q6_id uuid; v_q7_id uuid; v_q8_id uuid; v_q9_id uuid; v_q10_id uuid; v_q11_id uuid; v_q12_id uuid; v_q13_id uuid; v_q14_id uuid; v_q15_id uuid; v_q16_id uuid; v_q17_id uuid; v_q18_id uuid; v_q19_id uuid; v_q20_id uuid; v_q21_id uuid; v_q22_id uuid; v_q23_id uuid; v_q24_id uuid; v_q25_id uuid; v_q26_id uuid; v_q27_id uuid; v_q28_id uuid; v_q29_id uuid; v_q30_id uuid; v_q31_id uuid; v_q32_id uuid;
BEGIN
    IF EXISTS (SELECT 1 FROM public.courses WHERE slug = 'nodejs-intermedio') THEN
        RAISE EXCEPTION 'El slug nodejs-intermedio ya existe en public.courses.';
    END IF;

    INSERT INTO public.courses (id, slug, title, description, language, level, duration_weeks, position, is_published)
    VALUES (
        gen_random_uuid(),
        'nodejs-intermedio',
        'Node.js intermedio',
        'Curso intermedio para aprender módulos, APIs, manejo de errores, streams y servidores HTTP con Node.js.',
        'Node.js',
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
        'modulos-y-npm',
        'Módulos y npm',
        'Organizar código y reutilizar dependencias en aplicaciones Node.js.',
        '[{"type": "paragraph", "text": "Node.js usa módulos para separar responsabilidades y reutilizar lógica entre archivos."}, {"type": "paragraph", "text": "npm sirve como gestor de dependencias y facilita la instalación de librerías reutilizables."}, {"type": "code", "text": "const fs = require(''fs''); const http = require(''http'');"}, {"type": "exercise", "title": "Ejercicio práctico", "steps": ["Crea un módulo simple.", "Importa una dependencia con require.", "Haz uso del módulo desde un archivo principal."]}, {"type": "tip", "title": "Consejo", "text": "La modularización mantiene la app navegable y facilita pruebas."}]'::jsonb,
        1,
        false
    )
    RETURNING id INTO v_lesson_1;

    INSERT INTO public.lessons (id, course_id, slug, title, objective, content, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'servidor-http',
        'Servidor HTTP',
        'Crear un servicio web básico con Node.js y responder rutas y peticiones.',
        '[{"type": "paragraph", "text": "Un servidor HTTP escucha peticiones y devuelve respuestas con contenidos específicos."}, {"type": "paragraph", "text": "La estructura usual incluye una ruta, un método HTTP y un cuerpo de respuesta."}, {"type": "code", "text": "http.createServer((req, res) => { res.end(''Hola Mundo''); });"}, {"type": "exercise", "title": "Ejercicio práctico", "steps": ["Crea un servidor con http.createServer.", "Define un mensaje de respuesta.", "Prueba la ruta por navegador o curl."]}, {"type": "warning", "title": "Atención", "text": "El manejo de rutas y métodos HTTP debe ser claro para no crear endpoints ambiguos."}]'::jsonb,
        2,
        false
    )
    RETURNING id INTO v_lesson_2;

    INSERT INTO public.lessons (id, course_id, slug, title, objective, content, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'errores-y-async',
        'Errores y asincronía',
        'Controlar fallos y trabajar con operaciones asíncronas de forma segura.',
        '[{"type": "paragraph", "text": "Las operaciones asíncronas son frecuentes en Node.js y requieren control de errores preciso."}, {"type": "paragraph", "text": "Los callbacks, promesas y async/await ayudan a modelar flujos complejos y legibles."}, {"type": "code", "text": "async function obtenerDatos() { try { return await fetch(''/api''); } catch (error) { console.error(error); } }"}, {"type": "exercise", "title": "Ejercicio práctico", "steps": ["Escribe una función async.", "Usa try/catch.", "Muestra el resultado o el error según corresponda."]}, {"type": "tip", "title": "Buena práctica", "text": "El manejo de errores debe ser explícito para no ocultar fallos del usuario."}]'::jsonb,
        3,
        false
    )
    RETURNING id INTO v_lesson_3;

    INSERT INTO public.lessons (id, course_id, slug, title, objective, content, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'streams-y-archivos',
        'Streams y archivos',
        'Procesar grandes volúmenes de datos sin cargar todo en memoria.',
        '[{"type": "paragraph", "text": "Los streams permiten leer o escribir datos en chunks y son útiles para archivos grandes o flujos de red."}, {"type": "paragraph", "text": "Cuando un punto de entrada puede ser grande, los streams mantienen consumo más eficiente y controlado."}, {"type": "code", "text": "const readStream = fs.createReadStream(''archivo.txt''); readStream.on(''data'', chunk => console.log(chunk));"}, {"type": "exercise", "title": "Ejercicio práctico", "steps": ["Crea un stream de lectura.", "Escucha el evento data.", "Muestra el contenido recibido en trozos."]}, {"type": "warning", "title": "Atención", "text": "Los streams requieren manejo cuidadoso de eventos y cierre de recursos."}]'::jsonb,
        4,
        false
    )
    RETURNING id INTO v_lesson_4;


    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        v_lesson_1,
        'act-node-modulos',
        'Actividad 1: Módulos y npm',
        'Elige la respuesta correcta.',
        'activity',
        70,
        1,
        false
    )
    RETURNING id INTO v_activity_1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué es un módulo en Node.js?', 1, 1)
    RETURNING id INTO v_q1_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q1_id, 'Archivo o conjunto de código reutilizable', 1), (v_q1_id, 'Un tipo de servidor', 2), (v_q1_id, 'Una base de datos', 3), (v_q1_id, 'Un navegador', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q1_id, qo.id, 'Los módulos separan lógica y permiten reutilizar código.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q1_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Para qué sirve npm?', 2, 1)
    RETURNING id INTO v_q2_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q2_id, 'Gestionar paquetes y dependencias de un proyecto', 1), (v_q2_id, 'Crear clases CSS', 2), (v_q2_id, 'Diseñar interfaces', 3), (v_q2_id, 'Iniciar un navegador', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q2_id, qo.id, 'npm es el gestor de paquetes del ecosistema Node.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q2_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué hace require(''fs'')?', 3, 1)
    RETURNING id INTO v_q3_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q3_id, 'Carga el módulo de sistema de archivos', 1), (v_q3_id, 'Declara un servidor HTTP', 2), (v_q3_id, 'Crea CSS', 3), (v_q3_id, 'Inicia un bucle infinito', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q3_id, qo.id, 'fs ofrece funciones para leer y escribir archivos.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q3_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué ventaja tiene separar lógica en módulos?', 4, 1)
    RETURNING id INTO v_q4_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q4_id, 'Más organización y reutilización', 1), (v_q4_id, 'Más errores de red', 2), (v_q4_id, 'Menor claridad', 3), (v_q4_id, 'Más dependencia de una sola vista', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q4_id, qo.id, 'La modularización ayuda a mantener el proyecto ordenado.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q4_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué suele estar en package.json?', 5, 1)
    RETURNING id INTO v_q5_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q5_id, 'Metadatos y dependencias del proyecto', 1), (v_q5_id, 'Solo rutas CSS', 2), (v_q5_id, 'Solo variables de entorno', 3), (v_q5_id, 'Solo HTML', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q5_id, qo.id, 'package.json define el proyecto y sus dependencias.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q5_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        v_lesson_2,
        'act-node-http',
        'Actividad 2: Servidor HTTP',
        'Selecciona la respuesta correcta.',
        'activity',
        70,
        2,
        false
    )
    RETURNING id INTO v_activity_2;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué crea un servidor HTTP en Node.js?', 1, 1)
    RETURNING id INTO v_q1_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q1_id, 'http.createServer()', 1), (v_q1_id, 'fs.createServer()', 2), (v_q1_id, 'db.createServer()', 3), (v_q1_id, 'path.createServer()', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q1_id, qo.id, 'createServer() prepara un servidor web.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q1_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué es req en un handler HTTP?', 2, 1)
    RETURNING id INTO v_q2_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q2_id, 'La petición del cliente', 1), (v_q2_id, 'La respuesta del servidor', 2), (v_q2_id, 'El nombre del archivo', 3), (v_q2_id, 'Una variable de entorno', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q2_id, qo.id, 'req representa la solicitud entrante.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q2_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué es res?', 3, 1)
    RETURNING id INTO v_q3_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q3_id, 'La respuesta que envía el servidor', 1), (v_q3_id, 'El archivo de dependencias', 2), (v_q3_id, 'La ruta del proyecto', 3), (v_q3_id, 'La consola del navegador', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q3_id, qo.id, 'res permite devolver contenido al cliente.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q3_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué ayuda a organizar endpoints?', 4, 1)
    RETURNING id INTO v_q4_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q4_id, 'Evaluar método, ruta y lógica de negocio', 1), (v_q4_id, 'Ignorar la URL', 2), (v_q4_id, 'Usar solo una ruta global', 3), (v_q4_id, 'No controlar errores', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q4_id, qo.id, 'La decisión por ruta y método define el comportamiento.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q4_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué es un endpoint?', 5, 1)
    RETURNING id INTO v_q5_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q5_id, 'Una ruta HTTP con una funcionalidad concreta', 1), (v_q5_id, 'Un archivo de configuración', 2), (v_q5_id, 'Una librería de estilos', 3), (v_q5_id, 'Un comando de terminal', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q5_id, qo.id, 'Los endpoints son las interfaces del servidor.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q5_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        v_lesson_3,
        'act-node-async',
        'Actividad 3: Errores y asincronía',
        'Elige la respuesta correcta.',
        'activity',
        70,
        3,
        false
    )
    RETURNING id INTO v_activity_3;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué hace try/catch en código async?', 1, 1)
    RETURNING id INTO v_q1_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q1_id, 'Captura errores durante la ejecución asíncrona', 1), (v_q1_id, 'Crea una promesa', 2), (v_q1_id, 'Elimina callbacks', 3), (v_q1_id, 'Configura rutas', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q1_id, qo.id, 'try/catch controla errores de flujo asíncrono.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q1_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué es async/await?', 2, 1)
    RETURNING id INTO v_q2_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q2_id, 'Sintaxis para manejar promesas de forma legible', 1), (v_q2_id, 'Un tipo de servidor', 2), (v_q2_id, 'Un comando npm', 3), (v_q2_id, 'Una ruta de archivo', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q2_id, qo.id, 'async/await simplifica el trabajo con promesas.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q2_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué indica una promesa rechazada?', 3, 1)
    RETURNING id INTO v_q3_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q3_id, 'Que hubo un error al resolver la operación', 1), (v_q3_id, 'Que el código nunca se ejecuta', 2), (v_q3_id, 'Que no se cargó un módulo', 3), (v_q3_id, 'Que el servidor se apagó', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q3_id, qo.id, 'Una promesa rechazada requiere manejo explícito.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q3_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué hace await?', 4, 1)
    RETURNING id INTO v_q4_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q4_id, 'Espera la resolución de una promesa antes de continuar', 1), (v_q4_id, 'Inicia un servidor', 2), (v_q4_id, 'Crea una carpeta', 3), (v_q4_id, 'Escribe un archivo', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q4_id, qo.id, 'await pausa la función hasta que la promesa resuelva.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q4_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué es una buena práctica con errores?', 5, 1)
    RETURNING id INTO v_q5_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q5_id, 'Registrar contexto útil y responder según el caso', 1), (v_q5_id, 'Ocultarlos', 2), (v_q5_id, 'Ignorarlos', 3), (v_q5_id, 'No validar entrada', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q5_id, qo.id, 'Los errores necesitan tratamiento claro y útil.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q5_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        v_lesson_4,
        'act-node-streams',
        'Actividad 4: Streams y archivos',
        'Selecciona la respuesta correcta.',
        'activity',
        70,
        4,
        false
    )
    RETURNING id INTO v_activity_4;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué es un stream?', 1, 1)
    RETURNING id INTO v_q1_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q1_id, 'Flujo continuo de lectura o escritura de datos', 1), (v_q1_id, 'Un archivo de configuración', 2), (v_q1_id, 'Un módulo npm', 3), (v_q1_id, 'Un framework de UI', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q1_id, qo.id, 'Los streams manejan datos en chunks.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q1_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué evento es útil para leer chunks?', 2, 1)
    RETURNING id INTO v_q2_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q2_id, 'data', 1), (v_q2_id, 'click', 2), (v_q2_id, 'submit', 3), (v_q2_id, 'mount', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q2_id, qo.id, 'data se dispara cuando hay contenido disponible.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q2_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Por qué son útiles los streams?', 3, 1)
    RETURNING id INTO v_q3_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q3_id, 'Porque manejan grandes volúmenes sin cargar todo en memoria', 1), (v_q3_id, 'Porque eliminan archivos', 2), (v_q3_id, 'Porque fuerzan una sola ruta', 3), (v_q3_id, 'Porque no requieren eventos', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q3_id, qo.id, 'Los streams reducen consumo de memoria.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q3_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué hace fs.createReadStream()?', 4, 1)
    RETURNING id INTO v_q4_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q4_id, 'Crea un flujo de lectura para un archivo', 1), (v_q4_id, 'Crea un servidor HTTP', 2), (v_q4_id, 'Instala dependencias', 3), (v_q4_id, 'Genera HTML', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q4_id, qo.id, 'CreateReadStream lee el archivo en porciones.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q4_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué factor es importante en streams?', 5, 1)
    RETURNING id INTO v_q5_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q5_id, 'Cerrar recursos y gestionar eventos', 1), (v_q5_id, 'Eliminar todos los datos', 2), (v_q5_id, 'No mostrar errores', 3), (v_q5_id, 'Ignorar respuesta del cliente', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q5_id, qo.id, 'Los eventos y cierre correcto son esenciales.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q5_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        NULL,
        'exam-nodejs-intermedio',
        'Examen final: Node.js intermedio',
        'Selecciona la respuesta correcta.',
        'exam',
        70,
        5,
        false
    )
    RETURNING id INTO v_exam_id;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué es un módulo en Node.js?', 1, 1)
    RETURNING id INTO v_q1_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q1_id, 'Lógica reutilizable separada en archivos', 1), (v_q1_id, 'Tipo de navegador', 2), (v_q1_id, 'Archivo de CSS', 3), (v_q1_id, 'Base de datos', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q1_id, qo.id, 'Los módulos organizan el código.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q1_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Para qué sirve npm?', 2, 1)
    RETURNING id INTO v_q2_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q2_id, 'Instalar y gestionar dependencias', 1), (v_q2_id, 'Corregir HTML', 2), (v_q2_id, 'Diseñar componentes', 3), (v_q2_id, 'Ejecutar SQL', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q2_id, qo.id, 'npm gestiona paquetes del proyecto.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q2_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace createServer()?', 3, 1)
    RETURNING id INTO v_q3_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q3_id, 'Crea un servidor HTTP', 1), (v_q3_id, 'Abre un módulo', 2), (v_q3_id, 'Compila CSS', 3), (v_q3_id, 'Crea una tabla', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q3_id, qo.id, 'createServer prepara un servicio web.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q3_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué representa req?', 4, 1)
    RETURNING id INTO v_q4_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q4_id, 'La petición del cliente', 1), (v_q4_id, 'La respuesta del servidor', 2), (v_q4_id, 'Un archivo de configuración', 3), (v_q4_id, 'Un paquete externo', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q4_id, qo.id, 'req representa la solicitud entrante.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q4_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué representa res?', 5, 1)
    RETURNING id INTO v_q5_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q5_id, 'La respuesta del servidor', 1), (v_q5_id, 'Un módulo local', 2), (v_q5_id, 'Una dependencia global', 3), (v_q5_id, 'Una estructura de base de datos', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q5_id, qo.id, 'res devuelve los datos al cliente.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q5_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace async/await?', 6, 1)
    RETURNING id INTO v_q6_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q6_id, 'Simplifica el manejo de promesas', 1), (v_q6_id, 'Elimina rutas', 2), (v_q6_id, 'Limpia package.json', 3), (v_q6_id, 'Instala módulos', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q6_id, qo.id, 'async/await mejora la lectura del flujo asíncrono.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q6_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace await?', 7, 1)
    RETURNING id INTO v_q7_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q7_id, 'Espera la resolución de una promesa', 1), (v_q7_id, 'Cierra el servidor', 2), (v_q7_id, 'Crea un módulo', 3), (v_q7_id, 'Ejecuta SQL', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q7_id, qo.id, 'await pausa la ejecución hasta completarse la promesa.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q7_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué es un stream?', 8, 1)
    RETURNING id INTO v_q8_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q8_id, 'Flujo de lectura o escritura continuo', 1), (v_q8_id, 'Un tipo de módulo', 2), (v_q8_id, 'Una vista MVC', 3), (v_q8_id, 'Un comando bash', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q8_id, qo.id, 'Los streams procesan datos en partes.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q8_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué significa data en un stream?', 9, 1)
    RETURNING id INTO v_q9_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q9_id, 'Evento que entrega bloques del contenido', 1), (v_q9_id, 'Nombre del archivo', 2), (v_q9_id, 'Ruta del servidor', 3), (v_q9_id, 'Variable global', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q9_id, qo.id, 'data entrega chunks de información.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q9_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué beneficio tienen los streams?', 10, 1)
    RETURNING id INTO v_q10_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q10_id, 'Reducen consumo de memoria con archivos grandes', 1), (v_q10_id, 'Mejoran el diseño visual', 2), (v_q10_id, 'Eliminan errores', 3), (v_q10_id, 'Necesitan menos CPU', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q10_id, qo.id, 'Streams procesan en bloques y ahorran memoria.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q10_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué se debe hacer con errores async?', 11, 1)
    RETURNING id INTO v_q11_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q11_id, 'Capturarlos y registrar contexto útil', 1), (v_q11_id, 'Ignorarlos', 2), (v_q11_id, 'Ocultarlos', 3), (v_q11_id, 'No responder', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q11_id, qo.id, 'Los errores deben gestionarse explícitamente.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q11_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué favorece una buena arquitectura en Node.js?', 12, 1)
    RETURNING id INTO v_q12_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q12_id, 'Separar módulos, rutas y lógica de negocio', 1), (v_q12_id, 'Usar un único archivo gigantesco', 2), (v_q12_id, 'No usar package.json', 3), (v_q12_id, 'Tratar el servidor como un HTML', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q12_id, qo.id, 'La modularización mejora mantenimiento y escalabilidad.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q12_id AND qo.position = 1;

END $$;

COMMIT;
