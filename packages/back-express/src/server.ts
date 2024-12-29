import express, { Request, Response } from 'express';
import { Pool } from 'pg';
import { createGetterRoutes } from './fetchTableNames';
import { tripNgram } from './routes/indexSearch/tripNgram';

export const app = express();
const PORT = 3000;

// connect to database:
export const pool = new Pool({
    user: "pablo_escobar_gaviria",
    host: 'database',
    database: "narcos",
    password: "APyRnWxbJu7JB#",
    port: 5432,
})
  

// Define a simple route with type annotations
app.get('/', async (req: Request, res: Response) => {
    try {

        const result = await pool.query(`SELECT table_name
  FROM information_schema.tables
 WHERE table_schema='public'
   AND table_type='BASE TABLE' AND table_name != 'spatial_ref_sys';`);
        res.send();
    } catch (err) {
        console.error('Error connecting to the database:', err);
        res.status(500).send(err);
    }
});

app.get('/test', async (req: Request, res: Response) => {
    const result = await pool.query(`SELECT country_name, paradedb.score(id) FROM countries
WHERE country_name @@@ '${req.query.search || ''}'
ORDER BY score DESC;`)
    res.send(result.rows)
})

tripNgram()

createGetterRoutes().then((response) => {
    app.listen(PORT, (): void => {
        console.log(`Server is running on http://localhost:${PORT}`);
    });
})

