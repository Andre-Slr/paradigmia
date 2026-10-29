import type { Course } from '../types'
import { htmlCssCourse } from './htmlCss'
import { pythonCourse } from './python'

export const courses: Course[] = [pythonCourse, htmlCssCourse]

export function findCourse(courseId?: string): Course | undefined {
  return courses.find((course) => course.id === courseId)
}
