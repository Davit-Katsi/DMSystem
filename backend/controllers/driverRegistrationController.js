const DriverProfile = require('../models/driverProfile');
const Vehicle = require('../models/vehicle');

exports.registerDriver = async (req, res) => {
  try {
    const { employment_status, SSN, EIN } = req.body;

    // Ensure SSN is only inserted when employment_status is Individual
    const ssnValue = employment_status === 'Individual' ? SSN : null;

    // Ensure EIN is only inserted when employment_status is Business
    const einValue = employment_status === 'Business' ? EIN : null;

    // Check for duplicate SSN if Individual
    if (employment_status === 'Individual' && SSN) {
      const existingSSN = await DriverProfile.findOne({ where: { SSN } });
      if (existingSSN) {
        return res.status(400).json({ error: 'SSN already exists. Please enter a unique SSN.' });
      }
    }

    // Check for duplicate EIN if Business
    if (employment_status === 'Business' && EIN) {
      const existingEIN = await DriverProfile.findOne({ where: { EIN } });
      if (existingEIN) {
        return res.status(400).json({ error: 'EIN already exists. Please enter a unique EIN.' });
      }
    }

    // Create Driver Profile
    const newDriver = await DriverProfile.create({
      ...req.body,
      SSN: ssnValue,
      EIN: einValue
    });

    // Create Vehicle Information
    const newVehicle = await Vehicle.create({
      ...req.body.vehicle,
      driverProfileId: newDriver.id
    });

    res.status(201).json({ driver: newDriver, vehicle: newVehicle });
  } catch (error) {
    console.error('Error during registration:', error);
    res.status(400).json({ error: error.message });
  }
};