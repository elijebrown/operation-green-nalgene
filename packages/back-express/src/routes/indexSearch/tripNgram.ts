import { app, pool } from "../../server"
import express, { Request, Response } from 'express';

export const tripNgram = () => {
app.get('/tr', async (req: Request, res: Response) => {
    const result = await pool.query(`SELECT trip_name, paradedb.score(id) FROM trips
WHERE trip_name @@@ paradedb.fuzzy_phrase(
field => 'trip_name',
value => '${req.query.search || ''}',
distance => 0
)
ORDER BY score DESC
LIMIT 2
;`)
    res.send(result.rows)
})
}

