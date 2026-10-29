-- PARADIGMIA / MIGRACION 001 (revisada)
-- Ejecutar SOLO tras revisar y respaldar el proyecto compartido.
-- No modifica public.perfiles ni public.onboarding_responses.
-- La ejecucion debe hacerse con un rol administrador (SQL Editor).
BEGIN;
CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE public.courses (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 slug text NOT NULL UNIQUE CHECK (slug ~ '^[a-z0-9]+(-[a-z0-9]+)*$'),
 title text NOT NULL CHECK (length(btrim(title)) > 0),
 description text NOT NULL DEFAULT '',
 language text NOT NULL CHECK (length(btrim(language)) > 0),
 level text NOT NULL CHECK (length(btrim(level)) > 0),
 duration_weeks integer CHECK (duration_weeks > 0),
 position integer NOT NULL DEFAULT 0 CHECK (position >= 0),
 is_published boolean NOT NULL DEFAULT false,
 created_at timestamptz NOT NULL DEFAULT now()
);
CREATE TABLE public.lessons (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 course_id uuid NOT NULL REFERENCES public.courses(id) ON DELETE RESTRICT,
 slug text NOT NULL CHECK (slug ~ '^[a-z0-9]+(-[a-z0-9]+)*$'),
 title text NOT NULL CHECK (length(btrim(title)) > 0),
 objective text NOT NULL DEFAULT '',
 content jsonb NOT NULL DEFAULT '[]'::jsonb CHECK (jsonb_typeof(content) = 'array'),
 position integer NOT NULL CHECK (position > 0),
 is_published boolean NOT NULL DEFAULT false,
 UNIQUE(course_id, slug), UNIQUE(course_id, position), UNIQUE(course_id, id)
);
CREATE TABLE public.assessments (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 course_id uuid NOT NULL REFERENCES public.courses(id) ON DELETE RESTRICT,
 lesson_id uuid,
 slug text NOT NULL CHECK (slug ~ '^[a-z0-9]+(-[a-z0-9]+)*$'),
 title text NOT NULL CHECK (length(btrim(title)) > 0),
 instructions text NOT NULL DEFAULT '',
 kind text NOT NULL CHECK (kind IN ('activity','exam')),
 passing_score numeric(5,2) NOT NULL DEFAULT 70 CHECK (passing_score = 70),
 position integer NOT NULL CHECK (position > 0),
 is_published boolean NOT NULL DEFAULT false,
 UNIQUE(course_id,slug), UNIQUE(course_id,id),
 FOREIGN KEY(course_id,lesson_id) REFERENCES public.lessons(course_id,id) ON DELETE RESTRICT,
 CHECK ((kind='exam' AND lesson_id IS NULL) OR (kind='activity' AND lesson_id IS NOT NULL))
);
-- Un unico examen final por curso; las actividades pueden ser varias.
CREATE UNIQUE INDEX assessments_one_final_exam_per_course ON public.assessments(course_id) WHERE kind='exam';
CREATE TABLE public.questions (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 assessment_id uuid NOT NULL REFERENCES public.assessments(id) ON DELETE RESTRICT,
 prompt text NOT NULL CHECK (length(btrim(prompt)) > 0),
 position integer NOT NULL CHECK (position > 0),
 points numeric(8,2) NOT NULL DEFAULT 1 CHECK (points > 0),
 UNIQUE(assessment_id,position), UNIQUE(assessment_id,id)
);
CREATE TABLE public.question_options (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 question_id uuid NOT NULL REFERENCES public.questions(id) ON DELETE RESTRICT,
 option_text text NOT NULL CHECK (length(btrim(option_text)) > 0),
 position integer NOT NULL CHECK (position > 0),
 UNIQUE(question_id,position), UNIQUE(question_id,id)
);
-- Soluciones y explicaciones sensibles no estan expuestas al cliente.
CREATE SCHEMA IF NOT EXISTS paradigmia_private;
REVOKE ALL ON SCHEMA paradigmia_private FROM PUBLIC, anon, authenticated;
CREATE TABLE paradigmia_private.correct_options (
 question_id uuid PRIMARY KEY REFERENCES public.questions(id) ON DELETE RESTRICT,
 option_id uuid NOT NULL UNIQUE,
 explanation text NOT NULL DEFAULT '',
 FOREIGN KEY(question_id,option_id) REFERENCES public.question_options(question_id,id) ON DELETE RESTRICT
);
REVOKE ALL ON ALL TABLES IN SCHEMA paradigmia_private FROM PUBLIC, anon, authenticated;

