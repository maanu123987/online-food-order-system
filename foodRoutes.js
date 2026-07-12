const express = require('express');
const db = require('../config/db');
const router = express.Router();

router.get('/', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT * FROM food_items ORDER BY id DESC');
    res.json(rows);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

router.get('/:id', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT * FROM food_items WHERE id = ?', [req.params.id]);
    if (!rows.length) return res.status(404).json({ message: 'Food not found' });
    res.json(rows[0]);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

module.exports = router;