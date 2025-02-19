const { Op } = require('sequelize');
const DriverProfile = require('../models/driverProfile');
const Vehicle = require('../models/vehicle');
const zipcodes = require('zipcodes');
const axios = require('axios');
const fs = require('fs');

// Find the 10 closest drivers to a given zip code (mock implementation)
exports.getLatestDrivers = async (req, res) => {
  const page = parseInt(req.query.page) || 1;
  const limit = parseInt(req.query.limit) || 20;  // Ensure consistent pagination limit
  const offset = (page - 1) * limit;
  const { date, sortBy } = req.query; // ✅ Get `sortBy` parameter
  
  try {

    const whereClause = {}; // ✅ Start with an empty WHERE clause

    // ✅ Apply date filtering if a date is provided
    if (date) {
      const startDate = new Date(date);
      startDate.setUTCHours(0, 0, 0, 0);
      const endDate = new Date(date);
      endDate.setUTCHours(23, 59, 59, 999);

      whereClause.updatedAt = { [Op.between]: [startDate, endDate] };
    }

    // ✅ Set sorting order based on query param
    const orderBy = sortBy === "updatedAt" ? [['updatedAt', 'DESC']] : [['createdAt', 'DESC']];

    const drivers = await DriverProfile.findAndCountAll({
      attributes: ['id', 'name', 'phone_number', 'unit_number', 'availability', 'zip_code', 'updatedAt'],
      include: [{
        model: Vehicle,
        as: 'vehicle',
        attributes: ['type'],
      }],
      where: whereClause, // ✅ Apply date filter dynamically
      order: orderBy, // ✅ Apply sorting dynamically
      limit: limit,
      offset: offset
    });

    // Convert ZIP codes to city and state
    const driversWithLocation = drivers.rows.map(driver => {
      const locationData = driver.zip_code ? zipcodes.lookup(driver.zip_code) : null;
      return {
        ...driver.toJSON(),
        location: locationData 
          ? `${locationData.city}, ${locationData.state}` 
          : 'Invalid ZIP Code'
      };
    });

    // ✅ Ensure total pages are calculated correctly
    res.status(200).json({
      drivers: driversWithLocation,
      totalDrivers: drivers.count,
      totalPages: Math.ceil(drivers.count / limit),
      currentPage: page
    });

  } catch (error) {
    console.error('Error fetching latest drivers:', error);
    res.status(500).json({ error: 'Failed to fetch drivers' });
  }
};

exports.getAllDrivers = async (req, res) => {
  try {

      const drivers = await DriverProfile.findAll({
          attributes: ['id', 'name', 'phone_number', 'unit_number', 'availability', 'zip_code', 'updatedAt'],
          include: [{
              model: Vehicle,
              as: 'vehicle',
              attributes: ['type'],
          }],
          order: [['createdAt', 'DESC']]
      });

      if (drivers.length === 0) {
          return res.status(404).json({ message: "No drivers found." });
      }

      res.status(200).json({ drivers });

  } catch (error) {
      console.error('❌ Error fetching all drivers:', error);
      res.status(500).json({ error: 'Failed to fetch all drivers' });
  }
};

// Search drivers based on query parameters
exports.searchDrivers = async (req, res) => {
  try {
    const { zip_code, state, availability, vehicleType, email, phone, unit_number } = req.query;

      const searchCriteria = { where: {}, include: [] };

      if (zip_code?.trim()) {
          searchCriteria.where.zip_code = { [Op.iLike]: `%${zip_code}%` };
      }

      if (unit_number?.trim()) {
        searchCriteria.where.unit_number = unit_number; // Ensure exact match for unit number
      }
    
      if (state?.trim()) {
          const zipCodesInState = zipcodes.lookupByState(state).map(z => z.zip);
          searchCriteria.where.zip_code = { [Op.in]: zipCodesInState };
      }

      if (availability?.trim()) {
          searchCriteria.where.availability = availability;
      }

      if (email?.trim()) {
          searchCriteria.where.email = { [Op.iLike]: `%${email}%` };
      }

      if (phone?.trim()) {
          searchCriteria.where.phone_number = { [Op.iLike]: `%${phone}%` };
      }

      if (vehicleType?.trim()) {
          searchCriteria.include.push({
              model: Vehicle,
              as: 'vehicle',
              where: { type: { [Op.iLike]: `%${vehicleType}%` } },
              required: true // ✅ Ensures only drivers with matching vehicle type are returned
          });
      } else {
          searchCriteria.include.push({
              model: Vehicle,
              as: 'vehicle'
          });
      }

      const drivers = await DriverProfile.findAll(searchCriteria);
      return res.status(200).json({ drivers });

  } catch (error) {
      console.error('Error searching drivers:', error);
      return res.status(500).json({ error: 'Failed to search drivers' });
  }
};

