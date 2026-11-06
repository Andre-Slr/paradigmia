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
        WHERE slug = 'java-basico-principiante'
    ) THEN
        RAISE EXCEPTION 'El slug java-basico-principiante ya existe en public.courses.';
    END IF;

    INSERT INTO public.courses (
        id, slug, title, description, language, level, duration_weeks, position, is_published
    )
    VALUES (
        gen_random_uuid(),
        'java-basico-principiante',
        'Java para principiantes',
        'Aprende sintaxis, flujo y clases básicas en Java.',
        'Java',
        'Principiante',
        4,
        999,
        false
    )
    RETURNING id INTO v_course_id;

    INSERT INTO public.lessons (
        id, course_id, slug, title, objective, content, position, is_published
    )
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'introduccion-a-java',
        'Introducción a Java',
        'Comprender la estructura de un programa Java.',
        '[{"type":"paragraph","text":"Java es un lenguaje orientado a objetos ampliamente usado en aplicaciones empresariales y móviles."},{"type":"paragraph","text":"Todo programa Java comienza desde una clase con método main."},{"type":"code","text":"public class Hola {\n  public static void main(String[] args) {\n    System.out.println(\"Hola, Java\");\n  }\n}"},{"type":"exercise","title":"Ejercicio práctico","steps":["Crea una clase Hola.","Agrega main.","Imprime un saludo."]},{"type":"tip","title":"Consejo","text":"La clase principal es el punto de entrada del programa."}]'::jsonb,
        1,
        false
    )
    RETURNING id INTO v_lesson_1;

    INSERT INTO public.lessons (
        id, course_id, slug, title, objective, content, position, is_published
    )
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'variables-y-tipos',
        'Variables y tipos',
        'Trabajar con tipos primitivos y variables.',
        '[{"type":"paragraph","text":"Las variables guardan valores y cada una tiene un tipo específico."},{"type":"paragraph","text":"Los tipos más comunes son int, double, boolean y String."},{"type":"code","text":"int edad = 20;\ndouble precio = 19.99;\nboolean activo = true;\nString nombre = \"Ana\";"},{"type":"exercise","title":"Ejercicio práctico","steps":["Declara dos variables numéricas.","Suma sus valores.","Muestra el resultado."]},{"type":"warning","title":"Atención","text":"Cada variable debe tener un tipo compatible con el valor asignado."}]'::jsonb,
        2,
        false
    )
    RETURNING id INTO v_lesson_2;

    INSERT INTO public.lessons (
        id, course_id, slug, title, objective, content, position, is_published
    )
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'condicionales-y-bucles',
        'Condicionales y bucles',
        'Controlar el flujo del programa.',
        '[{"type":"paragraph","text":"Las decisiones permiten ejecutar distintos bloques según condiciones."},{"type":"paragraph","text":"Los bucles repiten tareas sin duplicar código."},{"type":"code","text":"if (edad >= 18) {\n  System.out.println(\"Mayor de edad\");\n} else {\n  System.out.println(\"Menor de edad\");\n}\nfor (int i = 0; i < 5; i++) {\n  System.out.println(i);\n}"},{"type":"exercise","title":"Ejercicio práctico","steps":["Escribe un if para evaluar una nota.","Crea un bucle for.","Muestra el resultado."]},{"type":"tip","title":"Buena práctica","text":"La lógica condicional ayuda a decidir rutas distintas según los datos."}]'::jsonb,
        3,
        false
    )
    RETURNING id INTO v_lesson_3;

    INSERT INTO public.lessons (
        id, course_id, slug, title, objective, content, position, is_published
    )
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'poo-basica',
        'Programación orientada a objetos',
        'Entender clases, atributos y métodos.',
        '[{"type":"paragraph","text":"La POO organiza el código en clases y objetos."},{"type":"paragraph","text":"Los objetos tienen estado y comportamiento mediante atributos y métodos."},{"type":"code","text":"class Persona {\n  String nombre;\n  void saludar() {\n    System.out.println(\"Hola, \" + nombre);\n  }\n}"},{"type":"exercise","title":"Ejercicio práctico","steps":["Crea una clase Persona.","Agrega nombre.","Define saludar()."]},{"type":"tip","title":"Consejo","text":"Los objetos modelan entidades reales o abstractas con su propio comportamiento."}]'::jsonb,
        4,
        false
    )
    RETURNING id INTO v_lesson_4;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (gen_random_uuid(), v_course_id, v_lesson_1, 'actividad-java-sintaxis', 'Actividad 1: Sintaxis y clases', 'Selecciona la mejor opción.', 'activity', 70, 1, false)
    RETURNING id INTO v_activity_1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_1, '¿Qué símbolo termina una instrucción en Java?', 1, 1) RETURNING id INTO v_q1_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q1_id, ';', 1), (v_q1_id, ':', 2), (v_q1_id, ',', 3), (v_q1_id, '.', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q1_id, qo.id, 'Las instrucciones en Java terminan con punto y coma.' FROM public.question_options qo WHERE qo.question_id = v_q1_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_1, '¿Qué es el método main?', 2, 1) RETURNING id INTO v_q2_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q2_id, 'Punto de entrada del programa', 1), (v_q2_id, 'Clase abstracta', 2), (v_q2_id, 'Variable global', 3), (v_q2_id, 'Comentario', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q2_id, qo.id, 'main es el punto de entrada de una aplicación Java.' FROM public.question_options qo WHERE qo.question_id = v_q2_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_1, '¿Qué tipo representa texto?', 3, 1) RETURNING id INTO v_q3_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q3_id, 'String', 1), (v_q3_id, 'int', 2), (v_q3_id, 'double', 3), (v_q3_id, 'char', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q3_id, qo.id, 'String guarda cadenas de texto.' FROM public.question_options qo WHERE qo.question_id = v_q3_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_1, '¿Qué palabra clave define una clase?', 4, 1) RETURNING id INTO v_q4_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q4_id, 'class', 1), (v_q4_id, 'void', 2), (v_q4_id, 'return', 3), (v_q4_id, 'new', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q4_id, qo.id, 'class declara una clase.' FROM public.question_options qo WHERE qo.question_id = v_q4_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_1, '¿Qué instrucción imprime en consola?', 5, 1) RETURNING id INTO v_q5_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q5_id, 'System.out.println', 1), (v_q5_id, 'console.log', 2), (v_q5_id, 'printLine', 3), (v_q5_id, 'stdout', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q5_id, qo.id, 'System.out.println imprime el texto en consola.' FROM public.question_options qo WHERE qo.question_id = v_q5_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (gen_random_uuid(), v_course_id, v_lesson_2, 'actividad-java-variables', 'Actividad 2: Variables y tipos', 'Elige la opción correcta.', 'activity', 70, 2, false)
    RETURNING id INTO v_activity_2;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_2, '¿Qué tipo guarda un entero?', 1, 1) RETURNING id INTO v_q6_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q6_id, 'int', 1), (v_q6_id, 'boolean', 2), (v_q6_id, 'String', 3), (v_q6_id, 'double', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q6_id, qo.id, 'int almacena valores enteros.' FROM public.question_options qo WHERE qo.question_id = v_q6_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_2, '¿Qué tipo guarda verdadero o falso?', 2, 1) RETURNING id INTO v_q7_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q7_id, 'boolean', 1), (v_q7_id, 'char', 2), (v_q7_id, 'float', 3), (v_q7_id, 'byte', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q7_id, qo.id, 'boolean representa estados lógicos.' FROM public.question_options qo WHERE qo.question_id = v_q7_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_2, '¿Cuál es la sintaxis correcta para declarar una variable?', 3, 1) RETURNING id INTO v_q8_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q8_id, 'int edad = 20;', 1), (v_q8_id, 'edad = int 20;', 2), (v_q8_id, 'int = 20 edad;', 3), (v_q8_id, 'var edad: 20;', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q8_id, qo.id, 'La forma correcta es tipo nombre = valor;.' FROM public.question_options qo WHERE qo.question_id = v_q8_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_2, '¿Qué tipo se usa para números decimales?', 4, 1) RETURNING id INTO v_q9_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q9_id, 'double', 1), (v_q9_id, 'int', 2), (v_q9_id, 'boolean', 3), (v_q9_id, 'long', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q9_id, qo.id, 'double es apropiado para decimales.' FROM public.question_options qo WHERE qo.question_id = v_q9_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_2, '¿Qué operador realiza suma?', 5, 1) RETURNING id INTO v_q10_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q10_id, '+', 1), (v_q10_id, '-', 2), (v_q10_id, '*', 3), (v_q10_id, '/', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q10_id, qo.id, 'El símbolo + suma dos valores.' FROM public.question_options qo WHERE qo.question_id = v_q10_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (gen_random_uuid(), v_course_id, v_lesson_3, 'actividad-java-flujo', 'Actividad 3: Condicionales y bucles', 'Responde según la lógica de control.', 'activity', 70, 3, false)
    RETURNING id INTO v_activity_3;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_3, '¿Qué estructura evalúa condiciones?', 1, 1) RETURNING id INTO v_q11_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q11_id, 'if', 1), (v_q11_id, 'switch', 2), (v_q11_id, 'for', 3), (v_q11_id, 'while', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q11_id, qo.id, 'if ejecuta un bloque si la condición es verdadera.' FROM public.question_options qo WHERE qo.question_id = v_q11_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_3, '¿Qué bucle repite un número determinado de veces?', 2, 1) RETURNING id INTO v_q12_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q12_id, 'for', 1), (v_q12_id, 'else', 2), (v_q12_id, 'try', 3), (v_q12_id, 'case', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q12_id, qo.id, 'for se usa cuando se conoce la cantidad de iteraciones.' FROM public.question_options qo WHERE qo.question_id = v_q12_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_3, '¿Qué palabra clave se usa para la rama alternativa?', 3, 1) RETURNING id INTO v_q13_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q13_id, 'else', 1), (v_q13_id, 'return', 2), (v_q13_id, 'new', 3), (v_q13_id, 'final', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q13_id, qo.id, 'else ejecuta si la condición no se cumple.' FROM public.question_options qo WHERE qo.question_id = v_q13_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_3, '¿Qué operación compara igualdad?', 4, 1) RETURNING id INTO v_q14_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q14_id, '==', 1), (v_q14_id, '=', 2), (v_q14_id, '!=', 3), (v_q14_id, '<>', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q14_id, qo.id, '== compara igualdad, = asigna.' FROM public.question_options qo WHERE qo.question_id = v_q14_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_3, '¿Qué bucle continúa mientras la condición sea verdadera?', 5, 1) RETURNING id INTO v_q15_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q15_id, 'while', 1), (v_q15_id, 'switch', 2), (v_q15_id, 'class', 3), (v_q15_id, 'public', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q15_id, qo.id, 'while repite mientras se cumple la condición.' FROM public.question_options qo WHERE qo.question_id = v_q15_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (gen_random_uuid(), v_course_id, v_lesson_4, 'actividad-java-poo', 'Actividad 4: POO básica', 'Identifica los conceptos clave.', 'activity', 70, 4, false)
    RETURNING id INTO v_activity_4;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_4, '¿Qué es una clase?', 1, 1) RETURNING id INTO v_q16_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q16_id, 'Plantilla para crear objetos', 1), (v_q16_id, 'Condición lógica', 2), (v_q16_id, 'Variable global', 3), (v_q16_id, 'Tipo primitivo', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q16_id, qo.id, 'La clase define la estructura del objeto.' FROM public.question_options qo WHERE qo.question_id = v_q16_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_4, '¿Qué representa un atributo?', 2, 1) RETURNING id INTO v_q17_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q17_id, 'Estado de un objeto', 1), (v_q17_id, 'Operación del programa', 2), (v_q17_id, 'Comentario', 3), (v_q17_id, 'Paquete Java', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q17_id, qo.id, 'Los atributos describen el estado del objeto.' FROM public.question_options qo WHERE qo.question_id = v_q17_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_4, '¿Qué es un método?', 3, 1) RETURNING id INTO v_q18_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q18_id, 'Acción que realiza un objeto', 1), (v_q18_id, 'Tipo de bucle', 2), (v_q18_id, 'Comentario de código', 3), (v_q18_id, 'Sentencia import', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q18_id, qo.id, 'Los métodos encapsulan comportamientos.' FROM public.question_options qo WHERE qo.question_id = v_q18_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_4, '¿Qué palabra clave crea una instancia?', 4, 1) RETURNING id INTO v_q19_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q19_id, 'new', 1), (v_q19_id, 'return', 2), (v_q19_id, 'static', 3), (v_q19_id, 'if', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q19_id, qo.id, 'new crea un objeto de una clase.' FROM public.question_options qo WHERE qo.question_id = v_q19_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_activity_4, '¿Qué ventaja ofrece la POO?', 5, 1) RETURNING id INTO v_q20_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q20_id, 'Organiza mejor el código y reutiliza lógica', 1), (v_q20_id, 'Elimina variables', 2), (v_q20_id, 'Reduce el código a una sola línea', 3), (v_q20_id, 'Solo sirve para GUIs', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q20_id, qo.id, 'POO ayuda a modelar problemas complejos y reutilizar código.' FROM public.question_options qo WHERE qo.question_id = v_q20_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (gen_random_uuid(), v_course_id, NULL, 'examen-final-java', 'Examen final: Java para principiantes', 'Elige la respuesta correcta.', 'exam', 70, 5, false)
    RETURNING id INTO v_exam_id;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué palabra clave permite declarar una clase pública?', 1, 1) RETURNING id INTO v_q21_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q21_id, 'public', 1), (v_q21_id, 'static', 2), (v_q21_id, 'void', 3), (v_q21_id, 'new', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q21_id, qo.id, 'public define la visibilidad de la clase.' FROM public.question_options qo WHERE qo.question_id = v_q21_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué método da inicio a la aplicación?', 2, 1) RETURNING id INTO v_q22_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q22_id, 'main', 1), (v_q22_id, 'run', 2), (v_q22_id, 'start', 3), (v_q22_id, 'execute', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q22_id, qo.id, 'main es el punto de entrada.' FROM public.question_options qo WHERE qo.question_id = v_q22_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué tipo de dato representa un carácter?', 3, 1) RETURNING id INTO v_q23_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q23_id, 'char', 1), (v_q23_id, 'String', 2), (v_q23_id, 'int', 3), (v_q23_id, 'float', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q23_id, qo.id, 'char almacena un carácter.' FROM public.question_options qo WHERE qo.question_id = v_q23_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué operador compara igualdad?', 4, 1) RETURNING id INTO v_q24_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q24_id, '==', 1), (v_q24_id, '=', 2), (v_q24_id, '!=', 3), (v_q24_id, '=>', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q24_id, qo.id, '== compara valores.' FROM public.question_options qo WHERE qo.question_id = v_q24_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué palabra clave devuelve un valor desde un método?', 5, 1) RETURNING id INTO v_q25_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q25_id, 'return', 1), (v_q25_id, 'break', 2), (v_q25_id, 'continue', 3), (v_q25_id, 'case', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q25_id, qo.id, 'return termina el método y devuelve el valor.' FROM public.question_options qo WHERE qo.question_id = v_q25_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué estructura repite mientras se cumple una condición?', 6, 1) RETURNING id INTO v_q26_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q26_id, 'while', 1), (v_q26_id, 'switch', 2), (v_q26_id, 'class', 3), (v_q26_id, 'else', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q26_id, qo.id, 'while ejecuta mientras la condición es verdadera.' FROM public.question_options qo WHERE qo.question_id = v_q26_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué estructura es útil para múltiples casos?', 7, 1) RETURNING id INTO v_q27_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q27_id, 'switch', 1), (v_q27_id, 'string', 2), (v_q27_id, 'for', 3), (v_q27_id, 'return', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q27_id, qo.id, 'switch se usa para comparar múltiples alternativas.' FROM public.question_options qo WHERE qo.question_id = v_q27_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué palabra clave define un método sin devolver valor?', 8, 1) RETURNING id INTO v_q28_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q28_id, 'void', 1), (v_q28_id, 'boolean', 2), (v_q28_id, 'char', 3), (v_q28_id, 'long', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q28_id, qo.id, 'void indica que no devuelve nada.' FROM public.question_options qo WHERE qo.question_id = v_q28_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace break en un bucle?', 9, 1) RETURNING id INTO v_q29_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q29_id, 'Sale del bucle', 1), (v_q29_id, 'Reinicia la variable', 2), (v_q29_id, 'Declara una clase', 3), (v_q29_id, 'Declara un atributo', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q29_id, qo.id, 'break interrumpe la ejecución del bucle.' FROM public.question_options qo WHERE qo.question_id = v_q29_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué es una instancia?', 10, 1) RETURNING id INTO v_q30_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q30_id, 'Un objeto creado a partir de una clase', 1), (v_q30_id, 'Un tipo primitivo', 2), (v_q30_id, 'Un paquete', 3), (v_q30_id, 'Un comentario', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q30_id, qo.id, 'Una instancia es un objeto concreto.' FROM public.question_options qo WHERE qo.question_id = v_q30_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué permite la encapsulación?', 11, 1) RETURNING id INTO v_q31_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q31_id, 'Controlar el acceso a atributos y métodos', 1), (v_q31_id, 'Duplicar código', 2), (v_q31_id, 'Eliminar condicionales', 3), (v_q31_id, 'Reemplazar clases', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q31_id, qo.id, 'Encapsulación controla el acceso y protege el estado.' FROM public.question_options qo WHERE qo.question_id = v_q31_id AND qo.position = 1;
    INSERT INTO public.questions (id, assessment_id, prompt, position, points) VALUES (gen_random_uuid(), v_exam_id, '¿Qué puede guardar datos del objeto?', 12, 1) RETURNING id INTO v_q32_id; INSERT INTO public.question_options (question_id, option_text, position) VALUES (v_q32_id, 'Atributo', 1), (v_q32_id, 'Método', 2), (v_q32_id, 'Paquete', 3), (v_q32_id, 'Comentario', 4); INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation) SELECT v_q32_id, qo.id, 'Los atributos almacenan el estado del objeto.' FROM public.question_options qo WHERE qo.question_id = v_q32_id AND qo.position = 1;
END $$;

COMMIT;
