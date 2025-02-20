import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { Link } from 'react-router-dom';
import zipcodes from 'zipcodes';
import { FaDownload, FaUpload } from 'react-icons/fa'; // Import icons for Backup & Restore
import * as XLSX from "xlsx";

const Dashboard = () => {
  const { user, logout } = useAuth();
  const [drivers, setDrivers] = useState([]);
  const [totalPages, setTotalPages] = useState(1);
  const [searchParams, setSearchParams] = useState({ unitNumber: '', location: '', availability: '', vehicleType: '' });
  const [showAdvancedSearch, setShowAdvancedSearch] = useState(false);
  const [currentPage, setCurrentPage] = useState(1);
  const driversPerPage = 10;
  const [stats, setStats] = useState({
    totalDrivers: 0,
    availableDrivers: 0,
    onDutyDrivers: 0
  });
  const [isNearestSearch, setIsNearestSearch] = useState(false);
  const [backupMessage, setBackupMessage] = useState('');
  const [file, setFile] = useState(null);
  
  console.log("User data in Dashboard:", user);  // Debug: Check user data used in Dashboard
  
  const navigate = useNavigate();
  const [currentTime, setCurrentTime] = useState('');

  useEffect(() => {
    const updateTime = () => {
      const estTime = new Date().toLocaleTimeString('en-US', {
        timeZone: 'America/New_York',
        hour: '2-digit',
        minute: '2-digit',
        hour12: true
      });
      setCurrentTime(estTime);
    };

    updateTime();
    const interval = setInterval(updateTime, 60000);
    return () => clearInterval(interval);
  }, []);

  useEffect(() => {
    fetchLatestDrivers(1);
    fetchStats();
  }, []);  

  const fetchLatestDrivers = async (page = 1) => {
    try {
      const token = sessionStorage.getItem('authToken'); // ✅ Ensure token is retrieved correctly
      const response = await axios.get(`https://driver-management-backend-3chl.onrender.com/api/drivers/latest?page=${page}&limit=${driversPerPage}`, {
        headers: { Authorization: `Bearer ${token}` },
      });
      setDrivers(response.data.drivers);  // Make sure to set the drivers array
      setTotalPages(response.data.totalPages); // Set total pages for pagination
      setCurrentPage(page);  // ✅ Fix: Ensure UI updates to the selected page
    } catch (error) {
      console.error('Error fetching latest drivers:', error);
    }
  };
  
  const fetchStats = async () => {
    try {
      const token = sessionStorage.getItem('authToken'); // ✅ Ensure token is retrieved correctly
      const response = await axios.get('https://driver-management-backend-3chl.onrender.com/api/drivers/stats', {
        headers: { Authorization: `Bearer ${token}` },
      });
      setStats(response.data);
    } catch (error) {
      console.error('Error fetching stats:', error);
    }
  };

  const handleLogout = () => {
    logout();
    navigate('/login');
  };

  // Backup: Download driver data as JSON
  const handleDownloadBackup = async () => {
    try {
        const token = sessionStorage.getItem('authToken'); // ✅ Ensure token is retrieved correctly
        const response = await axios.get('https://driver-management-backend-3chl.onrender.com/api/backup/download', { // ✅ Ensure backend URL is correct
            headers: { Authorization: `Bearer ${token}` },
            responseType: 'blob',
        });

        const url = window.URL.createObjectURL(response.data);
        const link = document.createElement('a');
        link.href = url;
        link.setAttribute('download', 'driver_backup.json'); // ✅ Ensure correct file extension
        document.body.appendChild(link);
        link.click();

        setBackupMessage("Backup downloaded successfully!");
        setTimeout(() => setBackupMessage(""), 5000);
    } catch (error) {
        console.error("Error downloading backup:", error);
        setBackupMessage("Failed to download backup.");
        setTimeout(() => setBackupMessage(""), 5000);
    }
};

  // Restore: Upload JSON file
  const handleUploadBackup = async () => {
    if (!file) {
        setBackupMessage("Please select a JSON file to upload.");
        setTimeout(() => setBackupMessage(""), 5000);
        return;
    }

    const formData = new FormData();
    formData.append("backupFile", file);

    try {
        const token = sessionStorage.getItem('authToken'); // ✅ Ensure token is retrieved correctly
        await axios.post("https://driver-management-backend-3chl.onrender.com/api/backup/upload", formData, {
            headers: { Authorization: `Bearer ${token}`, "Content-Type": "multipart/form-data" },
        });

        setBackupMessage("Backup uploaded successfully! Refreshing data...");
        fetchLatestDrivers(1); // ✅ Reload data after restore
        setTimeout(() => setBackupMessage(""), 5000);
    } catch (error) {
        console.error("Error uploading backup:", error);
        setBackupMessage("Failed to upload backup.");
        setTimeout(() => setBackupMessage(""), 5000);
    }
};

// Download driver data Excel
const handleExportToExcel = async () => {
  try {
      const token = sessionStorage.getItem('authToken'); // ✅ Ensure token is retrieved correctly
      const response = await axios.get("https://driver-management-backend-3chl.onrender.com/api/backup/download", {
          headers: { Authorization: `Bearer ${token}` },
          responseType: "json",
      });

      if (!response.data || response.data.length === 0) {
          setBackupMessage("No data available for export.");
          setTimeout(() => setBackupMessage(""), 5000);
          return;
      }

      // ✅ Flatten vehicle data to make it appear as separate columns
      const formattedData = response.data.map(driver => ({
          ...driver, // ✅ Spread existing driver data
          vehicle_make: driver.vehicle?.make || '',
          vehicle_model: driver.vehicle?.model || '',
          vehicle_type: driver.vehicle?.type || '',
          trunk_width: driver.vehicle?.trunk_width || '',
          trunk_length: driver.vehicle?.trunk_length || '',
          trunk_height: driver.vehicle?.trunk_height || '',
          capacity_ton: driver.vehicle?.capacity_ton || '',
          capacity_m3: driver.vehicle?.capacity_m3 || '',
          license_plate: driver.vehicle?.license_plate || '',
          insurance_details: driver.vehicle?.insurance_details || '',
      }));

      // ✅ Convert to Excel format
      const workbook = XLSX.utils.book_new();
      const worksheet = XLSX.utils.json_to_sheet(formattedData);

      XLSX.utils.book_append_sheet(workbook, worksheet, "Drivers");
      XLSX.writeFile(workbook, "driver_data.xlsx");

      setBackupMessage("Data exported to Excel successfully!");
      setTimeout(() => setBackupMessage(""), 5000);
  } catch (error) {
      console.error("Error exporting to Excel:", error);
      setBackupMessage("Failed to export to Excel.");
      setTimeout(() => setBackupMessage(""), 5000);
  }
};

  const handleSearchChange = (e) => {
    const { name, value } = e.target;
    console.log(`Updating searchParams: ${name} = ${value}`);  // ✅ Debugging
    setSearchParams((prev) => ({
        ...prev,
        [name]: value.trim() !== "" ? value : "",
    }));
};

  const cancelSearch = () => {
    setSearchParams({ unitNumber: '', zipCode: '', state: '', availability: '', vehicleType: '', email: '', phone:'',})
    setShowAdvancedSearch(false);
    fetchLatestDrivers(1); // Reset to latest drivers
    setIsNearestSearch(false);
  };  

  const handleSearchSubmit = async (e) => {
    e.preventDefault();

    try {
        const token = sessionStorage.getItem('authToken'); // ✅ Ensure token is retrieved correctly
        let response;

        if (searchParams.zipCode?.trim()) {
            // ✅ Fix: Include `availability` when searching by ZIP Code
            response = await axios.get(`https://driver-management-backend-3chl.onrender.com/api/drivers/closest`, {
                headers: { Authorization: `Bearer ${token}` },
                params: {
                    zip_code: searchParams.zipCode,
                    availability: searchParams.availability || undefined, // ✅ Include availability filter
                    page: 1
                }
            });
            setIsNearestSearch(true);
        } else {
            response = await axios.get("https://driver-management-backend-3chl.onrender.com/api/drivers/search", {
                headers: { Authorization: `Bearer ${token}` },
                params: {
                    unit_number: searchParams.unitNumber || undefined,
                    zip_code: searchParams.zipCode || undefined,
                    state: searchParams.state || undefined,
                    availability: searchParams.availability || undefined,
                    vehicleType: searchParams.vehicleType || undefined,
                    email: searchParams.email?.trim() || undefined,
                    phone: searchParams.phone?.trim() || undefined,
                }
            });
            setIsNearestSearch(false);
        }

        // ✅ Fix: Ensure location & other data is correctly displayed
        const updatedDrivers = response.data.drivers.map(driver => ({
            ...driver,
            location: driver.zip_code 
                ? zipcodes.lookup(driver.zip_code)?.city + ", " + zipcodes.lookup(driver.zip_code)?.state 
                : "N/A"
        }));

        setDrivers(updatedDrivers);
        setTotalPages(response.data.totalPages || 2);
        setCurrentPage(1);

    } catch (error) {
        console.error("Error fetching drivers:", error);
    }
};

  const toggleAdvancedSearch = () => {
    setShowAdvancedSearch(!showAdvancedSearch);
  };

  const handleAddDriver = () => {
    navigate('/add-driver');
  };

  const paginate = async (pageNumber) => {
    setCurrentPage(pageNumber);

    try {
        const token = sessionStorage.getItem('authToken'); // ✅ Ensure token is retrieved correctly
      
        if (isNearestSearch) {
            const response = await axios.get(`https://driver-management-backend-3chl.onrender.com/api/drivers/closest`, {
                headers: { Authorization: `Bearer ${token}` },
                params: {
                    zip_code: searchParams.zipCode,
                    availability: searchParams.availability,
                    page: pageNumber
                }
            });
            setDrivers(response.data.drivers);
            setTotalPages(response.data.totalPages || 1);
        } else {
            // ✅ Fix: Ensure pagination works for default driver list
            fetchLatestDrivers(pageNumber);
        }
    } catch (error) {
        console.error("Error paginating search results:", error);
    }
};

  return (
    <div className="max-w-6xl mx-auto p-6 bg-background">
      <div className="mb-4 bg-primary text-white p-3 rounded-lg shadow-md">
        <div className="flex justify-between items-center">
          <h1 className="text-2xl font-bold">Driver Management System</h1> 
          <p className="text-m">Welcome, {user?.username}</p>
        </div>
      </div>

      {/* Button Panel with Time */}
      <div className="bg-background p-4 rounded-lg shadow-md mb-6 flex justify-between items-center">
            <div className="text-left">
              <p className="text-sm font-medium">Eastern Standard Time (EST)</p>
              <p className="text-lg font-bold text-black">{currentTime}</p>
            </div>
            <div className="flex space-x-4">
              {(user?.role === 'admin' || user?.role === 'recruiter') && (
                <button 
                  onClick={handleAddDriver} 
                  className="bg-primary text-white py-2 px-4 rounded hover:bg-secondary">
                  Add Driver
                </button>
              )}

              {user?.role === 'admin' && (
                <Link 
                  to="/user-management" 
                  className="bg-primary text-white py-2 px-4 rounded hover:bg-secondary">
                  Manage Users
                </Link>
              )}

              <button 
                onClick={() => navigate('/update-status')}
                className="bg-primary text-white py-2 px-4 rounded hover:bg-secondary">
                Update Driver Status
              </button>

              <button 
                onClick={handleLogout} 
                className="bg-danger text-white py-2 px-4 rounded hover:bg-primary">
                Logout
              </button>

            </div>
          </div>

          {/* DataManagement Panel */}
          {user?.role === 'admin' && (
            <div className="bg-white p-4 rounded-lg shadow-md mb-6 flex justify-between items-center">
                <h2 className="text-lg font-semibold">Data Management</h2>
                  <p className="text-gray-700 ml-4 min-w-[200px] text-sm">
                    {backupMessage}
                  </p>            
                <div className="flex items-center space-x-4">
                    <button onClick={handleExportToExcel} className="bg-primary text-white p-2 rounded flex items-center hover:bg-secondary">
                        Export to Excel
                    </button>
                    <button 
                        onClick={handleDownloadBackup} 
                        className="bg-primary text-white p-2 rounded flex items-center hover:bg-secondary">
                        <FaDownload className="mr-2" /> Backup
                    </button>
                    <label className="cursor-pointer bg-secondary text-white p-2 rounded flex items-center hover:bg-primary">
                        <FaUpload className="mr-2" /> Restore
                        <input type="file" className="hidden" onChange={(e) => setFile(e.target.files[0])} />
                    </label>
                    <button 
                        onClick={handleUploadBackup} 
                        className="bg-primary text-white p-2 rounded hover:bg-secondary">
                        Upload
                    </button>
                </div>
            </div>
        )}          

      {/* Search Panel */}
      <div className="bg-background p-4 rounded-lg shadow-md mb-6">
        <h2 className="text-xl font-bold mb-4">Search Drivers</h2>
        <form onSubmit={handleSearchSubmit} className="space-y-4">
          <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
            <div>
              <label className="block font-medium">Unit Number</label>
              <input type="text" name="unitNumber" value={searchParams.unitNumber} onChange={handleSearchChange} className="w-full p-2 border rounded" placeholder="Enter Unit Number" />
            </div>
            <div>
              <label className="block font-medium">Zip Code</label>
              <input type="text" name="zipCode" value={searchParams.zipCode} onChange={handleSearchChange} className="w-full p-2 border rounded" placeholder="Enter ZIP Code" />
            </div>
            <div>
              <label className="block font-medium">Location (State)</label>
              <input type="text" name="state" value={searchParams.state} onChange={handleSearchChange} className="w-full p-2 border rounded" placeholder="Enter State" />
            </div>
            <div>
              <label className="block font-medium">Availability Status</label>
              <select name="availability" value={searchParams.availability} onChange={handleSearchChange} className="w-full p-2 border rounded">
                <option value="">Select Status</option>
                <option value="Available">Available</option>
                <option value="On-Duty">On-Duty</option>
                <option value="Offline">Offline</option>
              </select>
            </div>
          </div>

          {/* Toggle Advanced Search Fields */}
          <button type="button" onClick={toggleAdvancedSearch} className="text-blue-500 underline">
            {showAdvancedSearch ? 'Hide Advanced Search' : 'Show Advanced Search'}
          </button>

          {showAdvancedSearch && (
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mt-4">
              <div>
                <label className="block font-medium">Vehicle Type</label>
                <input type="text" name="vehicleType" value={searchParams.vehicleType} onChange={handleSearchChange} className="w-full p-2 border rounded" placeholder="Enter Vehicle Type" />
              </div>
              <div>
                <label className="block font-medium">Email</label>
                <input type="email" name="email" value={searchParams.email} onChange={handleSearchChange} className="w-full p-2 border rounded" placeholder="Enter Email" />
              </div>
              <div>
                <label className="block font-medium">Phone Number</label>
                <input type="text" name="phone" value={searchParams.phone} onChange={handleSearchChange} className="w-full p-2 border rounded" placeholder="Enter Phone Number" />
              </div>
            </div>
          )}
          {/* ✅ Buttons - Full Width with Space Between */}
          <div className="flex gap-4 mt-4 w-full">
          <button 
            type="submit" 
            className="bg-primary text-white py-2 px-6 rounded hover:bg-secondary flex-1">
            Search
          </button>

          <button 
            type="button" 
            onClick={cancelSearch} 
            className="bg-secondary text-white py-2 px-6 rounded hover:bg-primary flex-1">
            Reset Search
          </button>


          </div>
        </form>
      </div>

      {/* Stats Box */}
      <div className="bg-background p-3 rounded-lg shadow-md mb-6 grid grid-cols-1 md:grid-cols-3 gap-4 text-center">
        <div>
          <h3 className="text-base font-medium">Total Drivers</h3>
          <p className="text-lg text-black">{stats.totalDrivers}</p>
        </div>
        <div>
          <h3 className="text-base font-medium">Available Drivers</h3>
          <p className="text-lg text-black">{stats.availableDrivers}</p>
        </div>
        <div>
          <h3 className="text-base font-medium">On-Duty Drivers</h3>
          <p className="text-lg text-black">{stats.onDutyDrivers}</p>
        </div>
      </div>

      {/* Driver List Container */}
      <div className="bg-background p-4 rounded-lg shadow-md w-full">
          <h2 className="text-xl font-bold mb-4">Driver List</h2>

          {/* ✅ Header Row (Now Full Width) */}
          <div className={`grid ${isNearestSearch ? 'grid-cols-[5%_18.5%_10%_15%_10%_12%_7%_12%]' : 'grid-cols-[7%_22%_12%_17%_10%_11%_11%]'} gap-x-4 font-bold border-b pb-2 w-full`}>
              <span className="text-left">Unit#</span>  
              <span className="text-left">Name</span>  
              <span className="text-left">Vehicle Type</span>
              <span className="text-left">Location</span>
              <span className="text-left">Availability</span>
              <span className="text-left">Phone</span>
              {isNearestSearch && <span className="text-left">Distance</span>}
              <span className="text-center">Actions</span>
          </div>

          {/* Driver Rows */}
          {drivers.length > 0 ? (
              drivers.map(driver => (
                <div key={driver.id} className={`grid ${isNearestSearch ? 'grid-cols-[5%_18.5%_10%_15%_10%_12%_7%_12%]' : 'grid-cols-[7%_22%_12%_17%_10%_11%_11%]'} gap-x-4 items-center border-b py-2 w-full`}>
                    <span>#{driver.unit_number || 'N/A'}</span>
                    <span>{driver.name || 'N/A'}</span>
                    <span>{driver.vehicle?.type || 'N/A'}</span>
                    <span>{driver.location || 'N/A'}</span>
                    <span>{driver.availability || 'N/A'}</span>
                    <span>{driver.phone_number || 'N/A'}</span>
                    {isNearestSearch && <span>{driver.distance || 'N/A'}</span>}
                    <span className="flex justify-center">
                    <button 
                      onClick={() => navigate(`/driver-profile/${driver.id}`)}
                      className="py-1 px-4 rounded bg-primary text-white hover:bg-secondary">
                      View Profile
                    </button>
                    </span>
                </div>
            ))
          ) : (
              <div className="text-center py-4 text-red-500 font-bold">
                  No drivers found.
              </div>
          )}

          {/* Pagination Controls */}
          {totalPages > 1 && (
              <div className="flex justify-center mt-4">
                  {[...Array(totalPages).keys()].map(number => (
                    <button 
                      key={number} 
                      onClick={() => paginate(number + 1)} 
                      className={`mx-1 px-3 py-1 rounded ${currentPage === number + 1 ? 'bg-primary text-white' : 'bg-accent hover:bg-secondary'}`}>
                      {number + 1}
                    </button>
                  ))}
              </div>
          )}
      </div>
    </div>
  );
};

export default Dashboard;
