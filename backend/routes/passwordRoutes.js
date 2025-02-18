const express = require('express');
const router = express.Router();
const { requestPasswordReset, resetPassword } = require('../controllers/userController');

// Route to request password reset
router.post('/request-reset', requestPasswordReset);

// Route to reset password
router.post('/reset-password', resetPassword);

module.exports = router;
