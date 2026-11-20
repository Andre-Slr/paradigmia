import { useEffect, useState } from 'react'
import {
  getCourseAcademicProgressForEnrollment,
  getPublishedCourseById,
  getUserEnrollments,
  type PublishedCourseRecord,
} from '@/features/courses/courseService'

/** R15: cursos que el estudiante ya terminó al 100 %, para recomendarle el siguiente. */
export async function loadCompletedCourses(userId: string): Promise<PublishedCourseRecord[]> {
  const enrollments = await getUserEnrollments(userId)
  const courses = await Promise.all(
    enrollments.map(async (enrollment) => {
      const course =
        enrollment.courses && !Array.isArray(enrollment.courses)
          ? enrollment.courses
          : await getPublishedCourseById(enrollment.course_id)
      if (!course) return null
      const progress = await getCourseAcademicProgressForEnrollment(enrollment.id, course.id)
      return progress.progress >= 100 ? course : null
    }),
  )
  return courses.filter((course): course is PublishedCourseRecord => course !== null)
}

export function useCompletedCourses(userId: string) {
  const [state, setState] = useState<{ userId: string; courses: PublishedCourseRecord[] } | null>(null)

  useEffect(() => {
    let active = true
    loadCompletedCourses(userId)
      .then((courses) => {
        if (active) setState({ userId, courses })
      })
      .catch(() => {
        // Si falla la consulta, se recomienda solo con el cuestionario.
        if (active) setState({ userId, courses: [] })
      })
    return () => {
      active = false
    }
  }, [userId])

  return state?.userId === userId ? state.courses : []
}