// Mock implementation for finding closest drivers
exports.getClosestDrivers = async (req, res) => {
    const { zip_code, availability, page = 1, limit = 10 } = req.query;

    if (!zip_code) {
        return res.status(400).json({ error: "ZIP code is required" });
    }

    console.log("🔍 Searching for nearest drivers from ZIP:", zip_code);

    try {
        const whereClause = { zip_code: { [Op.ne]: null } };

        if (availability?.trim()) {
            whereClause.availability = availability;  // ✅ Filter by availability if provided
        }

        const offset = (page - 1) * limit;

        const drivers = await DriverProfile.findAll({
            attributes: ['id', 'name', 'phone_number', 'unit_number', 'zip_code', 'availability'],
            where: whereClause,
            limit: parseInt(limit),
            offset: parseInt(offset),
            include: [{ model: Vehicle, as: 'vehicle', attributes: ['type'] }]  // ✅ Ensure Vehicle Type is always included
        });

        console.log("📌 Found Drivers:", drivers.map(d => ({ id: d.id, zip: d.zip_code })));

        if (drivers.length === 0) {
            return res.status(404).json({ error: "No drivers with valid ZIP codes found." });
        }

        // ✅ Validate Google Maps API Key
        if (!process.env.GOOGLE_MAPS_API_KEY) {
            return res.status(500).json({ error: "Google Maps API Key is missing!" });
        }

        // ✅ Prepare Google Maps API Request
        const driverZipCodes = drivers.map(driver => driver.zip_code).join('|');
        const googleApiUrl = `https://maps.googleapis.com/maps/api/distancematrix/json?origins=${zip_code}&destinations=${driverZipCodes}&key=${process.env.GOOGLE_MAPS_API_KEY}`;

        console.log("🔗 Google Maps API Request:", googleApiUrl);

        // ✅ Fetch Distance Data
        const response = await axios.get(googleApiUrl);

        if (!response.data.rows || !response.data.rows[0]) {
            console.error("❌ Google API Error:", response.data);
            return res.status(500).json({ error: "Google API did not return valid data." });
        }

        // ✅ Process Distance Data
        const distanceData = response.data.rows[0].elements;

        const driversWithDistance = drivers.map((driver, index) => {
            const rawDistance = distanceData[index]?.status === "OK" ? distanceData[index].distance.text : "N/A";
            let distanceInMiles = rawDistance.includes("km")
                ? (parseFloat(rawDistance.replace(/[^0-9.]/g, '')) * 0.621371).toFixed(1) + " mi"
                : rawDistance;

            return {
                ...driver.toJSON(),
                distance: distanceInMiles
            };
        });

        // ✅ Sort Drivers by Distance
        const sortedDrivers = driversWithDistance.sort((a, b) => {
            const distanceA = parseFloat(a.distance.replace(/[^0-9.]/g, '')) || Infinity;
            const distanceB = parseFloat(b.distance.replace(/[^0-9.]/g, '')) || Infinity;
            return distanceA - distanceB;
        });

        res.status(200).json({
            drivers: sortedDrivers.slice(0, limit),
            totalDrivers: drivers.length,
            totalPages: Math.ceil(drivers.length / limit),
            currentPage: parseInt(page)
        });

    } catch (error) {
        console.error("❌ Error fetching nearest drivers:", error);
        res.status(500).json({ error: "Failed to fetch nearest drivers" });
    }
};


exports.deleteDriver = async (req, res) => {
  const driverId = req.params.id;

  try {
    const driver = await DriverProfile.findByPk(driverId);
    if (!driver) {
      return res.status(404).json({ error: 'Driver not found' });
    }

    await driver.destroy();  // Delete the driver
    res.status(200).json({ message: 'Driver deleted successfully.' });
  } catch (error) {
    console.error('Error deleting driver:', error);
    res.status(500).json({ error: 'Failed to delete driver' });
  }
};

exports.getDriverById = async (req, res) => {
  try {
    const driverId = parseInt(req.params.id, 10);
    if (isNaN(driverId)) {
      return res.status(400).json({ error: "Invalid driver ID" });
    }

    const driver = await DriverProfile.findByPk(driverId, {
      include: [{
        model: Vehicle,
        as: 'vehicle',
        attributes: ['make', 'model', 'type', 'license_plate', 'insurance_details', 'trunk_width', 'trunk_length', 'trunk_height', 'capacity_ton', 'capacity_m3']
      }]
    });

    if (!driver) {
      return res.status(404).json({ error: 'Driver not found' });
    }

    res.status(200).json(driver);
  } catch (error) {
    console.error('Error fetching driver:', error);
    res.status(500).json({ error: 'Failed to fetch driver' });
  }
};

exports.getDriverStats = async (req, res) => {
  try {
    //console.log("Fetching driver stats...");

    // Fetch number of total, avaiable and on-duty of drivers
    const totalDrivers = await DriverProfile.count();
    const availableDrivers = await DriverProfile.count({ where: { availability: 'Available' } });
    const onDutyDrivers = await DriverProfile.count({ where: { availability: 'On-Duty' } });
    //console.log("Total Drivers Found:", totalDrivers);

    // Return response
    res.status(200).json({ totalDrivers, availableDrivers, onDutyDrivers });
  } catch (error) {
    console.error("Error fetching driver stats:", error);
    res.status(500).json({ error: "Failed to fetch driver stats" });
  }
};


