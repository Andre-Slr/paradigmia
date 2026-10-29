import { useState } from 'react'
import type { CodeLanguage, LessonBlock } from '../types'
import RichText from './RichText'

const LANGUAGE_NAME: Record<CodeLanguage, string> = {
  python: 'Python',
  html: 'HTML',
  css: 'CSS',
}

const CALLOUT_ICON = {
  beginner: '🌱',
  tip: '💡',
  warning: '⚠️',
}

interface LessonBlockViewProps {
  block: LessonBlock
  /** R6: si es false, las ayudas para principiantes se muestran cerradas. */
  beginnerHelpOpen: boolean
}

export default function LessonBlockView({ block, beginnerHelpOpen }: LessonBlockViewProps) {
  const [open, setOpen] = useState(beginnerHelpOpen)

  switch (block.type) {
    case 'heading':
      return <h2>{block.text}</h2>

    case 'text':
      return (
        <p>
          <RichText text={block.text} />
        </p>
      )

    case 'list':
      return (
        <ul>
          {block.items.map((item) => (
            <li key={item}>
              <RichText text={item} />
            </li>
          ))}
        </ul>
      )

    case 'code':
      return (
        <>
          <figure className="code-block">
            <figcaption className="code-block-lang">
              {LANGUAGE_NAME[block.language]}
            </figcaption>
            <pre>
              <code>{block.code}</code>
            </pre>
            {block.output && (
              <div className="code-block-output">
                <span>Resultado en la consola</span>
                <pre>{block.output}</pre>
              </div>
            )}
          </figure>
          {block.caption && <p className="code-caption">{block.caption}</p>}
        </>
      )

    case 'callout':
      if (block.variant === 'beginner' && !open) {
        return (
          <div className="callout">
            <button type="button" className="callout-toggle" onClick={() => setOpen(true)}>
              {CALLOUT_ICON.beginner} Mostrar ayuda: {block.title}
            </button>
          </div>
        )
      }
      return (
        <aside className={`callout is-${block.variant}`}>
          <strong>
            <span aria-hidden="true">{CALLOUT_ICON[block.variant]} </span>
            {block.title}
          </strong>
          <p>
            <RichText text={block.text} />
          </p>
        </aside>
      )

    case 'table':
      return (
        <div className="table-scroll">
          <table className="lesson-table">
            <thead>
              <tr>
                {block.headers.map((header) => (
                  <th key={header} scope="col">
                    {header}
                  </th>
                ))}
              </tr>
            </thead>
            <tbody>
              {block.rows.map((row) => (
                <tr key={row.join('|')}>
                  {row.map((cell, index) => (
                    <td key={index}>{block.codeColumns?.includes(index) ? <code className="inline-code">{cell}</code> : cell}</td>
                  ))}
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )
  }
}
