const express = require('express');
const router = express.Router();
const { getDriverById, deleteDriver, updateDriver, getDriverStats } = require('../controllers/dashboardController');
const { getAllDrivers, getLatestDrivers, searchDrivers, getClosestDrivers,} = require('../controllers/dashboardController');
const { authenticateToken, } = require('../middleware/authMiddleware');
const { downloadBackup, uploadBackup } = require('../controllers/dashboardController');
const multer = require('multer');
// Multer setup for file uploads
const upload = multer({ dest: 'uploads/' });

// Debugging: Check if functions are defined
console.log('getLatestDrivers:', getLatestDrivers);
console.log('searchDrivers:', searchDrivers);
console.log('getClosestDrivers:', getClosestDrivers);

// GET driver stats
router.get('/drivers/stats', authenticateToken, getDriverStats);

// Route to get the latest drivers (accessible to all roles)
router.get('/drivers/latest', authenticateToken, getLatestDrivers);

// Route to search drivers based on criteria (accessible to all roles)
router.get('/drivers/search', authenticateToken, searchDrivers);

// Route to find the closest drivers to a zip code (accessible to dispatchers and admins)
router.get('/drivers/closest', authenticateToken, getClosestDrivers);

// DELETE driver by ID
router.delete('/drivers/:id', authenticateToken, deleteDriver);

// Get All Drivers
router.get('/drivers/all', authenticateToken, getAllDrivers);
// GET driver by ID
router.get('/drivers/:id', authenticateToken, getDriverById);

// PUT driver by ID
router.put('/drivers/:id', authenticateToken, updateDriver);

// Route to download backup (Admin only)
router.get('/backup/download', authenticateToken, downloadBackup);

// Route to upload backup (Admin only)
router.post('/backup/upload', authenticateToken, upload.single('backupFile'), uploadBackup);

module.exports = router;