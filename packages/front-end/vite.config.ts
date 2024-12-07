import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  root: './packages/front-end/',
  plugins: [react()],
  build: {
    outDir: '../../dist',
    rollupOptions: {
      input: './packages/front-end/index.html'
    }
  }
})