CREATE TABLE public.enrollments (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 user_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
 course_id uuid NOT NULL REFERENCES public.courses(id) ON DELETE RESTRICT,
 enrolled_at timestamptz NOT NULL DEFAULT now(),
 UNIQUE(user_id,course_id), UNIQUE(id,course_id)
);
CREATE TABLE public.lesson_progress (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 enrollment_id uuid NOT NULL,
 course_id uuid NOT NULL,
 lesson_id uuid NOT NULL,
 completed_at timestamptz NOT NULL DEFAULT now(),
 UNIQUE(enrollment_id,lesson_id),
 FOREIGN KEY(enrollment_id,course_id) REFERENCES public.enrollments(id,course_id) ON DELETE CASCADE,
 FOREIGN KEY(course_id,lesson_id) REFERENCES public.lessons(course_id,id) ON DELETE RESTRICT
);
CREATE TABLE public.assessment_attempts (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 enrollment_id uuid NOT NULL,
 course_id uuid NOT NULL,
 assessment_id uuid NOT NULL,
 score numeric(5,2) NOT NULL CHECK(score BETWEEN 0 AND 100),
 passed boolean NOT NULL,
 submitted_at timestamptz NOT NULL DEFAULT now(),
 UNIQUE(id,assessment_id),
 FOREIGN KEY(enrollment_id,course_id) REFERENCES public.enrollments(id,course_id) ON DELETE CASCADE,
 FOREIGN KEY(course_id,assessment_id) REFERENCES public.assessments(course_id,id) ON DELETE RESTRICT
);
CREATE TABLE public.attempt_answers (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 attempt_id uuid NOT NULL,
 assessment_id uuid NOT NULL,
 question_id uuid NOT NULL,
 option_id uuid NOT NULL,
 is_correct boolean NOT NULL,
 UNIQUE(attempt_id,question_id),
 FOREIGN KEY(attempt_id,assessment_id) REFERENCES public.assessment_attempts(id,assessment_id) ON DELETE CASCADE,
 FOREIGN KEY(assessment_id,question_id) REFERENCES public.questions(assessment_id,id) ON DELETE RESTRICT,
 FOREIGN KEY(question_id,option_id) REFERENCES public.question_options(question_id,id) ON DELETE RESTRICT
);
CREATE INDEX lessons_course_idx ON public.lessons(course_id);
CREATE INDEX assessments_course_idx ON public.assessments(course_id);
CREATE INDEX questions_assessment_idx ON public.questions(assessment_id);
CREATE INDEX question_options_question_idx ON public.question_options(question_id);
CREATE INDEX enrollments_user_idx ON public.enrollments(user_id);
CREATE INDEX lesson_progress_enrollment_idx ON public.lesson_progress(enrollment_id);
CREATE INDEX attempts_enrollment_idx ON public.assessment_attempts(enrollment_id);
CREATE INDEX attempts_assessment_idx ON public.assessment_attempts(assessment_id);
CREATE INDEX answers_attempt_idx ON public.attempt_answers(attempt_id);

ALTER TABLE public.courses ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.lessons ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.assessments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.question_options ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.enrollments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.lesson_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.assessment_attempts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.attempt_answers ENABLE ROW LEVEL SECURITY;

CREATE POLICY courses_read ON public.courses FOR SELECT TO authenticated USING(is_published);
CREATE POLICY lessons_read ON public.lessons FOR SELECT TO authenticated USING(is_published AND EXISTS(SELECT 1 FROM public.courses c WHERE c.id=course_id AND c.is_published));
CREATE POLICY assessments_read ON public.assessments FOR SELECT TO authenticated USING(is_published AND EXISTS(SELECT 1 FROM public.courses c WHERE c.id=course_id AND c.is_published) AND (kind='exam' OR EXISTS(SELECT 1 FROM public.lessons l WHERE l.id=lesson_id AND l.is_published)));
CREATE POLICY questions_read ON public.questions FOR SELECT TO authenticated USING(EXISTS(SELECT 1 FROM public.assessments a WHERE a.id=assessment_id));
CREATE POLICY options_read ON public.question_options FOR SELECT TO authenticated USING(EXISTS(SELECT 1 FROM public.questions q WHERE q.id=question_id));
CREATE POLICY enrollments_read ON public.enrollments FOR SELECT TO authenticated USING(user_id=(SELECT auth.uid()));
CREATE POLICY enrollments_insert ON public.enrollments FOR INSERT TO authenticated WITH CHECK(user_id=(SELECT auth.uid()) AND EXISTS(SELECT 1 FROM public.courses c WHERE c.id=course_id AND c.is_published));
CREATE POLICY progress_read ON public.lesson_progress FOR SELECT TO authenticated USING(EXISTS(SELECT 1 FROM public.enrollments e WHERE e.id=enrollment_id AND e.user_id=(SELECT auth.uid())));
CREATE POLICY attempts_read ON public.assessment_attempts FOR SELECT TO authenticated USING(EXISTS(SELECT 1 FROM public.enrollments e WHERE e.id=enrollment_id AND e.user_id=(SELECT auth.uid())));
CREATE POLICY answers_read ON public.attempt_answers FOR SELECT TO authenticated USING(EXISTS(SELECT 1 FROM public.assessment_attempts a JOIN public.enrollments e ON e.id=a.enrollment_id WHERE a.id=attempt_id AND e.user_id=(SELECT auth.uid())));

