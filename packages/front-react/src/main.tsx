import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './styles/index.css'
import App from './components/App.tsx'
import { createBrowserRouter, RouterProvider } from 'react-router'
import { Trip } from './components/Trip.tsx'
import { genericLoaderFunction } from './async/genericLoaderFunction.ts'
import { Photos } from './components/Photos.tsx'

const tripsLoader = genericLoaderFunction('tripPhotos', 'tripId')
const photosLoader = genericLoaderFunction('photos')
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
                        loader: tripsLoader,
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
                element: <Photos />,
                loader: photosLoader,
            },
        ],
    },
])

createRoot(document.getElementById('root')!).render(
    <StrictMode>
        <RouterProvider router={router} />
    </StrictMode>
)
