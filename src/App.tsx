import { Navigate, Route, Routes } from 'react-router-dom'
import AuthPage from '@/features/auth/AuthPage'
import { useAuth } from '@/features/auth/useAuth'
import DashboardPage from '@/features/dashboard/DashboardPage'
import OnboardingPage from '@/features/onboarding/OnboardingPage'
import { useOnboarding } from '@/features/onboarding/useOnboarding'
import MainPage from '@/features/dashboard/MainPage'

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
       <Route
        path="/main"
        element={
          user ? (
            <MainPage user={user} onLogout={signOut} />
          ) : (
            <Navigate to="/login" replace />
          )
        }
      />
      <Route path="*" element={<Navigate to={home} replace />} />
    </Routes>
  )
}
