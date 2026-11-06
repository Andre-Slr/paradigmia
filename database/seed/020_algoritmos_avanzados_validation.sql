SELECT c.id, c.slug, c.title, c.is_published
FROM public.courses c
WHERE c.slug = 'algoritmos-avanzados';

SELECT COUNT(*) AS lesson_count
FROM public.lessons l
JOIN public.courses c ON c.id = l.course_id
WHERE c.slug = 'algoritmos-avanzados';

SELECT a.kind, COUNT(*) AS assessment_count
FROM public.assessments a
JOIN public.courses c ON c.id = a.course_id
WHERE c.slug = 'algoritmos-avanzados'
GROUP BY a.kind
ORDER BY a.kind;

SELECT a.slug, a.kind, COUNT(q.id) AS question_count
FROM public.assessments a
LEFT JOIN public.questions q ON q.assessment_id = a.id
JOIN public.courses c ON c.id = a.course_id
WHERE c.slug = 'algoritmos-avanzados'
GROUP BY a.id, a.slug, a.kind, a.position
ORDER BY a.position;

SELECT q.id AS question_id, q.prompt, COUNT(qo.id) AS option_count
FROM public.questions q
LEFT JOIN public.question_options qo ON qo.question_id = q.id
JOIN public.assessments a ON a.id = q.assessment_id
JOIN public.courses c ON c.id = a.course_id
WHERE c.slug = 'algoritmos-avanzados'
GROUP BY q.id, q.prompt
HAVING COUNT(qo.id) <> 4
ORDER BY q.id;

SELECT q.id AS question_id, q.prompt, COUNT(co.question_id) AS correct_option_count
FROM public.questions q
LEFT JOIN paradigmia_private.correct_options co ON co.question_id = q.id
JOIN public.assessments a ON a.id = q.assessment_id
JOIN public.courses c ON c.id = a.course_id
WHERE c.slug = 'algoritmos-avanzados'
GROUP BY q.id, q.prompt
HAVING COUNT(co.question_id) <> 1
ORDER BY q.id;

SELECT a.id, a.slug, a.title
FROM public.assessments a
JOIN public.courses c ON c.id = a.course_id
WHERE c.slug = 'algoritmos-avanzados' AND a.is_published = true;

SELECT
    (SELECT COUNT(*) FROM public.lessons WHERE course_id = (SELECT id FROM public.courses WHERE slug = 'algoritmos-avanzados')) AS total_lessons,
    (SELECT COUNT(*) FROM public.assessments WHERE course_id = (SELECT id FROM public.courses WHERE slug = 'algoritmos-avanzados')) AS total_assessments,
    (SELECT COUNT(*) FROM public.questions WHERE assessment_id IN (SELECT id FROM public.assessments WHERE course_id = (SELECT id FROM public.courses WHERE slug = 'algoritmos-avanzados'))) AS total_questions,
    (SELECT COUNT(*) FROM public.question_options WHERE question_id IN (SELECT q.id FROM public.questions q JOIN public.assessments a ON a.id = q.assessment_id WHERE a.course_id = (SELECT id FROM public.courses WHERE slug = 'algoritmos-avanzados'))) AS total_options,
    (SELECT COUNT(*) FROM paradigmia_private.correct_options WHERE question_id IN (SELECT q.id FROM public.questions q JOIN public.assessments a ON a.id = q.assessment_id WHERE a.course_id = (SELECT id FROM public.courses WHERE slug = 'algoritmos-avanzados'))) AS total_correct_answers;

SELECT q.id AS question_id, co.option_id
FROM public.questions q
JOIN public.assessments a ON a.id = q.assessment_id
JOIN public.courses c ON c.id = a.course_id
JOIN paradigmia_private.correct_options co ON co.question_id = q.id
LEFT JOIN public.question_options qo ON qo.id = co.option_id AND qo.question_id = q.id
WHERE c.slug = 'algoritmos-avanzados' AND qo.id IS NULL;

SELECT l.id, l.slug
FROM public.lessons l
JOIN public.courses c ON c.id = l.course_id
WHERE c.slug = 'algoritmos-avanzados' AND l.is_published = true;
