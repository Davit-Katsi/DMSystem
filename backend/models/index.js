const sequelize = require('./db');
const User = require('./user');
const DriverProfile = require('./driverProfile');
const Vehicle = require('./vehicle');

// Centralized association to prevent circular dependency
DriverProfile.hasOne(Vehicle, { foreignKey: 'driverProfileId', as: 'vehicle', onDelete: 'CASCADE' });
Vehicle.belongsTo(DriverProfile, { foreignKey: 'driverProfileId', as: 'driverProfile' });

// Sync models with database
sequelize.sync({ alter: true })
  .then(() => console.log('Database schema updated successfully.'))
  .catch(err => console.error('Error updating schema:', err));

module.exports = {
  sequelize,
  DriverProfile,
  Vehicle,
  User,
};
