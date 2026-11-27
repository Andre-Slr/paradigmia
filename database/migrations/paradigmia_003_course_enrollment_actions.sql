BEGIN;

CREATE FUNCTION public.reset_course_progress(p_course_id uuid)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
DECLARE
  v_user uuid := auth.uid();
  v_enrollment uuid;
BEGIN
  IF v_user IS NULL THEN
    RAISE EXCEPTION 'Se requiere una sesión autenticada';
  END IF;

  SELECT e.id INTO v_enrollment
  FROM public.enrollments e
  WHERE e.user_id = v_user
    AND e.course_id = p_course_id
  FOR UPDATE;

  IF v_enrollment IS NULL THEN
    RAISE EXCEPTION 'No existe una inscripción para este curso';
  END IF;

  DELETE FROM public.assessment_attempts
  WHERE enrollment_id = v_enrollment;

  DELETE FROM public.lesson_progress
  WHERE enrollment_id = v_enrollment;
END;
$$;

CREATE FUNCTION public.delete_course_enrollment(p_course_id uuid)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
DECLARE
  v_user uuid := auth.uid();
  v_enrollment uuid;
BEGIN
  IF v_user IS NULL THEN
    RAISE EXCEPTION 'Se requiere una sesión autenticada';
  END IF;

  DELETE FROM public.enrollments
  WHERE user_id = v_user
    AND course_id = p_course_id
  RETURNING id INTO v_enrollment;

  IF v_enrollment IS NULL THEN
    RAISE EXCEPTION 'No existe una inscripción para este curso';
  END IF;
END;
$$;

REVOKE ALL ON FUNCTION public.reset_course_progress(uuid) FROM PUBLIC, anon, authenticated;
REVOKE ALL ON FUNCTION public.delete_course_enrollment(uuid) FROM PUBLIC, anon, authenticated;
GRANT EXECUTE ON FUNCTION public.reset_course_progress(uuid) TO authenticated;
GRANT EXECUTE ON FUNCTION public.delete_course_enrollment(uuid) TO authenticated;

COMMIT;