-- Revocacion explicita: ninguna escritura directa sobre calificaciones/progreso.
REVOKE ALL ON public.courses, public.lessons, public.assessments, public.questions,
 public.question_options, public.enrollments, public.lesson_progress,
 public.assessment_attempts, public.attempt_answers FROM PUBLIC, anon, authenticated;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT SELECT ON public.courses, public.lessons, public.assessments, public.questions,
 public.question_options, public.enrollments, public.lesson_progress,
 public.assessment_attempts, public.attempt_answers TO authenticated;
GRANT INSERT(user_id,course_id) ON public.enrollments TO authenticated;

-- RPC 1: completar leccion, sin aceptar un user_id arbitrario.
CREATE FUNCTION public.complete_lesson(p_lesson_id uuid)
RETURNS uuid
LANGUAGE plpgsql SECURITY DEFINER
SET search_path = ''
AS $$
DECLARE v_user uuid := auth.uid(); v_enrollment uuid; v_course uuid; v_progress uuid;
BEGIN
 IF v_user IS NULL THEN RAISE EXCEPTION 'Autenticacion requerida'; END IF;
 SELECT e.id, e.course_id INTO v_enrollment, v_course
 FROM public.enrollments e JOIN public.lessons l ON l.course_id=e.course_id
 JOIN public.courses c ON c.id=e.course_id
 WHERE e.user_id=v_user AND l.id=p_lesson_id AND l.is_published AND c.is_published;
 IF v_enrollment IS NULL THEN RAISE EXCEPTION 'Leccion no disponible o sin inscripcion'; END IF;
 INSERT INTO public.lesson_progress(enrollment_id,course_id,lesson_id)
 VALUES(v_enrollment,v_course,p_lesson_id)
 ON CONFLICT(enrollment_id,lesson_id) DO NOTHING;
 SELECT id INTO v_progress FROM public.lesson_progress
 WHERE enrollment_id=v_enrollment AND lesson_id=p_lesson_id;
 RETURN v_progress;
END;
$$;

-- RPC 2: corregir respuestas en servidor. Formato:
-- [{"question_id":"UUID","option_id":"UUID"}, ...]
-- Requiere exactamente una respuesta por pregunta y solucion configurada para cada una.
CREATE FUNCTION public.submit_assessment(p_assessment_id uuid, p_answers jsonb)
RETURNS TABLE(attempt_id uuid, score numeric, passed boolean, best_exam_score numeric)
LANGUAGE plpgsql SECURITY DEFINER
SET search_path = ''
AS $$
DECLARE
 v_user uuid := auth.uid(); v_enrollment uuid; v_course uuid; v_kind text;
 v_passing numeric; v_attempt uuid; v_total integer; v_received integer;
 v_points numeric; v_earned numeric; v_score numeric(5,2); v_passed boolean;
 v_best numeric(5,2); v_item jsonb; v_question uuid; v_option uuid;