exports.updateDriver = async (req, res) => {
  const driverId = parseInt(req.params.id, 10); // Ensure ID is an integer
  if (isNaN(driverId)) {
    return res.status(400).json({ error: "Invalid driver ID" });
  }

  const {
    name, phone_number, email, address, license_number, license_expiration,
    employment_status, SSN, EIN, unit_number,
    individual_name, individual_address, company_name, company_address,
    availability, zip_code,
    vehicle
  } = req.body;

  try {
    const driver = await DriverProfile.findByPk(driverId);
    if (!driver) {
      return res.status(404).json({ error: 'Driver not found' });
    }

    // Update driver profile
    await driver.update({
      name, phone_number, email, address, license_number, license_expiration,
      employment_status, SSN, EIN, unit_number,
      individual_name, individual_address, company_name, company_address, availability, zip_code
    });

    // Update vehicle info if it exists
    if (vehicle) {
      const driverVehicle = await Vehicle.findOne({ where: { driverProfileId: driverId } });
      if (driverVehicle) {
        await driverVehicle.update({
          make: vehicle.make,
          model: vehicle.model,
          type: vehicle.type,
          license_plate: vehicle.license_plate,
          insurance_details: vehicle.insurance_details,
          trunk_width: vehicle.trunk_width,
          trunk_length: vehicle.trunk_length,
          trunk_height: vehicle.trunk_height,
          capacity_ton: vehicle.capacity_ton,
          capacity_m3: vehicle.capacity_m3
        });
      } else {
        await Vehicle.create({ 
          ...vehicle, 
          driverProfileId: driverId 
        });
      }
    }

    res.status(200).json({ message: 'Driver updated successfully.' });
  } catch (error) {
    console.error('Error updating driver:', error);
    res.status(500).json({ error: 'Failed to update driver' });
  }
};

//Download Backup
exports.downloadBackup = async (req, res) => {
  try {
      if (req.user.role !== 'admin') {
          return res.status(403).json({ error: "Access denied: insufficient permissions" });
      }

      const drivers = await DriverProfile.findAll({
          include: [{ model: Vehicle, as: 'vehicle' }]
      });

      if (!drivers || drivers.length === 0) {
          return res.status(404).json({ error: "No driver data available for backup." });
      }

      // ✅ Convert database data to JSON format
      const jsonData = JSON.stringify(drivers, null, 2); // Pretty print JSON

      res.setHeader('Content-Type', 'application/json'); // ✅ Correct MIME type
      res.setHeader('Content-Disposition', 'attachment; filename=driver_backup.json'); // ✅ Change file extension to .json
      res.send(jsonData); // ✅ Send JSON directly

  } catch (error) {
      console.error("❌ Error downloading backup:", error);
      res.status(500).json({ error: "Failed to download backup." });
  }
};

//Upload Backup
exports.uploadBackup = async (req, res) => {
  if (!req.file) {
      return res.status(400).json({ error: "No file uploaded" });
  }

  const filePath = req.file.path;
  console.log("📌 Processing uploaded file:", filePath);

  try {
      // ✅ Read JSON file and parse it
      const jsonData = JSON.parse(fs.readFileSync(filePath, 'utf8'));

      for (const driver of jsonData) {
          console.log("📌 Processing driver:", driver);

          // ✅ Check if driver already exists by unit_number
          let existingDriver = await DriverProfile.findOne({ where: { unit_number: driver.unit_number } });

          if (existingDriver) {
              console.log("⚠️ Driver already exists, updating:", driver.unit_number);
              await existingDriver.update(driver);
          } else {
              existingDriver = await DriverProfile.create(driver);
              console.log("✅ Driver inserted:", existingDriver.id);
          }

          // ✅ Insert or update Vehicle data if it exists
          if (driver.vehicle) {
              let existingVehicle = await Vehicle.findOne({ where: { driverProfileId: existingDriver.id } });

              if (existingVehicle) {
                  console.log("⚠️ Vehicle already exists, updating for driver:", existingDriver.id);
                  await existingVehicle.update(driver.vehicle);
              } else {
                  await Vehicle.create({
                      driverProfileId: existingDriver.id, // ✅ Associate with the driver
                      ...driver.vehicle
                  });
                  console.log("✅ Vehicle inserted for driver:", existingDriver.id);
              }
          }
      }

      fs.unlinkSync(filePath); // ✅ Delete uploaded file after processing
      res.status(200).json({ message: "Backup successfully restored." });

  } catch (error) {
      console.error("❌ Error restoring backup:", error);
      res.status(500).json({ error: "Failed to restore backup." });
  }
};
