import axios from "axios"
import { tablesType } from "../types-constants/types"
import { camelCase, mapKeys } from "lodash"

export const matchSearchText = async <T>(inputStr: string, table: tablesType): Promise<T | null> => {
    try {
        const result = await axios.get(`http://127.0.0.01:3000/cityNgram?search=${inputStr}`)
        const camelCasedData = result.data?.map((item: any) =>
            mapKeys(item, (_, key) => camelCase(key))
        )
        console.log(camelCasedData)
        return camelCasedData as T
    } catch (error) {
        console.error(error)
        return null
    } 
}