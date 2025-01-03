import { useLoaderData } from 'react-router'
import { tripsPageloader } from './loaders/trips'
import { useEffect } from 'react'

export const Trip = () => {
    const photosObjArr = useLoaderData<typeof tripsPageloader>()

    useEffect(() => {
        console.log(photosObjArr)
    }, [photosObjArr])
    return (
        <>
            {photosObjArr?.map((value, index) => (
                <h2 key={index}>{value.photoFilepath}</h2>
            ))}
        </>
    )
}
