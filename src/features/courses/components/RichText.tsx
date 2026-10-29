interface RichTextProps {
  text: string
}

/**
 * Muestra un texto convirtiendo lo que va entre `comillas invertidas` en código
 * en línea. Así el contenido de las lecciones se escribe como texto simple.
 */
export default function RichText({ text }: RichTextProps) {
  const parts = text.split('`')

  return (
    <>
      {parts.map((part, index) =>
        index % 2 === 1 ? (
          <code key={index} className="inline-code">
            {part}
          </code>
        ) : (
          part
        ),
      )}
    </>
  )
}
