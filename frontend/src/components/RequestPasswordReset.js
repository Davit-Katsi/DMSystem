// src/components/RequestPasswordReset.js

import React, { useState } from 'react';
import axios from 'axios';

const RequestPasswordReset = () => {
  const [email, setEmail] = useState('');
  const [message, setMessage] = useState('');
  const [error, setError] = useState('');

  const handleRequestReset = async () => {
    try {
      const response = await axios.post('http://https://driver-management-backend-3chl.onrender.com/api/users/request-password-reset', { email });
      setMessage(response.data.message);
      setError('');
    } catch (error) {
      console.error('Error requesting password reset:', error);
      setError(error.response?.data?.error || 'Failed to request password reset.');
      setMessage('');
    }

    setTimeout(() => {
      setMessage('');
      setError('');
    }, 5000);
  };

  return (
    <div className="max-w-md mx-auto p-6 bg-background shadow-md rounded-lg">
      <h2 className="text-2xl font-bold mb-4 text-gray-800">Request Password Reset</h2>
      {message && <div className="bg-accent text-primary p-3 rounded mb-4">{message}</div>}
      {error && <div className="bg-danger text-white p-3 rounded mb-4">{error}</div>}

      <input
        type="email"
        placeholder="Enter your email"
        value={email}
        onChange={(e) => setEmail(e.target.value)}
        className="w-full p-2 border rounded mb-4 focus:outline-none focus:ring-2 focus:ring-secondary"
      />
      <button
        onClick={handleRequestReset}
        className="w-full bg-primary text-white py-2 rounded hover:bg-secondary"
      >
        Send Reset Link
      </button>
    </div>
  );
};

export default RequestPasswordReset;
