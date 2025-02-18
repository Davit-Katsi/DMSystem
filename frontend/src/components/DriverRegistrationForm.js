import React, { useState } from 'react';
import axios from 'axios';
import ReactInputMask from 'react-input-mask';
import { Link } from 'react-router-dom';

const DriverRegistrationForm = () => {
  const [formData, setFormData] = useState({
    name: '',
    phone_number: '',
    email: '',
    address: '',
    license_number: '',
    license_expiration: '',
    employment_status: 'Individual',
    individual_name: '',
    individual_address: '',
    SSN: '',
    company_name: '',
    company_address: '',
    EIN: '',
    unit_number: '',
    vehicle: {
      make: '',
      model: '',
      type: '',
      trunk_width: '',
      trunk_length: '',
      trunk_height: '',
      capacity_ton: '',
      capacity_m3: '',
      license_plate: '',
      insurance_details: ''
    }
  });

  const [errorMessage, setErrorMessage] = useState('');
  const [successMessage, setSuccessMessage] = useState('');

  const handleChange = (e) => {
    const { name, value } = e.target;

    if (name === 'employment_status') {
      setFormData((prevData) => ({
        ...prevData,
        employment_status: value,
        SSN: value === 'Individual' ? '' : null,
        EIN: value === 'Business' ? '' : null,
        individual_name: '',
        individual_address: '',
        company_name: '',
        company_address: ''
      }));
    } else if (name in formData.vehicle) {
      setFormData({ ...formData, vehicle: { ...formData.vehicle, [name]: value } });
    } else {
      setFormData({ ...formData, [name]: value });
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    const ssnPattern = /^\d{3}-\d{2}-\d{4}$/;
    const einPattern = /^\d{2}-\d{7}$/;
    const unitPattern = /^\d{4}$/;

    if (formData.employment_status === 'Individual' && !ssnPattern.test(formData.SSN)) {
      setErrorMessage('Invalid SSN format. Please enter in the format XXX-XX-XXXX.');
      setTimeout(() => setErrorMessage(''), 3000);
      return;
    }

    if (formData.employment_status === 'Business' && !einPattern.test(formData.EIN)) {
      setErrorMessage('Invalid EIN format. Please enter in the format XX-XXXXXXX.');
      setTimeout(() => setErrorMessage(''), 3000);
      return;
    }

    if (!unitPattern.test(formData.unit_number)) {
      setErrorMessage('Invalid Unit Number. Please enter a 4-digit number.');
      setTimeout(() => setErrorMessage(''), 3000);
      return;
    }

    try {
      await axios.post('http://localhost:5000/api/register', formData);
      setSuccessMessage('Driver Registered Successfully!');
      setTimeout(() => setSuccessMessage(''), 3000);
      setFormData({
        name: '', phone_number: '', email: '', address: '', license_number: '', license_expiration: '',
        employment_status: 'Individual', individual_name: '', individual_address: '', SSN: '',
        company_name: '', company_address: '', EIN: '', unit_number: '',
        vehicle: { make: '', model: '', type: '', trunk_width: '', trunk_length: '', trunk_height: '', capacity_ton: '', capacity_m3: '', license_plate: '', insurance_details: '' }
      });
    } catch (error) {
      if (error.response && error.response.data.error) {
        setErrorMessage(`Error: ${error.response.data.error}`);
      } else {
        setErrorMessage('An unexpected error occurred.');
      }
      setTimeout(() => setErrorMessage(''), 3000);
    }
  };

  return (
    <div className="max-w-3xl mx-auto p-6 bg-background rounded-lg shadow-md mt-10">
      {/* Title and "Return to Dashboard" */}
      <div className="flex justify-between items-center mb-6">
        <h2 className="text-3xl font-bold text-gray-800">Driver Registration Form</h2>
        <Link to="/" className="bg-primary text-white py-2 px-4 rounded hover:bg-secondary shadow">
          Return to Dashboard
        </Link>
      </div>

      {errorMessage && <div className="bg-danger text-white p-3 rounded mb-4">{errorMessage}</div>}
      {successMessage && <div className="bg-accent text-primary p-3 rounded mb-4">{successMessage}</div>}

      <form onSubmit={handleSubmit} className="space-y-6">

        {/* Driver Personal Information */}
        <div className="border-l-4 border-primary pl-4">
          <h3 className="text-xl font-semibold mb-2 text-gray-700">Driver Personal Information</h3>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <label className="block font-medium">Unit Number (4 digits)</label>
              <ReactInputMask mask="9999" value={formData.unit_number} onChange={handleChange}>
                {(inputProps) => (
                  <input {...inputProps} type="text" name="unit_number" placeholder="####" className="w-full p-2 border rounded" required />
                )}
              </ReactInputMask>
            </div>
            <div>
              <label className="block font-medium">Name</label>
              <input type="text" name="name" value={formData.name} onChange={handleChange} className="w-full p-2 border rounded" required />
            </div>
            <div>
              <label className="block font-medium">Phone Number</label>
              <ReactInputMask mask="999-999-9999" value={formData.phone_number} onChange={handleChange}>
              {(inputProps) => (
                <input {...inputProps} type="text" name="phone_number" placeholder="XXX-XXX-XXXX" className="w-full p-2 border rounded" required />
              )}
              </ReactInputMask>
            </div>
            <div>
              <label className="block font-medium">Email</label>
              <input type="email" name="email" value={formData.email} onChange={handleChange} className="w-full p-2 border rounded" />
            </div>
            <div>
              <label className="block font-medium">Address</label>
              <input type="text" name="address" value={formData.address} onChange={handleChange} className="w-full p-2 border rounded" />
            </div>
            <div>
              <label className="block font-medium">License Expiration Date</label>
              <input type="date" name="license_expiration" value={formData.license_expiration} onChange={handleChange} className="w-full p-2 border rounded" required />
            </div>
          </div>
        </div>

        {/* Employment Status */}
        <div className="border-l-4 border-primary pl-4">
          <h3 className="text-xl font-semibold mb-2 text-gray-700">Employment Status</h3>
          <div>
            <label className="block font-medium">Select Employment Type</label>
            <select name="employment_status" value={formData.employment_status} onChange={handleChange} className="w-full p-2 border rounded">
              <option value="Individual">Individual</option>
              <option value="Business">Business</option>
            </select>
          </div>

          {formData.employment_status === 'Individual' && (
            <div className="mt-4 grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label className="block font-medium">Individual Name</label>
                <input type="text" name="individual_name" value={formData.individual_name} onChange={handleChange} className="w-full p-2 border rounded" required />
              </div>
              <div>
                <label className="block font-medium">Individual Address</label>
                <input type="text" name="individual_address" value={formData.individual_address} onChange={handleChange} className="w-full p-2 border rounded" required />
              </div>
              <div>
                <label className="block font-medium">SSN</label>
                <ReactInputMask mask="999-99-9999" value={formData.SSN} onChange={handleChange}>
                  {(inputProps) => (
                    <input {...inputProps} type="text" name="SSN" placeholder="XXX-XX-XXXX" className="w-full p-2 border rounded" required />
                  )}
                </ReactInputMask>
              </div>
            </div>
          )}

          {formData.employment_status === 'Business' && (
            <div className="mt-4 grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label className="block font-medium">Company Name</label>
                <input type="text" name="company_name" value={formData.company_name} onChange={handleChange} className="w-full p-2 border rounded" required />
              </div>
              <div>
                <label className="block font-medium">Company Address</label>
                <input type="text" name="company_address" value={formData.company_address} onChange={handleChange} className="w-full p-2 border rounded" required />
              </div>
              <div>
                <label className="block font-medium">EIN</label>
                <ReactInputMask mask="99-9999999" value={formData.EIN} onChange={handleChange}>
                  {(inputProps) => (
                    <input {...inputProps} type="text" name="EIN" placeholder="XX-XXXXXXX" className="w-full p-2 border rounded" required />
                  )}
                </ReactInputMask>
              </div>
            </div>
          )}
        </div>

        {/* Truck Information */}
        <div className="border-l-4 border-primary pl-4">
          <h3 className="text-xl font-semibold mb-2 text-gray-700">Truck Information</h3>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <label className="block font-medium">Truck Make</label>
              <input type="text" name="make" value={formData.vehicle.make} onChange={handleChange} className="w-full p-2 border rounded" required />
            </div>
            <div>
              <label className="block font-medium">Truck Model</label>
              <input type="text" name="model" value={formData.vehicle.model} onChange={handleChange} className="w-full p-2 border rounded" required />
            </div>
            <div>
              <label className="block font-medium">Type</label>
              <input type="text" name="type" value={formData.vehicle.type} onChange={handleChange} className="w-full p-2 border rounded" />
            </div>
            <div>
              <label className="block font-medium">License Plate Number</label>
              <input type="text" name="license_plate" value={formData.vehicle.license_plate} onChange={handleChange} className="w-full p-2 border rounded" required />
            </div>
          </div>

          {/* Trunk Dimensions */}
          <h4 className="text-lg font-medium mt-4 text-gray-600">Trunk Dimensions (in meters)</h4>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <div>
              <label className="block font-medium">Width</label>
              <input type="text" name="trunk_width" value={formData.vehicle.trunk_width} onChange={handleChange} className="w-full p-2 border rounded" required />
            </div>
            <div>
              <label className="block font-medium">Length</label>
              <input type="text" name="trunk_length" value={formData.vehicle.trunk_length} onChange={handleChange} className="w-full p-2 border rounded" required />
            </div>
            <div>
              <label className="block font-medium">Height</label>
              <input type="text" name="trunk_height" value={formData.vehicle.trunk_height} onChange={handleChange} className="w-full p-2 border rounded" required />
            </div>
          </div>

          {/* Trunk Capacity */}
          <h4 className="text-lg font-medium mt-4 text-gray-600">Trunk Capacity</h4>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <label className="block font-medium">Tonnage</label>
              <input type="text" name="capacity_ton" value={formData.vehicle.capacity_ton} onChange={handleChange} className="w-full p-2 border rounded" required />
            </div>
            <div>
              <label className="block font-medium">Capacity (m³)</label>
              <input type="text" name="capacity_m3" value={formData.vehicle.capacity_m3} onChange={handleChange} className="w-full p-2 border rounded" required />
            </div>
          </div>
        </div>

        {/* Insurance Details */}
        <div className="border-l-4 border-primary pl-4">
          <h3 className="text-xl font-semibold mb-2 text-gray-700">Insurance Details</h3>
          <textarea name="insurance_details" value={formData.vehicle.insurance_details} onChange={handleChange} className="w-full p-2 border rounded"></textarea>
        </div>

        <button type="submit" className="w-full bg-primary text-white py-2 rounded hover:bg-secondary">
          Register Driver
        </button>
      </form>
    </div>
  );
};

export default DriverRegistrationForm;
