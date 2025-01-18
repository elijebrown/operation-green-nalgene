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

export const visitedCountries = (`
    SELECT DISTINCT co.id, country_id, co.country_name, paradedb.score(co.id) AS score
FROM countries co
JOIN provinces p ON co.id = p.country_id
JOIN cities c ON p.id = c.province_id
JOIN photos ph ON c.id = ph.city_id
WHERE co.country_name @@@ paradedb.fuzzy_phrase(
    field => 'country_name',
    value => $1,
    distance => 0
    )
ORDER BY score DESC
LIMIT 3
`)


export const tripSimilaritySearch = (`
    SELECT DISTINCT t.id, t.trip_name, t.trip_date, t.trip_text, paradedb.score(t.id) AS score
FROM trips t
WHERE t.trip_name @@@ paradedb.fuzzy_phrase(
    field => 'trip_name',
    value => $1,
    distance => 0
    )
    ORDER BY score DESC
    LIMIT 1
  `)

export const memorySimiliaritySearch = (`
    SELECT DISTINCT m.id AS *, paradedb.score(m.id) AS score
FROM memories m
WHERE m.memory_title @@@ paradedb.fuzzy_phrase(
    field => 'memory_title',
    value => $1,
    distance => 0
    )
    `)

// export const visitedCountries = `SELECT DISTINCT co.id AS country_id, co.country_name
// FROM countries co
// JOIN provinces p ON co.id = p.country_id
// JOIN cities c ON p.id = c.province_id
// JOIN photos ph ON c.id = ph.city_id
// `



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

export const searchAllRelevant = (`
  WITH
-- CTE for Visited Cities
visited_cities AS (
    SELECT 
        c.id AS id, 
        c.city_name AS name, 
        'city' AS type,
        paradedb.score(c.id) AS score
    FROM cities c
    JOIN photos p ON p.city_id = c.id
    WHERE c.city_name @@@ paradedb.fuzzy_phrase(
        field => 'city_name',
        value => $1,
        distance => 0
    )
    GROUP BY c.id, c.city_name
    ORDER BY score DESC
    LIMIT 3
),

-- CTE for Visited Provinces
visited_provinces AS (
    SELECT 
        provinces.id AS id, 
        provinces.province_name AS name, 
        'province' AS type,
        paradedb.score(provinces.id) AS score
    FROM provinces
    JOIN cities c ON provinces.id = c.province_id
    JOIN photos ph ON ph.city_id = c.id
    WHERE provinces.province_name @@@ paradedb.fuzzy_phrase(
        field => 'province_name',
        value => $1,
        distance => 0
    )
    GROUP BY provinces.id, provinces.province_name
    ORDER BY score DESC
    LIMIT 3
),

-- CTE for Visited Countries
visited_countries AS (
    SELECT 
        co.id AS id, 
        co.country_name AS name, 
        'country' AS type,
        paradedb.score(co.id) AS score
    FROM countries co
    JOIN provinces p ON co.id = p.country_id
    JOIN cities c ON p.id = c.province_id
    JOIN photos ph ON c.id = ph.city_id
    WHERE co.country_name @@@ paradedb.fuzzy_phrase(
        field => 'country_name',
        value => $1,
        distance => 0
    )
    GROUP BY co.id, co.country_name
    ORDER BY score DESC
    LIMIT 3
),

-- CTE for Trip Similarity Search
trip_similarity AS (
    SELECT 
        t.id AS id, 
        t.trip_name AS name, 
        'trip' AS type,
        paradedb.score(t.id) AS score
    FROM trips t
    WHERE t.trip_name @@@ paradedb.fuzzy_phrase(
        field => 'trip_name',
        value => $1,
        distance => 0
    )
    ORDER BY score DESC
    LIMIT 1
),

-- CTE for Memory Similarity Search
memory_similarity AS (
    SELECT 
        m.id AS id, 
        m.memory_title AS name, 
        'memory' AS type,
        paradedb.score(m.id) AS score
    FROM memories m
    WHERE m.memory_title @@@ paradedb.fuzzy_phrase(
        field => 'memory_title',
        value => $1,
        distance => 0
    )
    GROUP BY m.id, m.memory_title
    ORDER BY score DESC
    LIMIT 3 -- Added LIMIT for consistency
)

-- Consolidate All Results Using SELECT *
SELECT * FROM visited_cities

UNION ALL

SELECT * FROM visited_provinces

UNION ALL

SELECT * FROM visited_countries

UNION ALL

SELECT * FROM trip_similarity

UNION ALL

SELECT * FROM memory_similarity

-- Final Ordering by Score
ORDER BY score DESC;
`)
