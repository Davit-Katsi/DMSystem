// src/components/ResetPassword.js

import React, { useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import axios from 'axios';

const ResetPassword = () => {
  const { token } = useParams();  // Token from URL
  const [newPassword, setNewPassword] = useState('');
  const [message, setMessage] = useState('');
  const [error, setError] = useState('');
  const navigate = useNavigate();

  const handleResetPassword = async () => {
    try {
      const response = await axios.post('https://driver-management-backend-3chl.onrender.com/api/users/reset-password', { token, newPassword });
      setMessage(response.data.message);
      setError('');
      setTimeout(() => navigate('/login'), 3000);  // Redirect to login after 3 seconds
    } catch (error) {
      console.error('Error resetting password:', error);
      setError(error.response?.data?.error || 'Failed to reset password.');
      setMessage('');
    }

    setTimeout(() => {
      setMessage('');
      setError('');
    }, 5000);
  };

  return (
    <div className="max-w-md mx-auto p-6 bg-background shadow-md rounded-lg">
      <h2 className="text-2xl font-bold mb-4 text-gray-800">Reset Password</h2>
      {message && <div className="bg-accent text-primary p-3 rounded mb-4">{message}</div>}
      {error && <div className="bg-danger text-white p-3 rounded mb-4">{error}</div>}

      <input
        type="password"
        placeholder="Enter new password"
        value={newPassword}
        onChange={(e) => setNewPassword(e.target.value)}
        className="w-full p-2 border rounded mb-4 focus:outline-none focus:ring-2 focus:ring-secondary"
      />
      <button
        onClick={handleResetPassword}
        className="w-full bg-primary text-white py-2 rounded hover:bg-secondary"
      >
        Reset Password
      </button>
    </div>
  );
};

export default ResetPassword;
