import { Navigate, Route, Routes } from 'react-router-dom'
import AuthPage from '@/features/auth/AuthPage'
import { useAuth } from '@/features/auth/useAuth'
import DashboardPage from '@/features/dashboard/DashboardPage'

export default function App() {
  const { user, loading, signIn, signUp, signOut } = useAuth()

  if (loading) {
    return (
      <main className="auth">
        <div className="d-flex flex-grow-1 align-items-center justify-content-center">
          <p className="subtitle mb-0">Comprobando sesión...</p>
        </div>
      </main>
    )
  }

  return (
    <Routes>
      <Route
        path="/login"
        element={
          user ? (
            <Navigate to="/dashboard" replace />
          ) : (
            <AuthPage mode="login" onSignIn={signIn} onSignUp={signUp} />
          )
        }
      />
      <Route
        path="/register"
        element={
          user ? (
            <Navigate to="/dashboard" replace />
          ) : (
            <AuthPage mode="register" onSignIn={signIn} onSignUp={signUp} />
          )
        }
      />
      <Route
        path="/dashboard"
        element={
          user ? (
            <DashboardPage user={user} onLogout={signOut} />
          ) : (
            <Navigate to="/login" replace />
          )
        }
      />
      <Route
        path="*"
        element={<Navigate to={user ? '/dashboard' : '/login'} replace />}
      />
    </Routes>
  )
}
