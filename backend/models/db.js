const { Sequelize } = require("sequelize");
require("dotenv").config(); // Load environment variables

// Initialize Sequelize with DATABASE_URL from environment
const sequelize = new Sequelize(process.env.DATABASE_URL, {
    dialect: "postgres",
    logging: false, // Disable logging in production
    dialectOptions: {
        ssl: {
            require: true, // Required for cloud databases like Render
            rejectUnauthorized: false // Prevents SSL certificate validation errors
        }
    }
});

// Test Connection
sequelize.authenticate()
    .then(() => console.log("✅ Database connected successfully"))
    .catch((err) => console.error("❌ Database connection failed:", err));

module.exports = sequelize;
