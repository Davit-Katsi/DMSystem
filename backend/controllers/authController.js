const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const User = require('../models/user');

exports.loginUser = async (req, res) => {
  const { email, password } = req.body;

  try {
    const user = await User.findOne({ where: { email } });

    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }

    console.log('Entered password:', password);
    console.log('Stored hashed password:', user.password);

    const isPasswordValid = await bcrypt.compare(password, user.password);
    console.log('Is password valid?', isPasswordValid);

    if (!isPasswordValid) {
      return res.status(401).json({ error: 'Incorrect password. Please try again.' });
    }

    const token = jwt.sign({ id: user.id, username: user.username, role: user.role }, 'your_secret_key', { expiresIn: '1h' });
    res.status(200).json({ 
      token,
      user: {
        id: user.id,
        username: user.username,  // Include username in the response
        role: user.role
      }
    });
  } catch (error) {
    console.error('Error logging in:', error);
    res.status(500).json({ error: 'Login failed' });
  }
};

