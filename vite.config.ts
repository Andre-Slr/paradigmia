import { fileURLToPath, URL } from 'node:url'
import react from '@vitejs/plugin-react'
import { defineConfig } from 'vite'

const repository = process.env.GITHUB_REPOSITORY
const base = repository ? `/${repository.split('/')[1]}/` : '/'

// https://vite.dev/config/
export default defineConfig({
  base,
  plugins: [react()],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url)),
    },
  },
})
