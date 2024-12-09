import { useState } from 'react'
import reactLogo from './assets/react.svg'
import viteLogo from '/vite.svg'
import './App.css'
import { Button } from '@/components/ui/button'
import { Input } from './components/ui/input'

function App() {
  const [count, setCount] = useState(0)

  return (
    <>
      <div >
        <a href="https://vite.dev" target="_blank">
          <img src={viteLogo} className="logo" alt="Vite logo" />
        </a>
        <a href="https://react.dev" target="_blank">
          <img src={reactLogo} className="logo react" alt="React logo" />
        </a>
      </div>
      <h1>ssb</h1>
      <Input title='input your bob here'></Input>
      <Button variant='default'><small className="text-sm font-medium leading-none">hello</small></Button>
      <div className="card">
        <button onClick={() => setCount((count) => count + 1)}>
          hello mudda{count}
        </button>
        <p>
          Edit <code>src/App.tsx</code> and save to test HMR
        </p>
      </div>
      <p className="read-the-docs">
        Click on the Vite and React logos to learn more
      </p>

      <p className="text-sm text-muted-foreground">Enter your email address.</p>
      <h2 className="scroll-m-20 border-b pb-2 text-3xl font-semibold tracking-tight first:mt-0">
      The People of the Kingdom
    </h2>
    </>
  )
}

export default App
