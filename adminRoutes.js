const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const db = require('../config/db');
const router = express.Router();

router.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;
    const [rows] = await db.query('SELECT * FROM admins WHERE email = ?', [email]);
    if (!rows.length) return res.status(404).json({ message: 'Admin not found' });
    const admin = rows[0];
    const isMatch = await bcrypt.compare(password, admin.password);
    if (!isMatch) return res.status(401).json({ message: 'Invalid password' });
    const token = jwt.sign({ id: admin.id, role: 'admin' }, process.env.JWT_SECRET, { expiresIn: '1d' });
    res.json({ token, admin: { id: admin.id, name: admin.name, email: admin.email } });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

module.exports = router;