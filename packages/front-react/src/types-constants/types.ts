export type tablesType = 'countries' | 'provinces' | 'cities' | 'trips' | 'memories' | 'photos'

export type tripsType = {
    id: number
    tripDate: string
    tripName: string
    tripText: string | null
}

export type memoriesType = {
    id: number
    tripId: number
    memoryText: string
    memoryName: string
}
