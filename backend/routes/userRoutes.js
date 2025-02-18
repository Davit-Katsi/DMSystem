const express = require('express');
const router = express.Router();
const { getUsers, addUser, updateUser, deleteUser, updateProfile } = require('../controllers/userController');
const { authenticateToken, authorizeRoles } = require('../middleware/authMiddleware');
const { requestPasswordReset, resetPassword } = require('../controllers/userController');

// Get all users (Admin only)
router.get('/', authenticateToken, authorizeRoles('admin'), getUsers);

// Add new user (Admin only)
router.post('/', authenticateToken, authorizeRoles('admin'), addUser);

// Update user role (Admin only)
router.put('/:id', authenticateToken, authorizeRoles('admin'), updateUser);

// Delete user (Admin only)
router.delete('/:id', authenticateToken, authorizeRoles('admin'), deleteUser);

// Update profile (for authenticated users)
router.put('/profile', authenticateToken, updateProfile);

// Request password reset (public route)
router.post('/request-password-reset', requestPasswordReset);

// Reset password using token (public route)
router.post('/reset-password', resetPassword);

module.exports = router;
