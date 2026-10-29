import { Navigate, Route, Routes } from 'react-router-dom'
import type { ReactElement } from 'react'
import type { User } from '@supabase/supabase-js'
import AuthPage from '@/features/auth/AuthPage'
import { useAuth } from '@/features/auth/useAuth'
import CoursePage from '@/features/courses/CoursePage'
import CoursesPage from '@/features/courses/CoursesPage'
import LessonPage from '@/features/courses/LessonPage'
import DashboardPage from '@/features/dashboard/DashboardPage'
import OnboardingPage from '@/features/onboarding/OnboardingPage'
import { useOnboarding } from '@/features/onboarding/useOnboarding'

export default function App() {
  const { user, loading, signIn, signUp, signOut } = useAuth()
  const { status, submit } = useOnboarding(user?.id)

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

  // Vistas que requieren sesión iniciada y el cuestionario inicial completado.
  function privateRoute(render: (user: User) => ReactElement) {
    if (!user) return <Navigate to="/login" replace />
    if (status !== 'completed') return <Navigate to="/onboarding" replace />
    return render(user)
  }

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
      <Route path="/cursos" element={privateRoute((u) => <CoursesPage user={u} />)} />
      <Route path="/cursos/:courseId" element={privateRoute((u) => <CoursePage user={u} />)} />
      <Route
        path="/cursos/:courseId/lecciones/:lessonId"
        element={privateRoute((u) => <LessonPage user={u} />)}
      />
      <Route path="*" element={<Navigate to={home} replace />} />
    </Routes>
  )
}
