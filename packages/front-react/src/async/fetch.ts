import axios from 'axios'
import { camelCase, mapKeys } from 'lodash'

export const fetch = async <T>(
    endpoint: string,
    inputStr?: string
): Promise<T | null> => {
    try {
        const result = await axios.get(
            `http://127.0.0.01:3000/${endpoint}?search=${inputStr || ''}`
        )
        let camelCasedData: any = null
        if (result?.data?.rows) {
            camelCasedData = result.data.rows.map((item: any) =>
                mapKeys(item, (_, key) => camelCase(key))
            )
        } else {
            camelCasedData = result?.data?.map((item: any) =>
                mapKeys(item, (_, key) => camelCase(key))
            )
        }
        console.log(camelCasedData)
        return camelCasedData as T
    } catch (error) {
        console.error(error)
        return null
    }
}
