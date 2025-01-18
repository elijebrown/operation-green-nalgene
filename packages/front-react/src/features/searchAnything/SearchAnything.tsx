import { Autocomplete, Combobox, MantineSize, TextInput } from '@mantine/core'
import { ChangeEvent, useEffect, useState } from 'react'
import { fetch } from '../../async/fetch'
import { searchResultType } from '../../types-constants/types'
import { useNavigate } from 'react-router'

type props = {
    size?: MantineSize
}

export const SearchAnything = ({ size }: props) => {
    const [text, setText] = useState('')
    const [results, setResults] = useState<string[]>([])

    const handleChange = (value: string) => {
        setText(value)
        if (value) {
            fetch<searchResultType[]>('searchAll', value).then((response) => {
                console.log(response)
                const filteredResults = response?.map((searchObj) => (
                  `${searchObj.name}: ${searchObj.type === 'province' ? 'region' : searchObj.type}`
                ))
                setResults(filteredResults || [])
            })
        } else {
            setResults([])
        }
    }

    const navigate = useNavigate()

    return (
        <>
            <p>{Math.random()}</p>
            {/* <Combobox withinPortal={false}>
              <Combobox.Target>
                <TextInput
                    size={size || 'sm'}
                    placeholder="Search Anything.."
                    value={text}
                    onChange={handleChange}
                />
              </Combobox.Target>
              <Combobox.Dropdown>
                <Combobox.Options>
                {results.map((val, index) => (
              <Combobox.Option key={index} value={val.name}/>
            ))}
                </Combobox.Options>
              </Combobox.Dropdown>
            </Combobox> */}
            <Autocomplete
                data={results.map((val) => val)}
                placeholder="Search Anything.."
                onChange={handleChange}
                onOptionSubmit={() => {
                  navigate('/')
                }}
            ></Autocomplete>
        </>
    )
}
