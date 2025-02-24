const { DataTypes, Model } = require("sequelize");
const sequelize = require("./db"); // Correct Sequelize import

// Define DriverProfile Model FIRST
class DriverProfile extends Model {}

DriverProfile.init({
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    name: { type: DataTypes.STRING, allowNull: false },
    phone_number: { type: DataTypes.STRING, allowNull: false },
    email: { type: DataTypes.STRING, validate: { isEmail: true } },
    address: { type: DataTypes.TEXT },
    license_number: { type: DataTypes.STRING, allowNull: false },
    license_expiration: { type: DataTypes.DATE, allowNull: false },
    availability: { type: DataTypes.ENUM("Available", "On-Duty", "Offline"), defaultValue: "Offline", allowNull: false },
    zip_code: { type: DataTypes.STRING(10), allowNull: true },
    employment_status: { type: DataTypes.ENUM("Business", "Individual"), allowNull: false },
    SSN: { type: DataTypes.STRING, unique: true, allowNull: true },
    EIN: { type: DataTypes.STRING, unique: true, allowNull: true },
    unit_number: { type: DataTypes.STRING(4) },
    individual_name: { type: DataTypes.STRING, allowNull: true },
    individual_address: { type: DataTypes.STRING, allowNull: true },
    company_name: { type: DataTypes.STRING, allowNull: true },
    company_address: { type: DataTypes.STRING, allowNull: true }
}, {
    sequelize,
    modelName: "DriverProfile",
    tableName: "DriverProfiles",
    timestamps: true
});

// Import Vehicle AFTER defining DriverProfile
const Vehicle = require("./vehicle");

// Define Association AFTER Model is Defined
DriverProfile.hasOne(Vehicle, { foreignKey: "driverProfileId", as: "vehicle" });

module.exports = DriverProfile;
