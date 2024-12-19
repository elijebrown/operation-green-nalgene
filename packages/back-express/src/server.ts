import express, { Request, Response } from 'express';

const app = express();
const PORT: number = 3000;

// Define a simple route with type annotations
app.get('/', (req: Request, res: Response): void => {
    res.send(`<h1>Hello</h1>`);
});

app.listen(PORT, (): void => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