BEGIN
 IF v_user IS NULL THEN RAISE EXCEPTION 'Autenticacion requerida'; END IF;
 IF p_answers IS NULL OR jsonb_typeof(p_answers) <> 'array' THEN
  RAISE EXCEPTION 'Respuestas deben ser un arreglo JSON'; END IF;
 SELECT e.id, a.course_id, a.kind, a.passing_score
 INTO v_enrollment,v_course,v_kind,v_passing
 FROM public.assessments a JOIN public.enrollments e ON e.course_id=a.course_id
 JOIN public.courses c ON c.id=a.course_id
 LEFT JOIN public.lessons l ON l.id=a.lesson_id
 WHERE a.id=p_assessment_id AND e.user_id=v_user AND a.is_published AND c.is_published
 AND (a.kind='exam' OR (l.id IS NOT NULL AND l.is_published));
 IF v_enrollment IS NULL THEN RAISE EXCEPTION 'Evaluacion no disponible o sin inscripcion'; END IF;
 SELECT count(*),coalesce(sum(q.points),0) INTO v_total,v_points
 FROM public.questions q WHERE q.assessment_id=p_assessment_id;
 IF v_total=0 THEN RAISE EXCEPTION 'Evaluacion sin preguntas'; END IF;
 IF EXISTS (
  SELECT 1 FROM public.questions q
  WHERE q.assessment_id=p_assessment_id AND (
   (SELECT count(*) FROM public.question_options o WHERE o.question_id=q.id) < 2
   OR NOT EXISTS(SELECT 1 FROM paradigmia_private.correct_options co WHERE co.question_id=q.id)
  )
 ) THEN RAISE EXCEPTION 'Evaluacion incompleta'; END IF;
 v_received := jsonb_array_length(p_answers);
 IF v_received <> v_total THEN RAISE EXCEPTION 'Debe responder todas las preguntas'; END IF;
 -- Validar la estructura, pertenencia de preguntas/opciones y ausencia de repetidos.
 IF EXISTS (
  SELECT 1 FROM jsonb_array_elements(p_answers) x(item)
  WHERE jsonb_typeof(x.item) <> 'object'
     OR jsonb_typeof(x.item->'question_id') IS DISTINCT FROM 'string'
     OR jsonb_typeof(x.item->'option_id') IS DISTINCT FROM 'string'
 ) THEN RAISE EXCEPTION 'Formato de respuestas invalido'; END IF;
 IF EXISTS (
  SELECT 1 FROM jsonb_array_elements(p_answers) x(item)
  WHERE NOT EXISTS (
   SELECT 1 FROM public.questions q JOIN public.question_options o ON o.question_id=q.id
   WHERE q.assessment_id=p_assessment_id
     AND q.id::text=x.item->>'question_id' AND o.id::text=x.item->>'option_id'
  )
 ) THEN RAISE EXCEPTION 'Pregunta u opcion no pertenece a la evaluacion'; END IF;
 IF (SELECT count(DISTINCT x.item->>'question_id') FROM jsonb_array_elements(p_answers) x(item)) <> v_total
 THEN RAISE EXCEPTION 'Preguntas repetidas'; END IF;
 SELECT coalesce(sum(q.points) FILTER (WHERE co.option_id::text=x.item->>'option_id'),0)
 INTO v_earned
 FROM jsonb_array_elements(p_answers) x(item)
 JOIN public.questions q ON q.id::text=x.item->>'question_id' AND q.assessment_id=p_assessment_id
 JOIN paradigmia_private.correct_options co ON co.question_id=q.id;
 v_score := round(100*v_earned/v_points,2);
 v_passed := (v_kind='exam' AND v_score >= v_passing);
 INSERT INTO public.assessment_attempts(enrollment_id,course_id,assessment_id,score,passed)
 VALUES(v_enrollment,v_course,p_assessment_id,v_score,v_passed) RETURNING id INTO v_attempt;
 INSERT INTO public.attempt_answers(attempt_id,assessment_id,question_id,option_id,is_correct)
 SELECT v_attempt,p_assessment_id,q.id,o.id,(o.id=co.option_id)
 FROM jsonb_array_elements(p_answers) x(item)
 JOIN public.questions q ON q.id::text=x.item->>'question_id' AND q.assessment_id=p_assessment_id
 JOIN public.question_options o ON o.id::text=x.item->>'option_id' AND o.question_id=q.id
 JOIN paradigmia_private.correct_options co ON co.question_id=q.id;
 SELECT max(a.score) INTO v_best FROM public.assessment_attempts a
 JOIN public.assessments s ON s.id=a.assessment_id
 WHERE a.enrollment_id=v_enrollment AND s.kind='exam';
 RETURN QUERY SELECT v_attempt,v_score,v_passed,v_best;
END;
$$;

-- Las funciones SECURITY DEFINER deben pertenecer a un rol de confianza.
REVOKE ALL ON FUNCTION public.complete_lesson(uuid) FROM PUBLIC,anon,authenticated;
REVOKE ALL ON FUNCTION public.submit_assessment(uuid,jsonb) FROM PUBLIC,anon,authenticated;
GRANT EXECUTE ON FUNCTION public.complete_lesson(uuid) TO authenticated;
GRANT EXECUTE ON FUNCTION public.submit_assessment(uuid,jsonb) TO authenticated;
COMMIT;
