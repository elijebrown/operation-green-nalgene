import { useLoaderData } from 'react-router'
import { tripsPageloader } from './loaders/trips'
import { lazy, useEffect } from 'react'
import { AdvancedImage } from '@cloudinary/react';
import { Cloudinary } from "@cloudinary/url-gen";
import { cldBaseUrl } from '../types-constants/constants';
import { Flex, Grid, Image, Paper, Stack } from '@mantine/core';
import { scale } from '@cloudinary/url-gen/actions/resize';
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
        <Stack>
            {photosObjArr?.map((value) => {
                const cldImg = cloudinary.image(value.photoFilepath)
                .format('auto')
                .quality('auto')
                .resize(scale().width(400))
                .roundCorners(byRadius(12))
                .toURL()
                return (<Paper shadow='md' pr={'20px'} key={value.photoFilepath} style={{maxWidth:'400px', borderRadius: '15px'}}>
                        <img src={cldImg} style={{borderRadius: '7px'}}/>
                        </Paper>)
            })}
        </Stack>
    )
}
