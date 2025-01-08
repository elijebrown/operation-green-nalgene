import { useLoaderData } from 'react-router'
import { tripsPageloader } from './loaders/trips'
import { lazy, useEffect } from 'react'
import { AdvancedImage } from '@cloudinary/react';
import { Cloudinary } from "@cloudinary/url-gen";
import { cldBaseUrl } from '../types-constants/constants';
import { Flex, Grid, Image, Paper, Stack } from '@mantine/core';
import { scale, crop, limitFill, fit } from '@cloudinary/url-gen/actions/resize';
import { byRadius } from '@cloudinary/url-gen/actions/roundCorners';

export const Trip = () => {
    const photosObjArr = useLoaderData<typeof tripsPageloader>()

    useEffect(() => {
        console.log(photosObjArr)
    }, [photosObjArr])

    const cloudinary = new Cloudinary({
        cloud: {
            cloudName: 'dchwbmloi'
        }
    })
    return (
        <Flex justify='center' gap={10} display={'flex'} wrap={'wrap'}>
            {photosObjArr?.map((value) => {
                const cldImg = cloudinary.image(value.photoFilepath)
                .format('auto')
                .quality('auto')
                .resize(fit(1200,1200))
                .roundCorners(byRadius(12))
                .toURL()
                return (
                        <img src={cldImg} style={{height: '300px', borderRadius: '7px', minWidth: 'auto', objectFit: 'contain'}}/>)
            })}
        </Flex>
    )
}
