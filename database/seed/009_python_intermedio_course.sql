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
        WHERE slug = 'python-intermedio'
    ) THEN
        RAISE EXCEPTION 'El slug python-intermedio ya existe en public.courses.';
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
        'python-intermedio',
        'Python intermedio',
        'Curso de nivel intermedio para profundizar en funciones, estructuras de datos y manejo de errores.',
        'Python',
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
        'funciones-y-modulos',
        'Funciones y módulos',
        'Organizar código reutilizable y reutilizar lógica con módulos.',
        '[{"type":"paragraph","text":"Las funciones permiten encapsular bloques de código para reutilizar lógica en distintos lugares del programa."},{"type":"paragraph","text":"Los módulos ayudan a organizar el código en archivos separados y compartir funcionalidades entre partes del proyecto."},{"type":"code","text":"def sumar(a, b):\n    return a + b\n\nprint(sumar(2, 3))"},{"type":"exercise","title":"Ejercicio práctico","steps":["Define una función con un parámetro.","Llama a la función desde el programa principal.","Muestra el resultado para verificar el comportamiento." ]},{"type":"tip","title":"Consejo","text":"Las funciones bien nombradas hacen que el código sea más legible y fácil de mantener."}]'::jsonb,
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
        'listas-y-diccionarios',
        'Listas y diccionarios',
        'Trabajar con estructuras de datos clave para almacenar y consultar información.',
        '[{"type":"paragraph","text":"Las listas almacenan valores ordenados y permiten recorrer datos secuencialmente."},{"type":"paragraph","text":"Los diccionarios agrupan información por pares clave-valor para acceder a los datos por nombre."},{"type":"code","text":"notas = [8, 9, 10]\nusuario = {\"nombre\": \"Ana\", \"edad\": 25}"},{"type":"exercise","title":"Ejercicio práctico","steps":["Crea una lista con varios valores.","Define un diccionario con nombre y edad.","Accede a un valor específico por clave." ]},{"type":"warning","title":"Atención","text":"Las claves en un diccionario deben ser únicas para evitar ambigüedad en el acceso."}]'::jsonb,
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
        'iteraciones-y-archivos',
        'Iteraciones y archivos',
        'Procesar colecciones y guardar información en archivos de texto.',
        '[{"type":"paragraph","text":"Los bucles permiten recorrer listas, cadenas y otras colecciones repetidamente."},{"type":"paragraph","text":"Python también puede abrir archivos para escribir y leer contenido de forma organizada."},{"type":"code","text":"for numero in range(1, 5):\n    print(numero)\n\nwith open(\"datos.txt\", \"w\") as archivo:\n    archivo.write(\"hola\")"},{"type":"exercise","title":"Ejercicio práctico","steps":["Recorre una lista con un bucle.","Abre un archivo en modo escritura.","Guarda una línea con contenido simple." ]},{"type":"tip","title":"Buena práctica","text":"Usar with open asegura que el archivo se cierre correctamente después de la operación."}]'::jsonb,
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
        'errores-y-excepciones',
        'Errores y excepciones',
        'Prevenir fallas durante la ejecución con manejo de errores.',
        '[{"type":"paragraph","text":"Los errores pueden aparecer por entradas inválidas, archivos inexistentes o operaciones inesperadas."},{"type":"paragraph","text":"Las excepciones permiten capturar esos errores y responder de forma controlada sin terminar abruptamente el programa."},{"type":"code","text":"try:\n    valor = int(\"abc\")\nexcept ValueError:\n    print(\"Entrada inválida\")"},{"type":"exercise","title":"Ejercicio práctico","steps":["Prueba una conversión inválida.","Captura el error con except.","Muestra un mensaje útil para el usuario." ]},{"type":"warning","title":"Atención","text":"No todos los errores deben ignorarse; conviene tratarlos con mensajes claros y una respuesta apropiada."}]'::jsonb,
        4,
        false
    )
    RETURNING id INTO v_lesson_4;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (gen_random_uuid(), v_course_id, v_lesson_1, 'actividad-python-funciones', 'Actividad 1: Funciones y módulos', 'Selecciona la opción correcta.', 'activity', 70, 1, false)
    RETURNING id INTO v_activity_1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_1, '¿Qué es una función?', 1, 1) RETURNING id INTO v_q1_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q1_id, 'Bloque reutilizable de código', 1), (v_q1_id, 'Un archivo de texto', 2), (v_q1_id, 'Un navegador', 3), (v_q1_id, 'Un comando de Git', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q1_id, qo.id, 'Una función encapsula código reutilizable para ejecutarse cuando se llama.' FROM public.question_options qo WHERE qo.question_id = v_q1_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_1, '¿Qué palabra clave define una función?', 2, 1) RETURNING id INTO v_q2_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q2_id, 'def', 1), (v_q2_id, 'func', 2), (v_q2_id, 'function', 3), (v_q2_id, 'class', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q2_id, qo.id, 'def declara una función en Python.' FROM public.question_options qo WHERE qo.question_id = v_q2_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_1, '¿Qué hace return?', 3, 1) RETURNING id INTO v_q3_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q3_id, 'Devuelve un valor', 1), (v_q3_id, 'Crea un archivo', 2), (v_q3_id, 'Importa código', 3), (v_q3_id, 'Abre un diccionario', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q3_id, qo.id, 'return entrega el resultado de la función al código que la invocó.' FROM public.question_options qo WHERE qo.question_id = v_q3_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_1, '¿Qué permite import?', 4, 1) RETURNING id INTO v_q4_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q4_id, 'Usar funciones de otros módulos', 1), (v_q4_id, 'Crear archivos', 2), (v_q4_id, 'Eliminar datos', 3), (v_q4_id, 'Guardar texto', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q4_id, qo.id, 'import permite acceder a funciones y clases de otros archivos Python.' FROM public.question_options qo WHERE qo.question_id = v_q4_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_1, '¿Qué es un módulo?', 5, 1) RETURNING id INTO v_q5_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q5_id, 'Archivo reutilizable con código Python', 1), (v_q5_id, 'Una base de datos', 2), (v_q5_id, 'Un tipo de excepción', 3), (v_q5_id, 'Una variable vacía', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q5_id, qo.id, 'Un módulo agrupa código reutilizable en un archivo Python.' FROM public.question_options qo WHERE qo.question_id = v_q5_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (gen_random_uuid(), v_course_id, v_lesson_2, 'actividad-python-datos', 'Actividad 2: Listas y diccionarios', 'Elige la mejor respuesta.', 'activity', 70, 2, false)
    RETURNING id INTO v_activity_2;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_2, '¿Qué almacena una lista?', 1, 1) RETURNING id INTO v_q6_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q6_id, 'Secuencia ordenada de elementos', 1), (v_q6_id, 'Un solo valor', 2), (v_q6_id, 'Un comando del sistema', 3), (v_q6_id, 'Un bloque try', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q6_id, qo.id, 'Las listas guardan varios elementos en un orden específico.' FROM public.question_options qo WHERE qo.question_id = v_q6_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_2, '¿Qué contiene un diccionario?', 3, 1) RETURNING id INTO v_q7_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q7_id, 'Pares clave:valor', 1), (v_q7_id, 'Cadenas vacías', 2), (v_q7_id, 'Valores nulos', 3), (v_q7_id, 'Archivos temporales', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q7_id, qo.id, 'Los diccionarios usan claves y valores para guardar información.' FROM public.question_options qo WHERE qo.question_id = v_q7_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_2, '¿Cómo se accede a un valor de diccionario?', 2, 1) RETURNING id INTO v_q8_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q8_id, 'usuario["nombre"]', 1), (v_q8_id, 'usuario.nombre()', 2), (v_q8_id, 'usuario->nombre', 3), (v_q8_id, 'usuario[0]', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q8_id, qo.id, 'La clave se accede con corchetes y un texto representando la clave.' FROM public.question_options qo WHERE qo.question_id = v_q8_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_2, '¿Qué representa una lista?', 4, 1) RETURNING id INTO v_q9_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q9_id, 'Colección ordenada y mutable', 1), (v_q9_id, 'Un tipo de error', 2), (v_q9_id, 'Una función', 3), (v_q9_id, 'Un módulo', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q9_id, qo.id, 'Las listas son estructuras mutables y ordenadas.' FROM public.question_options qo WHERE qo.question_id = v_q9_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_2, '¿Qué favorece un diccionario?', 5, 1) RETURNING id INTO v_q10_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q10_id, 'Acceso por nombre', 1), (v_q10_id, 'Ordenamiento por fuerza', 2), (v_q10_id, 'Evitar estructura', 3), (v_q10_id, 'Reducir funciones', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q10_id, qo.id, 'Las claves permiten acceder a cada valor por nombre, sin depender del orden.' FROM public.question_options qo WHERE qo.question_id = v_q10_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (gen_random_uuid(), v_course_id, v_lesson_3, 'actividad-python-iteraciones', 'Actividad 3: Iteraciones y archivos', 'Selecciona la opción correcta.', 'activity', 70, 3, false)
    RETURNING id INTO v_activity_3;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_3, '¿Qué hace un for?', 1, 1) RETURNING id INTO v_q11_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q11_id, 'Recorre elementos de una colección', 1), (v_q11_id, 'Elimina módulos', 2), (v_q11_id, 'Crea una tabla', 3), (v_q11_id, 'Abre una base de datos', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q11_id, qo.id, 'for itera sobre cada elemento de un iterable.' FROM public.question_options qo WHERE qo.question_id = v_q11_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_3, '¿Qué hace open("archivo", "w")?', 2, 1) RETURNING id INTO v_q12_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q12_id, 'Escribe en el archivo', 1), (v_q12_id, 'Lee el contenido', 2), (v_q12_id, 'Elimina el archivo', 3), (v_q12_id, 'Crea una función', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q12_id, qo.id, '"w" abre el archivo en modo escritura.' FROM public.question_options qo WHERE qo.question_id = v_q12_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_3, '¿Qué hace with open?', 3, 1) RETURNING id INTO v_q13_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q13_id, 'Abre y cierra el archivo automáticamente', 1), (v_q13_id, 'Genera una función', 2), (v_q13_id, 'Elimina variables', 3), (v_q13_id, 'Carga un módulo', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q13_id, qo.id, 'with open garantiza la limpieza del archivo al finalizar.' FROM public.question_options qo WHERE qo.question_id = v_q13_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_3, '¿Qué es range(1, 5)?', 4, 1) RETURNING id INTO v_q14_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q14_id, 'Números del 1 al 4', 1), (v_q14_id, 'Línea de texto', 2), (v_q14_id, 'Lista vacía', 3), (v_q14_id, 'Un diccionario', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q14_id, qo.id, 'range(1, 5) genera valores desde 1 hasta 4.' FROM public.question_options qo WHERE qo.question_id = v_q14_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_3, '¿Qué tipos puede recorrer un for?', 5, 1) RETURNING id INTO v_q15_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q15_id, 'Listas, cadenas y tuplas', 1), (v_q15_id, 'Solo archivos', 2), (v_q15_id, 'Solo cadenas vacías', 3), (v_q15_id, 'Solo funciones', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q15_id, qo.id, 'for puede iterar sobre varios tipos iterables, no solo sobre listas.' FROM public.question_options qo WHERE qo.question_id = v_q15_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (gen_random_uuid(), v_course_id, v_lesson_4, 'actividad-python-excepciones', 'Actividad 4: Errores y excepciones', 'Elige la respuesta correcta.', 'activity', 70, 4, false)
    RETURNING id INTO v_activity_4;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_4, '¿Qué hace try?', 1, 1) RETURNING id INTO v_q16_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q16_id, 'Intenta ejecutar código potencialmente problemático', 1), (v_q16_id, 'Crea funciones', 2), (v_q16_id, 'Importa módulos', 3), (v_q16_id, 'Abre un archivo', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q16_id, qo.id, 'try agrupa el bloque de código que puede fallar.' FROM public.question_options qo WHERE qo.question_id = v_q16_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_4, '¿Qué es except?', 2, 1) RETURNING id INTO v_q17_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q17_id, 'Bloque que captura la excepción', 1), (v_q17_id, 'Un tipo de módulo', 2), (v_q17_id, 'Un diccionario', 3), (v_q17_id, 'Una clase', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q17_id, qo.id, 'except maneja errores específicos dentro del flujo del programa.' FROM public.question_options qo WHERE qo.question_id = v_q17_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_4, '¿Qué excepción produce int("abc")?', 3, 1) RETURNING id INTO v_q18_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q18_id, 'ValueError', 1), (v_q18_id, 'TypeError', 2), (v_q18_id, 'SyntaxError', 3), (v_q18_id, 'KeyError', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q18_id, qo.id, 'La conversión de texto no numérico a entero lanza ValueError.' FROM public.question_options qo WHERE qo.question_id = v_q18_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_4, '¿Qué beneficio tienen las excepciones?', 4, 1) RETURNING id INTO v_q19_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q19_id, 'Evita romper el programa', 1), (v_q19_id, 'Elimina la necesidad de lógica', 2), (v_q19_id, 'Borra archivos', 3), (v_q19_id, 'Hace que todo sea estático', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q19_id, qo.id, 'Las excepciones permiten responder a fallos sin interrumpir completamente la ejecución.' FROM public.question_options qo WHERE qo.question_id = v_q19_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_4, '¿Qué es recomendable al manejar errores?', 5, 1) RETURNING id INTO v_q20_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q20_id, 'Mostrar un mensaje claro', 1), (v_q20_id, 'Ignorar el problema', 2), (v_q20_id, 'Eliminar el bloque try', 3), (v_q20_id, 'Cambiar todo el código', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q20_id, qo.id, 'Un mensaje claro ayuda a diagnosticar el fallo y mantener la experiencia del usuario.' FROM public.question_options qo WHERE qo.question_id = v_q20_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (gen_random_uuid(), v_course_id, NULL, 'examen-final-python-intermedio', 'Examen final: Python intermedio', 'Selecciona la respuesta correcta.', 'exam', 70, 5, false)
    RETURNING id INTO v_exam_id;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué palabra clave define una función?', 1, 1) RETURNING id INTO v_q21_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q21_id, 'def', 1), (v_q21_id, 'function', 2), (v_q21_id, 'func', 3), (v_q21_id, 'class', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q21_id, qo.id, 'def declara una función en Python.' FROM public.question_options qo WHERE qo.question_id = v_q21_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace return?', 2, 1) RETURNING id INTO v_q22_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q22_id, 'Devuelve un valor', 1), (v_q22_id, 'Abre un archivo', 2), (v_q22_id, 'Importa un módulo', 3), (v_q22_id, 'Crea un diccionario', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q22_id, qo.id, 'return entrega el valor resultante al llamador.' FROM public.question_options qo WHERE qo.question_id = v_q22_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué es un módulo?', 3, 1) RETURNING id INTO v_q23_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q23_id, 'Archivo reutilizable de Python', 1), (v_q23_id, 'Variable global', 2), (v_q23_id, 'Tipo de excepción', 3), (v_q23_id, 'Base de datos', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q23_id, qo.id, 'Un módulo es un archivo Python con funciones o clases reutilizables.' FROM public.question_options qo WHERE qo.question_id = v_q23_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué estructura usa pares clave:valor?', 4, 1) RETURNING id INTO v_q24_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q24_id, 'Diccionario', 1), (v_q24_id, 'Lista', 2), (v_q24_id, 'Tupla', 3), (v_q24_id, 'Set', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q24_id, qo.id, 'Los diccionarios almacenan contenido con pares de clave y valor.' FROM public.question_options qo WHERE qo.question_id = v_q24_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Para qué sirve un diccionario?', 5, 1) RETURNING id INTO v_q25_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q25_id, 'Acceder por nombre a cada dato', 1), (v_q25_id, 'Crear una función', 2), (v_q25_id, 'Guardar texto fijo', 3), (v_q25_id, 'Descomponer un módulo', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q25_id, qo.id, 'Los diccionarios permiten encontrar cada dato mediante su clave.' FROM public.question_options qo WHERE qo.question_id = v_q25_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué almacena una lista?', 6, 1) RETURNING id INTO v_q26_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q26_id, 'Elementos ordenados', 1), (v_q26_id, 'Solo un valor', 2), (v_q26_id, 'Un set aleatorio', 3), (v_q26_id, 'Un módulo', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q26_id, qo.id, 'Las listas almacenan varios elementos ordenados.' FROM public.question_options qo WHERE qo.question_id = v_q26_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace un for?', 7, 1) RETURNING id INTO v_q27_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q27_id, 'Recorre elementos de una colección', 1), (v_q27_id, 'Elimina a un archivo', 2), (v_q27_id, 'Crea un bloque try', 3), (v_q27_id, 'Cierra un módulo', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q27_id, qo.id, 'for recorre uno por uno los elementos de una colección.' FROM public.question_options qo WHERE qo.question_id = v_q27_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace open("archivo", "w")?', 8, 1) RETURNING id INTO v_q28_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q28_id, 'Escribe en el archivo', 1), (v_q28_id, 'Lee el contenido', 2), (v_q28_id, 'Elimina el archivo', 3), (v_q28_id, 'Crea una función', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q28_id, qo.id, '"w" abre el archivo para escribir en él.' FROM public.question_options qo WHERE qo.question_id = v_q28_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace with open?', 9, 1) RETURNING id INTO v_q29_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q29_id, 'Cierra el archivo automáticamente', 1), (v_q29_id, 'Genera un módulo', 2), (v_q29_id, 'Ejecuta un return', 3), (v_q29_id, 'Declara una función', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q29_id, qo.id, 'with open garantiza cierre seguro del archivo.' FROM public.question_options qo WHERE qo.question_id = v_q29_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace except?', 10, 1) RETURNING id INTO v_q30_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q30_id, 'Captura y maneja errores', 1), (v_q30_id, 'Define un módulo', 2), (v_q30_id, 'Genera una lista', 3), (v_q30_id, 'Crea una instantánea', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q30_id, qo.id, 'except gestiona errores para mantener la app estable.' FROM public.question_options qo WHERE qo.question_id = v_q30_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué excepción lanza int("abc")?', 11, 1) RETURNING id INTO v_q31_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q31_id, 'ValueError', 1), (v_q31_id, 'IndexError', 2), (v_q31_id, 'KeyError', 3), (v_q31_id, 'TypeError', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q31_id, qo.id, 'int("abc") lanza ValueError porque el contenido no es numérico.' FROM public.question_options qo WHERE qo.question_id = v_q31_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué beneficio tiene manejar errores?', 12, 1) RETURNING id INTO v_q32_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q32_id, 'Programa más robusto', 1), (v_q32_id, 'Menos lógica', 2), (v_q32_id, 'Más archivos vacíos', 3), (v_q32_id, 'Menos pruebas', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q32_id, qo.id, 'Manejar errores mejora la robustez y la experiencia del usuario.' FROM public.question_options qo WHERE qo.question_id = v_q32_id AND qo.position = 1;
END $$;

COMMIT;
