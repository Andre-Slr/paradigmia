import { supabase } from '@/lib/supabaseClient'

export interface PublishedCourseRecord {
  id: string
  slug: string
  title: string
  description: string | null
  language: string | null
  level: string | null
  duration_weeks: number | null
  position: number | null
  is_published: boolean
}

export interface LessonContentBlock {
  type?: string | null
  text?: string | null
  content?: string | null
  language?: string | null
}

export interface PublishedLessonRecord {
  id: string
  course_id: string | null
  slug: string | null
  title: string | null
  description: string | null
  objective: string | null
  content: LessonContentBlock[] | string[] | string | null
  position: number | null
  is_published: boolean | null
}

export interface PublishedAssessmentRecord {
  id: string
  course_id: string | null
  lesson_id: string | null
  slug: string | null
  title: string | null
  description: string | null
  instructions: string | null
  type: string | null
  kind: string | null
  passing_score: number | null
  position: number | null
  is_published: boolean | null
}

export interface AssessmentAttemptRecord {
  id: string
  enrollment_id: string | null
  course_id: string | null
  assessment_id: string | null
  score: number | null
  passed: boolean | null
  submitted_at: string | null
}

export interface AssessmentSubmissionResult {
  attempt_id: string | null
  score: number | null
  passed: boolean | null
  best_exam_score: number | null
}

export interface AttemptReviewEntry {
  attempt_id?: string | null
  question_id?: string | null
  selected_option_id?: string | null
  selected_option_text?: string | null
  correct_option_id?: string | null
  correct_option_text?: string | null
  is_correct?: boolean | null
  explanation?: string | null
}

export interface CourseAcademicProgress {
  totalLessons: number
  completedLessons: number
  totalActivities: number
  passedActivities: number
  totalExamAssessments: number
  passedExams: number
  totalRequiredItems: number
  completedRequiredItems: number
  progress: number
  examPassed: boolean
  completedLessonIds: string[]
  passedActivityIds: string[]
  passedExamIds: string[]
}

export interface CourseLearningStep {
  type: 'lesson' | 'activity' | 'exam'
  id: string
  title: string
  slug: string
  url: string
  lessonId?: string
  activityId?: string
  position: number
}

export interface PublishedQuestionRecord {
  id: string
  assessment_id: string | null
  prompt: string | null
  explanation: string | null
  position: number | null
  points: number | null
}

export interface PublishedQuestionOptionRecord {
  id: string
  question_id: string | null
  option_text: string | null
  position: number | null
}

export interface CourseEnrollmentRecord {
  id: string
  user_id: string
  course_id: string
  enrolled_at: string | null
}

export interface EnrollmentWithCourseRecord extends CourseEnrollmentRecord {
  courses?: PublishedCourseRecord | PublishedCourseRecord[] | null
}

export async function getPublishedCourses(): Promise<PublishedCourseRecord[]> {
  const { data, error } = await supabase
    .from('courses')
    .select('*')
    .eq('is_published', true)
    .order('position', { ascending: true })

  if (error) {
    throw new Error(error.message)
  }

  return (data ?? []) as PublishedCourseRecord[]
}

export async function getPublishedCourseById(courseId: string): Promise<PublishedCourseRecord | null> {
  const { data, error } = await supabase
    .from('courses')
    .select('*')
    .eq('id', courseId)
    .eq('is_published', true)
    .maybeSingle()

  if (error) {
    throw new Error(error.message)
  }

  return (data as PublishedCourseRecord | null) ?? null
}

export async function getPublishedCourseBySlug(slug: string): Promise<PublishedCourseRecord | null> {
  const { data, error } = await supabase
    .from('courses')
    .select('*')
    .eq('slug', slug)
    .eq('is_published', true)
    .maybeSingle()

  if (error) {
    throw new Error(error.message)
  }

  return (data as PublishedCourseRecord | null) ?? null
}

