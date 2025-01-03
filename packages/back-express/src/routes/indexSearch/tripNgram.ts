import { ngramSearchStringBuilder } from "../../constants/sqlStatements";
import { app, pool } from "../../server"
import express, { Request, Response } from 'express';

export const tripNgram = () => {
app.get('/tripNgram', async (req: Request, res: Response) => {
    const result = await pool.query(ngramSearchStringBuilder({table: 'trips',
        searchColumn: 'trip_name'
    }), [req.query.search || ''])
    res.send(result.rows)
})
}

