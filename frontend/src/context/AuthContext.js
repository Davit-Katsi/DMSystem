import React, { createContext, useContext, useState, useEffect } from 'react';

const AuthContext = createContext();

export const AuthProvider = ({ children }) => {
  const [user, setUser] = useState(null);

  const login = (userData) => {
    console.log("User data on login:", userData);
    setUser(userData);  // Store user info in state
    localStorage.setItem('token', userData.token);  // Save token in localStorage
  };

  useEffect(() => {
    const token = localStorage.getItem('token');
    if (token) {
      const userPayload = JSON.parse(atob(token.split('.')[1]));
      console.log("User data on refresh:", userPayload);  // Debug: Check user data after refresh
      setUser(userPayload);
    }
  }, []);

  const logout = () => {
    setUser(null);
    localStorage.removeItem('token');  // Clear token on logout
  };

  return (
    <AuthContext.Provider value={{ user, login, logout }}>
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => useContext(AuthContext);
