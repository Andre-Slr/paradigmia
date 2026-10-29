-- Paradigmia | Migracion 001 | Esquema academico y RLS
-- Revisar y respaldar la base antes de ejecutar en produccion.
-- No altera public.perfiles ni public.onboarding_responses.
BEGIN;
CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE public.courses (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 slug text NOT NULL UNIQUE CHECK (slug ~ '^[a-z0-9]+(-[a-z0-9]+)*$'),
 title text NOT NULL CHECK (length(btrim(title)) > 0),
 description text NOT NULL DEFAULT '',
 language text NOT NULL,
 level text NOT NULL,
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
 title text NOT NULL,
 instructions text NOT NULL DEFAULT '',
 kind text NOT NULL CHECK (kind IN ('activity','exam')),
 passing_score numeric(5,2) NOT NULL DEFAULT 70 CHECK (passing_score BETWEEN 0 AND 100),
 position integer NOT NULL CHECK (position > 0),
 is_published boolean NOT NULL DEFAULT false,
 UNIQUE(course_id,slug), UNIQUE(course_id,id),
 FOREIGN KEY(course_id,lesson_id) REFERENCES public.lessons(course_id,id) ON DELETE RESTRICT,
 CHECK ((kind='exam' AND lesson_id IS NULL) OR (kind='activity' AND lesson_id IS NOT NULL))
);
CREATE TABLE public.questions (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 assessment_id uuid NOT NULL REFERENCES public.assessments(id) ON DELETE RESTRICT,
 prompt text NOT NULL CHECK (length(btrim(prompt)) > 0),
 explanation text NOT NULL DEFAULT '',
 position integer NOT NULL CHECK(position > 0),
 points numeric(8,2) NOT NULL DEFAULT 1 CHECK(points > 0),
 UNIQUE(assessment_id,position), UNIQUE(assessment_id,id)
);
-- The correct-answer flag is deliberately kept in a separate private schema.
CREATE SCHEMA IF NOT EXISTS paradigmia_private;
REVOKE ALL ON SCHEMA paradigmia_private FROM PUBLIC, anon, authenticated;
CREATE TABLE public.question_options (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 question_id uuid NOT NULL REFERENCES public.questions(id) ON DELETE RESTRICT,
 option_text text NOT NULL CHECK(length(btrim(option_text)) > 0),
 position integer NOT NULL CHECK(position > 0),
 UNIQUE(question_id,position), UNIQUE(question_id,id)
);
CREATE TABLE paradigmia_private.correct_options (
 question_id uuid PRIMARY KEY REFERENCES public.questions(id) ON DELETE RESTRICT,
 option_id uuid NOT NULL UNIQUE,
 FOREIGN KEY(question_id,option_id) REFERENCES public.question_options(question_id,id) ON DELETE RESTRICT
);
REVOKE ALL ON ALL TABLES IN SCHEMA paradigmia_private FROM PUBLIC, anon, authenticated;

CREATE TABLE public.enrollments (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 user_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
 course_id uuid NOT NULL REFERENCES public.courses(id) ON DELETE RESTRICT,
 enrolled_at timestamptz NOT NULL DEFAULT now(),
 UNIQUE(user_id,course_id), UNIQUE(id,course_id), UNIQUE(id,user_id)
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

-- Published catalog is readable by signed-in students; unpublished rows stay hidden.
CREATE POLICY courses_read ON public.courses FOR SELECT TO authenticated USING(is_published);
CREATE POLICY lessons_read ON public.lessons FOR SELECT TO authenticated USING(is_published AND EXISTS (SELECT 1 FROM public.courses c WHERE c.id=course_id AND c.is_published));
CREATE POLICY assessments_read ON public.assessments FOR SELECT TO authenticated USING(is_published AND EXISTS (SELECT 1 FROM public.courses c WHERE c.id=course_id AND c.is_published));
CREATE POLICY questions_read ON public.questions FOR SELECT TO authenticated USING(EXISTS (SELECT 1 FROM public.assessments a JOIN public.courses c ON c.id=a.course_id WHERE a.id=assessment_id AND a.is_published AND c.is_published));
CREATE POLICY options_read ON public.question_options FOR SELECT TO authenticated USING(EXISTS (SELECT 1 FROM public.questions q JOIN public.assessments a ON a.id=q.assessment_id JOIN public.courses c ON c.id=a.course_id WHERE q.id=question_id AND a.is_published AND c.is_published));
CREATE POLICY enrollments_read ON public.enrollments FOR SELECT TO authenticated USING(user_id=(SELECT auth.uid()));
CREATE POLICY enrollments_insert ON public.enrollments FOR INSERT TO authenticated WITH CHECK(user_id=(SELECT auth.uid()) AND EXISTS(SELECT 1 FROM public.courses c WHERE c.id=course_id AND c.is_published));
CREATE POLICY progress_read ON public.lesson_progress FOR SELECT TO authenticated USING(EXISTS(SELECT 1 FROM public.enrollments e WHERE e.id=enrollment_id AND e.user_id=(SELECT auth.uid())));
-- No client-side INSERT/UPDATE/DELETE on progress or scores. Use server-side RPC with validation.
CREATE POLICY attempts_read ON public.assessment_attempts FOR SELECT TO authenticated USING(EXISTS(SELECT 1 FROM public.enrollments e WHERE e.id=enrollment_id AND e.user_id=(SELECT auth.uid())));
CREATE POLICY answers_read ON public.attempt_answers FOR SELECT TO authenticated USING(EXISTS(SELECT 1 FROM public.assessment_attempts a JOIN public.enrollments e ON e.id=a.enrollment_id WHERE a.id=attempt_id AND e.user_id=(SELECT auth.uid())));

-- Explicit table grants; RLS still applies to all authenticated reads.
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT SELECT ON public.courses,public.lessons,public.assessments,public.questions,public.question_options,public.enrollments,public.lesson_progress,public.assessment_attempts,public.attempt_answers TO authenticated;
GRANT INSERT ON public.enrollments TO authenticated;
-- In particular, authenticated has no INSERT/UPDATE privilege on attempts, answers or progress.
REVOKE INSERT,UPDATE,DELETE ON public.lesson_progress,public.assessment_attempts,public.attempt_answers FROM anon,authenticated;
REVOKE ALL ON paradigmia_private.correct_options FROM PUBLIC,anon,authenticated;
COMMIT;
