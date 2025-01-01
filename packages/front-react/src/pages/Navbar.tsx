import { useQuery } from '@tanstack/react-query'
import { fetchAllFromTable } from '../async/trips'
import { useEffect } from 'react'
import {
    Button,
    Flex,
    Group,
    TextInput,
    Grid,
    HoverCard,
    Text,
    Stack,
} from '@mantine/core'
import { defSpacing } from '../types-constants/constants'
import { memoriesType, tablesType, tripsType } from '../types-constants/types'

export const Navbar = () => {
    const trips = useQuery({
        queryKey: ['tripNames'],
        queryFn: () => fetchAllFromTable<tripsType[]>('trips'),
    })

    const memories = useQuery({
        queryKey: ['memoryNames'],
        queryFn: () => fetchAllFromTable<memoriesType[]>('memories')
    })

    useEffect(() => {
        if (!trips.isLoading && !trips.isError) {
            trips.data?.map((val) => console.log(val))
        }
    }, [trips])

    return (
        <Grid mt={defSpacing} ml={defSpacing} mr={defSpacing} pos={'sticky'}>
            <Grid.Col span={8}>
                <Button variant="subtle" color="orange" size="md">
                    Home
                </Button>
                <HoverCard withArrow>
                    <HoverCard.Target>
                        <Button
                            variant="subtle"
                            color="orange"
                            size="md"
                            className="no-click-cursor"
                        >
                            Trips
                        </Button>
                    </HoverCard.Target>
                    <HoverCard.Dropdown p={0}>
                        <Stack gap={0}>
                            {trips.data?.map((val, index) => (
                                <Button
                                    color="gray"
                                    radius={0}
                                    variant="subtle"
                                    key={index}
                                >
                                    {val.tripName}
                                </Button>
                            ))}
                        </Stack>
                    </HoverCard.Dropdown>
                </HoverCard>
                <HoverCard withArrow>
                    <HoverCard.Target>
                        <Button
                            variant="subtle"
                            color="orange"
                            size="md"
                            className="no-click-cursor"
                        >
                            Memories
                        </Button>
                    </HoverCard.Target>
                    <HoverCard.Dropdown p={0}>
                        <Stack gap={0}>
                            {memories.data?.map((val, index) => (
                                <Button
                                    color="gray"
                                    radius={0}
                                    variant="subtle"
                                    key={index}
                                >
                                    {val.memoryName}
                                </Button>
                            ))}
                        </Stack>
                    </HoverCard.Dropdown>
                </HoverCard>
                <Button variant="subtle" color="orange" size="md">
                    Photos
                </Button>
                <Button variant="subtle" color="orange" size="md">
                    About
                </Button>
            </Grid.Col>
            <Grid.Col span={4}>
                <TextInput
                    size="md"
                    placeholder="Search Anything.."
                ></TextInput>
            </Grid.Col>
        </Grid>
    )
}
