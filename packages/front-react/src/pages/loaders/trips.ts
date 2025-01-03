import { LoaderFunctionArgs } from 'react-router'
import { fetch } from '../../async/matchCities'
import { photosType } from '../../types-constants/types'

export const tripsPageloader = async ({ params }: LoaderFunctionArgs) => {
    const photosObjArr = await fetch<photosType[]>('tripPhotos', params.tripId)
    return photosObjArr
}
