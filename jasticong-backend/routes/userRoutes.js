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
  // Tambah pesan baru
router.post('/messages', (req, res) => {
  const { user_id, friend_id, food_name, details, quantity, price } = req.body;
  const query = `INSERT INTO messages (user_id, friend_id, food_name, details, quantity, price)
                 VALUES (?, ?, ?, ?, ?, ?)`;

  db.query(query, [user_id, friend_id, food_name, details, quantity, price], (err, result) => {
      if (err) {
          res.status(500).send(err);
      } else {
          res.status(201).send({ id: result.insertId, message: 'Message created successfully' });
      }
  });
});

// Ambil semua pesan untuk user tertentu
router.get('/messages/:userId', (req, res) => {
  const userId = req.params.userId;
  const query = `SELECT * FROM messages WHERE user_id = ? OR friend_id = ?`;

  db.query(query, [userId, userId], (err, results) => {
      if (err) {
          res.status(500).send(err);
      } else {
          res.status(200).send(results);
      }
  });
});

// Update pesan
router.put('/messages/:id', (req, res) => {
  const { food_name, details, quantity, price } = req.body;
  const query = `UPDATE messages SET food_name = ?, details = ?, quantity = ?, price = ? WHERE id = ?`;

  db.query(query, [food_name, details, quantity, price, req.params.id], (err, result) => {
      if (err) {
          res.status(500).send(err);
      } else {
          res.status(200).send({ message: 'Message updated successfully' });
      }
  });
});

// Hapus pesan
router.delete('/messages/:id', (req, res) => {
  const query = `DELETE FROM messages WHERE id = ?`;

  db.query(query, [req.params.id], (err, result) => {
      if (err) {
          res.status(500).send(err);
      } else {
          res.status(200).send({ message: 'Message deleted successfully' });
      }
  });
});


module.exports = router; // Pastikan ini adalah router, bukan object biasa
