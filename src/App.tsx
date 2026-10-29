import { useEffect } from 'react'
import { Navigate, Route, Routes } from 'react-router-dom'
import AuthPage from '@/features/auth/AuthPage'
import { useAuth } from '@/features/auth/useAuth'
import ActivityPage from '@/features/courses/ActivityPage'
import CourseDetailPage from '@/features/courses/CourseDetailPage'
import CoursesPage from '@/features/courses/CoursesPage'
import ExamPage from '@/features/courses/ExamPage'
import LessonPage from '@/features/courses/LessonPage'
import MyCoursesPage from '@/features/courses/MyCoursesPage'
import DashboardPage from '@/features/dashboard/DashboardPage'
import OnboardingPage from '@/features/onboarding/OnboardingPage'
import RetakeQuestionnairePage from '@/features/settings/RetakeQuestionnairePage'
import SettingsPage from '@/features/settings/SettingsPage'
import { useOnboarding } from '@/features/onboarding/useOnboarding'
import { applyPreferences, loadPreferences } from '@/features/settings/preferences'

export default function App() {
  const { user, loading, signIn, signUp, signOut } = useAuth()
  const { status, submit } = useOnboarding(user?.id)
  const userId = user?.id

  // Al iniciar sesión se aplican las preferencias de apariencia de ese usuario.
  useEffect(() => {
    if (userId) applyPreferences(loadPreferences(userId))
  }, [userId])

  if (loading || (user && status === 'loading')) {
    return (
      <main className="auth">
        <div className="d-flex flex-grow-1 align-items-center justify-content-center">
          <p className="subtitle mb-0">Comprobando sesión...</p>
        </div>
      </main>
    )
  }

  const home = !user
    ? '/login'
    : status === 'completed'
      ? '/dashboard'
      : '/onboarding'

  return (
    <Routes>
      <Route
        path="/login"
        element={
          user ? (
            <Navigate to={home} replace />
          ) : (
            <AuthPage mode="login" onSignIn={signIn} onSignUp={signUp} />
          )
        }
      />
      <Route
        path="/register"
        element={
          user ? (
            <Navigate to={home} replace />
          ) : (
            <AuthPage mode="register" onSignIn={signIn} onSignUp={signUp} />
          )
        }
      />
      <Route
        path="/onboarding"
        element={
          !user ? (
            <Navigate to="/login" replace />
          ) : status === 'completed' ? (
            <Navigate to="/dashboard" replace />
          ) : (
            <OnboardingPage onSubmit={submit} />
          )
        }
      />
      <Route
        path="/courses"
        element={
          !user ? (
            <Navigate to="/login" replace />
          ) : status !== 'completed' ? (
            <Navigate to="/onboarding" replace />
          ) : (
            <CoursesPage user={user} onLogout={signOut} />
          )
        }
      />
      <Route
        path="/my-courses"
        element={
          !user ? (
            <Navigate to="/login" replace />
          ) : status !== 'completed' ? (
            <Navigate to="/onboarding" replace />
          ) : (
            <MyCoursesPage user={user} onLogout={signOut} />
          )
        }
      />
      <Route
        path="/courses/:courseId"
        element={
          !user ? (
            <Navigate to="/login" replace />
          ) : status !== 'completed' ? (
            <Navigate to="/onboarding" replace />
          ) : (
            <CourseDetailPage user={user} onLogout={signOut} />
          )
        }
      />
      <Route
        path="/courses/:courseId/lessons/:lessonId"
        element={
          !user ? (
            <Navigate to="/login" replace />
          ) : status !== 'completed' ? (
            <Navigate to="/onboarding" replace />
          ) : (
            <LessonPage user={user} onLogout={signOut} />
          )
        }
      />
      <Route
        path="/courses/:courseId/activities/:activityId"
        element={
          !user ? (
            <Navigate to="/login" replace />
          ) : status !== 'completed' ? (
            <Navigate to="/onboarding" replace />
          ) : (
            <ActivityPage user={user} onLogout={signOut} />
          )
        }
      />
      <Route
        path="/courses/:courseId/exam"
        element={
          !user ? (
            <Navigate to="/login" replace />
          ) : status !== 'completed' ? (
            <Navigate to="/onboarding" replace />
          ) : (
            <ExamPage user={user} onLogout={signOut} />
          )
        }
      />
      <Route
        path="/dashboard"
        element={
          !user ? (
            <Navigate to="/login" replace />
          ) : status !== 'completed' ? (
            <Navigate to="/onboarding" replace />
          ) : (
            <DashboardPage user={user} onLogout={signOut} />
          )
        }
      />
      <Route
        path="/settings"
        element={
          !user ? (
            <Navigate to="/login" replace />
          ) : status !== 'completed' ? (
            <Navigate to="/onboarding" replace />
          ) : (
            <SettingsPage user={user} onLogout={signOut} />
          )
        }
      />
      <Route
        path="/settings/questionnaire"
        element={
          !user ? (
            <Navigate to="/login" replace />
          ) : status !== 'completed' ? (
            <Navigate to="/onboarding" replace />
          ) : (
            <RetakeQuestionnairePage onSubmit={submit} />
          )
        }
      />
      <Route path="*" element={<Navigate to={home} replace />} />
    </Routes>
  )
}
