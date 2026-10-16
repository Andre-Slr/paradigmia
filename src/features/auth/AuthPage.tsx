import LoginForm from './LoginForm'
import RegisterForm from './RegisterForm'
import type { SignUpData, SignUpResult } from './useAuth'

interface AuthPageProps {
  mode: 'login' | 'register'
  onSignIn: (email: string, password: string) => Promise<string | null>
  onSignUp: (data: SignUpData) => Promise<SignUpResult>
}

export default function AuthPage({ mode, onSignIn, onSignUp }: AuthPageProps) {
  return (
    <main className="auth">
      <div className="row g-0 flex-grow-1">
        <div
          className="col-12 col-md-6 auth-visual d-none d-md-flex"
          aria-hidden="true"
          style={{ backgroundImage: "url('https://images.pexels.com/photos/39520964/pexels-photo-39520964.jpeg')", backgroundSize: 'cover', backgroundPosition: 'center' }}
        >
          <div className="brand-icon">P</div>
        </div>

        <div className="col-12 col-md-6 auth-form-panel">
          <section className="auth-form">
            {mode === 'register' ? (
              <RegisterForm onSignUp={onSignUp} />
            ) : (
              <LoginForm onSignIn={onSignIn} />
            )}
          </section>
        </div>
      </div>
    </main>
  )
}
