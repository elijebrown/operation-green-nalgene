import express, { Request, Response } from 'express';
import { Pool } from 'pg';

const app = express();
const PORT = 3000;


// connect to database:
const pool = new Pool({
    user: "pablo_escobar_gaviria",
    host: 'database',
    database: "narcos",
    password: "APyRnWxbJu7JB#",
    port: 5432,
})

// Define a simple route with type annotations
app.get('/', async (req: Request, res: Response) => {
    try {
        
      const result = await pool.query('SELECT * FROM countries');
      res.send(result);
    } catch (err) {
      console.error('Error connecting to the database:', err);
      res.status(500).send(err);
    }
  });

app.listen(PORT, (): void => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
