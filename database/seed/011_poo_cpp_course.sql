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
        WHERE slug = 'poo-cpp'
    ) THEN
        RAISE EXCEPTION 'El slug poo-cpp ya existe en public.courses.';
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
        'poo-cpp',
        'POO con C++',
        'Curso intermedio para aprender clases, encapsulación, herencia y polimorfismo en C++.',
        'C++',
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
        'clases-y-objetos',
        'Clases y objetos',
        'Modelar entidades con datos y comportamiento.',
        '[{"type": "paragraph", "text": "Una clase define un tipo de dato con atributos y métodos."}, {"type": "paragraph", "text": "Un objeto es una instancia concreta de esa clase."}, {"type": "code", "text": "class Persona { public: std::string nombre; void saludar() { std::cout << ''Hola''; } };"}, {"type": "exercise", "title": "Ejercicio práctico", "steps": ["Define una clase Persona.", "Agrega un atributo nombre.", "Instancia un objeto y llama a saludar()."]}, {"type": "tip", "title": "Consejo", "text": "Las clases agrupan conceptos relacionados para evitar lógica dispersa."}]'::jsonb,
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
        'encapsulamiento',
        'Encapsulamiento',
        'Restringir acceso y proteger el estado interno.',
        '[{"type": "paragraph", "text": "private y public permiten controlar qué parte del código puede acceder a cada atributo."}, {"type": "paragraph", "text": "Esto mejora la consistencia del modelo y reduce errores."}, {"type": "code", "text": "class Cuenta { private: double saldo; public: void depositar(double v) { saldo += v; } };"}, {"type": "exercise", "title": "Ejercicio práctico", "steps": ["Crea una clase Cuenta.", "Guarda saldo en private.", "Usa un método público para modificarlo."]}, {"type": "warning", "title": "Atención", "text": "Los datos internos deben protegerse para mantener invariantes."}]'::jsonb,
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
        'herencia-y-polimorfismo',
        'Herencia y polimorfismo',
        'Reutilizar lógica y adaptar comportamientos.',
        '[{"type": "paragraph", "text": "La herencia crea clases especializadas a partir de una base."}, {"type": "paragraph", "text": "El polimorfismo permite manejar distintos tipos mediante una interfaz común."}, {"type": "code", "text": "class Animal { public: virtual void hablar() { std::cout << ''...''; } };"}, {"type": "exercise", "title": "Ejercicio práctico", "steps": ["Crea una clase Animal.", "Define Perro y Gato.", "Llama a hablar() desde un puntero base."]}, {"type": "tip", "title": "Consejo", "text": "La herencia reduce duplicación y el polimorfismo mejora extensibilidad."}]'::jsonb,
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
        'plantillas-y-sobrecarga',
        'Plantillas y sobrecarga',
        'Crear código flexible y reutilizable.',
        '[{"type": "paragraph", "text": "La sobrecarga permite usar el mismo nombre con distintas firmas."}, {"type": "paragraph", "text": "Las plantillas adaptan una lógica a distintos tipos sin duplicar código."}, {"type": "code", "text": "template <typename T> T maximo(T a, T b) { return a > b ? a : b; }"}, {"type": "exercise", "title": "Ejercicio práctico", "steps": ["Define una plantilla maximo.", "Prueba con int y double.", "Verifica que devuelve el mayor valor."]}, {"type": "warning", "title": "Atención", "text": "La flexibilidad debe ir acompañada de claridad para evitar ambigüedades."}]'::jsonb,
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
        'act-cpp-clases',
        'Actividad 1: Clases y objetos',
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
        '¿Qué es una clase en C++?',
        1,
        1
    )
    RETURNING id INTO v_q1_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q1_id, 'Una plantilla para crear objetos', 1), (v_q1_id, 'Un tipo primitivo', 2), (v_q1_id, 'Una librería estática', 3), (v_q1_id, 'Un archivo de cabecera', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q1_id, qo.id, 'La clase define la estructura y el comportamiento común.'
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
        '¿Qué es un objeto?',
        2,
        1
    )
    RETURNING id INTO v_q2_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q2_id, 'Una instancia concreta de una clase', 1), (v_q2_id, 'Una función auxiliar', 2), (v_q2_id, 'Un namespace', 3), (v_q2_id, 'Una variable global', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q2_id, qo.id, 'Un objeto es una ejemplificación concreta de una clase.'
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
        '¿Qué representan los atributos?',
        3,
        1
    )
    RETURNING id INTO v_q3_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q3_id, 'Datos o estado del objeto', 1), (v_q3_id, 'Solo acciones de consola', 2), (v_q3_id, 'Funciones globales', 3), (v_q3_id, 'Valores constantes no usados', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q3_id, qo.id, 'Los atributos guardan estado.'
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
        '¿Qué representa un método?',
        4,
        1
    )
    RETURNING id INTO v_q4_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q4_id, 'Comportamiento del objeto', 1), (v_q4_id, 'Un dato simple', 2), (v_q4_id, 'Un archivo de texto', 3), (v_q4_id, 'Una macro', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q4_id, qo.id, 'Los métodos realizan acciones del objeto.'
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
        '¿Qué permite la encapsulación?',
        5,
        1
    )
    RETURNING id INTO v_q5_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q5_id, 'Controlar acceso a los datos internos', 1), (v_q5_id, 'Eliminar clases', 2), (v_q5_id, 'Cambiar compilador', 3), (v_q5_id, 'Reducir archivos', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q5_id, qo.id, 'La encapsulación protege el estado interno.'
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
        'act-cpp-encapsulamiento',
        'Actividad 2: Encapsulamiento',
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
        '¿Qué significa private?',
        1,
        1
    )
    RETURNING id INTO v_q6_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q6_id, 'Los miembros solo son accesibles dentro de la clase', 1), (v_q6_id, 'Todos pueden modificarlos', 2), (v_q6_id, 'Se eliminan al ejecutar', 3), (v_q6_id, 'Son constantes', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q6_id, qo.id, 'private restringe acceso interno.'
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
        '¿Qué significa public?',
        2,
        1
    )
    RETURNING id INTO v_q7_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q7_id, 'Los miembros son accesibles desde fuera', 1), (v_q7_id, 'Los miembros son ocultos', 2), (v_q7_id, 'Los miembros no existen', 3), (v_q7_id, 'Los miembros son temporales', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q7_id, qo.id, 'public expone la interfaz.'
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
        '¿Qué ventaja tiene un getter?',
        3,
        1
    )
    RETURNING id INTO v_q8_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q8_id, 'Permite leer un valor sin exponer el atributo directamente', 1), (v_q8_id, 'Duplica código', 2), (v_q8_id, 'Borra métodos', 3), (v_q8_id, 'Deshabilita compilación', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q8_id, qo.id, 'Getter ofrece lectura controlada.'
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
        '¿Qué es una invariante?',
        4,
        1
    )
    RETURNING id INTO v_q9_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q9_id, 'Condición que debe cumplirse siempre', 1), (v_q9_id, 'Un archivo de cabecera', 2), (v_q9_id, 'Un nombre de variable', 3), (v_q9_id, 'Un puntero nulo', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q9_id, qo.id, 'Las invariantes mantienen consistencia.'
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
        '¿Por qué se encapsulan datos?',
        5,
        1
    )
    RETURNING id INTO v_q10_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q10_id, 'Para proteger la consistencia y reducir errores', 1), (v_q10_id, 'Para aumentar acoplamiento', 2), (v_q10_id, 'Para cambiar el lenguaje', 3), (v_q10_id, 'Para eliminar clases', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q10_id, qo.id, 'Encapsular mejora robustez y mantenibilidad.'
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
        'act-cpp-herencia',
        'Actividad 3: Herencia y polimorfismo',
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
        '¿Qué permite la herencia?',
        1,
        1
    )
    RETURNING id INTO v_q11_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q11_id, 'Crear clases especializadas a partir de una base', 1), (v_q11_id, 'Modificar un compilador', 2), (v_q11_id, 'Reducir el tamaño del código', 3), (v_q11_id, 'Eliminar métodos', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q11_id, qo.id, 'La herencia reutiliza lógica de base.'
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
        '¿Qué es polimorfismo?',
        2,
        1
    )
    RETURNING id INTO v_q12_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q12_id, 'Capacidad de usar una interfaz común con implementaciones distintas', 1), (v_q12_id, 'Un tipo de puntero', 2), (v_q12_id, 'Una variable de entorno', 3), (v_q12_id, 'Un plugin de compilación', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q12_id, qo.id, 'Polimorfismo abstrae implementaciones distintas.'
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
        '¿Qué es override?',
        3,
        1
    )
    RETURNING id INTO v_q13_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q13_id, 'Sobrescribir una función virtual en la clase hija', 1), (v_q13_id, 'Declarar un atributo público', 2), (v_q13_id, 'Crear una plantilla', 3), (v_q13_id, 'Activar un destructor', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q13_id, qo.id, 'override redefine un método virtual.'
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
        '¿Qué es una clase base?',
        4,
        1
    )
    RETURNING id INTO v_q14_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q14_id, 'La clase de la que heredan otras', 1), (v_q14_id, 'La clase más pequeña', 2), (v_q14_id, 'La clase sin métodos', 3), (v_q14_id, 'Una macro', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q14_id, qo.id, 'La clase base comparte lógica común.'
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
        '¿Qué ventaja trae la reutilización por herencia?',
        5,
        1
    )
    RETURNING id INTO v_q15_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q15_id, 'Menos duplicación y más consistencia', 1), (v_q15_id, 'Más dependencias globales', 2), (v_q15_id, 'Más bugs de compilación', 3), (v_q15_id, 'Menos claridad', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q15_id, qo.id, 'La herencia evita duplicar lógica.'
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
        'act-cpp-templates',
        'Actividad 4: Plantillas y sobrecarga',
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
        '¿Qué es sobrecarga de funciones?',
        1,
        1
    )
    RETURNING id INTO v_q16_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q16_id, 'Definir varias funciones con el mismo nombre y distintas firmas', 1), (v_q16_id, 'Crear un atributo oculto', 2), (v_q16_id, 'Reducir un módulo', 3), (v_q16_id, 'Cambiar un compilador', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q16_id, qo.id, 'Sobrecarga permite distintas implementaciones del mismo nombre.'
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
        '¿Qué es una plantilla?',
        2,
        1
    )
    RETURNING id INTO v_q17_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q17_id, 'Patrón de código reutilizable para varios tipos', 1), (v_q17_id, 'Archivo de cabecera', 2), (v_q17_id, 'Variable global', 3), (v_q17_id, 'Módulo privado', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q17_id, qo.id, 'Las plantillas generalizan lógica para tipos distintos.'
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
        '¿Qué hace typename T?',
        3,
        1
    )
    RETURNING id INTO v_q18_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q18_id, 'Declara un parámetro genérico de tipo', 1), (v_q18_id, 'Crea un objeto', 2), (v_q18_id, 'Hace privado un miembro', 3), (v_q18_id, 'Elimina un método', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q18_id, qo.id, 'T representa el tipo instanciado.'
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
        '¿Cuál es un caso útil de sobrecarga?',
        4,
        1
    )
    RETURNING id INTO v_q19_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q19_id, 'Crear funciones para sumar int y double', 1), (v_q19_id, 'Ocultar todos los atributos', 2), (v_q19_id, 'Eliminar clases', 3), (v_q19_id, 'Desactivar compilación', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q19_id, qo.id, 'La sobrecarga ayuda a usar el mismo nombre con distintos tipos.'
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
        '¿Qué aportan las plantillas?',
        5,
        1
    )
    RETURNING id INTO v_q20_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q20_id, 'Reutilización y flexibilidad para distintos tipos', 1), (v_q20_id, 'Menor claridad', 2), (v_q20_id, 'Más acoplamiento', 3), (v_q20_id, 'Menos mantenimiento', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q20_id, qo.id, 'Las plantillas reducen duplicación y mantienen seguridad.'
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
        'exam-cpp',
        'Examen final: POO con C++',
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
        '¿Qué es una clase?',
        1,
        1
    )
    RETURNING id INTO v_q21_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q21_id, 'Plantilla para crear objetos', 1), (v_q21_id, 'Archivo de cabecera', 2), (v_q21_id, 'Un tipo primitivo', 3), (v_q21_id, 'Una variable global', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q21_id, qo.id, 'La clase define estructura y comportamiento.'
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
        '¿Qué es un objeto?',
        2,
        1
    )
    RETURNING id INTO v_q22_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q22_id, 'Instancia concreta de una clase', 1), (v_q22_id, 'Función virtual', 2), (v_q22_id, 'Archivo de texto', 3), (v_q22_id, 'Puntero de memoria', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q22_id, qo.id, 'Los objetos son instancias concretas.'
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
        '¿Qué significa private?',
        3,
        1
    )
    RETURNING id INTO v_q23_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q23_id, 'Restringe acceso a la clase', 1), (v_q23_id, 'Hace visible todo', 2), (v_q23_id, 'Es un tipo de archivo', 3), (v_q23_id, 'Crea un namespace', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q23_id, qo.id, 'private limita acceso al interior de la clase.'
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
        '¿Qué define public?',
        4,
        1
    )
    RETURNING id INTO v_q24_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q24_id, 'Expone el miembro fuera de la clase', 1), (v_q24_id, 'Es una variable local', 2), (v_q24_id, 'Es una plantilla', 3), (v_q24_id, 'Es una macro', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q24_id, qo.id, 'public hace visibles los miembros a otros contextos.'
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
        '¿Qué permite la herencia?',
        5,
        1
    )
    RETURNING id INTO v_q25_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q25_id, 'Reutilizar código entre clases relacionadas', 1), (v_q25_id, 'Cambiar los tipos de datos', 2), (v_q25_id, 'Reducir compilación', 3), (v_q25_id, 'Ocultar todas las funciones', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q25_id, qo.id, 'Herencia comparte código común.'
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
        '¿Qué es el polimorfismo?',
        6,
        1
    )
    RETURNING id INTO v_q26_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q26_id, 'Capacidad de usar una interfaz común con distintas implementaciones', 1), (v_q26_id, 'Un tipo de archivo', 2), (v_q26_id, 'Un error de compilación', 3), (v_q26_id, 'Un atributo privado', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q26_id, qo.id, 'El polimorfismo permite manejar distintos tipos de forma unificada.'
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
        '¿Qué significa override?',
        7,
        1
    )
    RETURNING id INTO v_q27_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q27_id, 'Reemplazar una función virtual en la clase hija', 1), (v_q27_id, 'Crear un puntero', 2), (v_q27_id, 'Definir private', 3), (v_q27_id, 'Convertir en template', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q27_id, qo.id, 'override redefine un método virtual.'
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
        '¿Qué es una plantilla?',
        8,
        1
    )
    RETURNING id INTO v_q28_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q28_id, 'Código genérico reutilizable para distintos tipos', 1), (v_q28_id, 'Una macro del compilador', 2), (v_q28_id, 'Un atributo privado', 3), (v_q28_id, 'Un archivo de entrada', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q28_id, qo.id, 'Las plantillas generalizan lógica.'
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
        '¿Qué hace la sobrecarga?',
        9,
        1
    )
    RETURNING id INTO v_q29_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q29_id, 'Permite varias funciones con el mismo nombre pero firmas diferentes', 1), (v_q29_id, 'Elimina atributos', 2), (v_q29_id, 'Hace pública la clase', 3), (v_q29_id, 'Desactiva la compilación', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q29_id, qo.id, 'La sobrecarga ofrece varias alternativas con el mismo nombre.'
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
        '¿Qué describe la interfaz pública?',
        10,
        1
    )
    RETURNING id INTO v_q30_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q30_id, 'Los métodos y atributos accesibles desde fuera', 1), (v_q30_id, 'El código privado completo', 2), (v_q30_id, 'El compilador', 3), (v_q30_id, 'Las librerías externas', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q30_id, qo.id, 'La interfaz pública es el contrato de uso.'
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
        '¿Qué beneficio tiene encapsular datos?',
        11,
        1
    )
    RETURNING id INTO v_q31_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q31_id, 'Mayor control sobre cambios y errores', 1), (v_q31_id, 'Más acoplamiento', 2), (v_q31_id, 'Menos estabilidad', 3), (v_q31_id, 'Menos reutilización', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q31_id, qo.id, 'Encapsular mejora consistencia y control.'
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
        '¿Qué ayuda a evitar duplicar lógica?',
        12,
        1
    )
    RETURNING id INTO v_q32_id;

    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q32_id, 'Herencia y plantillas', 1), (v_q32_id, 'Variables globales', 2), (v_q32_id, 'Más métodos privados', 3), (v_q32_id, 'Más archivos vacíos', 4);

    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q32_id, qo.id, 'La herencia y plantillas permiten reutilizar lógica.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q32_id
      AND qo.position = 1;

END $$;

COMMIT;
