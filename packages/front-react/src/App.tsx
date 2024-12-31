import { ChangeEvent, ChangeEventHandler, useState } from 'react'
import reactLogo from './assets/react.svg'
import viteLogo from '/vite.svg'
import './App.css'
import { Button } from '@/components/ui/button'
import { Input } from './components/ui/input'

function App() {
  const [count, setCount] = useState(0)
  const [text, setText] = useState('')
  const [result, setResult] = useState('')

  const handleChange = async (event: ChangeEvent<HTMLInputElement>) => {
    const searchValue = event.target.value;
    
    // Set the text state with the current input value
    setText(searchValue);
  
    // Log the input value for debugging
  
    try {
      // Send the GET request with the query parameter 'search'
      const response = await fetch(`http://localhost:3000/cityNgram?search=${encodeURIComponent(searchValue)}`, {
        method: 'GET', // Default is 'GET', you can omit this if you want
        headers: {
          'Content-Type': 'application/json', // Add headers if needed
        },
      });
  
      // Handle the response
      if (response.ok) {
        const data = await response.json(); // Assuming the server returns JSON
        console.log(data);
        setResult(JSON.stringify(data))
      } else {
        console.error('Error fetching data:', response.status);
      }
    } catch (error) {
      console.error('Fetch error:', error);
    }
  };
  

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
      <Input onChange={handleChange} value={text} title='input your bob here'></Input>
      <h2>{result}</h2>
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
