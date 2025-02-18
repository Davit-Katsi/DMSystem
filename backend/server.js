const express = require('express');
const cors = require('cors');
const app = express();
const sequelize = require('./models');  // Import Sequelize
const registrationRoutes = require('./routes/registrationRoutes');  // Import Registration Routes
const dashboardRoutes = require('./routes/dashboardRoutes');
require('dotenv').config();
const googleApiKey = process.env.GOOGLE_MAPS_API_KEY;

const PORT = process.env.PORT || 5000;

// Enable CORS for all origins
app.use(cors());

app.use(express.json());  // Middleware to parse JSON

const authRoutes = require('./routes/authRoutes');
app.use('/api/auth', authRoutes);

const passwordRoutes = require('./routes/passwordRoutes');
app.use('/api/password', passwordRoutes);

const userRoutes = require('./routes/userRoutes');
app.use('/api/users', userRoutes);

// Use Dashboard Routes
app.use('/api', dashboardRoutes);

// API Routes
app.use('/api', registrationRoutes);

app.get('/', (req, res) => {
  res.send('Driver Management System API is running!');
});

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});

app.get('/test-db', async (req, res) => {
  try {
    await sequelize.authenticate();
    res.send("Database connection successful! 🎉");
  } catch (error) {
    res.status(500).send("Database connection failed: " + error.message);
  }
});
