/**
 * @fileoverview get all db data and hydrate react router with routes
 */

import '../styles/App.css'
import '@mantine/core/styles.css'
import {
    QueryClient,
    QueryClientProvider,
    useQuery,
} from '@tanstack/react-query'

import { MantineProvider } from '@mantine/core'
import { Navbar } from './Navbar'
import { Outlet } from 'react-router'
import '@mantine/carousel/styles.css'

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
                    <Outlet />
                </MantineProvider>
            </QueryClientProvider>
        </>
    )
}

export default App
