import { useEffect, useState } from 'react'
import viteLogo from '/vite.svg'
import '../styles/App.css'
import '@mantine/core/styles.css'
import {
    QueryClient,
    QueryClientProvider,
    useQuery,
} from '@tanstack/react-query'

import { MantineProvider } from '@mantine/core'
import { Navbar } from './Navbar'

function App() {
    const queryClient = new QueryClient()

    // useQuery({
    //     queryKey: ['todos'],
    //     queryFn: fetchTodoList,
    //   })

    return (
        <>
            <QueryClientProvider client={queryClient}>
                <MantineProvider defaultColorScheme="dark">
                    <Navbar></Navbar>
                </MantineProvider>
            </QueryClientProvider>
        </>
    )
}

export default App
