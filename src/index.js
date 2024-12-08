const express = require('express');
const app = express();

// Define a simple route
app.get('/', (req, res) => {
    res.send('Hello World!');
});

// Start the server on port 8080
const PORT = 8080;
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
