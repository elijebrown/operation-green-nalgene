import { ngramSearchStringBuilder, visitedCities, visitedProvinces } from "../../constants/sqlStatements";
import { app, pool } from "../../server";
import { Request, Response } from 'express'

export const provinceNgram = () => (
    app.get('/provinceNgram', async (req: Request, res: Response) => {
        const result = await pool.query(
            visitedProvinces
            , [req.query.search || ''])
        res.send(result.rows)
    }))
