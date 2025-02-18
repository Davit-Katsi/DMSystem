import React, { useState } from 'react';
import axios from 'axios';
import { useNavigate, Link } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';

const Login = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [errorMessage, setErrorMessage] = useState('');  // State for error messages
  const navigate = useNavigate();
  const { login } = useAuth();

  const handleLogin = async () => {
    setErrorMessage('');  // Clear previous errors
    try {
      const response = await axios.post('http://localhost:5000/api/auth/login', { email, password });

      const token = response.data.token;
      const userPayload = JSON.parse(atob(token.split('.')[1]));
      login({ 
        token, 
        role: userPayload.role, 
        username: userPayload.username  // Include username in the auth context
      });

      navigate('/');
    } catch (error) {
      console.error('Login failed:', error.response?.data?.error || 'Login error');
      
      if (error.response) {
        // Handle specific error responses from the server
        if (error.response.status === 404) {
          setErrorMessage('User not found. Please check your email.');
        } else if (error.response.status === 401) {
          setErrorMessage('Incorrect password. Please try again.');
        } else {
          setErrorMessage('An unexpected error occurred. Please try again later.');
        }
      } else {
        setErrorMessage('Unable to connect to the server. Please check your connection.');
      }
    }
  };

  return (
    <div className="max-w-sm mx-auto p-6 bg-background rounded-lg shadow-md mt-10">
      <h2 className="text-2xl font-bold mb-4">Login</h2>

      {/* Display Error Message */}
      {errorMessage && (
        <div className="mb-4 p-2 bg-danger text-white rounded">
          {errorMessage}
        </div>
      )}

      <input
        type="email"
        placeholder="Email"
        value={email}
        onChange={(e) => setEmail(e.target.value)}
        className="w-full p-2 border rounded mb-4"
      />

      <input
        type="password"
        placeholder="Password"
        value={password}
        onChange={(e) => setPassword(e.target.value)}
        className="w-full p-2 border rounded mb-4"
      />
      <button
        onClick={handleLogin}
        className="w-full bg-primary text-white py-2 rounded hover:bg-secondary"
      >
        Login
      </button>

    {/* Reset Password Link */}
    <div className="mt-4 text-center">
    <Link to="/request-password-reset" className="text-secondary hover:underline">
      Forgot Password?
    </Link>
    </div>
  </div>
  );
};

export default Login;
