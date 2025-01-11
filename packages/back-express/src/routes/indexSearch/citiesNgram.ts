import { ngramSearchStringBuilder, visitedCities } from "../../constants/sqlStatements";
import { app, pool } from "../../server";
import { Request, Response } from 'express'

export const cityNgram = () => (
    app.get('/cityNgram', async (req: Request, res: Response) => {
        const result = await pool.query(visitedCities, [req.query.search || ''])
        res.send(result.rows)
    }))

// WITH validCities AS (SELECT DISTINCT c.id, c.city_name
//     FROM cities c
//     JOIN photos p ON c.id = p.city_id)
// SELECT city_name, paradedb.score(id) FROM validCities WHERE city_name @@@ paradedb.fuzzy_phrase(
//     field => 'city_name',
//     value => $1,
//     distance => 0
//     )
//     ORDER BY score DESC
//     LIMIT 2;`    