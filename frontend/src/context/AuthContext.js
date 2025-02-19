import React, { createContext, useContext, useState, useEffect } from 'react';

const AuthContext = createContext();

export const AuthProvider = ({ children }) => {
  const [user, setUser] = useState(null);

  const login = (userData) => {
    console.log("✅ User logged in:", userData);
    setUser(userData);
    sessionStorage.setItem('token', userData.token);  // ✅ Store token in sessionStorage instead of localStorage
  };

  useEffect(() => {
    const token = sessionStorage.getItem('token');
    if (token) {
      const decodedPayload = JSON.parse(atob(token.split('.')[1]));

      // ✅ Check if token has expired
      if (decodedPayload.exp * 1000 < Date.now()) {
        console.log("⚠ Token expired. Logging out...");
        logout();
        return;
      }

      console.log("🔄 Restoring session for:", decodedPayload);
      setUser(decodedPayload);
    }
  }, []);

  const logout = () => {
    console.log("🚪 User logged out");
    setUser(null);
    sessionStorage.removeItem('token');  // ✅ Clear sessionStorage on logout
  };

  return (
    <AuthContext.Provider value={{ user, login, logout }}>
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => useContext(AuthContext);
