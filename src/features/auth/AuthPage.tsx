import { Link } from 'react-router-dom'
import logo from '@/assets/branding/logo-paradigmia.png'
import mascotaSerpiente from '@/assets/branding/mascota-serpiente.png'
import hojasSuperiorIzquierda from '@/assets/decor/hojas-superior-izquierda.png'
import hojasSuperiorDerecha from '@/assets/decor/hojas-superior-derecha.png'
import hojasInferiorIzquierda from '@/assets/decor/hojas-inferior-izquierda.png'
import hojasInferiorDerecha from '@/assets/decor/hojas-inferior-derecha.png'
import '@/styles/student.css'
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
    <main className="auth auth-login">
      <header className="auth-navbar">
        <Link to="/" className="auth-navbar-brand" aria-label="Volver al inicio">
          <img src={logo} alt="Paradigmia" />
        </Link>
        <Link to="/" className="auth-navbar-back">
          Volver al inicio
        </Link>
      </header>

      <div className="auth-hero">
        <div className="student-banner-decor student-banner-decor-top-left" aria-hidden="true">
          <img src={hojasSuperiorIzquierda} alt="" />
        </div>
        <div className="student-banner-decor student-banner-decor-top-right" aria-hidden="true">
          <img src={hojasSuperiorDerecha} alt="" />
        </div>
        <div className="student-banner-decor student-banner-decor-bottom-left" aria-hidden="true">
          <img src={hojasInferiorIzquierda} alt="" />
        </div>
        <div className="student-banner-decor student-banner-decor-bottom-right" aria-hidden="true">
          <img src={hojasInferiorDerecha} alt="" />
        </div>

        <div className="auth-hero-visual" aria-hidden="true">
          <img src={mascotaSerpiente} alt="" />
        </div>

        <section className="auth-form">
          <h1 className="auth-form-title">
            {mode === 'register' ? 'Crea tu cuenta' : 'Inicia sesión'}
          </h1>
          {mode === 'register' ? (
            <RegisterForm onSignUp={onSignUp} />
          ) : (
            <LoginForm onSignIn={onSignIn} />
          )}
        </section>
      </div>
    </main>
  )
}
