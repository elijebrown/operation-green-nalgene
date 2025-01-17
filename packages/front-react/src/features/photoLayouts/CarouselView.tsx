import { photosType } from '../../types-constants/types'
import { Cloudinary } from '@cloudinary/url-gen/index'
import { fill, fit, scale } from '@cloudinary/url-gen/actions/resize'
import { autoGravity } from '@cloudinary/url-gen/qualifiers/gravity'
import { Carousel } from '@mantine/carousel'
import { Image } from '@mantine/core'

type props = { photos: photosType[] }
export const CarouselView = ({ photos }: props) => {
    const cloudinary = new Cloudinary({
        cloud: {
            cloudName: 'dchwbmloi',
        },
    })

    return (
        <Carousel slideSize={'fit-content'} dragFree slideGap={'md'} loop align={'start'}>
            {photos.map((value) => {
                const cldImg = cloudinary
                    .image(value.photoFilepath)
                    .format('auto')
                    .quality('auto')
                    .resize(
                        fit(1200,1200)
                    )
                    .toURL()

                return (
                    <Carousel.Slide key={value.photoFilepath}>
                        <Image
                            src={cldImg}
                            style={{ maxHeight: '500px', minWidth: 'auto'}}
                        />
                    </Carousel.Slide>
                )
            })}
        </Carousel>
    )
}
