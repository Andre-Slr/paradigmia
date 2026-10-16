# Paradigmia

Aplicación web construida con React, TypeScript, Vite y Supabase (autenticación por correo y contraseña).

## Requisitos

- [Bun](https://bun.sh) (recomendado) o Node.js + npm

## Instalación

```bash
bun install
```

## Variables de entorno

Crea un archivo `.env.local` en la raíz del proyecto con las siguientes variables:

```env
VITE_SUPABASE_URL=tu_url_de_supabase
VITE_SUPABASE_PUBLISHABLE_KEY=tu_clave_publica
```

Puedes obtener estos valores desde el panel de Supabase: **Project Settings → API**.

## Ejecutar en local

```bash
bun run dev
```

La aplicación estará disponible en `http://localhost:5173`.

## Scripts disponibles

| Comando           | Descripción                                |
| ----------------- | ------------------------------------------ |
| `bun run dev`     | Inicia el servidor de desarrollo con HMR   |
| `bun run build`   | Compila el proyecto para producción        |
| `bun run preview` | Previsualiza la compilación de producción  |
| `bun run lint`    | Ejecuta el linter (ESLint)                 |

## Estilos / Design System

La app usa **Bootstrap 5** y un único archivo de tema (`src/styles/theme.css`) que define la paleta y las tipografías oficiales. Reglas para todo el equipo:

- Usar siempre clases de Bootstrap (`btn`, `form-control`, `container`, `row`, `col`, etc.).
- **No hardcodear** colores ni fuentes: el único lugar con colores y tipografías es `src/styles/theme.css` (variables `--bs-*`).
- Paleta oficial: `#19350C`, `#687D31`, `#D5D3CC`, `#406768`, `#6FA9BB`.
- Tipografías: **Nunito** (títulos, botones, navegación) y **Inter** (párrafos, formularios y textos generales).
- Clases personalizadas adicionales viven también en `theme.css` (`.brand-icon`, `.user-info`, etc.).

## Funcionalidades

- Registro e inicio de sesión con Supabase Auth.
- Cierre de sesión y persistencia de la sesión.
