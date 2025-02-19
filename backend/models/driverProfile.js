const { DataTypes } = require('sequelize');
const sequelize = require('./db');  // Import Sequelize instance from db.js
const Vehicle = require('./vehicle');

DriverProfile.hasOne(Vehicle, { foreignKey: "driverProfileId", as: "vehicle" }); // ✅ Corrected association

const DriverProfile = sequelize.define('DriverProfile', {
  name: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  phone_number: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  email: {
    type: DataTypes.STRING,
    validate: {
      isEmail: true,
    },
  },
  address: {
    type: DataTypes.TEXT,
  },
  license_number: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  license_expiration: {
    type: DataTypes.DATE,
    allowNull: false,
  },
  availability: {
    type: DataTypes.ENUM('Available', 'On-Duty', 'Offline'),
    defaultValue: 'Offline',
    allowNull: false,
  },
  zip_code: {
    type: DataTypes.STRING(10),
    allowNull: true,
  },
  employment_status: {
    type: DataTypes.ENUM('Business', 'Individual'),
    allowNull: false,
  },
  SSN: {
    type: DataTypes.STRING,
    unique: true,
    allowNull: true,
  },
  EIN: {
    type: DataTypes.STRING,
    unique: true,
    allowNull: true,
  },
  unit_number: { 
    type: DataTypes.STRING(4)
  },
  individual_name: {   // Added field
    type: DataTypes.STRING,
    allowNull: true,
  },
  individual_address: {   // Added field
    type: DataTypes.STRING,
    allowNull: true,
  },
  company_name: {   // Added field
    type: DataTypes.STRING,
    allowNull: true,
  },
  company_address: {   // Added field
    type: DataTypes.STRING,
    allowNull: true,
  }
}, {
  timestamps: true,
});


module.exports = DriverProfile;
