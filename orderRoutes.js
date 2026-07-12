const express = require('express');
const db = require('../config/db');
const router = express.Router();

router.post('/place', async (req, res) => {
  try {
    const { userId, totalAmount, deliveryAddress, phone, paymentMethod } = req.body;
    const [result] = await db.query('INSERT INTO orders (user_id, total_amount, delivery_address, phone, payment_method, status) VALUES (?, ?, ?, ?, ?, ?)', [userId, totalAmount, deliveryAddress, phone, paymentMethod, 'Order Placed']);
    res.status(201).json({ message: 'Order placed', orderId: result.insertId });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

router.get('/history/:userId', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT * FROM orders WHERE user_id = ? ORDER BY id DESC', [req.params.userId]);
    res.json(rows);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

module.exports = router;