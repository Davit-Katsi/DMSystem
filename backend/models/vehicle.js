const { DataTypes } = require('sequelize');
const sequelize = require('./db');  // Import Sequelize instance from db.js
const DriverProfile = require('./driverProfile');

const Vehicle = sequelize.define('Vehicle', {
  make: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  model: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  type: {
    type: DataTypes.STRING,
  },
  trunk_width: {
    type: DataTypes.FLOAT,
  },
  trunk_length: {
    type: DataTypes.FLOAT,
  },
  trunk_height: {
    type: DataTypes.FLOAT,
  },
  capacity_ton: {
    type: DataTypes.FLOAT,
  },
  capacity_m3: {
    type: DataTypes.FLOAT,
  },
  license_plate: {
    type: DataTypes.STRING,
    allowNull: false  // Ensure 'unique: true' is removed
  },
  insurance_details: {
    type: DataTypes.TEXT,
  }
}, {
  timestamps: true,
});

module.exports = Vehicle;
