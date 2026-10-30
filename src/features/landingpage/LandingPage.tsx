
import React from "react";
import { Link } from 'react-router-dom';
import logo from '@/assets/branding/logo-paradigmia.png';
import curso from '@/assets/icons/cursos.png';

const LandingPage: React.FC = () => {
  const courses = [
    {
      title: "Desarrollo Web",
      description: "Aprende HTML, CSS, JavaScript y React desde cero.",
      level: "Principiante",
      duration: "8 semanas",
    },
    {
      title: "Python",
      description: "Domina Python y desarrolla tus primeras aplicaciones.",
      level: "Principiante",
      duration: "6 semanas",
    },
    {
      title: "Bases de Datos",
      description: "Aprende SQL, consultas y administración de datos.",
      level: "Intermedio",
      duration: "5 semanas",
    },
  ];

  const benefits = [
    {
      title: "Aprendizaje práctico",
      description:
        "Desarrolla proyectos reales mientras aprendes programación.",
    },
    {
      title: "Aprende a tu ritmo",
      description:
        "Accede al contenido y organiza tu aprendizaje según tu disponibilidad.",
    },
    {
      title: "Seguimiento de progreso",
      description:
        "Consulta tus avances y conoce las habilidades que has desarrollado.",
    },
  ];

  return (
    <div className="landing-page">

      {/* NAVBAR */}
      <nav className="navbar navbar-expand-lg bg-white border-bottom">
        <div className="container py-2">

          <a className="navbar-brand fw-bold" href="#">
        
              <img 
                src={logo} 
                alt="Logo" 
                style={{ width: "180px", height: "auto" }} // Ajuste de tamaño de logo
                />
        
          </a>

          <button
            className="navbar-toggler"
            type="button"
            data-bs-toggle="collapse"
            data-bs-target="#navbarLanding"
            aria-controls="navbarLanding"
            aria-expanded="false"
            aria-label="Abrir navegación"
          >
            <span className="navbar-toggler-icon"></span>
          </button>

          <div
            className="collapse navbar-collapse"
            id="navbarLanding"
          >
            <ul className="navbar-nav mx-auto mb-2 mb-lg-0">
              <li className="nav-item">
                <a className="nav-link" href="#inicio">
                  Inicio
                </a>
              </li>

              <li className="nav-item">
                <a className="nav-link" href="#cursos">
                  Cursos
                </a>
              </li>

              <li className="nav-item">
                <a className="nav-link" href="#beneficios">
                  Beneficios
                </a>
              </li>

              <li className="nav-item">
                <a className="nav-link" href="#recomendaciones">
                  Recomendaciones
                </a>
              </li>
            </ul>

            <div className="d-flex gap-2">
              <Link to="/login" className="btn btn-outline-primary">
                Iniciar sesión
              </Link>

              <Link to="/register" className="btn btn-primary">
                Registrarse
              </Link>
            </div>
          </div>
        </div>
      </nav>

      {/* HERO */}
      <section id="inicio" className="py-5 bg-light">
        <div className="container py-lg-5">
          <div className="row align-items-center g-5">

            <div className="col-lg-7">
              <span className="badge bg-secondary-subtle text-secondary mb-3">
                Aprende. Practica. Desarrolla.
              </span>

              <h1 className="display-4 fw-bold mb-4">
                Construye tu futuro aprendiendo programación
              </h1>

              <p className="lead text-body-secondary mb-4">
                Descubre cursos diseñados para desarrollar tus habilidades
                tecnológicas. Aprende desde cero y avanza a tu propio ritmo.
              </p>

              <div className="d-flex flex-wrap gap-3">
                <a href="#cursos" className="btn btn-primary btn-lg">
                  Explorar cursos
                </a>

                <a href="#beneficios" className="btn btn-outline-primary btn-lg">
                  Conocer más
                </a>
              </div>

              <div className="row mt-5 g-3">
                <div className="col-4">
                  <h3 className="fw-bold mb-0">+20</h3>
                  <small className="text-body-secondary">
                    Cursos
                  </small>
                </div>

                <div className="col-4">
                  <h3 className="fw-bold mb-0">+10</h3>
                  <small className="text-body-secondary">
                    Tecnologías
                  </small>
                </div>

                <div className="col-4">
                  <h3 className="fw-bold mb-0">100%</h3>
                  <small className="text-body-secondary">
                    Aprendizaje flexible
                  </small>
                </div>
              </div>
            </div>

            <div className="col-lg-5">
              <div className="card border-0 shadow-sm p-4">
                <div className="card-body text-center">
                  <div className="brand-icon mx-auto mb-4 d-flex align-items-center justify-content-cente">
                   <img 
                    src={curso} 
                    alt="curso" 
                    className="img-fluid"
                    />
                  </div>

                  <h3 className="fw-bold">
                    Tu próxima habilidad comienza aquí
                  </h3>

                  <p className="text-body-secondary">
                    Aprende nuevas tecnologías y transforma tus ideas
                    en proyectos.
                  </p>

                  <div className="border rounded p-3 text-start mt-4">
                    <div className="d-flex justify-content-between mb-2">
                      <span className="fw-semibold">
                        Tu aprendizaje
                      </span>
                      <span className="text-body-secondary">
                        En progreso
                      </span>
                    </div>

                    <div className="progress" role="progressbar"
                      aria-label="Ejemplo de progreso" aria-valuenow={70}
                      aria-valuemin={0} aria-valuemax={100}>
                      <div className="progress-bar" style={{ width: "70%" }}></div>
                    </div>

                    <small className="text-body-secondary mt-2 d-block">
                      Cada paso cuenta para alcanzar tus objetivos.
                    </small>
                  </div>
                </div>
              </div>
            </div>

          </div>
        </div>
      </section>

      {/* CURSOS */}
      <section id="cursos" className="py-5">
        <div className="container py-4">

          <div className="text-center mb-5">
            <span className="text-uppercase text-body-secondary fw-semibold">
              Formación
            </span>

            <h2 className="fw-bold mt-2">
              Explora nuestros cursos
            </h2>

            <p className="text-body-secondary">
              Encuentra el conocimiento que necesitas para comenzar.
            </p>
          </div>

          <div className="row g-4">
            {courses.map((course, index) => (
              <div className="col-md-6 col-lg-4" key={index}>
                <div className="card h-100 shadow-sm">
                  <div className="card-body p-4">

                    <span className="badge bg-secondary-subtle text-secondary mb-3">
                      {course.level}
                    </span>

                    <h4 className="card-title fw-bold">
                      {course.title}
                    </h4>

                    <p className="card-text text-body-secondary">
                      {course.description}
                    </p>

                    <div className="d-flex justify-content-between align-items-center mt-4">
                      <small className="text-body-secondary">
                        {course.duration}
                      </small>

                      <a href="/courses" className="btn btn-outline-primary btn-sm">
                        Ver curso
                      </a>
                    </div>

                  </div>
                </div>
              </div>
            ))}
          </div>

          <div className="text-center mt-5">
            <a href="/courses" className="btn btn-primary">
              Ver todos los cursos
            </a>
          </div>

        </div>
      </section>

      {/* BENEFICIOS */}
      <section id="beneficios" className="py-5 bg-light">
        <div className="container py-4">

          <div className="text-center mb-5">
            <h2 className="fw-bold">
              ¿Por qué aprender con nosotros?
            </h2>

            <p className="text-body-secondary">
              Una plataforma diseñada para facilitar tu aprendizaje.
            </p>
          </div>

          <div className="row g-4">
            {benefits.map((benefit, index) => (
              <div className="col-md-4" key={index}>
                <div className="card h-100 border-0 shadow-sm">
                  <div className="card-body p-4">
                    <div className="brand-icon mb-3">
                      {index + 1}
                    </div>

                    <h5 className="fw-bold">
                      {benefit.title}
                    </h5>

                    <p className="text-body-secondary mb-0">
                      {benefit.description}
                    </p>
                  </div>
                </div>
              </div>
            ))}
          </div>

        </div>
      </section>

      {/* RECOMENDACIONES */}
      <section id="recomendaciones" className="py-5">
        <div className="container py-4">

          <div className="row align-items-center g-4">
            <div className="col-lg-7">
              <span className="badge bg-secondary-subtle text-secondary mb-3">
                Para comenzar
              </span>

              <h2 className="fw-bold">
                ¿No sabes qué curso elegir?
              </h2>

              <p className="text-body-secondary">
                Te recomendamos comenzar con fundamentos de desarrollo web
                o Python. Son excelentes opciones para construir una base
                sólida en programación.
              </p>

              <a href="/courses" className="btn btn-primary">
                Descubrir recomendaciones
              </a>
            </div>

            <div className="col-lg-5">
              <div className="card border-0 bg-light p-4">
                <div className="card-body">
                  <h5 className="fw-bold mb-3">
                    Nuestra recomendación
                  </h5>

                  <div className="border rounded bg-white p-3 mb-3">
                    <h6 className="fw-bold">1. Fundamentos de Python</h6>
                    <small className="text-body-secondary">
                      Ideal para comenzar desde cero.
                    </small>
                  </div>

                  <div className="border rounded bg-white p-3">
                    <h6 className="fw-bold">2. Desarrollo Web</h6>
                    <small className="text-body-secondary">
                      Aprende a crear sitios y aplicaciones web.
                    </small>
                  </div>
                </div>
              </div>
            </div>
          </div>

        </div>
      </section>

      {/* LLAMADO A LA ACCIÓN */}
      <section className="py-5 bg-light">
        <div className="container text-center py-4">
          <h2 className="fw-bold">
            Comienza a desarrollar tus habilidades hoy
          </h2>

          <p className="text-body-secondary mt-3">
            Da el primer paso y descubre todo lo que puedes crear.
          </p>

          <Link to="/register" className="btn btn-primary btn-lg mt-3">
            Crear cuenta gratis
          </Link>
        </div>
      </section>

      {/* FOOTER */}
      <footer className="border-top py-4">
        <div className="container">
          <div className="row align-items-center g-3">

            <div className="col-md-6">
              <span className="fw-bold">
                DevLearn
              </span>
              <p className="text-body-secondary mb-0 small">
                Aprende programación y desarrolla tu potencial.
              </p>
            </div>

            <div className="col-md-6 text-md-end">
              <small className="text-body-secondary">
                © {new Date().getFullYear()} DevLearn. Todos los derechos reservados.
              </small>
            </div>

          </div>
        </div>
      </footer>

    </div>
  );
};

export default LandingPage;
