-- Paradigmia 002: 45 preguntas, 180 opciones y 45 soluciones privadas
-- Ejecutar en SQL Editor como administrador, tras migracion 001 y 9 evaluaciones.
-- Idempotente: no modifica preguntas existentes; falla si hay contenido parcial distinto.
BEGIN;
DO $seed$
DECLARE
  r record; v_assessment uuid; v_question uuid; v_option uuid; v_existing integer;
BEGIN
  -- actividad-introduccion-python, pregunta 1
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='actividad-introduccion-python';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'actividad-introduccion-python'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=1;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué función muestra texto en Python?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 1', 'actividad-introduccion-python'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'actividad-introduccion-python', 1; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué función muestra texto en Python?',1) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'len()',1) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'type()',2) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'print()',3) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'input()',4) RETURNING id INTO v_option;
  END IF;
  -- actividad-introduccion-python, pregunta 2
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='actividad-introduccion-python';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'actividad-introduccion-python'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=2;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué extensión se usa normalmente para archivos Python?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 2', 'actividad-introduccion-python'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'actividad-introduccion-python', 2; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué extensión se usa normalmente para archivos Python?',2) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'.css',1) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'.py',2) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'.js',3) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'.html',4) RETURNING id INTO v_option;
  END IF;
  -- actividad-introduccion-python, pregunta 3
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='actividad-introduccion-python';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'actividad-introduccion-python'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=3;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Cuál es un comentario válido en Python?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 3', 'actividad-introduccion-python'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'actividad-introduccion-python', 3; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Cuál es un comentario válido en Python?',3) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'# comentario',1) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'// comentario',2) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'<!-- comentario -->',3) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'/* comentario */',4) RETURNING id INTO v_option;
  END IF;
  -- actividad-introduccion-python, pregunta 4
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='actividad-introduccion-python';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'actividad-introduccion-python'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=4;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué hace print("Hola")?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 4', 'actividad-introduccion-python'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'actividad-introduccion-python', 4; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué hace print("Hola")?',4) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'Pide una contraseña',1) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'Crea una variable',2) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'Cierra el programa',3) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'Muestra Hola',4) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
  END IF;
  -- actividad-variables-python, pregunta 1
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='actividad-variables-python';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'actividad-variables-python'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=1;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué tipo de dato es 25 en Python?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 1', 'actividad-variables-python'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'actividad-variables-python', 1; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué tipo de dato es 25 en Python?',1) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'list',1) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'int',2) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'str',3) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'bool',4) RETURNING id INTO v_option;
  END IF;
  -- actividad-variables-python, pregunta 2
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='actividad-variables-python';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'actividad-variables-python'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=2;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué tipo de dato es "Hola"?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 2', 'actividad-variables-python'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'actividad-variables-python', 2; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué tipo de dato es "Hola"?',2) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'str',1) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'int',2) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'float',3) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'bool',4) RETURNING id INTO v_option;
  END IF;
  -- actividad-variables-python, pregunta 3
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='actividad-variables-python';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'actividad-variables-python'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=3;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Cómo se asigna 10 a edad?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 3', 'actividad-variables-python'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'actividad-variables-python', 3; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Cómo se asigna 10 a edad?',3) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'edad == 10',1) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'10 = edad',2) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'edad :=: 10',3) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'edad = 10',4) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
  END IF;
  -- actividad-variables-python, pregunta 4
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='actividad-variables-python';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'actividad-variables-python'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=4;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué valor booleano existe en Python?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 4', 'actividad-variables-python'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'actividad-variables-python', 4; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué valor booleano existe en Python?',4) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'TRUEE',1) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'Verdadero',2) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'True',3) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'true',4) RETURNING id INTO v_option;
  END IF;
  -- examen-final-python, pregunta 1
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='examen-final-python';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'examen-final-python'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=1;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué función imprime un mensaje?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 1', 'examen-final-python'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'examen-final-python', 1; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué función imprime un mensaje?',1) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'print()',1) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'scan()',2) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'echo()',3) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'show()',4) RETURNING id INTO v_option;
  END IF;
  -- examen-final-python, pregunta 2
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='examen-final-python';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'examen-final-python'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=2;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Cuál es una variable válida?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 2', 'examen-final-python'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'examen-final-python', 2; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Cuál es una variable válida?',2) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'20edad = 20',1) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'mi edad = 20',2) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'edad-actual = 20',3) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'mi_edad = 20',4) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
  END IF;
  -- examen-final-python, pregunta 3
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='examen-final-python';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'examen-final-python'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=3;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué tipo de dato es 3.14?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 3', 'examen-final-python'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'examen-final-python', 3; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué tipo de dato es 3.14?',3) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'bool',1) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'str',2) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'float',3) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'int',4) RETURNING id INTO v_option;
  END IF;
  -- examen-final-python, pregunta 4
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='examen-final-python';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'examen-final-python'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=4;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué operador compara igualdad?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 4', 'examen-final-python'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'examen-final-python', 4; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué operador compara igualdad?',4) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'<>',1) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'==',2) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'=',3) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'===',4) RETURNING id INTO v_option;
  END IF;
  -- examen-final-python, pregunta 5
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='examen-final-python';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'examen-final-python'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=5;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué estructura ejecuta código según una condición?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 5', 'examen-final-python'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'examen-final-python', 5; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué estructura ejecuta código según una condición?',5) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'if',1) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'import',2) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'def',3) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'print',4) RETURNING id INTO v_option;
  END IF;
  -- examen-final-python, pregunta 6
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='examen-final-python';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'examen-final-python'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=6;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué función obtiene la longitud de una cadena?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 6', 'examen-final-python'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'examen-final-python', 6; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué función obtiene la longitud de una cadena?',6) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'size()',1) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'countall()',2) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'length()',3) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'len()',4) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
  END IF;
  -- examen-final-python, pregunta 7
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='examen-final-python';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'examen-final-python'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=7;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué resultado da 2 + 3 * 4?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 7', 'examen-final-python'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'examen-final-python', 7; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué resultado da 2 + 3 * 4?',7) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'24',1) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'9',2) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'14',3) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'20',4) RETURNING id INTO v_option;
  END IF;
  -- actividad-html, pregunta 1
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='actividad-html';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'actividad-html'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=1;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué etiqueta define un título principal?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 1', 'actividad-html'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'actividad-html', 1; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué etiqueta define un título principal?',1) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'<span>',1) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'<h1>',2) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'<p>',3) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'<div>',4) RETURNING id INTO v_option;
  END IF;
  -- actividad-html, pregunta 2
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='actividad-html';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'actividad-html'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=2;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué etiqueta crea un párrafo?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 2', 'actividad-html'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'actividad-html', 2; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué etiqueta crea un párrafo?',2) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'<p>',1) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'<a>',2) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'<img>',3) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'<ul>',4) RETURNING id INTO v_option;
  END IF;
  -- actividad-html, pregunta 3
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='actividad-html';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'actividad-html'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=3;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué atributo define la URL de un enlace?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 3', 'actividad-html'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'actividad-html', 3; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué atributo define la URL de un enlace?',3) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'src',1) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'alt',2) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'class',3) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'href',4) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
  END IF;
  -- actividad-html, pregunta 4
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='actividad-html';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'actividad-html'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=4;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué etiqueta muestra una imagen?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 4', 'actividad-html'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'actividad-html', 4; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué etiqueta muestra una imagen?',4) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'<picturetext>',1) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'<media>',2) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'<img>',3) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'<image>',4) RETURNING id INTO v_option;
  END IF;
  -- actividad-css, pregunta 1
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='actividad-css';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'actividad-css'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=1;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué propiedad cambia el color del texto?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 1', 'actividad-css'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'actividad-css', 1; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué propiedad cambia el color del texto?',1) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'font-size',1) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'padding',2) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'color',3) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'background',4) RETURNING id INTO v_option;
  END IF;
  -- actividad-css, pregunta 2
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='actividad-css';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'actividad-css'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=2;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué selector apunta a una clase?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 2', 'actividad-css'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'actividad-css', 2; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué selector apunta a una clase?',2) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'@clase',1) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'.clase',2) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'#clase',3) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'clase()',4) RETURNING id INTO v_option;
  END IF;
  -- actividad-css, pregunta 3
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='actividad-css';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'actividad-css'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=3;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué propiedad cambia el tamaño del texto?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 3', 'actividad-css'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'actividad-css', 3; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué propiedad cambia el tamaño del texto?',3) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'font-size',1) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'font-weight',2) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'line-height',3) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'text-align',4) RETURNING id INTO v_option;
  END IF;
  -- actividad-css, pregunta 4
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='actividad-css';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'actividad-css'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=4;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué propiedad agrega espacio interior?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 4', 'actividad-css'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'actividad-css', 4; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué propiedad agrega espacio interior?',4) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'margin',1) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'border',2) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'gap',3) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'padding',4) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
  END IF;
  -- examen-final-web, pregunta 1
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='examen-final-web';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'examen-final-web'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=1;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué lenguaje estructura una página web?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 1', 'examen-final-web'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'examen-final-web', 1; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué lenguaje estructura una página web?',1) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'CSS',1) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'SQL',2) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'Python',3) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'HTML',4) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
  END IF;
  -- examen-final-web, pregunta 2
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='examen-final-web';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'examen-final-web'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=2;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué lenguaje aplica estilos visuales?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 2', 'examen-final-web'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'examen-final-web', 2; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué lenguaje aplica estilos visuales?',2) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'JSON',1) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'SQL',2) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'CSS',3) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'HTML',4) RETURNING id INTO v_option;
  END IF;
  -- examen-final-web, pregunta 3
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='examen-final-web';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'examen-final-web'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=3;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué etiqueta representa un enlace?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 3', 'examen-final-web'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'examen-final-web', 3; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué etiqueta representa un enlace?',3) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'<li>',1) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'<a>',2) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'<linktext>',3) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'<p>',4) RETURNING id INTO v_option;
  END IF;
  -- examen-final-web, pregunta 4
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='examen-final-web';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'examen-final-web'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=4;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué atributo indica la ruta de una imagen?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 4', 'examen-final-web'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'examen-final-web', 4; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué atributo indica la ruta de una imagen?',4) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'src',1) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'href',2) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'alt',3) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'id',4) RETURNING id INTO v_option;
  END IF;
  -- examen-final-web, pregunta 5
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='examen-final-web';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'examen-final-web'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=5;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué selector CSS selecciona un ID?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 5', 'examen-final-web'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'examen-final-web', 5; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué selector CSS selecciona un ID?',5) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'.principal',1) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'principal',2) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'@principal',3) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'#principal',4) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
  END IF;
  -- examen-final-web, pregunta 6
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='examen-final-web';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'examen-final-web'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=6;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué propiedad define el fondo de un elemento?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 6', 'examen-final-web'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'examen-final-web', 6; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué propiedad define el fondo de un elemento?',6) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'font-style',1) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'line-height',2) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'background-color',3) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'text-color',4) RETURNING id INTO v_option;
  END IF;
  -- examen-final-web, pregunta 7
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='examen-final-web';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'examen-final-web'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=7;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué propiedad CSS controla el margen exterior?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 7', 'examen-final-web'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'examen-final-web', 7; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué propiedad CSS controla el margen exterior?',7) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'width',1) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'margin',2) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'padding',3) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'border-radius',4) RETURNING id INTO v_option;
  END IF;
  -- actividad-introduccion-js, pregunta 1
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='actividad-introduccion-js';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'actividad-introduccion-js'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=1;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué instrucción escribe en la consola?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 1', 'actividad-introduccion-js'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'actividad-introduccion-js', 1; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué instrucción escribe en la consola?',1) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'echo()',1) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'alert.log()',2) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'console.log()',3) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'print()',4) RETURNING id INTO v_option;
  END IF;
  -- actividad-introduccion-js, pregunta 2
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='actividad-introduccion-js';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'actividad-introduccion-js'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=2;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué palabra declara una constante?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 2', 'actividad-introduccion-js'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'actividad-introduccion-js', 2; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué palabra declara una constante?',2) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'constant',1) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'const',2) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'varies',3) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'static',4) RETURNING id INTO v_option;
  END IF;
  -- actividad-introduccion-js, pregunta 3
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='actividad-introduccion-js';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'actividad-introduccion-js'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=3;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué tipo representa verdadero o falso?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 3', 'actividad-introduccion-js'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'actividad-introduccion-js', 3; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué tipo representa verdadero o falso?',3) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'boolean',1) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'string',2) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'number',3) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'object',4) RETURNING id INTO v_option;
  END IF;
  -- actividad-introduccion-js, pregunta 4
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='actividad-introduccion-js';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'actividad-introduccion-js'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=4;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué extensión suele tener un archivo JavaScript?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 4', 'actividad-introduccion-js'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'actividad-introduccion-js', 4; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué extensión suele tener un archivo JavaScript?',4) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'.py',1) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'.css',2) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'.java',3) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'.js',4) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
  END IF;
  -- actividad-funciones-js, pregunta 1
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='actividad-funciones-js';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'actividad-funciones-js'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=1;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Cómo se declara una variable reasignable?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 1', 'actividad-funciones-js'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'actividad-funciones-js', 1; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Cómo se declara una variable reasignable?',1) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'fixed x = 1;',1) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'let x = 1;',2) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'const x = 1;',3) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'final x = 1;',4) RETURNING id INTO v_option;
  END IF;
  -- actividad-funciones-js, pregunta 2
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='actividad-funciones-js';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'actividad-funciones-js'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=2;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué palabra declara una función tradicional?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 2', 'actividad-funciones-js'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'actividad-funciones-js', 2; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué palabra declara una función tradicional?',2) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'function',1) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'method',2) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'def',3) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'func',4) RETURNING id INTO v_option;
  END IF;
  -- actividad-funciones-js, pregunta 3
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='actividad-funciones-js';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'actividad-funciones-js'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=3;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué instrucción devuelve un valor de una función?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 3', 'actividad-funciones-js'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'actividad-funciones-js', 3; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué instrucción devuelve un valor de una función?',3) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'break',1) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'continue',2) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'console',3) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'return',4) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
  END IF;
  -- actividad-funciones-js, pregunta 4
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='actividad-funciones-js';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'actividad-funciones-js'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=4;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Cuál es una llamada válida a saludar?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 4', 'actividad-funciones-js'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'actividad-funciones-js', 4; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Cuál es una llamada válida a saludar?',4) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'call saludar;',1) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'saludar[];',2) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'saludar();',3) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'function saludar;',4) RETURNING id INTO v_option;
  END IF;
  -- examen-final-js, pregunta 1
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='examen-final-js';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'examen-final-js'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=1;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué instrucción muestra información en la consola?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 1', 'examen-final-js'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'examen-final-js', 1; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué instrucción muestra información en la consola?',1) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'console.log()',1) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'print()',2) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'echo()',3) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'write.console()',4) RETURNING id INTO v_option;
  END IF;
  -- examen-final-js, pregunta 2
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='examen-final-js';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'examen-final-js'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=2;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué declaración no permite reasignar la variable?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 2', 'examen-final-js'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'examen-final-js', 2; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué declaración no permite reasignar la variable?',2) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'let',1) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'var',2) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'dynamic',3) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'const',4) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
  END IF;
  -- examen-final-js, pregunta 3
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='examen-final-js';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'examen-final-js'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=3;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué operador compara valor y tipo?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 3', 'examen-final-js'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'examen-final-js', 3; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué operador compara valor y tipo?',3) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'=',1) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'<>',2) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'===',3) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'==',4) RETURNING id INTO v_option;
  END IF;
  -- examen-final-js, pregunta 4
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='examen-final-js';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'examen-final-js'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=4;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué tipo de dato es "Hola"?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 4', 'examen-final-js'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'examen-final-js', 4; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué tipo de dato es "Hola"?',4) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'undefined',1) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'string',2) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'number',3) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'boolean',4) RETURNING id INTO v_option;
  END IF;
  -- examen-final-js, pregunta 5
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='examen-final-js';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'examen-final-js'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=5;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué palabra inicia una función tradicional?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 5', 'examen-final-js'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'examen-final-js', 5; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué palabra inicia una función tradicional?',5) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'function',1) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'def',2) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'method',3) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'lambda',4) RETURNING id INTO v_option;
  END IF;
  -- examen-final-js, pregunta 6
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='examen-final-js';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'examen-final-js'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=6;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué resultado produce 2 + 3?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 6', 'examen-final-js'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'examen-final-js', 6; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué resultado produce 2 + 3?',6) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'23',1) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'6',2) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'undefined',3) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'5',4) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
  END IF;
  -- examen-final-js, pregunta 7
  SELECT id INTO v_assessment FROM public.assessments WHERE slug='examen-final-js';
  IF v_assessment IS NULL THEN RAISE EXCEPTION 'Falta evaluacion: %', 'examen-final-js'; END IF;
  SELECT id INTO v_question FROM public.questions WHERE assessment_id=v_assessment AND position=7;
  IF v_question IS NOT NULL THEN
    IF NOT EXISTS (SELECT 1 FROM public.questions WHERE id=v_question AND prompt='¿Qué método convierte JSON textual en un objeto?') THEN RAISE EXCEPTION 'Pregunta existente distinta en % / 7', 'examen-final-js'; END IF;
    IF (SELECT count(*) FROM public.question_options WHERE question_id=v_question) <> 4 OR NOT EXISTS (SELECT 1 FROM paradigmia_private.correct_options WHERE question_id=v_question) THEN RAISE EXCEPTION 'Pregunta incompleta: % / %', 'examen-final-js', 7; END IF;
  ELSE
    INSERT INTO public.questions(assessment_id,prompt,position) VALUES(v_assessment,'¿Qué método convierte JSON textual en un objeto?',7) RETURNING id INTO v_question;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'JSON.read()',1) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'JSON.convert()',2) RETURNING id INTO v_option;
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'JSON.parse()',3) RETURNING id INTO v_option;
    INSERT INTO paradigmia_private.correct_options(question_id,option_id) VALUES(v_question,v_option);
    INSERT INTO public.question_options(question_id,option_text,position) VALUES(v_question,'JSON.stringify()',4) RETURNING id INTO v_option;
  END IF;
END;
$seed$;
-- Conteos de comprobacion antes de confirmar:
DO $verify$
DECLARE n integer;
BEGIN
 SELECT count(*) INTO n FROM public.questions;
 IF n < 45 THEN RAISE EXCEPTION 'Preguntas insuficientes: %', n; END IF;
END;
$verify$;
COMMIT;
SELECT (SELECT count(*) FROM public.questions) AS preguntas, (SELECT count(*) FROM public.question_options) AS opciones, (SELECT count(*) FROM paradigmia_private.correct_options) AS respuestas_correctas;