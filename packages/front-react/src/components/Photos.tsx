import { useLoaderData } from 'react-router'
import { genericLoaderFunction } from '../async/genericLoaderFunction'
import { LibraryView } from '../features/photoLayouts/LibraryView'

export const Photos = () => {
    const photosObjArr = useLoaderData<typeof genericLoaderFunction>()

    return <LibraryView photos={photosObjArr || []} />
}