export async function getPublishedCourseLessons(courseId: string): Promise<PublishedLessonRecord[]> {
  const { data, error } = await supabase
    .from('lessons')
    .select('*')
    .eq('course_id', courseId)
    .eq('is_published', true)
    .order('position', { ascending: true })

  if (error) {
    throw new Error(error.message)
  }

  return (data ?? []) as PublishedLessonRecord[]
}

export async function getPublishedCourseLessonBySlug(courseId: string, lessonSlug: string): Promise<PublishedLessonRecord | null> {
  const { data, error } = await supabase
    .from('lessons')
    .select('*')
    .eq('course_id', courseId)
    .eq('slug', lessonSlug)
    .eq('is_published', true)
    .maybeSingle()

  if (error) {
    throw new Error(error.message)
  }

  return (data as PublishedLessonRecord | null) ?? null
}

export async function getPublishedCourseAssessments(courseId: string): Promise<PublishedAssessmentRecord[]> {
  const { data, error } = await supabase
    .from('assessments')
    .select('*')
    .eq('course_id', courseId)
    .eq('is_published', true)
    .order('position', { ascending: true })

  if (error) {
    throw new Error(error.message)
  }

  return (data ?? []) as PublishedAssessmentRecord[]
}

export async function getPublishedCourseActivities(courseId: string): Promise<PublishedAssessmentRecord[]> {
  const { data, error } = await supabase
    .from('assessments')
    .select('*')
    .eq('course_id', courseId)
    .eq('kind', 'activity')
    .eq('is_published', true)
    .order('position', { ascending: true })

  if (error) {
    throw new Error(error.message)
  }

  return (data ?? []) as PublishedAssessmentRecord[]
}

export async function getPublishedCourseActivityBySlug(courseId: string, activitySlug: string): Promise<PublishedAssessmentRecord | null> {
  const { data, error } = await supabase
    .from('assessments')
    .select('*')
    .eq('course_id', courseId)
    .eq('slug', activitySlug)
    .eq('kind', 'activity')
    .eq('is_published', true)
    .maybeSingle()

  if (error) {
    throw new Error(error.message)
  }

  return (data as PublishedAssessmentRecord | null) ?? null
}

export async function getAssessmentQuestions(assessmentId: string): Promise<PublishedQuestionRecord[]> {
  const { data, error } = await supabase
    .from('questions')
    .select('*')
    .eq('assessment_id', assessmentId)
    .order('position', { ascending: true })

  if (error) {
    throw new Error(error.message)
  }

  return (data ?? []) as PublishedQuestionRecord[]
}

export async function getQuestionOptions(questionId: string): Promise<PublishedQuestionOptionRecord[]> {
  const { data, error } = await supabase
    .from('question_options')
    .select('*')
    .eq('question_id', questionId)
    .order('position', { ascending: true })

  if (error) {
    throw new Error(error.message)
  }

  return (data ?? []) as PublishedQuestionOptionRecord[]
}

export async function getCourseEnrollment(userId: string, courseId: string): Promise<CourseEnrollmentRecord | null> {
  const { data, error } = await supabase
    .from('enrollments')
    .select('*')
    .eq('user_id', userId)
    .eq('course_id', courseId)
    .maybeSingle()

  if (error) {
    throw new Error(error.message)
  }

  return (data as CourseEnrollmentRecord | null) ?? null
}

export async function getUserEnrollments(userId: string): Promise<EnrollmentWithCourseRecord[]> {
  const { data, error } = await supabase
    .from('enrollments')
    .select('id, user_id, course_id, enrolled_at, courses!course_id (*)')
    .eq('user_id', userId)
    .order('enrolled_at', { ascending: false })

  if (error) {
    throw new Error(error.message)
  }

  return (data ?? []) as unknown as EnrollmentWithCourseRecord[]
}

export async function createCourseEnrollment(userId: string, courseId: string): Promise<CourseEnrollmentRecord> {
  const { data, error } = await supabase
    .from('enrollments')
    .insert({ user_id: userId, course_id: courseId })
    .select('*')
    .single()

  if (error) {
    throw new Error(error.message)
  }

  return data as CourseEnrollmentRecord
}

