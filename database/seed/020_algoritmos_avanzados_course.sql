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
    IF EXISTS (SELECT 1 FROM public.courses WHERE slug = 'algoritmos-avanzados') THEN
        RAISE EXCEPTION 'El slug algoritmos-avanzados ya existe en public.courses.';
    END IF;

    INSERT INTO public.courses (id, slug, title, description, language, level, duration_weeks, position, is_published)
    VALUES (
        gen_random_uuid(),
        'algoritmos-avanzados',
        'Algoritmos avanzados',
        'Curso avanzado para profundizar en análisis de complejidad, algoritmos de grafos, programación dinámica, divide y vencerás y estrategias de optimización.',
        'Algoritmos',
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
        'complejidad-y-optimizacion',
        'Complejidad y optimización',
        'Analizar la eficiencia de algoritmos y estimar costos de tiempo y espacio.',
        '[{"type":"paragraph","text":"La complejidad algorítmica permite comparar soluciones y anticipar su rendimiento en datos grandes."},{"type":"paragraph","text":"La notación Big O describe el crecimiento de costo según el tamaño de entrada y ayuda a elegir enfoques más escalables."},{"type":"code","text":"O(log n)\nO(n log n)\nO(n^2)"},{"type":"exercise","title":"Ejercicio práctico","steps":["Compara dos algoritmos de búsqueda.","Identifica qué estructura domina en tiempo lineal.","Explica por qué un algoritmo cuadrático puede ser insuficiente."]},{"type":"tip","title":"Consejo","text":"La mejor solución no siempre es la más compleja; a menudo la más apropiada es la más predecible."}]'::jsonb,
        1,
        false
    )
    RETURNING id INTO v_lesson_1;

    INSERT INTO public.lessons (id, course_id, slug, title, objective, content, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'grafos-y-recorridos',
        'Grafos y recorridos',
        'Trabajar con estructuras de grafo, recorridos, conectividad y caminos mínimos.',
        '[{"type":"paragraph","text":"Los grafos modelan relaciones entre nodos y son esenciales para redes, rutas y dependencias."},{"type":"paragraph","text":"BFS y DFS permiten recorrer nodos con distintas estrategias según el problema que se quiere resolver."},{"type":"code","text":"BFS para distancias mínimas\nDFS para exploración profunda\nDijkstra para pesos positivos"},{"type":"exercise","title":"Ejercicio práctico","steps":["Dibuja un grafo simple.","Aplica BFS para encontrar una ruta mínima.","Compara DFS con BFS para una relación de dependencia."]},{"type":"warning","title":"Atención","text":"En grafos ponderados, la estrategia de recorrido debe considerar costos y pesos."}]'::jsonb,
        2,
        false
    )
    RETURNING id INTO v_lesson_2;

    INSERT INTO public.lessons (id, course_id, slug, title, objective, content, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'programacion-dinamica',
        'Programación dinámica',
        'Resolver subproblemas superpuestos y aplicar optimización sobre estados intermedios.',
        '[{"type":"paragraph","text":"La programación dinámica resuelve problemas complejos dividiéndolos en subproblemas reutilizables."},{"type":"paragraph","text":"Es útil cuando una solución óptima depende de decisiones previas y varias rutas conducen a soluciones repetidas."},{"type":"code","text":"dp[i] = mejorSolucionHasta(i)\nsubproblema con memoización"},{"type":"exercise","title":"Ejercicio práctico","steps":["Identifica un problema de optimización repetitivo.","Define un estado intermedio.","Evalúa si conviene memoización o tabulación."]},{"type":"tip","title":"Buena práctica","text":"La programación dinámica suele requerir reconocer estados y transiciones, no solo recursividad."}]'::jsonb,
        3,
        false
    )
    RETURNING id INTO v_lesson_3;

    INSERT INTO public.lessons (id, course_id, slug, title, objective, content, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        'divide-y-venceras',
        'Divide y vencerás',
        'Aplicar estrategias de partición, combinación y reducción para resolver problemas grandes.',
        '[{"type":"paragraph","text":"El enfoque divide y vencerás descompone un problema en subproblemas más pequeños y luego combina soluciones."},{"type":"paragraph","text":"Es especialmente útil para búsquedas, ordenación y problemas que admiten partición recursiva."},{"type":"code","text":"merge sort\nquick sort\nbinary search"},{"type":"exercise","title":"Ejercicio práctico","steps":["Particiona un problema en dos subproblemas.","Define cómo combinar resultados.","Evalúa la profundidad de recursión y su costo."]},{"type":"warning","title":"Atención","text":"La estrategia debe equilibrar costo de partición y costo de combinación."}]'::jsonb,
        4,
        false
    )
    RETURNING id INTO v_lesson_4;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        v_lesson_1,
        'act-alg-complejidad',
        'Actividad 1: Complejidad y optimización',
        'Elige la respuesta correcta.',
        'activity',
        70,
        1,
        false
    )
    RETURNING id INTO v_activity_1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué representa la notación O(n log n)?', 1, 1)
    RETURNING id INTO v_q1_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q1_id, 'Un crecimiento logarítmico multiplicado por n', 1), (v_q1_id, 'Un crecimiento constante', 2), (v_q1_id, 'Un crecimiento lineal puro', 3), (v_q1_id, 'Un crecimiento exponencial', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q1_id, qo.id, 'O(n log n) combina crecimiento lineal con un factor logarítmico, típico de búsquedas y ordenamientos eficientes.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q1_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué algoritmo suele ser más eficiente para ordenar grandes volúmenes?', 2, 1)
    RETURNING id INTO v_q2_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q2_id, 'Merge sort', 1), (v_q2_id, 'Búsqueda lineal', 2), (v_q2_id, 'Inserción en lista desordenada', 3), (v_q2_id, 'Recorrido completo sin comparación', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q2_id, qo.id, 'Merge sort tiene complejidad O(n log n) y escala mejor en conjuntos grandes.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q2_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué indica una complejidad O(1)?', 3, 1)
    RETURNING id INTO v_q3_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q3_id, 'Tiempo constante independiente del tamaño de entrada', 1), (v_q3_id, 'Tiempo que crece linealmente', 2), (v_q3_id, 'Tiempo que crece exponencialmente', 3), (v_q3_id, 'Tiempo no determinista', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q3_id, qo.id, 'O(1) indica acceso o cálculo sin depender del tamaño de entrada.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q3_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué es una mejor estrategia para mejorar la eficiencia en un problema repetitivo?', 4, 1)
    RETURNING id INTO v_q4_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q4_id, 'Identificar subproblemas solapados y reutilizar resultados', 1), (v_q4_id, 'Duplicar el problema varias veces', 2), (v_q4_id, 'Eliminar validaciones', 3), (v_q4_id, 'Usar solo algoritmos de fuerza bruta', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q4_id, qo.id, 'Reutilizar subresultados reduce costo y suele ser la base de la optimización.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q4_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_1, '¿Qué es el costo espacial de un algoritmo?', 5, 1)
    RETURNING id INTO v_q5_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q5_id, 'La cantidad de memoria que necesita para ejecutarse', 1), (v_q5_id, 'La calidad del código fuente', 2), (v_q5_id, 'El tiempo de compilación', 3), (v_q5_id, 'La cantidad de funciones que usa', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q5_id, qo.id, 'El costo espacial mide memoria adicional o almacenamiento necesario.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q5_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        v_lesson_2,
        'act-alg-grafos',
        'Actividad 2: Grafos y recorridos',
        'Elige la respuesta correcta.',
        'activity',
        70,
        2,
        false
    )
    RETURNING id INTO v_activity_2;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué característica define un grafo no dirigido?', 1, 1)
    RETURNING id INTO v_q6_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q6_id, 'Las conexiones son simétricas entre nodos', 1), (v_q6_id, 'Solo hay un nodo raíz', 2), (v_q6_id, 'No existen pesos', 3), (v_q6_id, 'Debe ser acíclico', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q6_id, qo.id, 'En grafos no dirigidos, la relación es bidireccional entre nodos conectados.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q6_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué hace BFS en un grafo?', 2, 1)
    RETURNING id INTO v_q7_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q7_id, 'Explora nodos por niveles desde un origen', 1), (v_q7_id, 'Ordena todos los elementos en un vector', 2), (v_q7_id, 'Solo mira nodos terminales', 3), (v_q7_id, 'Se usa solo en árboles binarios', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q7_id, qo.id, 'BFS recorre capas de nodos desde una fuente y se usa para distancias mínimas.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q7_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Cuál es una aplicación típica de Dijkstra?', 3, 1)
    RETURNING id INTO v_q8_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q8_id, 'Encontrar caminos mínimos de menor costo en grafos ponderados', 1), (v_q8_id, 'Recorrer una lista sin pesos', 2), (v_q8_id, 'Crear estructuras de datos sin nodos', 3), (v_q8_id, 'Comparar cadenas de texto de forma aleatoria', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q8_id, qo.id, 'Dijkstra resuelve caminos mínimos con pesos no negativos.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q8_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué diferencia a DFS de BFS?', 4, 1)
    RETURNING id INTO v_q9_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q9_id, 'DFS profundiza antes que amortigua la exploración por niveles', 1), (v_q9_id, 'DFS no usa colas', 2), (v_q9_id, 'BFS siempre es más lento que DFS', 3), (v_q9_id, 'DFS solo sirve con grafos dirigidos', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q9_id, qo.id, 'DFS explora hacia profundidad antes de explorar nodos vecinos de la misma capa.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q9_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_2, '¿Qué es una componente conexa?', 5, 1)
    RETURNING id INTO v_q10_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q10_id, 'Un conjunto de nodos unidos por rutas', 1), (v_q10_id, 'Un enfoque de ordenamiento', 2), (v_q10_id, 'Un árbol binario completo', 3), (v_q10_id, 'Un tipo de hash table', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q10_id, qo.id, 'Una componente conexa agrupa nodos que pueden comunicarse entre sí.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q10_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        v_lesson_3,
        'act-alg-dinamica',
        'Actividad 3: Programación dinámica',
        'Elige la respuesta correcta.',
        'activity',
        70,
        3,
        false
    )
    RETURNING id INTO v_activity_3;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué es la programación dinámica?', 1, 1)
    RETURNING id INTO v_q11_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q11_id, 'Descomponer un problema y reutilizar soluciones de subproblemas', 1), (v_q11_id, 'Resolver problemas sin memoización', 2), (v_q11_id, 'Un algoritmo de ordenamiento lineal', 3), (v_q11_id, 'Una técnica exclusiva de redes', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q11_id, qo.id, 'La programación dinámica se basa en subproblemas solapados y solución óptima incremental.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q11_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué es la memoización?', 2, 1)
    RETURNING id INTO v_q12_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q12_id, 'Guardar resultados calculados para reutilizarlos', 1), (v_q12_id, 'Eliminar datos de memoria', 2), (v_q12_id, 'Reducir la complejidad logarítmica', 3), (v_q12_id, 'Transformar un problema en uno lineal', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q12_id, qo.id, 'Memoización almacena resultados para evitar recomputación repetida.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q12_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué problema encaja bien con programación dinámica?', 3, 1)
    RETURNING id INTO v_q13_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q13_id, 'Algoritmos con decisiones secuenciales y estados repetidos', 1), (v_q13_id, 'Solo búsquedas binarias', 2), (v_q13_id, 'Ningún problema combinatorio', 3), (v_q13_id, 'Problemas sin subestructuras', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q13_id, qo.id, 'La programación dinámica es útil cuando un problema puede definirse por subproblemas repetidos y estados intermedios.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q13_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué es una tabla de programación dinámica?', 4, 1)
    RETURNING id INTO v_q14_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q14_id, 'Una estructura que guarda soluciones intermedias para reutilizarlas', 1), (v_q14_id, 'Un conjunto de archivos de configuración', 2), (v_q14_id, 'Un árbol binario infijo', 3), (v_q14_id, 'Un algoritmo de ordenamiento', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q14_id, qo.id, 'La tabla DP guarda resultados parciales para construir la solución final.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q14_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_3, '¿Qué ventaja tiene la tabulación frente a la recursión simple?', 5, 1)
    RETURNING id INTO v_q15_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q15_id, 'Evita recalcular estados y reduce costo de llamadas repetidas', 1), (v_q15_id, 'Hace que todos los problemas sean O(1)', 2), (v_q15_id, 'Elimina la necesidad de estados', 3), (v_q15_id, 'Asegura solución sin errores', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q15_id, qo.id, 'Tabular estados evita repetir trabajo y suele ser más eficiente para problemas solapados.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q15_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        v_lesson_4,
        'act-alg-divide',
        'Actividad 4: Divide y vencerás',
        'Elige la respuesta correcta.',
        'activity',
        70,
        4,
        false
    )
    RETURNING id INTO v_activity_4;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué describe el enfoque divide y vencerás?', 1, 1)
    RETURNING id INTO v_q16_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q16_id, 'Partir un problema en subproblemas más pequeños y combinar soluciones', 1), (v_q16_id, 'Evitar todas las particiones', 2), (v_q16_id, 'Resolver todo sin recursión', 3), (v_q16_id, 'Reducir código a una sola línea', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q16_id, qo.id, 'Divide y vencerás fragmenta el problema, resuelve partes y fusiona resultados.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q16_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué algoritmo clásico usa divide y vencerás?', 2, 1)
    RETURNING id INTO v_q17_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q17_id, 'Merge sort', 1), (v_q17_id, 'Hash map lineal', 2), (v_q17_id, 'Búsqueda secuencial por fuerza bruta', 3), (v_q17_id, 'Despliegue sin lógica', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q17_id, qo.id, 'Merge sort es un ejemplo clásico del enfoque divide y vencerás.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q17_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué favorece la recursión en este enfoque?', 3, 1)
    RETURNING id INTO v_q18_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q18_id, 'Resolver subproblemas de tamaño reducido de forma repetida', 1), (v_q18_id, 'Evitar la combinación de soluciones', 2), (v_q18_id, 'Eliminar la necesidad de partición', 3), (v_q18_id, 'Asegurar que no haya decisión alguna', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q18_id, qo.id, 'La recursión permite reducir el problema a instancias menores y manejables.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q18_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué riesgo tiene una partición muy desigual?', 4, 1)
    RETURNING id INTO v_q19_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q19_id, 'Aumenta la profundidad recursiva y puede empeorar rendimiento', 1), (v_q19_id, 'Mejora siempre la complejidad', 2), (v_q19_id, 'Elimina memoria auxiliar', 3), (v_q19_id, 'No afecta al algoritmo', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q19_id, qo.id, 'Una partición muy desigual puede llevar a recursión profunda y peor rendimiento.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q19_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_activity_4, '¿Qué es una combinación en divide y vencerás?', 5, 1)
    RETURNING id INTO v_q20_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q20_id, 'La etapa que integra soluciones parciales en una respuesta final', 1), (v_q20_id, 'La fase de carga inicial del programa', 2), (v_q20_id, 'Un análisis sin datos reales', 3), (v_q20_id, 'Una búsqueda lineal sin recursión', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q20_id, qo.id, 'La combinación reúne soluciones locales para producir la solución completa.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q20_id AND qo.position = 1;

    INSERT INTO public.assessments (id, course_id, lesson_id, slug, title, instructions, kind, passing_score, position, is_published)
    VALUES (
        gen_random_uuid(),
        v_course_id,
        NULL,
        'exam-algoritmos-avanzados',
        'Examen final: Algoritmos avanzados',
        'Selecciona la respuesta correcta para cada pregunta.',
        'exam',
        70,
        5,
        false
    )
    RETURNING id INTO v_exam_id;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué problema resuelve un árbol de decisión?', 1, 1)
    RETURNING id INTO v_q21_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q21_id, 'Modelar decisiones y condiciones para elegir una ruta', 1), (v_q21_id, 'Calcular la suma de una secuencia lineal', 2), (v_q21_id, 'Evitar cualquier complejidad', 3), (v_q21_id, 'Eliminar datos no estructurados', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q21_id, qo.id, 'Los árboles de decisión representan decisiones secuenciales basadas en condiciones.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q21_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué es un algoritmo greedy?', 2, 1)
    RETURNING id INTO v_q22_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q22_id, 'Un enfoque que elige la mejor opción local en cada paso', 1), (v_q22_id, 'Un algoritmo sin decisiones', 2), (v_q22_id, 'Un tipo de base de datos', 3), (v_q22_id, 'Un proceso sin recursión', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q22_id, qo.id, 'Greedy toma decisiones locales óptimas con la esperanza de lograr una solución global buena.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q22_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué problema resuelve BFS cuando el grafo tiene pesos uniformes?', 3, 1)
    RETURNING id INTO v_q23_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q23_id, 'Encuentra la ruta más corta en número de aristas', 1), (v_q23_id, 'Ordena el grafo sin recorrerlo', 2), (v_q23_id, 'Solo identifica ciclos', 3), (v_q23_id, 'Genera números primos', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q23_id, qo.id, 'BFS encuentra la ruta mínima en términos de número de pasos cuando todos los arcos tienen el mismo costo.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q23_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué es un ciclo en un grafo?', 4, 1)
    RETURNING id INTO v_q24_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q24_id, 'Un camino que vuelve a un nodo anteriormente visitado', 1), (v_q24_id, 'Un árbol sin aristas', 2), (v_q24_id, 'Una lista ordenada', 3), (v_q24_id, 'Una función de hash', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q24_id, qo.id, 'Un ciclo es una trayectoria cerrada que retorna a un nodo previo.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q24_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué ventaja tiene la memoización sobre recursión sin caché?', 5, 1)
    RETURNING id INTO v_q25_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q25_id, 'Evita recalcular soluciones repetidas', 1), (v_q25_id, 'Hace que el problema sea completamente lineal', 2), (v_q25_id, 'Interrumpe la lógica del algoritmo', 3), (v_q25_id, 'Elimina la necesidad de estados', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q25_id, qo.id, 'La memoización reutiliza cálculos previos y reduce trabajo repetido.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q25_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué característica hace que un problema sea apropiado para programación dinámica?', 6, 1)
    RETURNING id INTO v_q26_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q26_id, 'Tiene subproblemas solapados y decisiones dependientes de estados', 1), (v_q26_id, 'No requiere ninguna estructura de datos', 2), (v_q26_id, 'Depende solo de una única operación', 3), (v_q26_id, 'No requiere memoria auxiliar', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q26_id, qo.id, 'Los problemas con superposición de subproblemas son candidatos idóneos para DP.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q26_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué es un algoritmo de ordenamiento estable?', 7, 1)
    RETURNING id INTO v_q27_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q27_id, 'Mantiene el orden relativo de elementos iguales', 1), (v_q27_id, 'Elimina elementos duplicados', 2), (v_q27_id, 'No necesita comparación', 3), (v_q27_id, 'Solo trabaja con listas vacías', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q27_id, qo.id, 'La estabilidad garantiza que elementos equivalentes conserven su orden original.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q27_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué hace una búsqueda binaria?', 8, 1)
    RETURNING id INTO v_q28_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q28_id, 'Divide el espacio de búsqueda en mitades y reduce el rango cada vez', 1), (v_q28_id, 'Revisa cada elemento en orden', 2), (v_q28_id, 'Solo busca en listas desordenadas', 3), (v_q28_id, 'No necesita que la colección esté ordenada', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q28_id, qo.id, 'Búsqueda binaria explota ordenación para descartar mitades del conjunto.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q28_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué puede provocar una cola de prioridad?', 9, 1)
    RETURNING id INTO v_q29_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q29_id, 'Escoger siempre el elemento con mayor o menor prioridad según la política', 1), (v_q29_id, 'Un método de ordenamiento sin comparación', 2), (v_q29_id, 'Una lista ordenada manualmente', 3), (v_q29_id, 'Ajustes de configuración visual', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q29_id, qo.id, 'Una cola de prioridad entrega elementos según prioridad, no simplemente por ingreso.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q29_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué ocurre si un algoritmo tiene complejidad exponencial?', 10, 1)
    RETURNING id INTO v_q30_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q30_id, 'Puede volverse impracticable incluso con entradas medianas', 1), (v_q30_id, 'Siempre es óptimo para todos los casos', 2), (v_q30_id, 'No necesita memoria', 3), (v_q30_id, 'No se aplica a problemas reales', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q30_id, qo.id, 'La exponencial crece muy rápido y suele ser inviable para tamaños no triviales.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q30_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué es una solución óptima local?', 11, 1)
    RETURNING id INTO v_q31_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q31_id, 'Una decisión adecuada para el estado actual, aunque no garantice la mejor solución global', 1), (v_q31_id, 'La única posible en todo problema', 2), (v_q31_id, 'Una solución sin costo', 3), (v_q31_id, 'Un tipo de dato', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q31_id, qo.id, 'Una solución óptima local puede ser razonable localmente, pero no siempre globalmente óptima.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q31_id AND qo.position = 1;

    INSERT INTO public.questions (id, assessment_id, prompt, position, points)
    VALUES (gen_random_uuid(), v_exam_id, '¿Qué criterio suele usar un algoritmo de optimización a la hora de elegir una solución?', 12, 1)
    RETURNING id INTO v_q32_id;
    INSERT INTO public.question_options (question_id, option_text, position)
    VALUES (v_q32_id, 'Un criterio de costo, beneficio o objetivo global', 1), (v_q32_id, 'Un único valor aleatorio', 2), (v_q32_id, 'Un archivo de entrada fijo', 3), (v_q32_id, 'Un conjunto de variables visuales', 4);
    INSERT INTO paradigmia_private.correct_options (question_id, option_id, explanation)
    SELECT v_q32_id, qo.id, 'Los algoritmos de optimización buscan un equilibrio entre costo y beneficio para un objetivo concreto.'
    FROM public.question_options qo
    WHERE qo.question_id = v_q32_id AND qo.position = 1;

END $$;

COMMIT;
