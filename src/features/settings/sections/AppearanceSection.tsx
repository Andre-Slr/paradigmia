import type { FontSize, Preferences } from '../preferences'

const FONT_OPTIONS: Array<{ value: FontSize; label: string; sample: string }> = [
  { value: 'normal', label: 'Normal', sample: 'A' },
  { value: 'grande', label: 'Grande', sample: 'A+' },
  { value: 'muy-grande', label: 'Muy grande', sample: 'A++' },
]

interface SwitchRowProps {
  title: string
  description: string
  checked: boolean
  onChange: (checked: boolean) => void
}

function SwitchRow({ title, description, checked, onChange }: SwitchRowProps) {
  const id = `switch-${title.toLowerCase().replace(/\s+/g, '-')}`
  return (
    <div className="settings-row">
      <div className="settings-row-copy" id={id}>
        <strong>{title}</strong>
        <span>{description}</span>
      </div>
      <button
        type="button"
        role="switch"
        aria-checked={checked}
        aria-labelledby={id}
        className="settings-switch"
        onClick={() => onChange(!checked)}
      />
    </div>
  )
}

interface AppearanceSectionProps {
  preferences: Preferences
  onChange: (changes: Partial<Preferences>) => void
}

/** Apariencia y accesibilidad: se guarda en este navegador y se aplica en toda la plataforma. */
export default function AppearanceSection({ preferences, onChange: update }: AppearanceSectionProps) {
  return (
    <section className="settings-card" id="apariencia" aria-labelledby="apariencia-title">
      <div className="settings-card-head">
        <h2 id="apariencia-title">Apariencia y accesibilidad</h2>
        <p>Los cambios se aplican al momento en toda la plataforma y se guardan en este navegador.</p>
      </div>

      <div className="settings-row">
        <div className="settings-row-copy">
          <strong id="font-size-label">Tamaño de letra</strong>
          <span>Agranda todos los textos, incluidas las lecciones.</span>
        </div>
        <div className="settings-segmented" role="group" aria-labelledby="font-size-label">
          {FONT_OPTIONS.map((option) => (
            <button
              key={option.value}
              type="button"
              aria-pressed={preferences.fontSize === option.value}
              onClick={() => update({ fontSize: option.value })}
            >
              <span className="size-sample" aria-hidden="true">{option.sample}</span>
              <small>{option.label}</small>
            </button>
          ))}
        </div>
      </div>

      <SwitchRow
        title="Alto contraste"
        description="Oscurece los textos, marca los bordes y subraya los enlaces."
        checked={preferences.highContrast}
        onChange={(highContrast) => update({ highContrast })}
      />

      <SwitchRow
        title="Reducir animaciones"
        description="Quita las transiciones y los movimientos de la interfaz."
        checked={preferences.reducedMotion}
        onChange={(reducedMotion) => update({ reducedMotion })}
      />

      <div className="settings-preview" aria-live="polite">
        <strong>Vista previa</strong>
        <p>Así se verá el texto de tus lecciones con la configuración actual.</p>
      </div>
    </section>
  )
}