export async function getCompletedLessonIds(enrollmentId: string, courseId: string): Promise<string[]> {
  const { data, error } = await supabase
    .from('lesson_progress')
    .select('lesson_id')
    .eq('enrollment_id', enrollmentId)
    .eq('course_id', courseId)

  if (error) {
    throw new Error(error.message)
  }

  return Array.from(
    new Set(
      (data ?? [])
        .map((item) => (item as { lesson_id?: string | null }).lesson_id)
        .filter((lessonId): lessonId is string => Boolean(lessonId))
    )
  )
}

export async function getLessonCompletionCount(enrollmentId: string, courseId: string): Promise<number> {
  const completedLessonIds = await getCompletedLessonIds(enrollmentId, courseId)
  return completedLessonIds.length
}

export async function getLessonProgressStatus(userId: string, courseId: string, lessonId: string): Promise<boolean> {
  const enrollment = await getCourseEnrollment(userId, courseId)

  if (!enrollment) {
    return false
  }

  const { data, error } = await supabase
    .from('lesson_progress')
    .select('id')
    .eq('enrollment_id', enrollment.id)
    .eq('course_id', courseId)
    .eq('lesson_id', lessonId)
    .maybeSingle()

  if (error) {
    throw new Error(error.message)
  }

  return Boolean(data)
}

export async function completeLesson(lessonId: string): Promise<void> {
  const { error } = await supabase.rpc('complete_lesson', { p_lesson_id: lessonId })

  if (error) {
    throw new Error(error.message)
  }
}

export function normalizeAssessmentKind(assessment: Pick<PublishedAssessmentRecord, 'kind' | 'type'>): string {
  return ((assessment.kind ?? assessment.type ?? '') as string).trim().toLowerCase()
}

export function isAssessmentPassedByScore(
  assessment: Pick<PublishedAssessmentRecord, 'passing_score'>,
  score: number | string | null | undefined
): boolean {
  if (assessment.passing_score === null || assessment.passing_score === undefined) {
    return false
  }

  const numericScore = typeof score === 'number' ? score : Number(score ?? NaN)
  const passingScore = Number(assessment.passing_score)

  return Number.isFinite(numericScore) && Number.isFinite(passingScore) && numericScore >= passingScore
}

export function isExamAssessment(assessment: Pick<PublishedAssessmentRecord, 'kind' | 'type'>): boolean {
  const kind = normalizeAssessmentKind(assessment)
  return kind === 'exam' || kind === 'final' || kind === 'evaluacion' || kind === 'evaluación'
}

export function buildCourseLearningSequence(
  lessons: PublishedLessonRecord[],
  assessments: PublishedAssessmentRecord[],
  courseSlug: string
): CourseLearningStep[] {
  const orderedLessons = [...lessons].sort((left, right) => (left.position ?? 0) - (right.position ?? 0))
  const orderedActivities = [...assessments]
    .filter((assessment) => !isExamAssessment(assessment))
    .sort((left, right) => (left.position ?? 0) - (right.position ?? 0))
  const exam = [...assessments].filter((assessment) => isExamAssessment(assessment)).sort((left, right) => (left.position ?? 0) - (right.position ?? 0))

  const sequence: CourseLearningStep[] = []
  const activitiesByLesson = new Map<string, PublishedAssessmentRecord[]>()

  for (const activity of orderedActivities) {
    const key = activity.lesson_id ?? '__standalone__'
    const current = activitiesByLesson.get(key) ?? []
    current.push(activity)
    activitiesByLesson.set(key, current)
  }

  for (const lesson of orderedLessons) {
    sequence.push({
      type: 'lesson',
      id: lesson.id,
      title: lesson.title ?? 'Lección',
      slug: lesson.slug ?? lesson.id,
      url: `/courses/${courseSlug}/lessons/${lesson.slug ?? lesson.id}`,
      position: lesson.position ?? 0,
      lessonId: lesson.id,
    })

    const lessonActivities = activitiesByLesson.get(lesson.id) ?? []
    for (const activity of lessonActivities) {
      sequence.push({
        type: 'activity',
        id: activity.id,
        title: activity.title ?? 'Actividad',
        slug: activity.slug ?? activity.id,
        url: `/courses/${courseSlug}/activities/${activity.slug ?? activity.id}`,
        position: activity.position ?? 0,
        lessonId: lesson.id,
        activityId: activity.id,
      })
    }
  }

  for (const assessment of exam) {
    sequence.push({
      type: 'exam',
      id: assessment.id,
      title: assessment.title ?? 'Examen final',
      slug: assessment.slug ?? assessment.id,
      url: `/courses/${courseSlug}/exam`,
      position: assessment.position ?? Number.MAX_SAFE_INTEGER,
      activityId: assessment.id,
    })
  }

  return sequence
}

