const express = require('express');
const router = express.Router();

// Contoh endpoint
router.get('/users', (req, res) => {
    res.send({ message: 'User list' });
});
// Ambil data pesanan dari database
router.get('/orders', (req, res) => {
    const query = 'SELECT name, order_details FROM orders';
  
    db.query(query, (err, results) => {
      if (err) {
        res.status(500).send(err);
      } else {
        res.status(200).send(results);
      }
    });
  });
  

module.exports = router; // Pastikan ini adalah router, bukan object biasa
