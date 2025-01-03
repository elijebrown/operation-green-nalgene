import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './styles/index.css'
import App from './pages/App.tsx'
import { createBrowserRouter, RouterProvider } from 'react-router'
import { tripsPageloader } from './pages/loaders/trips.ts'
import { Trip } from './pages/Trip.tsx'
const router = createBrowserRouter([
    {
        path: '/',
        element: <App />,
        children: [
            {
                path: 'trips/',
                children: [
                    {
                        index: true,
                        element: <h1>index</h1>,
                    },
                    {
                        path: ':tripId',
                        element: <Trip />,
                        loader: tripsPageloader,
                    },
                ],
            },
            {
                path: 'memories/',
                children: [
                    {
                        index: true,
                        element: <h1>index</h1>,
                    },
                    {
                        path: ':memoriesid',
                        element: <h1>23432rgsd</h1>,
                    },
                ],
            },
            {
                path: 'photos',
            },
        ],
    },
])

createRoot(document.getElementById('root')!).render(
    <StrictMode>
        <RouterProvider router={router} />
    </StrictMode>
)