export function calculateCourseAcademicProgress({
  lessons,
  assessments,
  completedLessonIds,
  attempts,
}: {
  lessons: PublishedLessonRecord[]
  assessments: PublishedAssessmentRecord[]
  completedLessonIds: string[]
  attempts: AssessmentAttemptRecord[]
}): CourseAcademicProgress {
  const completedLessonSet = new Set(completedLessonIds)
  const activityAssessments = assessments.filter((assessment) => !isExamAssessment(assessment))
  const examAssessments = assessments.filter((assessment) => isExamAssessment(assessment))

  const assessmentMap = new Map<string, PublishedAssessmentRecord>()
  for (const assessment of assessments) {
    if (assessment.id) {
      assessmentMap.set(assessment.id, assessment)
    }
  }

  const passedActivityIds = Array.from(
    new Set(
      attempts
        .filter((attempt) => {
          const assessmentId = attempt.assessment_id
          if (!assessmentId) return false
          const assessment = assessmentMap.get(assessmentId)
          if (!assessment || activityAssessments.every((item) => item.id !== assessmentId)) {
            return false
          }

          if (attempt.passed === true) {
            return true
          }

          return isAssessmentPassedByScore(assessment, attempt.score)
        })
        .map((attempt) => attempt.assessment_id)
        .filter((assessmentId): assessmentId is string => Boolean(assessmentId))
    )
  )

  const passedExamIds = Array.from(
    new Set(
      attempts
        .filter((attempt) => {
          const assessmentId = attempt.assessment_id
          if (!assessmentId) return false
          const assessment = assessmentMap.get(assessmentId)
          if (!assessment || examAssessments.every((item) => item.id !== assessmentId)) {
            return false
          }

          if (attempt.passed === true) {
            return true
          }

          return isAssessmentPassedByScore(assessment, attempt.score)
        })
        .map((attempt) => attempt.assessment_id)
        .filter((assessmentId): assessmentId is string => Boolean(assessmentId))
    )
  )

  const completedRequiredItems =
    completedLessonSet.size + passedActivityIds.length + (passedExamIds.length > 0 ? 1 : 0)
  const totalRequiredItems = lessons.length + activityAssessments.length + examAssessments.length
  const progress = totalRequiredItems > 0 ? Math.round((completedRequiredItems / totalRequiredItems) * 100) : 0

  return {
    totalLessons: lessons.length,
    completedLessons: completedLessonSet.size,
    totalActivities: activityAssessments.length,
    passedActivities: passedActivityIds.length,
    totalExamAssessments: examAssessments.length,
    passedExams: passedExamIds.length,
    totalRequiredItems,
    completedRequiredItems,
    progress,
    examPassed: passedExamIds.length > 0,
    completedLessonIds: Array.from(completedLessonSet),
    passedActivityIds,
    passedExamIds,
  }
}

export async function getAssessmentAttemptsForEnrollment(enrollmentId: string, courseId: string): Promise<AssessmentAttemptRecord[]> {
  const { data, error } = await supabase
    .from('assessment_attempts')
    .select('*')
    .eq('enrollment_id', enrollmentId)
    .eq('course_id', courseId)
    .order('submitted_at', { ascending: false })

  if (error) {
    throw new Error(error.message)
  }

  return (data ?? []) as AssessmentAttemptRecord[]
}

