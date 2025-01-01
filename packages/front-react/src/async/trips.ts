import axios from 'axios'
import { urlBasePath } from '../types-constants/constants'
import { mapKeys, camelCase } from 'lodash';
import { tablesType } from '../types-constants/types'

export const fetchAllFromTable = async <T>(table: tablesType): Promise<T | null> => {
    try {
        const result = await axios.get(`http://127.0.0.1:3000/${table}`)
        const camelCasedData = result.data.rows.map((item: any) =>
            mapKeys(item, (_, key) => camelCase(key))
        )
        console.log(camelCasedData)
        return camelCasedData as T
    } catch (error) {
        console.error(error)
        return null
    }
}
