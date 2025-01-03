type paramsObj = {
    table: string
    searchColumn: string
    extraColumns?: string[]
    limit?: number
}

// prepared statement (value = $1)
export const ngramSearchStringBuilder = ({ table, searchColumn, extraColumns, limit }: paramsObj) => {
    const columns = `${searchColumn}, ${extraColumns ? extraColumns.join(',') : ''}`

    return `SELECT ${columns}, paradedb.score(id) AS score FROM ${table} WHERE ${searchColumn} @@@ paradedb.fuzzy_phrase(
    field => '${searchColumn}',
    value => $1,
    distance => 0
    )
    ORDER BY score DESC
    ${limit ? 'LIMIT ' + limit : ''}`
}

export const visitedCities = (cityTable: string) => (`SELECT DISTINCT c.id, c.city_name
FROM ${cityTable} c
JOIN photos p ON c.id = p.city_id`)

export const visitedProvinces = (provinceTable: string) => (`
    visitedCities AS (SELECT DISTINCT c.province_id
FROM cities c
JOIN photos p ON c.id = p.city_id)
    SELECT DISTINCT prov.id, prov.province_name
    FROM ${provinceTable} prov
    JOIN visitedCities ON visitedCities.province_id = prov.id
`)


