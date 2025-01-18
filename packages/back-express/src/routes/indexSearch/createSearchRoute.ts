import { memorySimiliaritySearch, searchAllRelevant, tripSimilaritySearch, visitedCities, visitedCountries, visitedProvinces } from "../../constants/sqlStatements";
import { app, pool } from "../../server";

type searchRoute = {endpoint: string, query: string}

export const searchRoutes: searchRoute[] = [
  {endpoint: 'citySearch', query: visitedCities},
  {endpoint: 'provinceSearch', query: visitedProvinces},
  {endpoint: 'countrySearch', query: visitedCountries},
  {endpoint: 'tripSearch', query: tripSimilaritySearch},
  {endpoint: 'memorySearch', query: memorySimiliaritySearch},
  {endpoint: 'searchAll', query: searchAllRelevant}
]

export const createSearchRoute = (endpoint: string, query: string) => (
  app.get(`/${endpoint}`, async (req, res) => {
    const result = await pool.query(query, [req.query.search || ''])
    res.send(result.rows)
  }
) 
)