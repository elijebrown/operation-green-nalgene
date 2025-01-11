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
    ${limit ? 'LIMIT ' + limit : ''}`
}

export const dvisitedCities = (cityTable: string) => (`SELECT DISTINCT c.id, c.city_name, score
FROM ${cityTable} c
JOIN photos p ON c.id = p.city_id`)

export const visitedCities = `
    SELECT DISTINCT c.city_name, c.id, paradedb.score(c.id) AS score
FROM cities c
JOIN photos p ON p.city_id = c.id
WHERE c.city_name @@@ paradedb.fuzzy_phrase(
    field => 'city_name',
    value => $1,
    distance => 0
    )
ORDER BY score DESC
LIMIT 3
`

export const dvisitedProvinces = (provinceTable: string) => (`
    visitedCities AS (SELECT DISTINCT c.province_id
FROM cities c
JOIN photos p ON c.id = p.city_id)
    SELECT DISTINCT prov.id, prov.province_name
    FROM ${provinceTable} prov
    JOIN visitedCities ON visitedCities.province_id = prov.id
`)

export const visitedProvinces = `
 SELECT DISTINCT provinces.province_name, provinces.id, paradedb.score(provinces.id) AS score
FROM provinces
JOIN cities c ON provinces.id = c.province_id
JOIN photos ON photos.city_id = c.id
WHERE provinces.province_name @@@ paradedb.fuzzy_phrase(
    field => 'province_name',
    value => $1,
    distance => 0
    )
ORDER BY score DESC
LIMIT 3
`

// HOW TO SEARCH ALL TABLES: 
/**
 * USE WITH AND STATEMENTS, COMPLETE EACH TABLE SEPERATELY AND INCLUDE SCORE
 * THEN AT THE END SORT ALL THE RESULTS BY SCORE 
 */

// SELECT DISTINCT p.id AS province_id, p.province_name
// FROM provinces p
// JOIN cities c ON p.id = c.province_id
// JOIN photos ph ON c.id = ph.city_id;

export const visitedCountries = (countryTable: string) => (`
    SELECT DISTINCT co.id AS country_id, co.country_name
FROM ${countryTable} co
JOIN provinces p ON co.id = p.country_id
JOIN cities c ON p.id = c.province_id
JOIN photos ph ON c.id = ph.city_id
`)

export const searchAllRelevant = (`
    WITH
    `)


//     SELECT 
//     t1.col1,
//     t2.col2,
//     t3.col3,
//     t4.col4,
//     t5.col5,
//     similarity(t1.col1, t2.col2) AS similarity_col1_col2,
//     similarity(t1.col1, t3.col3) AS similarity_col1_col3,
//     similarity(t1.col1, t4.col4) AS similarity_col1_col4,
//     similarity(t1.col1, t5.col5) AS similarity_col1_col5
// FROM 
//     table1 t1
// FULL OUTER JOIN table2 t2 ON 1 = 1
// FULL OUTER JOIN table3 t3 ON 1 = 1
// FULL OUTER JOIN table4 t4 ON 1 = 1
// FULL OUTER JOIN table5 t5 ON 1 = 1
// WHERE 
//     similarity(t1.col1, t2.col2) > 0.3 OR
//     similarity(t1.col1, t3.col3) > 0.3 OR
//     similarity(t1.col1, t4.col4) > 0.3 OR
//     similarity(t1.col1, t5.col5) > 0.3;
