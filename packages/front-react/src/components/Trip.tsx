import { useLoaderData } from 'react-router'
import { useEffect } from 'react'
import { Cloudinary } from '@cloudinary/url-gen'
import { LibraryView } from '../features/photoLayouts/LibraryView'
import { genericLoaderFunction } from '../async/genericLoaderFunction'
import { CarouselView } from '../features/photoLayouts/CarouselView'
import { Flex } from '@mantine/core'

export const Trip = () => {
    const photosObjArr = useLoaderData<typeof genericLoaderFunction>()

    return (
        // <Flex justify='center' gap={10} display={'flex'} wrap={'wrap'}>
        //     {photosObjArr?.map((value) => {
        //         const cldImg = cloudinary.image(value.photoFilepath)
        //         .format('auto')
        //         .quality('auto')
        //         .resize(fit(1200,1200))
        //         .roundCorners(byRadius(12))
        //         .toURL()
        //         return (
        //                 <img key={value.photoFilepath} src={cldImg} style={{height: '300px', borderRadius: '7px', minWidth: 'auto', objectFit: 'contain'}}/>)
        //     })}
        // </Flex>
        // <LibraryView photos={photosObjArr || []} />
            <CarouselView photos={photosObjArr || []}/>
    )
}
