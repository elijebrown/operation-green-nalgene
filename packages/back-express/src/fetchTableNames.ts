import { app, pool } from "./server";
import { Request, Response } from 'express';


const fetchTableNames = async (): Promise<string[]> => {
    const result = await pool.query(`SELECT table_name
      FROM information_schema.tables
     WHERE table_schema='public'
       AND table_type='BASE TABLE' AND table_name != 'spatial_ref_sys';`);

    // iterate through indexes
   return result.rows.map((row) => row.table_name)
}

export const createGetterRoutes = async () => {
    const tableNames = await fetchTableNames()
    tableNames.forEach((table) => {
        app.get(`/${table}`, async (req: Request, res: Response) => {
            const { rows, rowCount } = await pool.query(`SELECT * FROM ${table};`)
            res.send({ rowCount, rows })
        })
    })
    return tableNames
}