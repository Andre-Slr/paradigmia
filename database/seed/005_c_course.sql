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
        WHERE slug = 'c-basico-principiante'
    ) THEN
        RAISE EXCEPTION 'El slug c-basico-principiante ya existe en public.courses.';
    END IF;

    INSERT INTO public.courses (id, slug, title, description, language, level, duration_weeks, position, is_published)
    VALUES (
        gen_random_uuid(),
        'c-basico-principiante',
        'C para principiantes',
        'Aprende programación estructurada en C con variables, funciones, punteros y control de flujo.',
        'C',
        'Principiante',
        4,
        999,
        false
    )
    RETURNING id INTO v_course_id;

    INSERT INTO public.lessons (id, course_id, slug, title, objective, content, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'introduccion-a-c',
        'Introducción a C',
        'Entender la estructura base de un programa en C.',
        '[{"type":"paragraph","text":"C es un lenguaje eficiente muy cercano al hardware."},{"type":"paragraph","text":"Un programa en C comienza con main y usa stdio para entrada y salida."},{"type":"code","text":"#include <stdio.h>\nint main(void) {\n  printf(\"Hola, C\\n\");\n  return 0;\n}"},{"type":"exercise","title":"Ejercicio práctico","steps":["Crea un archivo main.","Incluye stdio.h.","Imprime un mensaje."]},{"type":"tip","title":"Consejo","text":"La estructura simple de C facilita la comprensión del flujo del programa."}]'::jsonb,
        1,
        false
    )
    RETURNING id INTO v_lesson_1;

    INSERT INTO public.lessons (id, course_id, slug, title, objective, content, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'variables-y-operadores',
        'Variables y operadores',
        'Guardar datos y ejecutar operaciones básicas.',
        '[{"type":"paragraph","text":"En C cada variable tiene un tipo explícito."},{"type":"paragraph","text":"Los operadores permiten asignar, comparar y calcular resultados."},{"type":"code","text":"int edad = 18;\nfloat precio = 15.5f;\nchar inicial = ''A'';\nint total = edad + 2;"},{"type":"exercise","title":"Ejercicio práctico","steps":["Declara dos números enteros.","Suma ambos.","Muestra el resultado."]},{"type":"warning","title":"Atención","text":"Las variables deben declararse antes de usarse para evitar errores de compilación."}]'::jsonb,
        2,
        false
    )
    RETURNING id INTO v_lesson_2;

    INSERT INTO public.lessons (id, course_id, slug, title, objective, content, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'condicionales-y-bucles',
        'Condicionales y bucles',
        'Tomar decisiones y repetir tareas.',
        '[{"type":"paragraph","text":"if, else y switch permiten tomar decisiones."},{"type":"paragraph","text":"for y while repiten instrucciones sin duplicarlas."},{"type":"code","text":"if (edad >= 18) {\n  printf(\"Mayor de edad\\n\");\n} else {\n  printf(\"Menor de edad\\n\");\n}\nfor (int i = 0; i < 3; i++) {\n  printf(\"%d\\n\", i);\n}"},{"type":"exercise","title":"Ejercicio práctico","steps":["Escribe un if.","Crea un for.","Verifica la salida."]},{"type":"tip","title":"Buena práctica","text":"Los bucles ayudan a automatizar tareas repetitivas con menos código."}]'::jsonb,
        3,
        false
    )
    RETURNING id INTO v_lesson_3;

    INSERT INTO public.lessons (id, course_id, slug, title, objective, content, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'funciones-y-punteros',
        'Funciones y punteros',
        'Reutilizar lógica y trabajar con memoria.',
        '[{"type":"paragraph","text":"Las funciones dividen el programa en bloques reutilizables."},{"type":"paragraph","text":"Los punteros guardan direcciones de memoria y son clave para arreglos y estructuras."},{"type":"code","text":"int sumar(int a, int b) { return a + b; }\nint x = 5;\nint *p = &x;"},{"type":"exercise","title":"Ejercicio práctico","steps":["Define sumar().","Llama a la función.","Comprueba el valor devuelto."]},{"type":"tip","title":"Consejo","text":"Los punteros permiten manipular memoria de forma precisa pero requieren cuidado."}]'::jsonb,
        4,
        false
    )
    RETURNING id INTO v_lesson_4;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published) VALUES (gen_random_uuid(), v_course_id, v_lesson_1, 'actividad-c-basico', 'Actividad 1: C básico', 'Elige la respuesta correcta.', 'activity', 70, 1, false) RETURNING id INTO v_activity_1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_1, '¿Qué librería usa printf?', 1, 1) RETURNING id INTO v_q1_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q1_id, 'stdio.h', 1), (v_q1_id, 'stdlib.h', 2), (v_q1_id, 'string.h', 3), (v_q1_id, 'math.h', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q1_id, qo.id, 'stdio.h incluye funciones de entrada y salida estándar.' FROM public.question_options qo WHERE qo.question_id = v_q1_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_1, '¿Qué función inicia todo programa en C?', 2, 1) RETURNING id INTO v_q2_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q2_id, 'main', 1), (v_q2_id, 'print', 2), (v_q2_id, 'start', 3), (v_q2_id, 'init', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q2_id, qo.id, 'main es el punto de entrada principal.' FROM public.question_options qo WHERE qo.question_id = v_q2_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_1, '¿Qué tipo guarda un entero?', 3, 1) RETURNING id INTO v_q3_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q3_id, 'int', 1), (v_q3_id, 'float', 2), (v_q3_id, 'char', 3), (v_q3_id, 'double', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q3_id, qo.id, 'int almacena números enteros.' FROM public.question_options qo WHERE qo.question_id = v_q3_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_1, '¿Qué instrucción termina el programa con éxito?', 4, 1) RETURNING id INTO v_q4_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q4_id, 'return 0;', 1), (v_q4_id, 'break;', 2), (v_q4_id, 'exit;', 3), (v_q4_id, 'close();', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q4_id, qo.id, 'return 0 indica finalización exitosa.' FROM public.question_options qo WHERE qo.question_id = v_q4_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_1, '¿Qué función imprime texto en consola?', 5, 1) RETURNING id INTO v_q5_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q5_id, 'printf', 1), (v_q5_id, 'echo', 2), (v_q5_id, 'print', 3), (v_q5_id, 'puts', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q5_id, qo.id, 'printf muestra texto formateado.' FROM public.question_options qo WHERE qo.question_id = v_q5_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published) VALUES (gen_random_uuid(), v_course_id, v_lesson_2, 'actividad-c-variables', 'Actividad 2: Variables y operadores', 'Selecciona la respuesta correcta.', 'activity', 70, 2, false) RETURNING id INTO v_activity_2;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_2, '¿Qué tipo guarda un valor decimal?', 1, 1) RETURNING id INTO v_q6_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q6_id, 'float', 1), (v_q6_id, 'int', 2), (v_q6_id, 'char', 3), (v_q6_id, 'bool', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q6_id, qo.id, 'float almacena valores decimales.' FROM public.question_options qo WHERE qo.question_id = v_q6_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_2, '¿Qué operador asigna un valor?', 2, 1) RETURNING id INTO v_q7_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q7_id, '=', 1), (v_q7_id, '==', 2), (v_q7_id, '!=', 3), (v_q7_id, '+=', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q7_id, qo.id, '= asigna el valor a la variable.' FROM public.question_options qo WHERE qo.question_id = v_q7_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_2, '¿Qué operador compara igualdad?', 3, 1) RETURNING id INTO v_q8_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q8_id, '==', 1), (v_q8_id, '=', 2), (v_q8_id, '!=', 3), (v_q8_id, '&&', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q8_id, qo.id, '== compara igualdad.' FROM public.question_options qo WHERE qo.question_id = v_q8_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_2, '¿Qué símbolo representa AND lógico?', 4, 1) RETURNING id INTO v_q9_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q9_id, '&&', 1), (v_q9_id, '&', 2), (v_q9_id, '||', 3), (v_q9_id, '!=', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q9_id, qo.id, '&& evalúa que ambas condiciones sean verdaderas.' FROM public.question_options qo WHERE qo.question_id = v_q9_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_2, '¿Qué tipo guarda un carácter?', 5, 1) RETURNING id INTO v_q10_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q10_id, 'char', 1), (v_q10_id, 'int', 2), (v_q10_id, 'float', 3), (v_q10_id, 'double', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q10_id, qo.id, 'char almacena un carácter individual.' FROM public.question_options qo WHERE qo.question_id = v_q10_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published) VALUES (gen_random_uuid(), v_course_id, v_lesson_3, 'actividad-c-flujo', 'Actividad 3: Condicionales y bucles', 'Responde según la lógica de control.', 'activity', 70, 3, false) RETURNING id INTO v_activity_3;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_3, '¿Qué estructura toma decisiones?', 1, 1) RETURNING id INTO v_q11_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q11_id, 'if', 1), (v_q11_id, 'switch', 2), (v_q11_id, 'for', 3), (v_q11_id, 'return', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q11_id, qo.id, 'if evalúa condiciones y decide rutas.' FROM public.question_options qo WHERE qo.question_id = v_q11_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_3, '¿Qué bucle repite un número fijo de veces?', 2, 1) RETURNING id INTO v_q12_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q12_id, 'for', 1), (v_q12_id, 'else', 2), (v_q12_id, 'case', 3), (v_q12_id, 'typedef', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q12_id, qo.id, 'for se usa cuando se sabe cuántas iteraciones habrá.' FROM public.question_options qo WHERE qo.question_id = v_q12_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_3, '¿Qué se usa para ejecutar una rama alternativa?', 3, 1) RETURNING id INTO v_q13_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q13_id, 'else', 1), (v_q13_id, 'break', 2), (v_q13_id, 'continue', 3), (v_q13_id, 'case', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q13_id, qo.id, 'else ejecuta cuando if no se cumple.' FROM public.question_options qo WHERE qo.question_id = v_q13_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_3, '¿Qué palabra clave termina un caso dentro de switch?', 4, 1) RETURNING id INTO v_q14_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q14_id, 'break', 1), (v_q14_id, 'continue', 2), (v_q14_id, 'return', 3), (v_q14_id, 'case', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q14_id, qo.id, 'break termina la ejecución de cada caso.' FROM public.question_options qo WHERE qo.question_id = v_q14_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_3, '¿Qué bucle continúa mientras la condición sea verdadera?', 5, 1) RETURNING id INTO v_q15_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q15_id, 'while', 1), (v_q15_id, 'struct', 2), (v_q15_id, 'if', 3), (v_q15_id, 'switch', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q15_id, qo.id, 'while repite mientras la condición se cumple.' FROM public.question_options qo WHERE qo.question_id = v_q15_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published) VALUES (gen_random_uuid(), v_course_id, v_lesson_4, 'actividad-c-funciones', 'Actividad 4: Funciones y punteros', 'Elige la opción más precisa.', 'activity', 70, 4, false) RETURNING id INTO v_activity_4;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_4, '¿Qué permite una función?', 1, 1) RETURNING id INTO v_q16_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q16_id, 'Reutilizar código', 1), (v_q16_id, 'Guardar memoria', 2), (v_q16_id, 'Ocultar variables', 3), (v_q16_id, 'Definir un arreglo', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q16_id, qo.id, 'Las funciones encapsulan lógica reutilizable.' FROM public.question_options qo WHERE qo.question_id = v_q16_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_4, '¿Qué es un puntero?', 2, 1) RETURNING id INTO v_q17_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q17_id, 'Variable que guarda una dirección de memoria', 1), (v_q17_id, 'Función de impresión', 2), (v_q17_id, 'Tipo booleano', 3), (v_q17_id, 'Bucle condicional', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q17_id, qo.id, 'Los punteros guardan direcciones de memoria.' FROM public.question_options qo WHERE qo.question_id = v_q17_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_4, '¿Qué operador obtiene la dirección de una variable?', 3, 1) RETURNING id INTO v_q18_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q18_id, '&', 1), (v_q18_id, '*', 2), (v_q18_id, '%', 3), (v_q18_id, '&&', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q18_id, qo.id, '& devuelve la dirección de memoria.' FROM public.question_options qo WHERE qo.question_id = v_q18_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_4, '¿Qué operador accede al valor apuntado por un puntero?', 4, 1) RETURNING id INTO v_q19_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q19_id, '*', 1), (v_q19_id, '&', 2), (v_q19_id, '=', 3), (v_q19_id, '||', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q19_id, qo.id, '* dereferencia el puntero.' FROM public.question_options qo WHERE qo.question_id = v_q19_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_4, '¿Qué ventaja ofrece una función bien diseñada?', 5, 1) RETURNING id INTO v_q20_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q20_id, 'Simplifica mantenimiento y reutilización', 1), (v_q20_id, 'Elimina la necesidad de main', 2), (v_q20_id, 'Hace cada programa más lento', 3), (v_q20_id, 'No requiere pruebas', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q20_id, qo.id, 'Las funciones mejoran organización y reutilización.' FROM public.question_options qo WHERE qo.question_id = v_q20_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published) VALUES (gen_random_uuid(), v_course_id, NULL, 'examen-final-c', 'Examen final: C para principiantes', 'Responde cada pregunta con la opción correcta.', 'exam', 70, 5, false) RETURNING id INTO v_exam_id;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué librería se usa con printf?', 1, 1) RETURNING id INTO v_q21_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q21_id, 'stdio.h', 1), (v_q21_id, 'stdlib.h', 2), (v_q21_id, 'math.h', 3), (v_q21_id, 'string.h', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q21_id, qo.id, 'stdio.h incluye printf y scanf.' FROM public.question_options qo WHERE qo.question_id = v_q21_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué función inicia todo programa en C?', 2, 1) RETURNING id INTO v_q22_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q22_id, 'main', 1), (v_q22_id, 'printf', 2), (v_q22_id, 'scanf', 3), (v_q22_id, 'start', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q22_id, qo.id, 'main es la función principal.' FROM public.question_options qo WHERE qo.question_id = v_q22_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué tipo de dato guarda números enteros?', 3, 1) RETURNING id INTO v_q23_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q23_id, 'int', 1), (v_q23_id, 'double', 2), (v_q23_id, 'char', 3), (v_q23_id, 'float', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q23_id, qo.id, 'int guarda enteros.' FROM public.question_options qo WHERE qo.question_id = v_q23_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué operador compara igualdad?', 4, 1) RETURNING id INTO v_q24_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q24_id, '==', 1), (v_q24_id, '=', 2), (v_q24_id, '!=', 3), (v_q24_id, '&&', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q24_id, qo.id, '== compara igualdad.' FROM public.question_options qo WHERE qo.question_id = v_q24_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué palabra clave se usa para cada caso en switch?', 5, 1) RETURNING id INTO v_q25_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q25_id, 'case', 1), (v_q25_id, 'default', 2), (v_q25_id, 'return', 3), (v_q25_id, 'while', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q25_id, qo.id, 'case define cada rama del switch.' FROM public.question_options qo WHERE qo.question_id = v_q25_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué sentencia sale del bucle actual?', 6, 1) RETURNING id INTO v_q26_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q26_id, 'break', 1), (v_q26_id, 'continue', 2), (v_q26_id, 'return', 3), (v_q26_id, 'switch', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q26_id, qo.id, 'break termina el bucle o switch actual.' FROM public.question_options qo WHERE qo.question_id = v_q26_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué estructura usa condiciones?', 7, 1) RETURNING id INTO v_q27_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q27_id, 'if', 1), (v_q27_id, 'struct', 2), (v_q27_id, 'enum', 3), (v_q27_id, 'for', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q27_id, qo.id, 'if decide según una condición.' FROM public.question_options qo WHERE qo.question_id = v_q27_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace el operador & sobre una variable?', 8, 1) RETURNING id INTO v_q28_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q28_id, 'Devuelve su dirección de memoria', 1), (v_q28_id, 'La multiplica', 2), (v_q28_id, 'La compara', 3), (v_q28_id, 'La concatena', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q28_id, qo.id, '& devuelve la dirección de memoria.' FROM public.question_options qo WHERE qo.question_id = v_q28_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace un puntero?', 9, 1) RETURNING id INTO v_q29_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q29_id, 'Guarda una dirección de memoria', 1), (v_q29_id, 'Ejecuta un bucle', 2), (v_q29_id, 'Es un tipo de cadena', 3), (v_q29_id, 'Inicia main', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q29_id, qo.id, 'Los punteros guardan referencias de memoria.' FROM public.question_options qo WHERE qo.question_id = v_q29_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace * sobre un puntero?', 10, 1) RETURNING id INTO v_q30_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q30_id, 'Accede al valor apuntado', 1), (v_q30_id, 'Crea un arreglo', 2), (v_q30_id, 'Declara una variable', 3), (v_q30_id, 'Cierra el programa', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q30_id, qo.id, '* dereferencia el puntero.' FROM public.question_options qo WHERE qo.question_id = v_q30_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué función se usa para leer entrada del usuario?', 11, 1) RETURNING id INTO v_q31_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q31_id, 'scanf', 1), (v_q31_id, 'printf', 2), (v_q31_id, 'main', 3), (v_q31_id, 'stdin', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q31_id, qo.id, 'scanf lee entrada del usuario.' FROM public.question_options qo WHERE qo.question_id = v_q31_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué permite una función bien escrita?', 12, 1) RETURNING id INTO v_q32_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q32_id, 'Organizar el código y reutilizar lógica', 1), (v_q32_id, 'Eliminar variables', 2), (v_q32_id, 'Generar HTML', 3), (v_q32_id, 'Cargar librerías automáticamente', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q32_id, qo.id, 'Las funciones mejoran organización y reutilización.' FROM public.question_options qo WHERE qo.question_id = v_q32_id AND qo.position = 1;
END $$;

COMMIT;
