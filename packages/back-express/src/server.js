const express = require('express');
const app = express();
const PORT = 3000

// Define a simple route
app.get('/', (req, res) => {
    res.send(`<h1>hello </h1>`);
});

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
