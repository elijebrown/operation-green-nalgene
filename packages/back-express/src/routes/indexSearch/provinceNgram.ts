import { ngramSearchStringBuilder, visitedCities, visitedProvinces } from "../../constants/sqlStatements";
import { app, pool } from "../../server";
import { Request, Response } from 'express'

export const provinceNgram = () => (
    app.get('/provinceNgram', async (req: Request, res: Response) => {
        const result = await pool.query(
            `
            WITH matchingProvinces AS (${ngramSearchStringBuilder({
                table: 'provinces',
                searchColumn: 'province_name',
                extraColumns: ['id']
            })}),
            ${visitedProvinces('matchingProvinces')}
            `
            , [req.query.search || ''])
        res.send(result.rows)
    }))
