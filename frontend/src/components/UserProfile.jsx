import React, { useState } from 'react';
import { useHotelService } from '../services/hotelService';
import { User } from '@asgardeo/react';

const UserProfile = () => {
  const [hotelProfileData, setHotelProfileData] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const hotelService = useHotelService();

  const fetchHotelProfile = async () => {
    setLoading(true);
    setError(null);

    try {
      const data = await hotelService.getHotelApiProfile();
      setHotelProfileData(data);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="user-profile">
      <h2>User Profile</h2>
      
      {/* Asgardeo Profile - This works without CORS issues */}
      <div className="asgardeo-profile">
        <h3>Authentication Profile</h3>
        <User>
          {(user) => (
            <div className="profile-info">
              <div className="profile-item">
                <strong>Display Name:</strong> {user.displayName || 'N/A'}
              </div>
              <div className="profile-item">
                <strong>Email:</strong> {user.email || 'N/A'}
              </div>
              <div className="profile-item">
                <strong>Username:</strong> {user.username || user.preferred_username || 'N/A'}
              </div>
              <div className="profile-item">
                <strong>First Name:</strong> {user.given_name || 'N/A'}
              </div>
              <div className="profile-item">
                <strong>Last Name:</strong> {user.family_name || 'N/A'}
              </div>
              <div className="profile-item">
                <strong>Phone:</strong> {user.phone_number || 'N/A'}
              </div>
              <div className="profile-item">
                <strong>User ID:</strong> {user.sub || 'N/A'}
              </div>
              {user.groups && user.groups.length > 0 && (
                <div className="profile-item">
                  <strong>Groups:</strong> {user.groups.join(', ')}
                </div>
              )}
              {user.roles && user.roles.length > 0 && (
                <div className="profile-item">
                  <strong>Roles:</strong> {user.roles.join(', ')}
                </div>
              )}
            </div>
          )}
        </User>
      </div>

      {/* Hotel API Profile */}
      <div className="api-profile-section">
        <h3>Hotel Booking Profile</h3>
        <button onClick={fetchHotelProfile} disabled={loading} className="fetch-button">
          {loading ? 'Loading...' : 'Fetch Hotel Profile'}
        </button>

        {error && (
          <div className="error-message">
            <p>Error: {error}</p>
            <p className="error-note">
              Note: This requires your hotel API to be running and configured properly.
            </p>
          </div>
        )}

        {hotelProfileData && (
          <div className="api-profile-data">
            <div className="profile-item">
              <strong>User ID:</strong> {hotelProfileData.userId}
            </div>
            <div className="profile-item">
              <strong>Name:</strong> {hotelProfileData.firstName} {hotelProfileData.lastName}
            </div>
            <div className="profile-item">
              <strong>Email:</strong> {hotelProfileData.email}
            </div>
            <div className="profile-item">
              <strong>Phone:</strong> {hotelProfileData.phoneNumber || 'N/A'}
            </div>
            <div className="profile-item">
              <strong>User Type:</strong> {hotelProfileData.userType}
            </div>
            <div className="profile-item">
              <strong>Registration Date:</strong> {hotelProfileData.registrationDate}
            </div>
          </div>
        )}
      </div>
    </div>
  );
};

export default UserProfile;