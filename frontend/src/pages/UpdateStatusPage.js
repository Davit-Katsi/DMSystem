import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { useAuth } from '../context/AuthContext';
import InputMask from 'react-input-mask';
import { useNavigate } from 'react-router-dom';
import zipcodes from 'zipcodes';

const UpdateStatusPage = () => {
  useAuth();
  const [drivers, setDrivers] = useState([]);
  const [filteredDrivers, setFilteredDrivers] = useState([]);
  const [selectedAvailability, setSelectedAvailability] = useState('');
  const [selectedDate, setSelectedDate] = useState('');
  const navigate = useNavigate();
  const [submittedDrivers, setSubmittedDrivers] = useState({});
  const [successMessage, setSuccessMessage] = useState({});
  const [loading, setLoading] = useState(true);
  const [currentPage, setCurrentPage] = useState(1);
  const driversPerPage = 20
  const totalPages = Math.ceil(filteredDrivers.length / driversPerPage);
  
  // Fetch drivers when the page loads
  useEffect(() => {
    fetchDrivers();
  }, []);

  const fetchDrivers = async () => {
    setLoading(true); // ✅ Start loading
    try {
        const token = localStorage.getItem('token');
        const response = await axios.get('http://localhost:5000/api/drivers/all', {
            headers: { Authorization: `Bearer ${token}` },
        });
        setDrivers(response.data.drivers);
        setFilteredDrivers(response.data.drivers);
    } catch (error) {
        console.error('Error fetching drivers:', error);
    }
    setLoading(false); // ✅ Data is now loaded
};

  const handleStatusChange = (driverId, field, value) => {
    setDrivers(prevDrivers =>
        prevDrivers.map(driver =>
            driver.id === driverId ? { ...driver, [field]: value } : driver
        )
    );

    setFilteredDrivers(prevFilteredDrivers =>
        prevFilteredDrivers.map(driver =>
            driver.id === driverId ? { ...driver, [field]: value } : driver
        )
    );
};
  
const saveDriverUpdate = async (driverId) => {
  const driver = drivers.find(driver => driver.id === driverId);
  if (!driver) return;

  console.log(`Attempting update for Driver ID: ${driverId}`);
  console.log(`Current ZIP Code: ${driver.zip_code}`);

  // ✅ Mark this driver as submitted before checking ZIP validity
  setSubmittedDrivers(prev => ({ ...prev, [driverId]: true }));

  // ✅ Lookup ZIP info only when Submit is clicked
  const zipInfo = zipcodes.lookup(driver.zip_code);
  const updatedLocation = zipInfo ? `${zipInfo.city}, ${zipInfo.state}` : 'Invalid ZIP Code';

  console.log(`ZIP Lookup Result: ${updatedLocation}`);

  // ✅ Prevent update if ZIP is invalid
  if (updatedLocation === 'Invalid ZIP Code') {
      console.log(`🚨 Update blocked for Driver ID: ${driverId} due to invalid ZIP!`);
      setSuccessMessage(prev => ({ ...prev, [driverId]: 'Invalid ZIP Code' }));
      return;
  }

  const updatedData = {
      availability: driver.availability,
      zip_code: driver.zip_code,
      location: updatedLocation // ✅ Update location only now!
  };

  try {
      const token = localStorage.getItem('token');
      const response = await axios.put(`http://localhost:5000/api/drivers/${driverId}`, updatedData, {
          headers: { Authorization: `Bearer ${token}` },
      });

      if (response.status === 200) {
          console.log(`✅ Update successful for Driver ID: ${driverId}`);
          setSuccessMessage(prev => ({ ...prev, [driverId]: 'Updated Successfully!' }));

          setTimeout(() => {
              setSuccessMessage(prev => ({ ...prev, [driverId]: '' }));
          }, 2000);

          fetchDrivers();  // ✅ Refresh driver list after update
      }
  } catch (error) {
      console.error('❌ Error saving driver updates:', error);
  }
};
 
  const formatLastUpdated = (updatedAt) => {
    const updatedDate = new Date(updatedAt);
    const today = new Date();
    const yesterday = new Date(today);
    yesterday.setDate(today.getDate() - 1);
  
    const isToday = updatedDate.toDateString() === today.toDateString();
    const isYesterday = updatedDate.toDateString() === yesterday.toDateString();
  
    if (isToday) return 'Today';
    if (isYesterday) return 'Yesterday';
  
    return updatedDate.toLocaleDateString();  // Show date if older
  };  

  // ✅ Function to filter drivers based on selected criteria
  const filterDrivers = () => {
    console.log("Filter function triggered!");
    console.log("Selected Date:", selectedDate);
    
    let filtered = [...drivers];

    if (selectedAvailability) {
        filtered = filtered.filter(driver => driver.availability === selectedAvailability);
    }

    if (selectedDate) {
        const today = new Date();
        const yesterday = new Date();
        yesterday.setDate(today.getDate() - 1);

        filtered = filtered.filter(driver => {
            const driverDate = new Date(driver.updatedAt);
            const driverDateLocal = new Date(driverDate.getTime() - driverDate.getTimezoneOffset() * 60000);
            const formattedDriverDate = driverDateLocal.toISOString().split('T')[0]; // ✅ Convert to YYYY-MM-DD

            console.log(`Checking driver date: ${formattedDriverDate} against selected date: ${selectedDate}`);

            if (selectedDate === "Today") {
                return driverDate.toDateString() === today.toDateString();
            } else if (selectedDate === "Yesterday") {
                return driverDate.toDateString() === yesterday.toDateString();
            } else {
                return formattedDriverDate === selectedDate; // ✅ Correct comparison
            }
        });
    }

    console.log("Filtered Drivers:", filtered);
    setFilteredDrivers(filtered);
};

const resetFilters = () => {
  console.log("Resetting filters...");

  setSelectedAvailability("");
  setSelectedDate("");
  setFilteredDrivers(drivers); // ✅ Restore full list
};

return (
  <div className="max-w-6xl mx-auto p-6 bg-background shadow-lg rounded-lg">
    <div className="flex justify-between items-center mb-6">
      <h2 className="text-2xl font-bold">Update Driver Availability & Location</h2>
      <button 
        onClick={() => navigate('/')} 
        className="bg-primary text-white py-2 px-4 rounded hover:bg-secondary"
      >
        Return to Dashboard
      </button>
    </div>

    {/* ✅ Filter Panel - Fields & Buttons Aligned at Bottom */}
    <div className="flex flex-wrap justify-center items-end gap-4 mb-6 p-4 bg-accent rounded-lg">
      
      {/* Availability Filter */}
      <div className="flex flex-col">
        <label className="block text-sm font-medium mb-1 text-center">Availability:</label>
        <select
          value={selectedAvailability}
          onChange={(e) => setSelectedAvailability(e.target.value)}
          className="w-48 p-2 border rounded h-10"
        >
          <option value="">All</option>
          <option value="Available">Available</option>
          <option value="On-Duty">On-Duty</option>
          <option value="Offline">Offline</option>
        </select>
      </div>

      {/* Last Updated Filter */}
      <div className="flex flex-col">
        <label className="block text-sm font-medium mb-1 text-center">Last Updated:</label>
        <select
          value={selectedDate}
          onChange={(e) => setSelectedDate(e.target.value)}
          className="w-48 p-2 border rounded h-10"
        >
          <option value="">All</option>
          <option value="Today">Today</option>
          <option value="Yesterday">Yesterday</option>
        </select>
      </div>

      {/* Pick a Date Filter */}
      <div className="flex flex-col">
        <label className="block text-sm font-medium mb-1 text-center">Pick a Date:</label>
        <input
          type="date"
          value={selectedDate}
          className="w-48 p-2 border rounded h-10"
          onChange={(e) => setSelectedDate(e.target.value)}
        />
      </div>

      {/* Buttons - Aligned with Fields */}
      <div className="flex gap-4">
      <button
        onClick={filterDrivers}
        className="bg-primary text-white py-2 px-4 rounded hover:bg-secondary h-10 flex items-center"
      >
        Apply Filters
      </button>

      <button
        onClick={resetFilters}
        className="bg-secondary text-white py-2 px-4 rounded hover:bg-primary h-10 flex items-center"
      >
        Reset Filters
      </button>
      </div>
    </div>

    {/* ✅ Show "No drivers found" only when loading is false */}
    {!loading && filteredDrivers.length === 0 && (
        <div className="text-center py-4 text-red-500 font-bold">
            No drivers found matching the selected filters.
        </div>
    )}

    {/* ✅ Driver List (Filters do not affect updating) */}
    {(filteredDrivers.length > 0 ? filteredDrivers : drivers)
      .slice((currentPage - 1) * driversPerPage, currentPage * driversPerPage)
      .map(driver => (
      <div key={driver.id} className="grid grid-cols-6 gap-4 mb-4 p-4 border rounded-lg shadow-sm items-end bg-background">

        {/* Unit Number & Name */}
        <div className="flex flex-col justify-center">
          <strong>#{driver.unit_number || 'N/A'}</strong>
          <span>{driver.name}</span>
          <span className="text-sm text-gray-600">Phone: {driver.phone_number}</span>
        </div>

        {/* Availability Selection */}
        <div>
          <label className="block text-sm font-medium mb-1">Availability:</label>
          <select
            value={drivers.find(d => d.id === driver.id)?.availability || ''}
            onChange={(e) => handleStatusChange(driver.id, 'availability', e.target.value)}
            className="w-full p-2 border rounded h-10"
          >
            <option value="Available">Available</option>
            <option value="On-Duty">On-Duty</option>
            <option value="Offline">Offline</option>
          </select>
        </div>

        {/* ZIP Code Input */}
        <div>
          <label className="block text-sm font-medium mb-1">ZIP Code:</label>
          <InputMask
            mask="99999"
            value={drivers.find(d => d.id === driver.id)?.zip_code || ''}
            onChange={(e) => handleStatusChange(driver.id, 'zip_code', e.target.value)}
          >
            {(inputProps) => (
              <input
                {...inputProps}
                type="text"
                className="w-full p-2 border rounded h-10 align-middle"
              />
            )}
          </InputMask>
        </div>
        
        {/* Last Updated */}
        <div className="flex flex-col justify-center">
        <label className="block text-sm font-medium text-gray-700">Last Updated:</label>
          <p className="h-10 flex items-center">{formatLastUpdated(driver.updatedAt)}</p>
        </div>
        
        <div className="flex flex-col justify-end w-full">
        <button
          onClick={() => saveDriverUpdate(driver.id)}
          className="bg-primary text-white py-2 px-4 rounded hover:bg-secondary h-10 w-full"
        >
          Submit
        </button>
        </div>

        <div className="flex flex-col justify-end w-full">
          <label className="block text-sm font-medium text-gray-700 text-center">Message:</label>
          <div className="w-full p-2 border rounded h-10 flex items-center justify-center bg-accent text-primary">
            {submittedDrivers[driver.id] && successMessage[driver.id] ? (
              <p className={successMessage[driver.id].includes("Invalid ZIP") ? "text-danger text-sm" : "text-primary text-sm"}>
                {successMessage[driver.id]}
              </p>
            ) : (
              <p className="text-gray-500 text-sm">No issues</p>
            )}
          </div>
        </div>
      </div>
    ))}
    {/* Pagination Controls */}
    {totalPages > 1 && (
      <div className="flex justify-center mt-4">
        {[...Array(totalPages).keys()].map(number => (
          <button 
            key={number} 
            onClick={() => setCurrentPage(number + 1)} 
            className={`mx-1 px-3 py-1 rounded ${currentPage === number + 1 ? 'bg-primary text-white' : 'bg-accent hover:bg-secondary'}`}>
            {number + 1}
          </button>
        ))}
      </div>
    )}
  </div>
);
  
};

export default UpdateStatusPage;