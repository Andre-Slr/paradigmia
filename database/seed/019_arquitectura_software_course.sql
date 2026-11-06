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
    IF EXISTS (SELECT 1 FROM public.courses WHERE slug = 'arquitectura-de-software') THEN
        RAISE EXCEPTION 'El slug arquitectura-de-software ya existe en public.courses.';
    END IF;

    INSERT INTO public.courses (id, slug, title, description, language, level, duration_weeks, position, is_published)
    VALUES (
        gen_random_uuid(),
        'arquitectura-de-software',
        'Arquitectura de software',
        'Curso avanzado para analizar sistemas complejos, patrones de diseño, decisiones de arquitectura y evolución de software.',
        'Software',
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
        'principios-arquitectura',
        'Principios de arquitectura',
        'Reconocer principios como cohesion, acoplamiento, encapsulamiento y escalabilidad.',
        '[{"type":"paragraph","text":"La arquitectura de software define cómo se organizan módulos, responsabilidades y dependencias de un sistema."},{"type":"paragraph","text":"Los principios de diseño ayudan a crear sistemas complejos, comprensibles y sostenibles."},{"type":"code","text":"class UsuarioService {\n  private final UsuarioRepository repo;\n  // responsabilidad clara\n}"},{"type":"exercise","title":"Ejercicio práctico","steps":["Identifica una responsabilidad en un módulo.","Evalúa si hay acoplamiento excesivo.","Separa una regla de negocio de la infraestructura."]},{"type":"tip","title":"Consejo","text":"Un buen diseño no elimina complejidad, la hace visible y manejable."}]'::jsonb,
        1,
        false
    )
    RETURNING id INTO v_lesson_1;

    INSERT INTO public.lessons (id, course_id, slug, title, objective, content, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'patrones-y-escalabilidad',
        'Patrones y escalabilidad',
        'Aplicar patrones de diseño y capilaridad de la arquitectura para sistemas con crecimiento continuo.',
        '[{"type":"paragraph","text":"Los patrones ayudan a resolver problemas recurrentes mediante soluciones probadas y comunicables."},{"type":"paragraph","text":"La escalabilidad requiere anticipar crecimiento en usuarios, tráfico y variabilidad de carga."},{"type":"code","text":"Strategy pattern\nObserver pattern\nService layer"},{"type":"exercise","title":"Ejercicio práctico","steps":["Estima dónde conviene un patrón facade.","Analiza si una solución requiere concurrencia.","Define un punto de extensión para cambiar la estrategia de negocio."]},{"type":"warning","title":"Atención","text":"La escalabilidad no se logra solo con más servidores; requiere también diseño modular y límites claros."}]'::jsonb,
        2,
        false
    )
    RETURNING id INTO v_lesson_2;

    INSERT INTO public.lessons (id, course_id, slug, title, objective, content, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'arquitectura-reactiva',
        'Arquitectura reactiva y calidad',
        'Balancear rendimiento, seguridad, observabilidad y mantenibilidad de sistemas productivos.',
        '[{"type":"paragraph","text":"La arquitectura reactiva pone atención a eventos, latencia y capacidad de respuesta frente a carga variable."},{"type":"paragraph","text":"La calidad del software depende de métricas, pruebas, trazabilidad y decisiones de diseño bien documentadas."},{"type":"code","text":"event-driven architecture\nqueue-based processing\nmonitoring with traces"},{"type":"exercise","title":"Ejercicio práctico","steps":["Define un flujo de eventos para un caso de negocio.","Identifica una métrica clave de calidad.","Diseña cómo responder a una caída de servicio."]},{"type":"tip","title":"Buena práctica","text":"La observabilidad convierte incidentes en decisiones de ingeniería basadas en evidencia."}]'::jsonb,
        3,
        false
    )
    RETURNING id INTO v_lesson_3;

    INSERT INTO public.lessons (id, course_id, slug, title, objective, content, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'evolucion-y-mantenimiento',
        'Evolución y mantenimiento',
        'Comprender cómo evolucionan sistemas largos en el tiempo y cómo mantener decisiones de arquitectura.',
        '[{"type":"paragraph","text":"Los sistemas de software evolucionan y, por tanto, su arquitectura debe dejar huecos para cambiar sin romper todo."},{"type":"paragraph","text":"Documentar decisiones importantes, límites, interfaces y deuda técnica ayuda a mantener la consistencia."},{"type":"code","text":"ADR\nBoundary context\nService interface"},{"type":"exercise","title":"Ejercicio práctico","steps":["Escribe una decisión clave en un ADR.","Define un límite de contexto para dos dominios.","Evalúa si la deuda técnica es aceptable o no."]},{"type":"warning","title":"Atención","text":"La falta de documentación suele hacer que la arquitectura se vuelva costosa de mantener."}]'::jsonb,
        4,
        false
    )
    RETURNING id INTO v_lesson_4;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        v_lesson_1,
        'act-arq-principios',
        'Actividad 1: Principios de arquitectura',
        'Elige la respuesta correcta.',
        'activity',
        70,
        1,
        false
    )
    RETURNING id INTO v_activity_1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué busca reducir el principio de bajo acoplamiento?', 1, 1)
    RETURNING id INTO v_q1_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q1_id, 'Las dependencias innecesarias entre módulos', 1), (v_q1_id, 'La cantidad de clases del sistema', 2), (v_q1_id, 'La velocidad de compilación', 3), (v_q1_id, 'El tamaño de la base de datos', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q1_id, qo.id, 'El bajo acoplamiento reduce dependencias frágiles y facilita cambios locales.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q1_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué representa la cohesión en un módulo?', 2, 1)
    RETURNING id INTO v_q2_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q2_id, 'Qué tan relacionadas están sus responsabilidades', 1), (v_q2_id, 'La cantidad de líneas del archivo', 2), (v_q2_id, 'La frecuencia de despliegues', 3), (v_q2_id, 'El número de interfaces abiertas', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q2_id, qo.id, 'La cohesión mide la afinidad entre funciones dentro de un mismo módulo.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q2_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué es encapsulamiento?', 3, 1)
    RETURNING id INTO v_q3_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q3_id, 'Ocultar detalles internos y exponer solo interfaces relevantes', 1), (v_q3_id, 'Duplicar lógica en cada módulo', 2), (v_q3_id, 'Hacer públicas todas las propiedades', 3), (v_q3_id, 'Eliminar tests del sistema', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q3_id, qo.id, 'Encapsulamiento protege la implementación y reduce efectos colaterales.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q3_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Cuál es una señal de diseño con alto acoplamiento?', 4, 1)
    RETURNING id INTO v_q4_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q4_id, 'Un módulo conoce demasiados detalles de otro módulo', 1), (v_q4_id, 'La interfaz del módulo es pequeña', 2), (v_q4_id, 'La lógica está centralizada', 3), (v_q4_id, 'Las pruebas son aisladas y automáticas', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q4_id, qo.id, 'Alto acoplamiento aparece cuando un módulo depende demasiado de implementaciones ajenas.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q4_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué busca la separación de responsabilidades?', 5, 1)
    RETURNING id INTO v_q5_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q5_id, 'Que cada componente tenga una razón clara para cambiar', 1), (v_q5_id, 'Que todo esté en una sola clase', 2), (v_q5_id, 'Que el sistema dependa de un solo framework', 3), (v_q5_id, 'Que los tests se eliminen', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q5_id, qo.id, 'La separación de responsabilidades reduce la mezcla de motivos de cambio.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q5_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        v_lesson_2,
        'act-arq-patrones',
        'Actividad 2: Patrones y escalabilidad',
        'Elige la respuesta correcta.',
        'activity',
        70,
        2,
        false
    )
    RETURNING id INTO v_activity_2;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué problema resuelve un patrón Strategy?', 1, 1)
    RETURNING id INTO v_q6_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q6_id, 'Permite intercambiar algoritmos o comportamientos sin cambiar el cliente', 1), (v_q6_id, 'Elimina la necesidad de interfaces', 2), (v_q6_id, 'Asegura que siempre haya un solo servicio', 3), (v_q6_id, 'Reduce todo a una sola clase', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q6_id, qo.id, 'Strategy encapsula alternativas de comportamiento reutilizable y intercambiable.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q6_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Cuál es una ventaja del patrón Observer?', 2, 1)
    RETURNING id INTO v_q7_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q7_id, 'Permite reaccionar automáticamente a cambios de estado', 1), (v_q7_id, 'Evita todo tipo de eventos', 2), (v_q7_id, 'Elimina la estrategia de negocio', 3), (v_q7_id, 'Convierte todo en código estático', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q7_id, qo.id, 'Observer facilita notificaciones y sincronización de dependencias.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q7_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué es escalabilidad horizontal?', 3, 1)
    RETURNING id INTO v_q8_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q8_id, 'Agregar más instancias de un servicio para distribuir carga', 1), (v_q8_id, 'Cambiar un lenguaje de programación', 2), (v_q8_id, 'Reducir la cantidad de servicios', 3), (v_q8_id, 'Eliminar la base de datos', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q8_id, qo.id, 'Escalabilidad horizontal añade replicas o nodos para manejar más carga.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q8_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué es un punto de extensión en arquitectura?', 4, 1)
    RETURNING id INTO v_q9_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q9_id, 'Un lugar donde el sistema puede cambiar sin reescribir el resto', 1), (v_q9_id, 'Un error de compilación permanente', 2), (v_q9_id, 'Un log que nunca se consulta', 3), (v_q9_id, 'Una regla de base de datos', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q9_id, qo.id, 'Los puntos de extensión permiten adaptar el sistema a cambios futuros con menor riesgo.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q9_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Por qué es útil un límite de contexto arquitectónico?', 5, 1)
    RETURNING id INTO v_q10_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q10_id, 'Porque define fronteras claras de dominio y dependencia', 1), (v_q10_id, 'Porque elimina todas las pruebas', 2), (v_q10_id, 'Porque hace que el sistema no escale', 3), (v_q10_id, 'Porque reemplaza la documentación técnica', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q10_id, qo.id, 'Los límites de contexto reducen ambigüedad entre dominios y responsabilidades.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q10_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        v_lesson_3,
        'act-arq-reactiva',
        'Actividad 3: Arquitectura reactiva y calidad',
        'Elige la respuesta correcta.',
        'activity',
        70,
        3,
        false
    )
    RETURNING id INTO v_activity_3;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué caracteriza a una arquitectura reactiva?', 1, 1)
    RETURNING id INTO v_q11_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q11_id, 'Se adapta a eventos y cargas variables con bajo bloqueo', 1), (v_q11_id, 'No tiene carga ni errores', 2), (v_q11_id, 'No usa servicios ni eventos', 3), (v_q11_id, 'Se diseña sin métricas ni trazas', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q11_id, qo.id, 'La arquitectura reactiva prioriza respuesta ante eventos y alta disponibilidad.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q11_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué es observabilidad?', 2, 1)
    RETURNING id INTO v_q12_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q12_id, 'La capacidad de comprender el estado del sistema a partir de métricas, logs y trazas', 1), (v_q12_id, 'La apariencia visual del dashboard', 2), (v_q12_id, 'Un tipo de despliegue estático', 3), (v_q12_id, 'La cantidad de herramientas instaladas', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q12_id, qo.id, 'Observabilidad permite medir, diagnosticar y responder ante problemas reales.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q12_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué es un sink de métricas?', 3, 1)
    RETURNING id INTO v_q13_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q13_id, 'Un destino donde se almacenan o visualizan métricas', 1), (v_q13_id, 'Un servicio que elimina logs', 2), (v_q13_id, 'Un tipo de controlador web', 3), (v_q13_id, 'Una política de seguridad', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q13_id, qo.id, 'Los sinks permiten persistir o visualizar métricas de forma centralizada.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q13_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Cuál es un beneficio de una traza distribuida?', 4, 1)
    RETURNING id INTO v_q14_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q14_id, 'Permite seguir una petición a través de varios servicios', 1), (v_q14_id, 'Evita la necesidad de logs', 2), (v_q14_id, 'Cambia la arquitectura por completo', 3), (v_q14_id, 'Reemplaza la base de datos', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q14_id, qo.id, 'Las trazas distribuidas ayudan a aislar cuellos de botella y fallos en servicios.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q14_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué es la calidad interna de una arquitectura?', 5, 1)
    RETURNING id INTO v_q15_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q15_id, 'La capacidad del sistema de sostener cambios y evolución con seguridad', 1), (v_q15_id, 'Solo la apariencia visual del sistema', 2), (v_q15_id, 'La velocidad en la carga del navegador', 3), (v_q15_id, 'El número de usuarios simultáneos', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q15_id, qo.id, 'La calidad interna refleja la sostenibilidad técnica del sistema.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q15_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        v_lesson_4,
        'act-arq-mantenimiento',
        'Actividad 4: Evolución y mantenimiento',
        'Elige la respuesta correcta.',
        'activity',
        70,
        4,
        false
    )
    RETURNING id INTO v_activity_4;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué es un ADR?', 1, 1)
    RETURNING id INTO v_q16_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q16_id, 'Un registro de decisiones de arquitectura', 1), (v_q16_id, 'Una interfaz de despliegue', 2), (v_q16_id, 'Una política de acceso', 3), (v_q16_id, 'Un patrón de base de datos', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q16_id, qo.id, 'ADR documenta decisiones clave y su contexto para futuras evoluciones.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q16_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Por qué documentar deuda técnica es importante?', 2, 1)
    RETURNING id INTO v_q17_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q17_id, 'Para que el equipo pueda priorizar y reducir problemas futuros', 1), (v_q17_id, 'Porque reemplaza tests automáticos', 2), (v_q17_id, 'Porque elimina la necesidad de arquitectura', 3), (v_q17_id, 'Porque no requiere mantenimiento', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q17_id, qo.id, 'Documentar deuda técnica ayuda a gestionar riesgos y priorizar refactorización.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q17_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué es un contrato de interfaz?', 3, 1)
    RETURNING id INTO v_q18_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q18_id, 'La definición de entrada, salida y comportamiento esperado de un módulo', 1), (v_q18_id, 'La configuración de una base de datos', 2), (v_q18_id, 'La apariencia de una vista web', 3), (v_q18_id, 'La política de respaldo del equipo', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q18_id, qo.id, 'El contrato define cómo interactuar con un componente sin entrar en detalles internos.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q18_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué beneficio aporta un monitoreo eficaz?', 4, 1)
    RETURNING id INTO v_q19_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q19_id, 'Permite detectar problemas antes de que afecten a clientes', 1), (v_q19_id, 'Elimina la necesidad de tests', 2), (v_q19_id, 'Impide cualquier cambio futuro', 3), (v_q19_id, 'Hace que la arquitectura sea más rígida', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q19_id, qo.id, 'Un monitoreo correcto anticipa fallos y mejora tiempos de respuesta.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q19_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué es una arquitectura evolutiva?', 5, 1)
    RETURNING id INTO v_q20_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q20_id, 'Una arquitectura preparada para incorporar cambios sin grandes reescrituras', 1), (v_q20_id, 'Una solución fija para siempre', 2), (v_q20_id, 'Un diseño sin pruebas ni documentación', 3), (v_q20_id, 'Un código monolítico sin módulos', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q20_id, qo.id, 'La arquitectura evolutiva acepta cambios con menor fricción y menor riesgo.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q20_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        NULL,
        'exam-arquitectura-software',
        'Examen final: Arquitectura de software',
        'Selecciona la respuesta correcta para cada pregunta.',
        'exam',
        70,
        5,
        false
    )
    RETURNING id INTO v_exam_id;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué efecto tiene un buen diseño de módulos sobre un sistema?', 1, 1)
    RETURNING id INTO v_q21_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q21_id, 'Reduce el impacto de cambios y facilita mantenimiento', 1), (v_q21_id, 'Impide cualquier evolución', 2), (v_q21_id, 'Elimina todas las dependencias', 3), (v_q21_id, 'Reemplaza la planificación de producto', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q21_id, qo.id, 'Un buen diseño modular minimiza impactos y mejora mantenibilidad.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q21_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué es un servicio en una arquitectura orientada a servicios?', 2, 1)
    RETURNING id INTO v_q22_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q22_id, 'Un componente autónomo que expone capacidades a través de interfaces', 1), (v_q22_id, 'Un archivo de configuración sin lógica', 2), (v_q22_id, 'Una librería sin contratos', 3), (v_q22_id, 'Un tipo de base de datos', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q22_id, qo.id, 'Los servicios encapsulan capacidades y se integran mediante interfaces bien definidas.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q22_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué se busca con la descomposición por dominio?', 3, 1)
    RETURNING id INTO v_q23_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q23_id, 'Separar áreas de negocio para gestionar complejidad', 1), (v_q23_id, 'Reducir todos los dominios a uno', 2), (v_q23_id, 'Eliminar todas las interfaces', 3), (v_q23_id, 'Unificar lenguaje y base de datos sin criterio', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q23_id, qo.id, 'La descomposición por dominio ayuda a gestionar complejidad y cambios por negocio.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q23_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué caracteriza a una arquitectura resistente?', 4, 1)
    RETURNING id INTO v_q24_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q24_id, 'Se prepara para fallos y recupera presión sin perder funcionalidad crítica', 1), (v_q24_id, 'No permite escalabilidad', 2), (v_q24_id, 'No requiere pruebas', 3), (v_q24_id, 'Es siempre monolítica', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q24_id, qo.id, 'La resistencia se construye anticipando fallos y recuperando servicios gradualmente.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q24_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué ventaja tiene un diseño con APIs públicas bien definidas?', 5, 1)
    RETURNING id INTO v_q25_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q25_id, 'Permite cambiar la implementación sin romper consumidores', 1), (v_q25_id, 'Elimina toda necesidad de tests', 2), (v_q25_id, 'Hace que todos los componentes sean iguales', 3), (v_q25_id, 'Reduce el papel de la documentación', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q25_id, qo.id, 'LOS contratos públicos mantienen compatibilidad y separan implementación de uso.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q25_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué es una arquitectura con estado compartido?', 6, 1)
    RETURNING id INTO v_q26_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q26_id, 'Una solución donde varios nodos necesitan el mismo contexto o sesión', 1), (v_q26_id, 'Una arquitectura sin almacenamiento', 2), (v_q26_id, 'Un sistema sin servicios', 3), (v_q26_id, 'Un patrón exclusivo para monolitos', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q26_id, qo.id, 'Estado compartido requiere coordinación y puede aumentar complejidad operacional.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q26_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué es una frontera de servicio?', 7, 1)
    RETURNING id INTO v_q27_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q27_id, 'Un límite claro entre componentes con responsabilidad distinta', 1), (v_q27_id, 'Una regla de estilo visual', 2), (v_q27_id, 'Una política de bloqueo de puertos', 3), (v_q27_id, 'Un recurso de memoria compartida', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q27_id, qo.id, 'Las fronteras de servicio clarifican dónde definir límites y dependencias.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q27_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué busca medir una métrica de latencia?', 8, 1)
    RETURNING id INTO v_q28_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q28_id, 'El tiempo que tarda una operación en responder', 1), (v_q28_id, 'La complejidad de un dato en memoria', 2), (v_q28_id, 'La cantidad de interfaces del sistema', 3), (v_q28_id, 'La longitud del código fuente', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q28_id, qo.id, 'La latencia refleja la demora de una operación y es crucial para percepción de calidad.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q28_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué es la arquitectura por capas?', 9, 1)
    RETURNING id INTO v_q29_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q29_id, 'Una organización por responsabilidades como presentación, dominio e infraestructura', 1), (v_q29_id, 'Un único módulo sin separación', 2), (v_q29_id, 'Un conjunto de rutas de navegación', 3), (v_q29_id, 'Un patrón exclusivo de bases de datos', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q29_id, qo.id, 'Las capas ayudan a separar responsabilidades y simplificar evolución del sistema.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q29_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Cuál es un riesgo de no controlar la deuda técnica?', 10, 1)
    RETURNING id INTO v_q30_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q30_id, 'Aumenta costo, fragilidad y tiempo de entrega', 1), (v_q30_id, 'Disminuye la necesidad de documentación', 2), (v_q30_id, 'Elimina todos los errores de producción', 3), (v_q30_id, 'Hace que la arquitectura no tenga capas', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q30_id, qo.id, 'La deuda técnica acumulada afecta sostenibilidad, velocidad y calidad.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q30_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué aporta una política clara de cambio de arquitectura?', 11, 1)
    RETURNING id INTO v_q31_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q31_id, 'Reduce ambigüedad y ayuda a decidir cuándo aceptar o rechazar cambios', 1), (v_q31_id, 'Hace que el sistema deje de cambiar', 2), (v_q31_id, 'Elimina dependencias de terceros', 3), (v_q31_id, 'Asegura que no exista documentación', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q31_id, qo.id, 'Las políticas de cambio permiten evaluar riesgos y decidir con criterio técnico.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q31_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué favorece un equipo que documenta decisiones de arquitectura?', 12, 1)
    RETURNING id INTO v_q32_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q32_id, 'Consistencia, aprendizaje y menos riesgo de decisiones contradictorias', 1), (v_q32_id, 'La eliminación de pruebas', 2), (v_q32_id, 'La reducción de equipos de software', 3), (v_q32_id, 'La supresión del dominio de negocio', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q32_id, qo.id, 'Documentar decisiones mejora continuidad, comprensión y coordinación del equipo.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q32_id AND qo.position = 1;

END $$;

COMMIT;
