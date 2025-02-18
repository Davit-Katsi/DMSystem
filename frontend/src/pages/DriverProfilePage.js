import React, { useEffect, useState, useCallback } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import axios from 'axios';
import { useAuth } from '../context/AuthContext';

const DriverProfilePage = () => {
  const { id } = useParams();
  const { user } = useAuth();
  const navigate = useNavigate();

  const [driver, setDriver] = useState(null);

  const fetchDriverProfile = useCallback(async () => {
    try {
      const token = localStorage.getItem('token');
      const response = await axios.get(`http://localhost:5000/api/drivers/${id}`, {
        headers: { Authorization: `Bearer ${token}` },
      });

      console.log("Driver data:", response.data); // ✅ Debugging

      // Ensure it correctly sets the driver data
      if (response.data.driver) {
        setDriver(response.data.driver); // If API wraps the driver inside `driver`
      } else {
        setDriver(response.data); // If API returns driver object directly
      }

    } catch (error) {
      console.error('Error fetching driver profile:', error);
    }
}, [id]);

  useEffect(() => {
    fetchDriverProfile();
  }, [fetchDriverProfile]);

  const handleDeleteDriver = async (driverId) => {
    if (window.confirm('Are you sure you want to delete this driver? This action cannot be undone.')) {
      try {
        const token = localStorage.getItem('token');
        await axios.delete(`http://localhost:5000/api/drivers/${driverId}`, {
          headers: { Authorization: `Bearer ${token}` },
        });

        alert('Driver profile was deleted successfully.');
        navigate('/');
      } catch (error) {
        console.error('Error deleting driver:', error);
        alert('Failed to delete driver. Please try again.');
      }
    }
  };

  return (
    <div className="max-w-4xl mx-auto p-6 bg-background shadow-lg rounded-lg">
      <div className="flex justify-between items-center mb-4">
        <div>
          <h2 className="text-2xl font-bold">Driver Profile</h2>
          <p className="text-lg text-gray-600">Unit #: {driver?.unit_number || 'N/A'}</p>
        </div>
        <button 
          onClick={() => navigate('/')} 
          className="bg-primary text-white py-2 px-4 rounded hover:bg-secondary"
        >
          Return to Dashboard
        </button>
      </div>

      {driver ? (
        <div className="space-y-6">
          <div className="bg-background p-4 rounded-lg shadow">
            <h3 className="text-xl font-semibold mb-2 text-primary">Personal Information</h3>
            <p><strong>Name:</strong> {driver.name}</p>
            <p><strong>Phone Number:</strong> {driver.phone_number}</p>
            <p><strong>Email:</strong> {driver.email || 'N/A'}</p>
            <p><strong>Address:</strong> {driver.address || 'N/A'}</p>
            <p><strong>License Expiration Date:</strong> {driver.license_expiration ? driver.license_expiration.split('T')[0] : 'N/A'}</p>
            <p><strong>Employment Status:</strong> {driver.employment_status}</p>
            {driver.employment_status === 'Individual' && (
              <>
                <p><strong>Individual Name:</strong> {driver.individual_name || 'N/A'}</p>
                <p><strong>Individual Address:</strong> {driver.individual_address || 'N/A'}</p>
                <p><strong>SSN:</strong> {driver.SSN || 'N/A'}</p>
              </>
            )}
            {driver.employment_status === 'Business' && (
              <>
                <p><strong>Company Name:</strong> {driver.company_name || 'N/A'}</p>
                <p><strong>Company Address:</strong> {driver.company_address || 'N/A'}</p>
                <p><strong>EIN:</strong> {driver.EIN || 'N/A'}</p>
              </>
            )}
          </div>

          <div className="bg-background p-4 rounded-lg shadow">
            <h3 className="text-xl font-semibold mb-2 text-primary">Vehicle Information</h3>
            <p><strong>Vehicle Type:</strong> {driver.vehicle?.type || 'N/A'}</p>
            <p><strong>Truck Make:</strong> {driver.vehicle?.make || 'N/A'}</p>
            <p><strong>Truck Model:</strong> {driver.vehicle?.model || 'N/A'}</p>
            <p><strong>License Plate:</strong> {driver.vehicle?.license_plate || 'N/A'}</p>
            <p><strong>Insurance Details:</strong> {driver.vehicle?.insurance_details || 'N/A'}</p>
            <p><strong>Trunk Dimensions: </strong> 
              {driver.vehicle ? `${driver.vehicle.trunk_width}W x ${driver.vehicle.trunk_length}L x ${driver.vehicle.trunk_height}H` : 'N/A'}
            </p>
            <p><strong>Capacity: </strong> 
              {driver.vehicle ? `${driver.vehicle.capacity_ton} tons / ${driver.vehicle.capacity_m3} m³` : 'N/A'}
            </p>
          </div>

          {(user?.role === 'admin' || user?.role === 'recruiter') && (
            <div className="flex space-x-4">
              <button 
                onClick={() => navigate(`/edit-driver/${driver.id}`)} 
                className="bg-secondary text-white py-2 px-4 rounded hover:bg-primary"
              >
                Edit Driver
              </button>

              <button 
                onClick={() => handleDeleteDriver(driver.id)} 
                className="bg-danger text-white py-2 px-4 rounded hover:bg-primary"
              >
                Delete Driver
              </button>
            </div>
          )}
        </div>
      ) : (
        <p>Loading driver information...</p>
      )}
    </div>
  );
};

export default DriverProfilePage;
