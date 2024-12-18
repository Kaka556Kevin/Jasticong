const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const db = require('./db'); // Pastikan file ini benar-benar ada dan di-export dengan benar

const app = express();

// Middleware
app.use(cors()); // Pastikan ini adalah fungsi
app.use(bodyParser.json());

// Routes
const userRoutes = require('./routes/userRoutes'); // Pastikan ini benar
app.use('/api', userRoutes); // Pastikan `userRoutes` adalah router, bukan object biasa
const orderRoutes = require('./routes/userRoutes'); // Tambahkan jika belum
app.use('/api/orders', orderRoutes); // Pastikan route ini aktif


// Server
const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Backend running at http://localhost:${PORT}`);
});
