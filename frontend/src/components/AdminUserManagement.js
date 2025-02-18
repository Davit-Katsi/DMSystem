import React, { useEffect, useState, useCallback } from 'react';
import axios from 'axios';
import { useAuth } from '../context/AuthContext';
import { Link } from 'react-router-dom';

const AdminUserManagement = () => {
  const { user } = useAuth();
  const [users, setUsers] = useState([]);
  const [newUser, setNewUser] = useState({ username: '', email: '', password: '', role: 'recruiter' });
  const [errorMessage, setErrorMessage] = useState('');
  const [successMessage, setSuccessMessage] = useState('');
  const [editUserId, setEditUserId] = useState(null);
  const [editedRole, setEditedRole] = useState('');

  const fetchUsers = useCallback(async () => {
    try {
      const token = localStorage.getItem('token');
      if (!token) {
        setErrorMessage('Authentication token not found.');
        setTimeout(() => setErrorMessage(''), 5000);
        return;
      }

      const response = await axios.get('http://localhost:5000/api/users', {
        headers: { Authorization: `Bearer ${token}` },
      });

      setUsers(response.data);
    } catch (error) {
      console.error('Error fetching users:', error);
      if (error.response && error.response.status === 403) {
        setErrorMessage('Access Denied: You do not have permission to view this resource.');
      } else {
        setErrorMessage('Failed to fetch users.');
      }
      setTimeout(() => setErrorMessage(''), 5000);
    }
  }, []);

  useEffect(() => {
    fetchUsers();
  }, [fetchUsers]);

  const handleAddUser = async () => {
    try {
      const token = localStorage.getItem('token');
      await axios.post('http://localhost:5000/api/users', newUser, {
        headers: { Authorization: `Bearer ${token}` },
      });
      setSuccessMessage('User added successfully!');
      setTimeout(() => setSuccessMessage(''), 5000);
      setNewUser({ username: '', email: '', password: '', role: 'recruiter' });
      fetchUsers();
    } catch (error) {
      console.error('Error adding user:', error);
      if (error.response && error.response.status === 400) {
        setErrorMessage(error.response.data.error || 'Failed to add user.');
      } else {
        setErrorMessage('Failed to add user.');
      }
      setTimeout(() => setErrorMessage(''), 5000);
    }
  };

  const handleDeleteUser = async (userId) => {
    const adminCount = users.filter(user => user.role === 'admin').length;
    const userToDelete = users.find(user => user.id === userId);

    if (userToDelete.role === 'admin' && adminCount === 1) {
      setErrorMessage('Cannot delete the last remaining admin.');
      setTimeout(() => setErrorMessage(''), 5000);
      return;
    }

    try {
      const token = localStorage.getItem('token');
      await axios.delete(`http://localhost:5000/api/users/${userId}`, {
        headers: { Authorization: `Bearer ${token}` },
      });
      setSuccessMessage('User deleted successfully!');
      setTimeout(() => setSuccessMessage(''), 5000);
      fetchUsers();
    } catch (error) {
      console.error('Error deleting user:', error);
      setErrorMessage('Failed to delete user.');
      setTimeout(() => setErrorMessage(''), 5000);
    }
  };

  const handleSaveEdit = async () => {
    const adminCount = users.filter(user => user.role === 'admin').length;
    const userToEdit = users.find(user => user.id === editUserId);

    if (userToEdit.role === 'admin' && editedRole !== 'admin' && adminCount === 1) {
      setErrorMessage('Cannot change role of the last remaining admin.');
      setTimeout(() => setErrorMessage(''), 5000);
      return;
    }

    try {
      const token = localStorage.getItem('token');
      await axios.put(`http://localhost:5000/api/users/${editUserId}`, { role: editedRole }, {
        headers: { Authorization: `Bearer ${token}` },
      });
      setSuccessMessage('User role updated successfully!');
      setTimeout(() => setSuccessMessage(''), 5000);
      setEditUserId(null);
      fetchUsers();
    } catch (error) {
      console.error('Error updating user role:', error);
      setErrorMessage('Failed to update user role.');
      setTimeout(() => setErrorMessage(''), 5000);
    }
  };

  if (user?.role !== 'admin') {
    return <p className="text-center text-red-500">Access Denied: Admins Only</p>;
  }

  return (
    <div className="max-w-4xl mx-auto p-6 bg-background rounded-lg shadow-md">
      
      {/* Title and "Return to Dashboard" */}
      <div className="flex justify-between items-center mb-4">
        <h2 className="text-2xl font-bold text-gray-800">User Management</h2>
        <Link to="/" className="bg-primary text-white py-2 px-4 rounded hover:bg-secondary shadow">
          Return to Dashboard
        </Link>
      </div>

      {/* Error and Success Messages */}
      {errorMessage && <div className="mb-4 p-3 bg-danger text-white rounded shadow">{errorMessage}</div>}
      {successMessage && <div className="mb-4 p-3 bg-accent text-primary rounded shadow">{successMessage}</div>}

      {/* User Count */}
      <div className="mb-4 p-3 bg-accent text-primary rounded shadow">
        <strong>Total Users:</strong> {users.length}
      </div>

      {/* Add New User Form */}
      <div className="mb-6">
        <h3 className="text-xl font-semibold mb-2 text-gray-700">Add New User</h3>
        <input
          type="text"
          name="username"
          placeholder="Username"
          value={newUser.username}
          onChange={(e) => setNewUser({ ...newUser, username: e.target.value })}
          className="w-full p-2 border rounded mb-2 focus:outline-none focus:ring-2 focus:ring-secondary"
        />
        <input
          type="email"
          name="email"
          placeholder="Email"
          value={newUser.email}
          onChange={(e) => setNewUser({ ...newUser, email: e.target.value })}
          className="w-full p-2 border rounded mb-2 focus:outline-none focus:ring-2 focus:ring-secondary"
        />
        <input
          type="password"
          name="password"
          placeholder="Password"
          value={newUser.password}
          onChange={(e) => setNewUser({ ...newUser, password: e.target.value })}
          className="w-full p-2 border rounded mb-2 focus:outline-none focus:ring-2 focus:ring-secondary"
        />
        <select
          name="role"
          value={newUser.role}
          onChange={(e) => setNewUser({ ...newUser, role: e.target.value })}
          className="w-full p-2 border rounded mb-4 focus:outline-none focus:ring-2 focus:ring-secondary"
        >
          <option value="recruiter">Recruiter</option>
          <option value="dispatcher">Dispatcher</option>
          <option value="admin">Admin</option>
        </select>
        <button
          onClick={handleAddUser}
          className="w-full bg-primary text-white py-2 rounded hover:bg-secondary shadow"
        >
          Add User
        </button>
      </div>

      {/* User List */}
      <div>
        <h3 className="text-xl font-semibold mb-2 text-gray-700">User List</h3>
        <ul>
          {users.map((user, index) => (
            <li key={user.id} className="flex justify-between items-center border-b py-2">
              <div>
                <p className="text-gray-800 font-medium"><strong>{index + 1}. {user.username}</strong> ({user.email})</p>
                {editUserId === user.id ? (
                  <select
                    value={editedRole}
                    onChange={(e) => setEditedRole(e.target.value)}
                    className="p-2 border rounded focus:outline-none focus:ring-2 focus:ring-secondary"
                  >
                    <option value="recruiter">Recruiter</option>
                    <option value="dispatcher">Dispatcher</option>
                    <option value="admin">Admin</option>
                  </select>
                ) : (
                  <p className="text-gray-600">Role: {user.role}</p>
                )}
              </div>
              <div className="flex space-x-2">
                {editUserId === user.id ? (
                  <button
                    onClick={handleSaveEdit}
                    className="bg-secondary text-white px-4 py-1 rounded hover:bg-primary shadow"
                  >
                    Save
                  </button>
                ) : (
                <button
                  onClick={() => {
                    setEditUserId(user.id);
                    setEditedRole(user.role);
                  }}
                  className={`px-4 py-1 rounded shadow ${
                    user.role === 'admin' && users.filter(u => u.role === 'admin').length === 1
                      ? 'bg-gray-400 text-white cursor-not-allowed'
                      : 'bg-accent text-primary hover:bg-secondary'
                  }`}
                  disabled={user.role === 'admin' && users.filter(u => u.role === 'admin').length === 1}
                >
                  Edit Role
                </button>
                )}
                <button
                  onClick={() => handleDeleteUser(user.id)}
                  className={`px-4 py-1 rounded shadow ${
                    user.role === 'admin' && users.filter(u => u.role === 'admin').length === 1
                      ? 'bg-gray-400 text-white cursor-not-allowed'
                      : 'bg-danger text-white hover:bg-primary'
                  }`}
                  disabled={user.role === 'admin' && users.filter(u => u.role === 'admin').length === 1}
                >
                  Delete
                </button>
              </div>
            </li>
          ))}
        </ul>
      </div>
    </div>
  );
};

export default AdminUserManagement;
