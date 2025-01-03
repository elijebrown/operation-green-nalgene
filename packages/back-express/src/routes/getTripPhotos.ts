import { app, pool } from "../server";
import { Request, Response} from 'express'

export const getTripPhotos = () => (
    app.get('/tripPhotos', async (req: Request, res: Response) => {
        console.log(parseInt(req.query.search as string))
        const result = await pool.query(`
            WITH photoIds AS (
                SELECT photo_id FROM trip_photos WHERE trip_id=$1
            )
            SELECT * FROM photos p JOIN photoIds i ON p.id = i.photo_id; 
            `, [parseInt(req.query.search as string) || ''])
        res.send(result.rows)
    })
)