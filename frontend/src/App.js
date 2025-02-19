import React, { useState, useEffect } from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
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

  const [isAuthenticated, setIsAuthenticated] = useState(false);

  useEffect(() => {
    const fetchStats = async () => {
      try {
        const token = sessionStorage.getItem('authToken'); // ✅ Use sessionStorage instead of localStorage
        if (!token) {
          setIsAuthenticated(false);
          return;
        }

        const response = await axios.get('https://driver-management-backend-3chl.onrender.com/api/drivers/stats', {
          headers: { Authorization: `Bearer ${token}` }
        });

        setStats(response.data);
        setIsAuthenticated(true);
      } catch (error) {
        console.error('Error fetching stats:', error);
        setIsAuthenticated(false); // Ensure the user is logged out if an error occurs
      }
    };

    fetchStats();
  }, []);

  return (
    <AuthProvider>
      <Router>
        <div className="min-h-screen bg-gray-100 p-4">
          <Routes>
            {/* ✅ Always start at login if not authenticated */}
            <Route path="/" element={isAuthenticated ? <Dashboard stats={stats} /> : <Navigate to="/login" />} />
            <Route path="/login" element={<Login />} />
            <Route path="/dashboard" element={isAuthenticated ? <Dashboard stats={stats} /> : <Navigate to="/login" />} />
            <Route path="/add-driver" element={isAuthenticated ? <DriverRegistrationForm /> : <Navigate to="/login" />} />
            <Route path="/user-management" element={isAuthenticated ? <AdminUserManagement /> : <Navigate to="/login" />} />
            <Route path="/request-password-reset" element={<RequestPasswordReset />} />
            <Route path="/reset-password/:token" element={<ResetPassword />} />
            <Route path="/driver-profile/:id" element={isAuthenticated ? <DriverProfilePage /> : <Navigate to="/login" />} />
            <Route path="/edit-driver/:id" element={isAuthenticated ? <EditDriverPage /> : <Navigate to="/login" />} />
            <Route path="/update-status" element={isAuthenticated ? <UpdateStatusPage /> : <Navigate to="/login" />} />
          </Routes>
        </div>
      </Router>
    </AuthProvider>
  );
}

export default App;
