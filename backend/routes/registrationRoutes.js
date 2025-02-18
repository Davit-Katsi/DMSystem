const express = require('express');
const router = express.Router();
const driverRegistrationController = require('../controllers/driverRegistrationController');

// Route to register a new driver
router.post('/register', driverRegistrationController.registerDriver);

module.exports = router;
