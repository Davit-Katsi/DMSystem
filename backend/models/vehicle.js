const { DataTypes, Model } = require("sequelize");
const sequelize = require("./db"); // Correct Sequelize import

// Define Vehicle Model FIRST
class Vehicle extends Model {}

Vehicle.init({
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    make: { type: DataTypes.STRING, allowNull: false },
    model: { type: DataTypes.STRING, allowNull: false },
    type: { type: DataTypes.STRING },
    trunk_width: { type: DataTypes.FLOAT },
    trunk_length: { type: DataTypes.FLOAT },
    trunk_height: { type: DataTypes.FLOAT },
    capacity_ton: { type: DataTypes.FLOAT },
    capacity_m3: { type: DataTypes.FLOAT },
    license_plate: { type: DataTypes.STRING, allowNull: false },
    insurance_details: { type: DataTypes.TEXT }
}, {
    sequelize,
    modelName: "Vehicle",
    tableName: "Vehicles",
    timestamps: true
});

// Import DriverProfile AFTER defining Vehicle
const DriverProfile = require("./driverProfile");

// Define Association AFTER Model is Defined
Vehicle.belongsTo(DriverProfile, { foreignKey: "driverProfileId", as: "driverProfile" });

module.exports = Vehicle;
