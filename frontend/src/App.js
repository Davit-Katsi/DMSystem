import React, { useState, useEffect } from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import axios from 'axios';
import Dashboard from './components/Dashboard';
import DriverRegistrationForm from './components/DriverRegistrationForm';
import { AuthProvider } from './context/AuthContext';
import Login from './components/Login';
import AdminUserManagement from './components/AdminUserManagement';
import RequestPasswordReset from './components/RequestPasswordReset';
import ResetPassword from './components/ResetPassword';
import DriverProfilePage from './pages/DriverProfilePage';
import EditDriverPage from './pages/EditDriverPage';
import UpdateStatusPage from './pages/UpdateStatusPage';


function App() {
  const [stats, setStats] = useState({
    totalDrivers: 0,
    availableDrivers: 0,
    onDutyDrivers: 0
  });

  useEffect(() => {
    const fetchStats = async () => {
      try {
        const token = localStorage.getItem('token');
        const response = await axios.get('http://localhost:5000/api/drivers/stats', {
          headers: { Authorization: `Bearer ${token}` }
        });
        setStats(response.data);
      } catch (error) {
        console.error('Error fetching stats:', error);
      }
    };

    fetchStats();
  }, []);

  return (
    <AuthProvider>
      <Router>
        <div className="min-h-screen bg-gray-100 p-4">
          <Routes>
            <Route path="/" element={<Dashboard stats={stats} />} />
            console.log("Dashboard route loaded");  // Debug: Check if Dashboard route is triggered
            <Route path="/add-driver" element={<DriverRegistrationForm />} />
            <Route path="/login" element={<Login />} />
            <Route path="/user-management" element={<AdminUserManagement />} />
            <Route path="/request-password-reset" element={<RequestPasswordReset />} />
            <Route path="/reset-password/:token" element={<ResetPassword />} />
            <Route path="/driver-profile/:id" element={<DriverProfilePage />} />
            <Route path="/edit-driver/:id" element={<EditDriverPage />} />
            <Route path="/update-status" element={<UpdateStatusPage />} />
          </Routes>
        </div>
      </Router>
    </AuthProvider>
  );
}

export default App;
