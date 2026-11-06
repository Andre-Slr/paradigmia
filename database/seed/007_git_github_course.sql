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
        WHERE slug = 'git-github-principiante'
    ) THEN
        RAISE EXCEPTION 'El slug git-github-principiante ya existe en public.courses.';
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
        'git-github-principiante',
        'Git y GitHub para principiantes',
        'Curso introductorio para trabajar con control de versiones, ramas y repositorios remotos.',
        'Git',
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
        'introduccion-a-git',
        'Introducción a Git',
        'Entender cómo Git registra cambios y mantiene un historial del proyecto.',
        '[{"type":"paragraph","text":"Git es un sistema de control de versiones que guarda snapshots del proyecto a lo largo del tiempo."},{"type":"paragraph","text":"Esto permite recuperar versiones anteriores, comparar cambios y trabajar de forma segura en equipo."},{"type":"code","text":"git init\ngit status\ngit add .\ngit commit -m \"Primer commit\""},{"type":"exercise","title":"Ejercicio práctico","steps":["Inicializa un repositorio.","Revisa su estado.","Haz un primer commit con un mensaje claro." ]},{"type":"tip","title":"Consejo","text":"Los mensajes de commit claros facilitan entender qué cambió y por qué."}]'::jsonb,
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
        'ramas-y-commits',
        'Ramas y commits',
        'Aprender a bifurcar el trabajo y registrar cambios de forma ordenada.',
        '[{"type":"paragraph","text":"Las ramas permiten trabajar en líneas independientes sin mezclar cambios de otros desarrolladores."},{"type":"paragraph","text":"Los commits actúan como instantáneas del proyecto con un historial legible y revisable."},{"type":"code","text":"git checkout -b feat/nueva-seccion\ngit commit -m \"Agrega nueva sección\""},{"type":"exercise","title":"Ejercicio práctico","steps":["Crea una rama de trabajo.","Haz un cambio pequeño.","Genera un commit con un mensaje claro." ]},{"type":"warning","title":"Atención","text":"Mantener ramas separadas ayuda a prevenir conflictos innecesarios y facilita despliegues seguros."}]'::jsonb,
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
        'sincronizacion-github',
        'Sincronización con GitHub',
        'Conectar el repositorio local con un remoto para compartir trabajo.',
        '[{"type":"paragraph","text":"GitHub aloja repositorios remotos y permite colaborar con otros desarrolladores desde cualquier equipo."},{"type":"paragraph","text":"git push y git pull sincronizan el historial local con el historial remoto."},{"type":"code","text":"git remote add origin <url>\ngit push -u origin main"},{"type":"exercise","title":"Ejercicio práctico","steps":["Configura un remoto.","Conecta el repositorio local.","Sube el proyecto a GitHub para revisarlo." ]},{"type":"tip","title":"Buena práctica","text":"Verifica siempre la rama actual antes de hacer push o pull para evitar errores de sincronización."}]'::jsonb,
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
        'colaboracion-y-fusion',
        'Colaboración y fusión',
        'Resolver conflictos y unir cambios de varias personas en un mismo proyecto.',
        '[{"type":"paragraph","text":"La colaboración en equipo requiere revisión de cambios, reconciliación de ramas y resolución de conflictos."},{"type":"paragraph","text":"Cuando dos personas tocan el mismo punto del proyecto, es necesario decidir qué versión conservar y fusionarla correctamente."},{"type":"code","text":"git pull origin main\ngit merge feature/nueva-seccion"},{"type":"exercise","title":"Ejercicio práctico","steps":["Actualiza tu rama con el último estado remoto.","Fusiona cambios de otra rama.","Resuelve un conflicto de forma consciente." ]},{"type":"warning","title":"Atención","text":"Un conflicto no indica un error fatal: normalmente implica decidir entre dos cambios válidos y combinar ambos con cuidado."}]'::jsonb,
        4,
        false
    )
    RETURNING id INTO v_lesson_4;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (gen_random_uuid(), v_course_id, v_lesson_1, 'actividad-git-introduccion', 'Actividad 1: Introducción a Git', 'Selecciona la opción correcta.', 'activity', 70, 1, false)
    RETURNING id INTO v_activity_1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_1, '¿Qué permite Git?', 1, 1) RETURNING id INTO v_q1_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q1_id, 'Control de versiones', 1), (v_q1_id, 'Diseño gráfico', 2), (v_q1_id, 'Compilar CSS', 3), (v_q1_id, 'Renderizar HTML', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q1_id, qo.id, 'Git guarda y controla versiones del proyecto.' FROM public.question_options qo WHERE qo.question_id = v_q1_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_1, '¿Qué es un commit?', 2, 1) RETURNING id INTO v_q2_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q2_id, 'Instantánea del proyecto con mensaje', 1), (v_q2_id, 'Un archivo remoto', 2), (v_q2_id, 'Una carpeta temporal', 3), (v_q2_id, 'Un script de compilación', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q2_id, qo.id, 'Un commit guarda un punto del historial del proyecto.' FROM public.question_options qo WHERE qo.question_id = v_q2_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_1, '¿Qué comando revisa el estado del repositorio?', 3, 1) RETURNING id INTO v_q3_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q3_id, 'git status', 1), (v_q3_id, 'git push', 2), (v_q3_id, 'git branch', 3), (v_q3_id, 'git log', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q3_id, qo.id, 'git status muestra archivos modificados y pendientes.' FROM public.question_options qo WHERE qo.question_id = v_q3_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_1, '¿Qué hace git add?', 4, 1) RETURNING id INTO v_q4_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q4_id, 'Prepara cambios para commit', 1), (v_q4_id, 'Elimina el repositorio', 2), (v_q4_id, 'Sube archivos al remoto', 3), (v_q4_id, 'Muestra el historial', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q4_id, qo.id, 'git add añade cambios al índice para que luego se confirmen.' FROM public.question_options qo WHERE qo.question_id = v_q4_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_1, '¿Qué almacena el repositorio?', 5, 1) RETURNING id INTO v_q5_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q5_id, 'Historial y archivos del proyecto', 1), (v_q5_id, 'Solo comentarios', 2), (v_q5_id, 'Tipos de datos', 3), (v_q5_id, 'Conexiones de red', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q5_id, qo.id, 'El repositorio conserva el historial y todos los archivos del proyecto.' FROM public.question_options qo WHERE qo.question_id = v_q5_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (gen_random_uuid(), v_course_id, v_lesson_2, 'actividad-git-ramas', 'Actividad 2: Ramas y commits', 'Elige la mejor respuesta.', 'activity', 70, 2, false)
    RETURNING id INTO v_activity_2;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_2, '¿Qué es una rama?', 1, 1) RETURNING id INTO v_q6_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q6_id, 'Línea independiente de trabajo', 1), (v_q6_id, 'Un archivo de configuración', 2), (v_q6_id, 'Un comando de red', 3), (v_q6_id, 'Un tipo de commit', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q6_id, qo.id, 'Las ramas permiten dividir el trabajo en líneas independientes.' FROM public.question_options qo WHERE qo.question_id = v_q6_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_2, '¿Qué comando crea una rama?', 2, 1) RETURNING id INTO v_q7_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q7_id, 'git checkout -b nombre', 1), (v_q7_id, 'git add nombre', 2), (v_q7_id, 'git push nombre', 3), (v_q7_id, 'git init nombre', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q7_id, qo.id, 'git checkout -b crea y cambia a la nueva rama.' FROM public.question_options qo WHERE qo.question_id = v_q7_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_2, '¿Qué muestra git log?', 3, 1) RETURNING id INTO v_q8_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q8_id, 'Historial de commits', 1), (v_q8_id, 'Archivos modificados', 2), (v_q8_id, 'Configuración local', 3), (v_q8_id, 'Estado de trabajo', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q8_id, qo.id, 'git log presenta el historial del repositorio.' FROM public.question_options qo WHERE qo.question_id = v_q8_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_2, '¿Qué hace git merge?', 4, 1) RETURNING id INTO v_q9_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q9_id, 'Integra cambios de una rama', 1), (v_q9_id, 'Crea un archivo nuevo', 2), (v_q9_id, 'Borra una rama', 3), (v_q9_id, 'Sincroniza con red', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q9_id, qo.id, 'git merge combina el contenido de una rama en otra.' FROM public.question_options qo WHERE qo.question_id = v_q9_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_2, '¿Qué hace un buen mensaje de commit?', 5, 1) RETURNING id INTO v_q10_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q10_id, 'Describe claramente el cambio', 1), (v_q10_id, 'Oculta información', 2), (v_q10_id, 'Cambia el sistema', 3), (v_q10_id, 'No tiene efecto', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q10_id, qo.id, 'El mensaje del commit debe reflejar el cambio realizado.' FROM public.question_options qo WHERE qo.question_id = v_q10_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (gen_random_uuid(), v_course_id, v_lesson_3, 'actividad-git-github', 'Actividad 3: GitHub', 'Selecciona la opción correcta.', 'activity', 70, 3, false)
    RETURNING id INTO v_activity_3;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_3, '¿Qué es GitHub?', 1, 1) RETURNING id INTO v_q11_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q11_id, 'Plataforma para repositorios remotos', 1), (v_q11_id, 'Un compilador de Python', 2), (v_q11_id, 'Un navegador', 3), (v_q11_id, 'Un sistema operativo', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q11_id, qo.id, 'GitHub aloja repositorios Git para compartir y colaborar.' FROM public.question_options qo WHERE qo.question_id = v_q11_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_3, '¿Qué comando conecta un repositorio local a GitHub?', 2, 1) RETURNING id INTO v_q12_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q12_id, 'git remote add origin <url>', 1), (v_q12_id, 'git add origin', 2), (v_q12_id, 'git merge origin', 3), (v_q12_id, 'git push origin', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q12_id, qo.id, 'git remote add define el origen remoto del repositorio.' FROM public.question_options qo WHERE qo.question_id = v_q12_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_3, '¿Qué hace git push?', 3, 1) RETURNING id INTO v_q13_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q13_id, 'Envía cambios al remoto', 1), (v_q13_id, 'Descarga cambios', 2), (v_q13_id, 'Crea ramas', 3), (v_q13_id, 'Elimina commits', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q13_id, qo.id, 'git push sincroniza el repositorio local con el remoto.' FROM public.question_options qo WHERE qo.question_id = v_q13_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_3, '¿Qué hace git clone?', 4, 1) RETURNING id INTO v_q14_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q14_id, 'Copia un repositorio remoto', 1), (v_q14_id, 'Crea una nueva rama', 2), (v_q14_id, 'Descarta commits', 3), (v_q14_id, 'Guarda un archivo', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q14_id, qo.id, 'git clone crea una copia local del repositorio remoto.' FROM public.question_options qo WHERE qo.question_id = v_q14_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_3, '¿Qué trae cambios del remoto?', 5, 1) RETURNING id INTO v_q15_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q15_id, 'git pull', 1), (v_q15_id, 'git add', 2), (v_q15_id, 'git log', 3), (v_q15_id, 'git branch', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q15_id, qo.id, 'git pull obtiene cambios del repositorio remoto.' FROM public.question_options qo WHERE qo.question_id = v_q15_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (gen_random_uuid(), v_course_id, v_lesson_4, 'actividad-git-colaboracion', 'Actividad 4: Colaboración', 'Elige la respuesta correcta.', 'activity', 70, 4, false)
    RETURNING id INTO v_activity_4;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_4, '¿Qué son conflictos de merge?', 1, 1) RETURNING id INTO v_q16_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q16_id, 'Cambios incompatibles en el mismo punto', 1), (v_q16_id, 'Errores del navegador', 2), (v_q16_id, 'Archivos vacíos', 3), (v_q16_id, 'Problemas de red', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q16_id, qo.id, 'Un conflicto ocurre cuando dos ramas modifican lo mismo.' FROM public.question_options qo WHERE qo.question_id = v_q16_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_4, '¿Qué ayuda a resolver conflictos?', 2, 1) RETURNING id INTO v_q17_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q17_id, 'Revisar y combinar cambios manualmente', 1), (v_q17_id, 'Eliminar ambos archivos', 2), (v_q17_id, 'Cambiar el sistema', 3), (v_q17_id, 'Borrar el historial', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q17_id, qo.id, 'Resolver conflictos requiere decidir la versión final correcta.' FROM public.question_options qo WHERE qo.question_id = v_q17_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_4, '¿Qué se revisa antes de fusionar?', 3, 1) RETURNING id INTO v_q18_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q18_id, 'Los cambios y el código', 1), (v_q18_id, 'El tamaño del disco', 2), (v_q18_id, 'La fecha del sistema', 3), (v_q18_id, 'La versión del SO', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q18_id, qo.id, 'La revisión valida que el cambio sea correcto antes de fusionarlo.' FROM public.question_options qo WHERE qo.question_id = v_q18_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_4, '¿Qué es un pull request?', 4, 1) RETURNING id INTO v_q19_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q19_id, 'Solicitud para revisar y fusionar cambios', 1), (v_q19_id, 'Comando Git', 2), (v_q19_id, 'Tipo de rama', 3), (v_q19_id, 'Archivo temporal', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q19_id, qo.id, 'Un pull request permite revisión antes de fusionar una rama.' FROM public.question_options qo WHERE qo.question_id = v_q19_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_4, '¿Qué facilita la colaboración?', 5, 1) RETURNING id INTO v_q20_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q20_id, 'Ramas, commits y revisión de cambios', 1), (v_q20_id, 'Trabajar sin historial', 2), (v_q20_id, 'Eliminar versiones', 3), (v_q20_id, 'Usar un solo archivo', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q20_id, qo.id, 'Ramas, commits y revisión permiten colaborar sin perder control del trabajo.' FROM public.question_options qo WHERE qo.question_id = v_q20_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (gen_random_uuid(), v_course_id, NULL, 'examen-final-git', 'Examen final: Git y GitHub', 'Selecciona la respuesta correcta.', 'exam', 70, 5, false)
    RETURNING id INTO v_exam_id;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué comando inicializa un repositorio?', 1, 1) RETURNING id INTO v_q21_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q21_id, 'git init', 1), (v_q21_id, 'git clone', 2), (v_q21_id, 'git add', 3), (v_q21_id, 'git pull', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q21_id, qo.id, 'git init crea un repositorio local.' FROM public.question_options qo WHERE qo.question_id = v_q21_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué comando muestra el estado?', 2, 1) RETURNING id INTO v_q22_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q22_id, 'git status', 1), (v_q22_id, 'git merge', 2), (v_q22_id, 'git log', 3), (v_q22_id, 'git init', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q22_id, qo.id, 'git status informa los cambios y la rama actual.' FROM public.question_options qo WHERE qo.question_id = v_q22_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué crea una instantánea del estado?', 3, 1) RETURNING id INTO v_q23_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q23_id, 'commit', 1), (v_q23_id, 'branch', 2), (v_q23_id, 'tag', 3), (v_q23_id, 'remote', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q23_id, qo.id, 'Un commit guarda una instantánea del proyecto.' FROM public.question_options qo WHERE qo.question_id = v_q23_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué comando prepara archivos para commit?', 4, 1) RETURNING id INTO v_q24_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q24_id, 'git add', 1), (v_q24_id, 'git pull', 2), (v_q24_id, 'git fetch', 3), (v_q24_id, 'git clone', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q24_id, qo.id, 'git add prepara cambios para ser confirmados.' FROM public.question_options qo WHERE qo.question_id = v_q24_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué permite trabajar sin mezclar código?', 5, 1) RETURNING id INTO v_q25_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q25_id, 'ramas', 1), (v_q25_id, 'comentarios', 2), (v_q25_id, 'archivos vacíos', 3), (v_q25_id, 'scripts', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q25_id, qo.id, 'Las ramas permiten líneas de trabajo paralelas.' FROM public.question_options qo WHERE qo.question_id = v_q25_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué comando crea y cambia a una rama?', 6, 1) RETURNING id INTO v_q26_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q26_id, 'git checkout -b nombre', 1), (v_q26_id, 'git add nombre', 2), (v_q26_id, 'git clone nombre', 3), (v_q26_id, 'git status nombre', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q26_id, qo.id, 'checkout -b crea la rama y te posiciona en ella.' FROM public.question_options qo WHERE qo.question_id = v_q26_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace git push?', 7, 1) RETURNING id INTO v_q27_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q27_id, 'Envía cambios al remoto', 1), (v_q27_id, 'Copia un repositorio', 2), (v_q27_id, 'Borra commits', 3), (v_q27_id, 'Actualiza la rama', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q27_id, qo.id, 'git push sincroniza el trabajo local con el servidor remoto.' FROM public.question_options qo WHERE qo.question_id = v_q27_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace git pull?', 8, 1) RETURNING id INTO v_q28_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q28_id, 'Trae cambios del remoto', 1), (v_q28_id, 'Sube cambios', 2), (v_q28_id, 'Crea una rama', 3), (v_q28_id, 'Borra archivos', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q28_id, qo.id, 'git pull obtiene y fusiona cambios del repositorio remoto.' FROM public.question_options qo WHERE qo.question_id = v_q28_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué es GitHub?', 9, 1) RETURNING id INTO v_q29_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q29_id, 'Plataforma para alojar repositorios', 1), (v_q29_id, 'Librería de JavaScript', 2), (v_q29_id, 'Servidor web', 3), (v_q29_id, 'Editor gráfico', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q29_id, qo.id, 'GitHub aloja repositorios y permite colaborar con otros usuarios.' FROM public.question_options qo WHERE qo.question_id = v_q29_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué ocurre en un conflicto?', 10, 1) RETURNING id INTO v_q30_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q30_id, 'Dos ramas modifican la misma línea', 1), (v_q30_id, 'Se borra el historial', 2), (v_q30_id, 'Se crea una nueva tabla', 3), (v_q30_id, 'Se elimina el repositorio', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q30_id, qo.id, 'El conflicto aparece cuando dos ramas tocan el mismo contenido.' FROM public.question_options qo WHERE qo.question_id = v_q30_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué integra cambios de una rama?', 11, 1) RETURNING id INTO v_q31_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q31_id, 'git merge', 1), (v_q31_id, 'git clone', 2), (v_q31_id, 'git add', 3), (v_q31_id, 'git init', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q31_id, qo.id, 'git merge incorpora los cambios de una rama a otra.' FROM public.question_options qo WHERE qo.question_id = v_q31_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué ayuda a entender un cambio de forma clara?', 12, 1) RETURNING id INTO v_q32_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q32_id, 'Mensaje descriptivo de commit', 1), (v_q32_id, 'Archivo aleatorio', 2), (v_q32_id, 'Comando git pull', 3), (v_q32_id, 'Un comentario sin contexto', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q32_id, qo.id, 'Un buen mensaje de commit comunica el propósito del cambio.' FROM public.question_options qo WHERE qo.question_id = v_q32_id AND qo.position = 1;
END $$;

COMMIT;
