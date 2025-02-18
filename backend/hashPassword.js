const bcrypt = require('bcrypt');

const generateHash = async (plainPassword) => {
  const hashedPassword = await bcrypt.hash(plainPassword, 10);
  console.log('Hashed Password:', hashedPassword);
};

// Replace 'new_secure_password' with your desired password
generateHash('new_secure_password');
