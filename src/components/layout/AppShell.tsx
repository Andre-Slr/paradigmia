import type { ReactNode } from 'react'
import Sidebar from './Sidebar'

interface AppShellProps {
  children: ReactNode
  onLogout?: () => Promise<string | null> | string | null | void
}

export default function AppShell({ children, onLogout }: AppShellProps) {
  return (
    <div className="student-shell">
      <aside className="student-sidebar-wrapper">
        <div className="student-sidebar-shell">
          <Sidebar onLogout={onLogout} />
        </div>
      </aside>

      <main className="student-main">
        <div className="student-page">{children}</div>
      </main>
    </div>
  )
}
