import React, { useState } from 'react';
import axios from 'axios';
import { useNavigate, Link } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';

const Login = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [errorMessage, setErrorMessage] = useState('');
  const navigate = useNavigate();
  const { login } = useAuth();

  const handleLogin = async (e) => {
    e.preventDefault(); // ✅ Prevent form from refreshing
    setErrorMessage(''); // ✅ Clear previous errors

    try {
      const response = await axios.post(
        'https://driver-management-backend-3chl.onrender.com/api/auth/login',
        { email, password }
      );

      const token = response.data.token;
      if (!token) {
        throw new Error("No token received");
      }

      sessionStorage.setItem("authToken", token); // ✅ Store token in sessionStorage
      const userPayload = JSON.parse(atob(token.split('.')[1]));
      login({
        token,
        role: userPayload.role,
        username: userPayload.username,
      });

      navigate('/dashboard'); // ✅ Redirect to dashboard on successful login
    } catch (error) {
      console.error('Login failed:', error.response?.data?.error || 'Login error');
      
      if (error.response) {
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
    <div className="max-w-sm mx-auto p-6 bg-white rounded-lg shadow-md mt-10">
      <h2 className="text-2xl font-bold mb-4">Login</h2>

      {/* Display Error Message */}
      {errorMessage && (
        <div className="mb-4 p-2 bg-red-500 text-white rounded">
          {errorMessage}
        </div>
      )}

      <form onSubmit={handleLogin}> {/* ✅ Wrap in form to trigger on submit */}
        <input
          type="email"
          placeholder="Email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          className="w-full p-2 border rounded mb-4"
          required
        />

        <input
          type="password"
          placeholder="Password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          className="w-full p-2 border rounded mb-4"
          required
        />

        <button
          type="submit"
          className="w-full bg-blue-500 text-white py-2 rounded hover:bg-blue-600"
        >
          Login
        </button>
      </form>

      {/* Reset Password Link */}
      <div className="mt-4 text-center">
        <Link to="/request-password-reset" className="text-blue-500 hover:underline">
          Forgot Password?
        </Link>
      </div>
    </div>
  );
};

export default Login;
