BEGIN;

DO $$
DECLARE
    v_course_id uuid;
    v_lesson_1 uuid; v_lesson_2 uuid; v_lesson_3 uuid; v_lesson_4 uuid;
    v_activity_1 uuid; v_activity_2 uuid; v_activity_3 uuid; v_activity_4 uuid;
    v_exam_id uuid;
    v_q1_id uuid; v_q2_id uuid; v_q3_id uuid; v_q4_id uuid; v_q5_id uuid;
    v_q6_id uuid; v_q7_id uuid; v_q8_id uuid; v_q9_id uuid; v_q10_id uuid;
    v_q11_id uuid; v_q12_id uuid; v_q13_id uuid; v_q14_id uuid; v_q15_id uuid;
    v_q16_id uuid; v_q17_id uuid; v_q18_id uuid; v_q19_id uuid; v_q20_id uuid;
    v_q21_id uuid; v_q22_id uuid; v_q23_id uuid; v_q24_id uuid; v_q25_id uuid;
    v_q26_id uuid; v_q27_id uuid; v_q28_id uuid; v_q29_id uuid; v_q30_id uuid;
    v_q31_id uuid; v_q32_id uuid;
BEGIN
    IF EXISTS (SELECT 1 FROM public.courses WHERE slug = 'apis-rest-y-seguridad') THEN
        RAISE EXCEPTION 'El slug apis-rest-y-seguridad ya existe en public.courses.';
    END IF;

    INSERT INTO public.courses (id, slug, title, description, language, level, duration_weeks, position, is_published)
    VALUES (
        gen_random_uuid(),
        'apis-rest-y-seguridad',
        'APIs REST y seguridad',
        'Curso avanzado para diseñar, documentar y proteger APIs REST con principios de interoperabilidad, autenticación y control de acceso.',
        'Backend',
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
        'fundamentos-rest',
        'Fundamentos de REST',
        'Comprender los principios arquitectónicos y el uso de HTTP en APIs REST.',
        '[{"type":"paragraph","text":"REST define una arquitectura basada en recursos, estados transferidos mediante peticiones HTTP."},{"type":"paragraph","text":"Los clientes envían solicitudes con verbos como GET, POST, PUT y DELETE para manipular recursos."},{"type":"code","text":"GET /usuarios/42\nPOST /usuarios\nPUT /usuarios/42\nDELETE /usuarios/42"},{"type":"exercise","title":"Ejercicio práctico","steps":["Identifica el recurso principal de una petición.","Relaciona cada verbo HTTP con una operación de negocio.","Compara la semántica de GET y POST."]},{"type":"tip","title":"Consejo","text":"REST favorece interoperabilidad y uso de estándares HTTP, no un modelo de objeto específico."}]'::jsonb,
        1,
        false
    )
    RETURNING id INTO v_lesson_1;

    INSERT INTO public.lessons (id, course_id, slug, title, objective, content, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'enpoints-y-recursos',
        'Endpoints y recursos',
        'Diseñar rutas, identificadores y representaciones coherentes para recursos públicos y privados.',
        '[{"type":"paragraph","text":"Los recursos deben modelarse con identificadores claros y un conjunto de representaciones consistentes."},{"type":"paragraph","text":"La estructura de URLs debe reflejar la entidad y no la lógica interna de implementación."},{"type":"code","text":"/clientes\n/clientes/42\n/clientes/42/pedidos"},{"type":"exercise","title":"Ejercicio práctico","steps":["Define la colección y el recurso individual.","Modela una relación entre dos entidades.","Evalúa si la URL comunica el dominio de negocio." ]},{"type":"warning","title":"Atención","text":"Las rutas deben mantener una semántica estable para evitar romper clientes existentes."}]'::jsonb,
        2,
        false
    )
    RETURNING id INTO v_lesson_2;

    INSERT INTO public.lessons (id, course_id, slug, title, objective, content, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'seguridad-api',
        'Seguridad en APIs',
        'Aplicar autenticación, autorización y políticas de protección a servicios web.',
        '[{"type":"paragraph","text":"La seguridad de una API incluye identificación del actor, validación de credenciales y control del acceso a recursos."},{"type":"paragraph","text":"Se debe impedir la exposición de datos sensibles y registrar eventos de acceso para auditoría."},{"type":"code","text":"Authorization: Bearer <token>\nX-RateLimit-Limit: 100"},{"type":"exercise","title":"Ejercicio práctico","steps":["Configura un flujo de autenticación.","Identifica el Cliente y el Scope requerido.","Define una regla de autorización para un recurso crítico."]},{"type":"tip","title":"Buena práctica","text":"Usa tokens con expiración y permisos mínimos necesarios para cada operación."}]'::jsonb,
        3,
        false
    )
    RETURNING id INTO v_lesson_3;

    INSERT INTO public.lessons (id, course_id, slug, title, objective, content, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'versionado-y-observabilidad',
        'Versionado y observabilidad',
        'Gestionar cambios de API, caché y monitoreo de comportamiento operativo.',
        '[{"type":"paragraph","text":"Un servicio web evoluciona con el tiempo y requiere estrategias de versionado y compatibilidad."},{"type":"paragraph","text":"La observabilidad permite detectar errores de rendimiento, abuso de endpoints y fallos inesperados."},{"type":"code","text":"GET /v1/usuarios\nCache-Control: max-age=300\nX-Request-Id: 5d3c7d"},{"type":"exercise","title":"Ejercicio práctico","steps":["Define una política para introducir cambios.","Explica cómo mejorar la trazabilidad de una petición.","Analiza cuándo conviene habilitar caché." ]},{"type":"warning","title":"Atención","text":"Cambios sin estrategia de compatibilidad pueden romper consumidores que dependen de una API estable."}]'::jsonb,
        4,
        false
    )
    RETURNING id INTO v_lesson_4;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        v_lesson_1,
        'act-rest-fundamentos',
        'Actividad 1: Fundamentos de REST',
        'Elige la respuesta correcta.',
        'activity',
        70,
        1,
        false
    )
    RETURNING id INTO v_activity_1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué caracteriza a una API REST?', 1, 1)
    RETURNING id INTO v_q1_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q1_id, 'Usa recursos identificables y peticiones HTTP estándar', 1), (v_q1_id, 'Depende solo de sockets personalizados', 2), (v_q1_id, 'Requiere un protocolo propietario', 3), (v_q1_id, 'No usa estado ni recursos', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q1_id, qo.id, 'REST se apoya en recursos y verbos HTTP, no en protocolos propietarios.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q1_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué representa el método GET en REST?', 2, 1)
    RETURNING id INTO v_q2_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q2_id, 'Obtener una representación de un recurso', 1), (v_q2_id, 'Eliminar un recurso', 2), (v_q2_id, 'Actualizar parcialmente un recurso', 3), (v_q2_id, 'Crear una sesión', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q2_id, qo.id, 'GET solicita una representación del recurso sin modificarlo.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q2_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué significa que una API sea stateless?', 3, 1)
    RETURNING id INTO v_q3_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q3_id, 'Cada petición lleva toda la información necesaria', 1), (v_q3_id, 'La API guarda la sesión del cliente', 2), (v_q3_id, 'Cada respuesta depende del estado anterior', 3), (v_q3_id, 'La API solo acepta un tipo de recurso', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q3_id, qo.id, 'En REST, cada solicitud debe contener la información imprescindible para ejecutarse.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q3_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Cuál es una buena ruta para consultar un usuario por id?', 4, 1)
    RETURNING id INTO v_q4_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q4_id, 'GET /usuarios/42', 1), (v_q4_id, 'POST /usuarios/42', 2), (v_q4_id, 'GET /usuario?id=42', 3), (v_q4_id, 'DELETE /usuarios', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q4_id, qo.id, 'GET /usuarios/42 representa la recuperación de un recurso concreto.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q4_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué es un recurso en REST?', 5, 1)
    RETURNING id INTO v_q5_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q5_id, 'Una entidad o colección accesible por la API', 1), (v_q5_id, 'Un puerto de red', 2), (v_q5_id, 'Un archivo de configuración', 3), (v_q5_id, 'Una regla de base de datos', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q5_id, qo.id, 'Un recurso modela un dato o conjunto de datos que la API expone.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q5_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        v_lesson_2,
        'act-rest-endpoints',
        'Actividad 2: Endpoints y recursos',
        'Elige la respuesta correcta.',
        'activity',
        70,
        2,
        false
    )
    RETURNING id INTO v_activity_2;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué ventaja tiene una URL jerárquica como /clientes/42/pedidos?', 1, 1)
    RETURNING id INTO v_q6_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q6_id, 'Expresa relaciones entre entidades de forma clara', 1), (v_q6_id, 'Oculta la estructura del dominio', 2), (v_q6_id, 'Elimina la necesidad de validación', 3), (v_q6_id, 'No permite paginación', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q6_id, qo.id, 'Las rutas jerárquicas reflejan relaciones entre recursos y mejoran legibilidad.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q6_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué es la idempotencia en REST?', 2, 1)
    RETURNING id INTO v_q7_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q7_id, 'Repetir la misma solicitud produce el mismo resultado final', 1), (v_q7_id, 'La respuesta cambia cada vez', 2), (v_q7_id, 'La solicitud siempre crea un nuevo recurso', 3), (v_q7_id, 'No influye en los endpoints', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q7_id, qo.id, 'La idempotencia garantiza que repetir una operación no altera el estado final esperado.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q7_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué indica un código 201 Created?', 3, 1)
    RETURNING id INTO v_q8_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q8_id, 'El recurso fue creado con éxito', 1), (v_q8_id, 'La solicitud fue aceptada pero aún no procesada', 2), (v_q8_id, 'El cliente no tiene autorización', 3), (v_q8_id, 'El servidor necesita autenticación', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q8_id, qo.id, '201 Created confirma la creación satisfactoria del recurso solicitado.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q8_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué hace mejor un payload estructurado en JSON?', 4, 1)
    RETURNING id INTO v_q9_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q9_id, 'Facilita el intercambio de datos entre clientes y servidores', 1), (v_q9_id, 'Impide cualquier validación', 2), (v_q9_id, 'Evita el uso de códigos HTTP', 3), (v_q9_id, 'Solo sirve para bases de datos', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q9_id, qo.id, 'JSON ofrece una representación sencilla, legible y ampliamente compatible.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q9_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué es un recurso embebido?', 5, 1)
    RETURNING id INTO v_q10_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q10_id, 'Un recurso relacionado incluido dentro de la representación principal', 1), (v_q10_id, 'Una copia temporal del servidor', 2), (v_q10_id, 'Un conjunto de cabeceras HTTP', 3), (v_q10_id, 'Un valor calculado del cliente', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q10_id, qo.id, 'Un recurso embebido ofrece información relacionada dentro de la misma representación.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q10_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        v_lesson_3,
        'act-rest-seguridad',
        'Actividad 3: Seguridad en APIs',
        'Elige la respuesta correcta.',
        'activity',
        70,
        3,
        false
    )
    RETURNING id INTO v_activity_3;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué finalidad tiene un token JWT?', 1, 1)
    RETURNING id INTO v_q11_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q11_id, 'Transportar credenciales verificables entre cliente y servidor', 1), (v_q11_id, 'Evitar todas las peticiones HTTP', 2), (v_q11_id, 'Reemplazar por completo la base de datos', 3), (v_q11_id, 'Encriptar el navegador del usuario', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q11_id, qo.id, 'JWT transporta información de autenticación y autorización de forma verificable.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q11_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué es OAuth 2.0?', 2, 1)
    RETURNING id INTO v_q12_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q12_id, 'Un framework de autorización para acceder a recursos sin compartir credenciales', 1), (v_q12_id, 'Un tipo de base de datos', 2), (v_q12_id, 'Un protocolo de compresión', 3), (v_q12_id, 'Una técnica de cache local', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q12_id, qo.id, 'OAuth 2.0 permite otorgar acceso delegado sin exponer credenciales del usuario.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q12_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué debe validarse antes de autorizar una operación sensible?', 3, 1)
    RETURNING id INTO v_q13_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q13_id, 'El permiso del usuario o rol y el contexto de la solicitud', 1), (v_q13_id, 'Solo el nombre del cliente', 2), (v_q13_id, 'La frecuencia de la pantalla del navegador', 3), (v_q13_id, 'La versión del sistema operativo', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q13_id, qo.id, 'La autorización debe basarse en permisos y contexto de la solicitud.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q13_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Por qué es útil limitar la tasa de peticiones?', 4, 1)
    RETURNING id INTO v_q14_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q14_id, 'Reduce abuso, ataques de fuerza bruta y sobrecarga del servicio', 1), (v_q14_id, 'Elimina la necesidad de logs', 2), (v_q14_id, 'Hace que las rutas sean más largas', 3), (v_q14_id, 'Aumenta la latencia de todos los endpoints', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q14_id, qo.id, 'El rate limiting mitiga abusos y protege disponibilidad.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q14_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué es una política de CORS?', 5, 1)
    RETURNING id INTO v_q15_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q15_id, 'Una regla de acceso para navegadores que restringe o permite solicitudes entre orígenes', 1), (v_q15_id, 'Un controlador de tráfico de red', 2), (v_q15_id, 'Una base de datos en caché', 3), (v_q15_id, 'Un tipo de token sin firma', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q15_id, qo.id, 'CORS define qué sitios pueden consumir la API desde un navegador.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q15_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        v_lesson_4,
        'act-rest-observabilidad',
        'Actividad 4: Versionado y observabilidad',
        'Elige la respuesta correcta.',
        'activity',
        70,
        4,
        false
    )
    RETURNING id INTO v_activity_4;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué objetivo tiene el versionado de API?', 1, 1)
    RETURNING id INTO v_q16_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q16_id, 'Mantener compatibilidad con clientes existentes mientras evoluciona el servicio', 1), (v_q16_id, 'Reducir la seguridad del servicio', 2), (v_q16_id, 'Eliminar trazabilidad', 3), (v_q16_id, 'Forzar que todos los clientes usen la misma versión', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q16_id, qo.id, 'Versionado permite introducir cambios sin romper implementaciones existentes.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q16_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué es ETag?', 2, 1)
    RETURNING id INTO v_q17_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q17_id, 'Un identificador para validar si un recurso cambió', 1), (v_q17_id, 'Una cabecera de autenticación', 2), (v_q17_id, 'Un algoritmo de encriptación', 3), (v_q17_id, 'Un tipo de endpoint', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q17_id, qo.id, 'ETag ayuda a detectar cambios de contenido y soportar caché de validación.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q17_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué es caché HTTP?', 3, 1)
    RETURNING id INTO v_q18_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q18_id, 'Una estrategia para almacenar respuestas temporales y reducir carga', 1), (v_q18_id, 'Una base de datos en memoria', 2), (v_q18_id, 'Un componente de autenticación', 3), (v_q18_id, 'Una política de firewall', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q18_id, qo.id, 'El caché HTTP reduce tráfico y mejora latencia para recursos estáticos o semiestáticos.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q18_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué indica un log de request ID?', 4, 1)
    RETURNING id INTO v_q19_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q19_id, 'Permite correlacionar una petición con errores o trazas asociadas', 1), (v_q19_id, 'Encripta el contenido del payload', 2), (v_q19_id, 'Asigna un token JWT', 3), (v_q19_id, 'Se usa para compilar código', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q19_id, qo.id, 'Los IDs de solicitud facilitan depuración y análisis de incidentes.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q19_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Cuál es una métrica útil para evaluar disponibilidad de una API?', 5, 1)
    RETURNING id INTO v_q20_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q20_id, 'Tasa de errores HTTP y tiempo de respuesta', 1), (v_q20_id, 'Número de líneas de código', 2), (v_q20_id, 'Cantidad de archivos del proyecto', 3), (v_q20_id, 'Nombre del navegador del usuario', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q20_id, qo.id, 'Disponibilidad y rendimiento se miden con errores y latencia.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q20_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        NULL,
        'exam-apis-rest-seguridad',
        'Examen final: APIs REST y seguridad',
        'Selecciona la respuesta correcta para cada pregunta.',
        'exam',
        70,
        5,
        false
    )
    RETURNING id INTO v_exam_id;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué indica que una API implementa HATEOAS?', 1, 1)
    RETURNING id INTO v_q21_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q21_id, 'La API incluye enlaces de navegación en sus representaciones', 1), (v_q21_id, 'La API no necesita rutas', 2), (v_q21_id, 'El servidor no responde en JSON', 3), (v_q21_id, 'La API es completamente estática', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q21_id, qo.id, 'HATEOAS hace explícitos los enlaces de navegación dentro de la representación.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q21_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace PATCH en una API REST?', 2, 1)
    RETURNING id INTO v_q22_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q22_id, 'Actualiza parcialmente un recurso', 1), (v_q22_id, 'Elimina un recurso', 2), (v_q22_id, 'Crea un cliente nuevo', 3), (v_q22_id, 'Valida el formato de la URL', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q22_id, qo.id, 'PATCH modifica solo parte del recurso, no el objeto completo.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q22_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué es un recurso anidado válido?', 3, 1)
    RETURNING id INTO v_q23_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q23_id, '/clientes/7/ventas', 1), (v_q23_id, '/ventas?id=7', 2), (v_q23_id, '/clientes/ventas/7', 3), (v_q23_id, '/clientes?ventas=7', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q23_id, qo.id, 'Una ruta anidada refleja claramente la relación cliente-ventas.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q23_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Cuál es la mejor razón para usar HTTPS en una API?', 4, 1)
    RETURNING id INTO v_q24_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q24_id, 'Protege la integridad y confidencialidad de los datos en tránsito', 1), (v_q24_id, 'Reduce la cantidad de endpoints', 2), (v_q24_id, 'Evita la necesidad de validación en la aplicación', 3), (v_q24_id, 'Cambia la semántica del verbo HTTP', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q24_id, qo.id, 'HTTPS cifra la comunicación y protege datos durante la transmisión.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q24_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué es un scope en OAuth 2.0?', 5, 1)
    RETURNING id INTO v_q25_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q25_id, 'Un permiso específico concedido a una aplicación', 1), (v_q25_id, 'Una versión de protocolo', 2), (v_q25_id, 'Un identificador de sesión', 3), (v_q25_id, 'Un tipo de respuesta HTTP', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q25_id, qo.id, 'Los scopes representan permisos concretos que una aplicación puede solicitar.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q25_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué beneficio aporta el control de caché con Cache-Control?', 6, 1)
    RETURNING id INTO v_q26_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q26_id, 'Reduce tráfico y mejora la reacción ante recursos repetidos', 1), (v_q26_id, 'Cambia la identidad del usuario', 2), (v_q26_id, 'Elimina costos de infraestructura', 3), (v_q26_id, 'Garantiza alta seguridad sin configuración', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q26_id, qo.id, 'Cache-Control optimiza respuestas repetidas y disminuye carga del backend.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q26_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué problema resuelve un throttling adecuado?', 7, 1)
    RETURNING id INTO v_q27_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q27_id, 'Sobrecarga y abuso de servicios por picos de tráfico', 1), (v_q27_id, 'Pérdida de datos del cliente', 2), (v_q27_id, 'Errores de sintaxis en JSON', 3), (v_q27_id, 'Definición de endpoints', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q27_id, qo.id, 'Throttling limita tasas para evitar denegación de servicio.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q27_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué es una cabecera Authorization?', 8, 1)
    RETURNING id INTO v_q28_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q28_id, 'Indica cómo el cliente presenta credenciales o tokens al servidor', 1), (v_q28_id, 'Define la estructura de un código HTML', 2), (v_q28_id, 'Regula el número de respuestas por minuto', 3), (v_q28_id, 'Configura la caché del navegador', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q28_id, qo.id, 'Authorization transmite la identidad o token del cliente con la solicitud.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q28_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué es la correlación de logs?', 9, 1)
    RETURNING id INTO v_q29_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q29_id, 'Relacionar eventos de una petición para rastrear su flujo por servicios', 1), (v_q29_id, 'Evitar la generación de logs', 2), (v_q29_id, 'Desactivar trazas en producción', 3), (v_q29_id, 'Cambiar la estructura del DOM', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q29_id, qo.id, 'La correlación de logs ayuda a reconstruir un flujo de petición entre componentes.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q29_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Por qué es importante sanitizar entradas en una API?', 10, 1)
    RETURNING id INTO v_q30_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q30_id, 'Para evitar inyección, errores y abuso de datos no confiables', 1), (v_q30_id, 'Porque reduce el uso de JSON', 2), (v_q30_id, 'Porque elimina request IDs', 3), (v_q30_id, 'Porque obliga a usar GET siempre', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q30_id, qo.id, 'Sanitizar entradas evita vulnerabilidades y fallos por entradas maliciosas o incorrectas.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q30_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué indica un 429 Too Many Requests?', 11, 1)
    RETURNING id INTO v_q31_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q31_id, 'Se superó el límite de peticiones permitido', 1), (v_q31_id, 'La autenticación falló', 2), (v_q31_id, 'El recurso fue borrado', 3), (v_q31_id, 'La respuesta está sin caché', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q31_id, qo.id, '429 indica que se ha sobrepasado el límite de consumo permitido por la API.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q31_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué ventaja tiene separar autenticación y autorización en una API?', 12, 1)
    RETURNING id INTO v_q32_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q32_id, 'Permite controlar identidad y permisos de forma independiente y más segura', 1), (v_q32_id, 'Reduce la necesidad de logs', 2), (v_q32_id, 'Hace que todas las rutas sean idénticas', 3), (v_q32_id, 'Suprime cualquier validación de entrada', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q32_id, qo.id, 'Separar autenticación y autorización mejora claridad, seguridad y mantenimiento.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q32_id AND qo.position = 1;

END $$;

COMMIT;
