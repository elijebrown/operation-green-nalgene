import { pool } from "./server";

export const fetchTableNames = async (): Promise<string[]> => {
    const result = await pool.query(`SELECT table_name
      FROM information_schema.tables
     WHERE table_schema='public'
       AND table_type='BASE TABLE' AND table_name != 'spatial_ref_sys';`);

    return result.rows || []
}