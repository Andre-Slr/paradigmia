import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import { BrowserRouter } from 'react-router-dom'
import 'bootstrap/dist/css/bootstrap.min.css'
import '@/styles/theme.css'
import App from '@/App'
import { applyPreferences, loadPreferences } from '@/features/settings/preferences'
import '@/features/settings/settings.css'

// Aplica tamaño de letra, contraste y animaciones guardados antes de mostrar la app.
applyPreferences(loadPreferences(null))

const basename = import.meta.env.BASE_URL.replace(/\/$/, '') || undefined

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <BrowserRouter basename={basename}>
      <App />
    </BrowserRouter>
  </StrictMode>,
)
