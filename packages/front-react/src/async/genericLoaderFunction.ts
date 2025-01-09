import { LoaderFunctionArgs } from 'react-router'
import { fetch } from './fetch'
import { photosType } from '../types-constants/types'

export const genericLoaderFunction =
    (endpoint: string, queryString?: string) =>
    async ({ params }: LoaderFunctionArgs) => {
        const photosObjArr = await fetch<photosType[]>(
            endpoint,
            params[queryString || '']
        )
        return photosObjArr
    }
