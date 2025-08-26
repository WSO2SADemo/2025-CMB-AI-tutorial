import { useState, useEffect, useCallback } from 'react';
import { useBookingService } from '../services/bookingService';

const UserBookings = () => {
  const [bookings, setBookings] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const bookingService = useBookingService();
  const userId = process.env.REACT_APP_USER_ID || 'user_john_001';

  const fetchBookings = useCallback(async () => {
    setLoading(true);
    setError(null);

    try {
      const result = await bookingService.getBookings(userId);
      setBookings(Array.isArray(result) ? result : []);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  }, [bookingService, userId]);

  useEffect(() => {
    if (userId) {
      fetchBookings();
    }
  }, [userId, fetchBookings]);


  const handleCancelBooking = async (bookingId) => {
    if (!window.confirm('Are you sure you want to cancel this booking?')) {
      return;
    }

    try {
      await bookingService.cancelBooking(bookingId);
      alert('Booking cancelled successfully');
      fetchBookings(); // Refresh the list
    } catch (err) {
      alert(`Error cancelling booking: ${err.message}`);
    }
  };

  const handleDeleteAllBookings = async () => {
    if (!window.confirm('Are you sure you want to delete ALL your bookings? This action cannot be undone.')) {
      return;
    }

    try {
      await bookingService.deleteAllBookings(userId);
      alert('All bookings deleted successfully');
      fetchBookings(); // Refresh the list
    } catch (err) {
      alert(`Error deleting bookings: ${err.message}`);
    }
  };

  if (!userId) {
    return <div className="error-message">User ID not configured. Please set REACT_APP_USER_ID in .env file.</div>;
  }

  if (loading) return <div className="loading">Loading bookings...</div>;

  return (
    <div className="user-bookings">
      <div className="bookings-header">
        <h2>My Bookings</h2>
        {bookings.length > 0 && (
          <button 
            onClick={handleDeleteAllBookings}
            className="delete-all-button"
            style={{ marginLeft: 'auto', backgroundColor: '#dc3545', color: 'white', padding: '8px 16px', border: 'none', borderRadius: '4px', cursor: 'pointer' }}
          >
            Delete All Bookings
          </button>
        )}
      </div>
      
      {error && (
        <div className="error-message">
          <p>Error: {error}</p>
        </div>
      )}

      {bookings.length === 0 ? (
        <p>No bookings found.</p>
      ) : (
        <div className="bookings-list">
          {bookings.map(booking => (
            <div key={booking.bookingId} className="booking-card">
              <div className="booking-header">
                <div className="booking-title">
                  <h3>Booking #{booking.confirmationNumber}</h3>
                  <span className={`booking-status ${booking.bookingStatus.toLowerCase()}`}>
                    {booking.bookingStatus}
                  </span>
                </div>
              </div>
              
              <div className="booking-content">
                <div className="booking-info-grid">
                  <div className="info-section">
                    <h4>Stay Details</h4>
                    <div className="info-item">
                      <span className="label">Hotel ID:</span>
                      <span className="value">{booking.hotelId}</span>
                    </div>
                    <div className="info-item">
                      <span className="label">Check-in:</span>
                      <span className="value">{new Date(booking.checkInDate).toLocaleDateString()}</span>
                    </div>
                    <div className="info-item">
                      <span className="label">Check-out:</span>
                      <span className="value">{new Date(booking.checkOutDate).toLocaleDateString()}</span>
                    </div>
                    <div className="info-item">
                      <span className="label">Guests:</span>
                      <span className="value">{booking.numberOfGuests}</span>
                    </div>
                  </div>
                  
                  <div className="info-section">
                    <h4>Guest Information</h4>
                    <div className="info-item">
                      <span className="label">Primary Guest:</span>
                      <span className="value">{booking.primaryGuest.firstName} {booking.primaryGuest.lastName}</span>
                    </div>
                    <div className="info-item">
                      <span className="label">Total Amount:</span>
                      <span className="value price">${booking.pricing[0]?.totalAmount || 0}</span>
                    </div>
                  </div>
                </div>
                
                {booking.bookingStatus !== 'CANCELLED' && (
                  <div className="booking-actions">
                    <button 
                      onClick={() => handleCancelBooking(booking.bookingId)}
                      className="cancel-button"
                    >
                      Cancel Booking
                    </button>
                  </div>
                )}
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
};

export default UserBookings;
