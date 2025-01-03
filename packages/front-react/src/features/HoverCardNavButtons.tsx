import { Button, HoverCard, Stack } from '@mantine/core'
import { useQuery } from '@tanstack/react-query'
import { memoriesType, tripsType } from '../types-constants/types'
import { fetchAllFromTable } from '../async/trips'
import { useNavigate } from 'react-router'

export const HoverCardNavButtons = () => {
    const navigate = useNavigate()

    const trips = useQuery({
        queryKey: ['tripNames'],
        queryFn: () => fetchAllFromTable<tripsType[]>('trips'),
    })

    const memories = useQuery({
        queryKey: ['memoryNames'],
        queryFn: () => fetchAllFromTable<memoriesType[]>('memories'),
    })

    return (
        <>
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
                                onClick={() => {
                                    navigate(`trips/${val.id}`)
                                }}
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
                                onClick={() => {
                                    navigate(`memories/${val.id}`)
                                }}
                            >
                                {val.memoryName}
                            </Button>
                        ))}
                    </Stack>
                </HoverCard.Dropdown>
            </HoverCard>
        </>
    )
}