export async function getAssessmentAttemptAnswers(attemptId: string): Promise<Array<{ question_id: string; option_id: string }>> {
  const { data, error } = await supabase
    .from('attempt_answers')
    .select('question_id, option_id')
    .eq('attempt_id', attemptId)

  if (error) {
    throw new Error(error.message)
  }

  return (data ?? []) as Array<{ question_id: string; option_id: string }>
}

export async function getAttemptReview(attemptId: string): Promise<AttemptReviewEntry[]> {
  const { data, error } = await supabase.rpc('get_attempt_review', {
    p_attempt_id: attemptId,
  })

  if (error) {
    throw new Error(error.message)
  }

  const rows = Array.isArray(data) ? data : data ? [data] : []

  return rows as AttemptReviewEntry[]
}

export async function submitAssessmentAnswers(
  assessmentId: string,
  answers: Array<{ question_id: string; option_id: string }>
): Promise<AssessmentSubmissionResult> {
  const { data, error } = await supabase.rpc('submit_assessment', {
    p_assessment_id: assessmentId,
    p_answers: answers,
  })

  if (error) {
    throw new Error(error.message)
  }

  const payload = Array.isArray(data) ? data[0] ?? null : data ?? null

  return (payload as AssessmentSubmissionResult | null) ?? {
    attempt_id: null,
    score: null,
    passed: null,
    best_exam_score: null,
  }
}

export async function getCourseAcademicProgressForEnrollment(
  enrollmentId: string,
  courseId: string
): Promise<CourseAcademicProgress> {
  const [lessons, assessments, completedLessonIds, attempts] = await Promise.all([
    getPublishedCourseLessons(courseId),
    getPublishedCourseAssessments(courseId),
    getCompletedLessonIds(enrollmentId, courseId),
    getAssessmentAttemptsForEnrollment(enrollmentId, courseId),
  ])

  return calculateCourseAcademicProgress({
    lessons,
    assessments,
    completedLessonIds,
    attempts,
  })
}

export async function getBestExamScore(enrollmentId: string, courseId: string): Promise<number | null> {
  const attempts = await getAssessmentAttemptsForEnrollment(enrollmentId, courseId)
  const assessmentIds = Array.from(
    new Set(
      attempts
        .map((attempt) => attempt.assessment_id)
        .filter((id): id is string => Boolean(id))
    )
  )

  if (assessmentIds.length === 0) {
    return null
  }

  const { data: assessmentsData, error: assessmentsError } = await supabase
    .from('assessments')
    .select('id, kind, passing_score')
    .in('id', assessmentIds)

  if (assessmentsError) {
    throw new Error(assessmentsError.message)
  }

  const assessmentMap = new Map<string, { kind?: string | null; type?: string | null; passing_score?: number | null }>()
  for (const assessment of (assessmentsData ?? []) as Array<{ id: string; kind?: string | null; type?: string | null; passing_score?: number | null }>) {
    assessmentMap.set(assessment.id, assessment)
  }

  const relevantScores = attempts.reduce<number[]>((scores, attempt) => {
    if (attempt.score === null || attempt.score === undefined || !attempt.assessment_id) {
      return scores
    }

    const assessment = assessmentMap.get(attempt.assessment_id)
    const kind = normalizeAssessmentKind({ kind: assessment?.kind ?? null, type: assessment?.type ?? null })
    const isExamAttempt = kind === 'exam' || kind === 'final' || kind === 'evaluacion' || kind === 'evaluación'

    if (!isExamAttempt) {
      return scores
    }

    const numericScore = Number(attempt.score)
    if (Number.isFinite(numericScore)) {
      scores.push(numericScore)
    }

    return scores
  }, [])

  if (relevantScores.length === 0) {
    return null
  }

  return Math.max(...relevantScores)
}
