const sequelize = require("./db");
const User = require("./user");
const DriverProfile = require("./driverProfile");
const Vehicle = require("./vehicle");

// 🚀 Define Associations HERE to avoid circular dependencies
DriverProfile.hasOne(Vehicle, { foreignKey: "driverProfileId", as: "vehicle", onDelete: "CASCADE" });
Vehicle.belongsTo(DriverProfile, { foreignKey: "driverProfileId", as: "driverProfile" });

sequelize.sync({ alter: true })
  .then(() => console.log("✅ Database schema updated successfully"))
  .catch(err => console.error("❌ Error updating schema:", err));

module.exports = {
  sequelize,
  DriverProfile,
  Vehicle,
  User
};
