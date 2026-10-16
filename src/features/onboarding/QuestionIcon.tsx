interface QuestionIconProps {
  name: string
  size?: number
}

export default function QuestionIcon({ name, size = 24 }: QuestionIconProps) {
  const base = {
    width: size,
    height: size,
    viewBox: '0 0 24 24',
    fill: 'none',
    stroke: 'currentColor',
    strokeWidth: 1.8,
    strokeLinecap: 'round',
    strokeLinejoin: 'round',
  } as const

  switch (name) {
    case 'cap':
      return (
        <svg {...base} aria-hidden="true">
          <path d="M2.5 8.5 12 4l9.5 4.5L12 13 2.5 8.5Z" />
          <path d="M6 10.6V15c0 1.1 2.7 2 6 2s6-.9 6-2v-4.4" />
          <path d="M21.5 8.5V13" />
        </svg>
      )
    case 'chart':
      return (
        <svg {...base} aria-hidden="true">
          <rect x="4" y="12" width="3.2" height="7.5" rx="1" />
          <rect x="10.4" y="8" width="3.2" height="11.5" rx="1" />
          <rect x="16.8" y="4" width="3.2" height="15.5" rx="1" />
        </svg>
      )
    case 'doc':
      return (
        <svg {...base} aria-hidden="true">
          <rect x="5" y="3" width="14" height="18" rx="2.5" />
          <path d="M9 8h6M9 12h6M9 16h4" />
        </svg>
      )
    case 'code':
      return (
        <svg {...base} aria-hidden="true">
          <path d="M9 8 5 12l4 4" />
          <path d="M15 8l4 4-4 4" />
          <path d="M13.5 6.5 10.5 17.5" />
        </svg>
      )
    default:
      return (
        <svg {...base} aria-hidden="true">
          <rect x="3" y="3" width="18" height="18" rx="5" />
          <path d="M10 10 8 12l2 2" />
          <path d="M14 10l2 2-2 2" />
        </svg>
      )
  }
}
