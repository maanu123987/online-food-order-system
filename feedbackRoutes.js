const express = require('express');
const db = require('../config/db');
const router = express.Router();

router.post('/', async (req, res) => {
  try {
    const { userId, foodId, rating, comment } = req.body;
    await db.query('INSERT INTO feedback (user_id, food_id, rating, comment) VALUES (?, ?, ?, ?)', [userId, foodId, rating, comment]);
    res.status(201).json({ message: 'Feedback submitted' });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

module.exports = router;