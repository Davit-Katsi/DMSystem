const jwt = require('jsonwebtoken');

// Replace this with your actual admin user details
const user = {
  id: 1,
  username: 'adminUser',
  role: 'admin'
};

const token = jwt.sign(user, 'your_secret_key', { expiresIn: '1h' });

console.log('JWT Token:', token);
