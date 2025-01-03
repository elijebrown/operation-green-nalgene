import { MantineSize, TextInput } from '@mantine/core'
import { ChangeEvent, useEffect, useState } from 'react'
import { fetch } from '../../async/matchCities'

type props = {
    size?: MantineSize
}

export const SearchAnything = ({ size }: props) => {
    const [text, setText] = useState('')
    const [results, setResults] = useState('')

    const handleChange = (event: ChangeEvent<HTMLInputElement>) => {
        const val = event.target.value
        setText(val)
        if (val) {
            fetch<any>('cityNgram', val).then((response) => {
                console.log(response)
                setResults(response[0].cityName || '')
            })
        }
    }

    useEffect(() => {
        console.log(results)
    }, [results])

    return (
        <>
            <TextInput
                size={size || 'sm'}
                placeholder="Search Anything.."
                value={text}
                onChange={handleChange}
            />
            <h2>{results}</h2>
        </>
    )
}
