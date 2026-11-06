BEGIN;

DO $$
DECLARE
    v_course_id uuid;
    v_lesson_1 uuid; v_lesson_2 uuid; v_lesson_3 uuid; v_lesson_4 uuid;
    v_activity_1 uuid; v_activity_2 uuid; v_activity_3 uuid; v_activity_4 uuid;
    v_exam_id uuid;
    v_q1_id uuid; v_q2_id uuid; v_q3_id uuid; v_q4_id uuid; v_q5_id uuid; v_q6_id uuid; v_q7_id uuid; v_q8_id uuid; v_q9_id uuid; v_q10_id uuid; v_q11_id uuid; v_q12_id uuid; v_q13_id uuid; v_q14_id uuid; v_q15_id uuid; v_q16_id uuid; v_q17_id uuid; v_q18_id uuid; v_q19_id uuid; v_q20_id uuid; v_q21_id uuid; v_q22_id uuid; v_q23_id uuid; v_q24_id uuid; v_q25_id uuid; v_q26_id uuid; v_q27_id uuid; v_q28_id uuid; v_q29_id uuid; v_q30_id uuid; v_q31_id uuid; v_q32_id uuid;
BEGIN
    IF EXISTS (SELECT 1 FROM public.courses WHERE slug = 'python-avanzado') THEN
        RAISE EXCEPTION 'El slug python-avanzado ya existe en public.courses.';
    END IF;

    INSERT INTO public.courses (id, slug, title, description, language, level, duration_weeks, position, is_published)
    VALUES (
        gen_random_uuid(),
        'python-avanzado',
        'Python avanzado',
        'Curso avanzado para trabajar con estructuras complejas, programas modulares, manejo de errores y librerías comunes en Python.',
        'Python',
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
        'estructuras-y-datos',
        'Estructuras y datos',
        'Trabajar con colecciones complejas y manipular información con precisión.',
        '[{"type": "paragraph", "text": "Python ofrece estructuras de datos flexibles y expresivas para modelar información real."}, {"type": "paragraph", "text": "Listas, diccionarios y conjuntos permiten organizar datos según el tipo de operación que se necesite."}, {"type": "code", "text": "usuarios = [{''nombre'': ''Ana'', ''edad'': 23}, {''nombre'': ''Luis'', ''edad'': 27}]"}, {"type": "exercise", "title": "Ejercicio práctico", "steps": ["Define una lista de diccionarios.", "Accede a una propiedad específica.", "Filtra elementos por condición."]}, {"type": "tip", "title": "Consejo", "text": "Seleccionar la estructura correcta mejora claridad y eficiencia en la lógica."}]'::jsonb,
        1,
        false
    )
    RETURNING id INTO v_lesson_1;

    INSERT INTO public.lessons (id, course_id, slug, title, objective, content, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'funciones-y-modulos',
        'Funciones y módulos',
        'Organizar programas con piezas reutilizables y archivos bien definidos.',
        '[{"type": "paragraph", "text": "Las funciones encapsulan tareas y permiten reutilizar lógica sin duplicar código."}, {"type": "paragraph", "text": "Los módulos separan responsabilidades y mantienen una base de código más mantenible."}, {"type": "code", "text": "def area_circulo(radio): return 3.14 * radio ** 2"}, {"type": "exercise", "title": "Ejercicio práctico", "steps": ["Crea una función que calcule el área de un rectángulo.", "Invócala con valores reales.", "Guarda el resultado en una variable."]}, {"type": "warning", "title": "Atención", "text": "La buena división de funciones favorece pruebas y mantenimiento del código."}]'::jsonb,
        2,
        false
    )
    RETURNING id INTO v_lesson_2;

    INSERT INTO public.lessons (id, course_id, slug, title, objective, content, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'excepciones-y-debug',
        'Excepciones y depuración',
        'Detectar fallos, manejar errores y analizar comportamientos inesperados.',
        '[{"type": "paragraph", "text": "Las excepciones indican que algo en la ejecución no se comportó como se esperaba."}, {"type": "paragraph", "text": "Loggear errores y validaciones complejas ayuda a diagnosticar fallos de forma más rápida."}, {"type": "code", "text": "try: valor = int(''abc'') except ValueError as e: print(''Entrada inválida'')"}, {"type": "exercise", "title": "Ejercicio práctico", "steps": ["Escribe un bloque try/except.", "Genera un error intencional.", "Muestra un mensaje de diagnóstico útil."]}, {"type": "tip", "title": "Buena práctica", "text": "Capturar errores con contexto es más útil que ocultarlos."}]'::jsonb,
        3,
        false
    )
    RETURNING id INTO v_lesson_3;

    INSERT INTO public.lessons (id, course_id, slug, title, objective, content, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'librerias-y-archivos',
        'Librerías y archivos',
        'Consumir utilidades externas y gestionar persistencia de información.',
        '[{"type": "paragraph", "text": "Python cuenta con librerías estándar y paquetes externos que resuelven tareas muy frecuentes."}, {"type": "paragraph", "text": "La lectura y escritura de archivos permite guardar resultados, datos de configuración y registros."}, {"type": "code", "text": "with open(''datos.txt'', ''r'', encoding=''utf-8'') as archivo: contenido = archivo.read()"}, {"type": "exercise", "title": "Ejercicio práctico", "steps": ["Crea un archivo con texto simple.", "Lée el contenido con open.", "Muestra el resultado por pantalla."]}, {"type": "warning", "title": "Atención", "text": "Cuidado con la codificación y el manejo de rutas para no perder información."}]'::jsonb,
        4,
        false
    )
    RETURNING id INTO v_lesson_4;


    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        v_lesson_1,
        'act-py-estructuras',
        'Actividad 1: Estructuras y datos',
        'Elige la respuesta correcta.',
        'activity',
        70,
        1,
        false
    )
    RETURNING id INTO v_activity_1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué es un diccionario en Python?', 1, 1)
    RETURNING id INTO v_q1_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q1_id, 'Una colección de pares clave-valor', 1), (v_q1_id, 'Un archivo JSON', 2), (v_q1_id, 'Un comando de shell', 3), (v_q1_id, 'Un tipo de excepción', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q1_id, qo.id, 'Los diccionarios guardan datos indexados por clave.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q1_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué permite una lista?', 2, 1)
    RETURNING id INTO v_q2_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q2_id, 'Guardar varios elementos ordenados', 1), (v_q2_id, 'Guardar solo claves', 2), (v_q2_id, 'Evitar iteraciones', 3), (v_q2_id, 'Definir funciones', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q2_id, qo.id, 'Las listas mantienen elementos ordenados.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q2_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué hace un conjunto?', 3, 1)
    RETURNING id INTO v_q3_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q3_id, 'Guarda valores únicos sin orden definido', 1), (v_q3_id, 'Guarda claves con valor', 2), (v_q3_id, 'Escribe archivos', 3), (v_q3_id, 'Define clases', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q3_id, qo.id, 'Los conjuntos eliminan duplicados automáticamente.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q3_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué representa una clave en un diccionario?', 4, 1)
    RETURNING id INTO v_q4_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q4_id, 'La identidad de cada valor', 1), (v_q4_id, 'Un parámetro de función', 2), (v_q4_id, 'Un mensaje de error', 3), (v_q4_id, 'Un método de archivo', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q4_id, qo.id, 'La clave permite acceder al valor asociado.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q4_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué ventaja tiene elegir la estructura adecuada?', 5, 1)
    RETURNING id INTO v_q5_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q5_id, 'Mejor claridad y operación del código', 1), (v_q5_id, 'Más complejidad', 2), (v_q5_id, 'Menos reutilización', 3), (v_q5_id, 'Menos velocidad', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q5_id, qo.id, 'La estructura correcta facilita operaciones razonables.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q5_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        v_lesson_2,
        'act-py-funciones',
        'Actividad 2: Funciones y módulos',
        'Selecciona la respuesta correcta.',
        'activity',
        70,
        2,
        false
    )
    RETURNING id INTO v_activity_2;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué es una función?', 1, 1)
    RETURNING id INTO v_q1_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q1_id, 'Bloque reutilizable de código', 1), (v_q1_id, 'Un archivo de texto', 2), (v_q1_id, 'Un tipo de dato', 3), (v_q1_id, 'Una estructura HTML', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q1_id, qo.id, 'Las funciones encapsulan lógica reutilizable.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q1_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué hace return?', 2, 1)
    RETURNING id INTO v_q2_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q2_id, 'Devuelve un valor al invocador', 1), (v_q2_id, 'Importa un módulo', 2), (v_q2_id, 'Escribe en un archivo', 3), (v_q2_id, 'Define una clase', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q2_id, qo.id, 'return entrega el resultado de la función.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q2_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Para qué se usan los módulos?', 3, 1)
    RETURNING id INTO v_q3_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q3_id, 'Organizar y reutilizar código', 1), (v_q3_id, 'Crear variables temporales', 2), (v_q3_id, 'Reducir la validación', 3), (v_q3_id, 'Cambiar la sintaxis del lenguaje', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q3_id, qo.id, 'Los módulos separan responsabilidades y facilitan reutilización.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q3_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué ventaja tiene una función bien diseñada?', 4, 1)
    RETURNING id INTO v_q4_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q4_id, 'Es más fácil de probar y reutilizar', 1), (v_q4_id, 'Se duplica toda la lógica', 2), (v_q4_id, 'Deja de ser Python', 3), (v_q4_id, 'Debe vivir en un único archivo', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q4_id, qo.id, 'Funciones bien diseñadas reducen duplicación.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q4_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué describe mejor la modularización?', 5, 1)
    RETURNING id INTO v_q5_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q5_id, 'Dividir tareas en piezas pequeñas y claras', 1), (v_q5_id, 'Usar una sola variable global', 2), (v_q5_id, 'Evitar funciones', 3), (v_q5_id, 'Incluir código en un bloque gigante', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q5_id, qo.id, 'La modularización organiza mejor el código.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q5_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        v_lesson_3,
        'act-py-excepciones',
        'Actividad 3: Excepciones y depuración',
        'Elige la respuesta correcta.',
        'activity',
        70,
        3,
        false
    )
    RETURNING id INTO v_activity_3;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué es una excepción?', 1, 1)
    RETURNING id INTO v_q1_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q1_id, 'Un error que interrumpe la ejecución normal', 1), (v_q1_id, 'Un tipo de lista', 2), (v_q1_id, 'Un módulo externo', 3), (v_q1_id, 'Una sentencia SQL', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q1_id, qo.id, 'Las excepciones representan fallos durante la ejecución.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q1_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué hace try/except?', 2, 1)
    RETURNING id INTO v_q2_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q2_id, 'Captura errores y permite manejarlos', 1), (v_q2_id, 'Elimina variables', 2), (v_q2_id, 'Lanza un archivo', 3), (v_q2_id, 'Crea un conjunto', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q2_id, qo.id, 'try/except controla fallos esperados.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q2_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué es útil para depurar?', 3, 1)
    RETURNING id INTO v_q3_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q3_id, 'Mensajes claros y contexto del error', 1), (v_q3_id, 'Ocultar la causa', 2), (v_q3_id, 'Ignorar el problema', 3), (v_q3_id, 'Cambiar la sintaxis', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q3_id, qo.id, 'Los errores necesitan contexto útil para corregirse.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q3_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué puede indicar un ValueError?', 4, 1)
    RETURNING id INTO v_q4_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q4_id, 'Que una conversión de tipo falló', 1), (v_q4_id, 'Que un archivo se cerró', 2), (v_q4_id, 'Que se creó un módulo', 3), (v_q4_id, 'Que una lista está vacía', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q4_id, qo.id, 'ValueError indica que el valor no es apropiado para la operación.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q4_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué mejora la robustez del programa?', 5, 1)
    RETURNING id INTO v_q5_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q5_id, 'Controlar errores y validar datos', 1), (v_q5_id, 'Evitar try/except', 2), (v_q5_id, 'No usar funciones', 3), (v_q5_id, 'Eliminar comentarios', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q5_id, qo.id, 'El manejo correcto de errores hace software más seguro.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q5_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        v_lesson_4,
        'act-py-librerias',
        'Actividad 4: Librerías y archivos',
        'Selecciona la respuesta correcta.',
        'activity',
        70,
        4,
        false
    )
    RETURNING id INTO v_activity_4;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué hace open(..., ''r'')?', 1, 1)
    RETURNING id INTO v_q1_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q1_id, 'Abre un archivo para lectura', 1), (v_q1_id, 'Abre un archivo para escritura binaria', 2), (v_q1_id, 'Crea un diccionario', 3), (v_q1_id, 'Ejecuta un módulo', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q1_id, qo.id, '''r'' significa lectura del contenido del archivo.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q1_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué es una librería en Python?', 2, 1)
    RETURNING id INTO v_q2_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q2_id, 'Conjunto de funciones y módulos reutilizables', 1), (v_q2_id, 'Una variable de entorno', 2), (v_q2_id, 'Un tipo de clave', 3), (v_q2_id, 'Un archivo CSV', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q2_id, qo.id, 'Las librerías encapsulan funcionalidad útil.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q2_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué hace with open(...) as archivo?', 3, 1)
    RETURNING id INTO v_q3_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q3_id, 'Abre el archivo y lo cierra al terminar', 1), (v_q3_id, 'Borra el archivo', 2), (v_q3_id, 'Importa un módulo', 3), (v_q3_id, 'Crea una estructura de datos', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q3_id, qo.id, 'with asegura cierre automático del recurso.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q3_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué es importante al leer archivos?', 4, 1)
    RETURNING id INTO v_q4_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q4_id, 'Usar una codificación adecuada', 1), (v_q4_id, 'No cerrar el archivo', 2), (v_q4_id, 'Eliminar todas las rutas', 3), (v_q4_id, 'Escoger solo listas', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q4_id, qo.id, 'La codificación correcta evita errores de texto.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q4_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué ayuda a usar librerías externas?', 5, 1)
    RETURNING id INTO v_q5_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q5_id, 'Entender su uso y mantener un entorno ordenado', 1), (v_q5_id, 'Ignorar dependencias', 2), (v_q5_id, 'No leer documentación', 3), (v_q5_id, 'Evitar módulos', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q5_id, qo.id, 'Conocer la librería reduce errores de uso y mantenimiento.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q5_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        NULL,
        'exam-python-avanzado',
        'Examen final: Python avanzado',
        'Selecciona la respuesta correcta.',
        'exam',
        70,
        5,
        false
    )
    RETURNING id INTO v_exam_id;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué es un diccionario?', 1, 1)
    RETURNING id INTO v_q1_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q1_id, 'Colección de pares clave-valor', 1), (v_q1_id, 'Tipo de función', 2), (v_q1_id, 'Semáforo de ejecución', 3), (v_q1_id, 'Lista ordenada', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q1_id, qo.id, 'Los diccionarios asignan claves a valores.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q1_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace una lista?', 2, 1)
    RETURNING id INTO v_q2_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q2_id, 'Guarda elementos ordenados', 1), (v_q2_id, 'Agrega nombres de funciones', 2), (v_q2_id, 'Define un bloque try', 3), (v_q2_id, 'Genera archivos', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q2_id, qo.id, 'Las listas mantienen orden y elementos.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q2_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué es una función?', 3, 1)
    RETURNING id INTO v_q3_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q3_id, 'Bloque reutilizable de código', 1), (v_q3_id, 'Tipo de excepción', 2), (v_q3_id, 'Archivo XML', 3), (v_q3_id, 'Comando de shell', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q3_id, qo.id, 'Las funciones encapsulan lógica repetible.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q3_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace return en una función?', 4, 1)
    RETURNING id INTO v_q4_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q4_id, 'Devuelve un valor al código que la invocó', 1), (v_q4_id, 'Cierra el programa', 2), (v_q4_id, 'Define un archivo', 3), (v_q4_id, 'Crea una lista', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q4_id, qo.id, 'return entrega el resultado resultante.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q4_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué es un módulo?', 5, 1)
    RETURNING id INTO v_q5_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q5_id, 'Archivo o conjunto de código reutilizable', 1), (v_q5_id, 'Un tipo de error', 2), (v_q5_id, 'Un objeto de base de datos', 3), (v_q5_id, 'Una lista ordenada', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q5_id, qo.id, 'Los módulos dividen y organizan el proyecto.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q5_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace try/except?', 6, 1)
    RETURNING id INTO v_q6_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q6_id, 'Controla errores durante la ejecución', 1), (v_q6_id, 'Evita definir funciones', 2), (v_q6_id, 'Lanza un archivo', 3), (v_q6_id, 'Elimina dependencias', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q6_id, qo.id, 'try/except maneja fallos previstos.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q6_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué es ValueError?', 7, 1)
    RETURNING id INTO v_q7_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q7_id, 'Error por valor incorrecto para una operación', 1), (v_q7_id, 'Error de archivo', 2), (v_q7_id, 'Error de módulo', 3), (v_q7_id, 'Error de sintaxis', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q7_id, qo.id, 'ValueError refleja un valor no válido.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q7_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace open(''archivo'',''r'')?', 8, 1)
    RETURNING id INTO v_q8_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q8_id, 'Lee archivo en modo texto', 1), (v_q8_id, 'Crea un diccionario', 2), (v_q8_id, 'Instala una librería', 3), (v_q8_id, 'Elimina la variable', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q8_id, qo.id, '''r'' abre para lectura.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q8_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace with open...?', 9, 1)
    RETURNING id INTO v_q9_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q9_id, 'Cierra el archivo automáticamente al terminar', 1), (v_q9_id, 'Abre solo lectura', 2), (v_q9_id, 'Crea variables globales', 3), (v_q9_id, 'Ignora excepciones', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q9_id, qo.id, 'with es útil para liberar recursos.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q9_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué es útil para organizar un proyecto?', 10, 1)
    RETURNING id INTO v_q10_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q10_id, 'Módulos y funciones bien estructuradas', 1), (v_q10_id, 'Una sola función gigante', 2), (v_q10_id, 'Un archivo sin separación', 3), (v_q10_id, 'Más variables globales', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q10_id, qo.id, 'La organización favorece mantenimiento.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q10_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué es una librería?', 11, 1)
    RETURNING id INTO v_q11_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q11_id, 'Conjunto de utilidades reutilizables', 1), (v_q11_id, 'Un diccionario vacío', 2), (v_q11_id, 'Un error de Python', 3), (v_q11_id, 'Un archivo de texto', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q11_id, qo.id, 'Las librerías encapsulan funcionalidad compartida.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q11_id AND qo.position = 1;


    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué mejora la depuración?', 12, 1)
    RETURNING id INTO v_q12_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q12_id, 'Mensajes de error claros y contexto útil', 1), (v_q12_id, 'Ocultar fallos', 2), (v_q12_id, 'Eliminar validación', 3), (v_q12_id, 'No usar funciones', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q12_id, qo.id, 'El contexto acelera la solución del problema.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q12_id AND qo.position = 1;

END $$;

COMMIT;
