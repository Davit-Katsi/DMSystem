const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const User = require('../models/user');

// Get All Users
exports.getUsers = async (req, res) => {
  try {
    const users = await User.findAll();
    res.status(200).json(users);
  } catch (error) {
    console.error('Error fetching users:', error);
    res.status(500).json({ error: 'Failed to fetch users' });
  }
};

// Add New User
exports.addUser = async (req, res) => {
  const { username, email, role, password } = req.body;

  try {
    // Check if email already exists
    const existingUser = await User.findOne({ where: { email } });
    if (existingUser) {
      return res.status(400).json({ error: 'A user with this email already exists.' });
    }

    const hashedPassword = await bcrypt.hash(password, 10);
    const newUser = await User.create({ username, email, role, password: hashedPassword });
    res.status(201).json(newUser);
  } catch (error) {
    console.error('Error adding user:', error);
    res.status(500).json({ error: 'Failed to add user.' });
  }
};

// Update User Role
exports.updateUser = async (req, res) => {
  const { id } = req.params;
  const { role } = req.body;

  try {
    const user = await User.findByPk(id);
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }

    const adminCount = await User.count({ where: { role: 'admin' } });

    if (user.role === 'admin' && role !== 'admin' && adminCount === 1) {
      return res.status(400).json({ error: 'Cannot change role of the last remaining admin.' });
    }

    user.role = role;
    await user.save();

    res.status(200).json(user);
  } catch (error) {
    console.error('Error updating user:', error);
    res.status(500).json({ error: 'Failed to update user' });
  }
};

// Delete User
exports.deleteUser = async (req, res) => {
  const { id } = req.params;

  try {
    const user = await User.findByPk(id);
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }

    const adminCount = await User.count({ where: { role: 'admin' } });

    if (user.role === 'admin' && adminCount === 1) {
      return res.status(400).json({ error: 'Cannot delete the last remaining admin.' });
    }

    await user.destroy();
    res.status(200).json({ message: 'User deleted successfully' });
  } catch (error) {
    console.error('Error deleting user:', error);
    res.status(500).json({ error: 'Failed to delete user' });
  }
};

// Update User Profile (username or email)
exports.updateProfile = async (req, res) => {
  const { username, email } = req.body;
  const userId = req.user.id;  // Get user ID from authenticated token

  try {
    const user = await User.findByPk(userId);

    if (!user) {
      return res.status(404).json({ error: 'User not found.' });
    }

    user.username = username || user.username;
    user.email = email || user.email;

    await user.save();

    res.status(200).json({ message: 'Profile updated successfully.', user });
  } catch (error) {
    console.error('Error updating profile:', error);
    res.status(500).json({ error: 'Failed to update profile.' });
  }
};

// Request Password Reset (Generates a reset token)
exports.requestPasswordReset = async (req, res) => {
  const { email } = req.body;

  try {
    const user = await User.findOne({ where: { email } });

    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }

    // Generate reset token (valid for 15 minutes)
    const resetToken = jwt.sign({ id: user.id }, 'your_secret_key', { expiresIn: '15m' });

    // Simulate sending email (log token for now)
    console.log(`Password reset link: http://localhost:3000/reset-password/${resetToken}`);

    res.status(200).json({ message: 'Password reset link has been sent to your email.' });
  } catch (error) {
    console.error('Error requesting password reset:', error);
    res.status(500).json({ error: 'Failed to request password reset.' });
  }
};

// Reset Password (Validates token and updates password)
exports.resetPassword = async (req, res) => {
  const { token, newPassword } = req.body;

  try {
    const decoded = jwt.verify(token, 'your_secret_key');
    const user = await User.findByPk(decoded.id);

    if (!user) {
      return res.status(404).json({ error: 'User not found.' });
    }

    console.log('Before saving, password should be plain text:', newPassword);
    user.password = newPassword;
    await user.save();
    console.log('After saving, password should be hashed:', user.password);

    res.status(200).json({ message: 'Password has been reset successfully.' });
  } catch (error) {
    console.error('Error resetting password:', error);
    res.status(400).json({ error: 'Invalid or expired token.' });
  }
};

