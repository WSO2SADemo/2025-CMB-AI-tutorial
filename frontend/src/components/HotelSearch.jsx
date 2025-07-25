import React, { useState, useEffect } from 'react';
import { useHotelService } from '../services/hotelService';
import HotelImage from './HotelImage';


const HotelSearch = () => {
  const [searchParams, setSearchParams] = useState({
    destination: '',
    checkInDate: '',
    checkOutDate: '',
    guests: 2,
    rooms: 1,
    minPrice: '',
    maxPrice: '',
    minRating: '',
    page: 1,
    pageSize: 10
  });
  const [hotels, setHotels] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [initialLoad, setInitialLoad] = useState(true);

  const hotelService = useHotelService();

  // Load initial hotels when component mounts
  useEffect(() => {
    const loadInitialHotels = async () => {
      setLoading(true);
      try {
        // Search with minimal parameters to get initial hotel list
        const result = await hotelService.searchHotels({
          page: 1,
          pageSize: 20
        });
        setHotels(result.hotels || []);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
        setInitialLoad(false);
      }
    };

    loadInitialHotels();
  }, []);

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setSearchParams(prev => ({
      ...prev,
      [name]: value
    }));
  };

  const handleSearch = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError(null);

    try {
      const result = await hotelService.searchHotels(searchParams);
      setHotels(result.hotels || []);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  const clearSearch = () => {
    setSearchParams({
      destination: '',
      checkInDate: '',
      checkOutDate: '',
      guests: 2,
      rooms: 1,
      minPrice: '',
      maxPrice: '',
      minRating: '',
      page: 1,
      pageSize: 10
    });
  };

  return (
    <div className="hotel-search">
      <h2>Search Hotels</h2>
      
      <div className="search-container">
        <form onSubmit={handleSearch} className="search-form">
          <div className="search-row-main">
            <div className="form-group">
              <input
                type="text"
                name="destination"
                value={searchParams.destination}
                onChange={handleInputChange}
                placeholder="Where are you going?"
                className="destination-input"
              />
            </div>
            
            <div className="form-group">
              <input
                type="date"
                name="checkInDate"
                value={searchParams.checkInDate}
                onChange={handleInputChange}
                className="date-input"
              />
            </div>
            
            <div className="form-group">
              <input
                type="date"
                name="checkOutDate"
                value={searchParams.checkOutDate}
                onChange={handleInputChange}
                className="date-input"
              />
            </div>
            
            <div className="form-group">
              <select
                name="guests"
                value={searchParams.guests}
                onChange={handleInputChange}
                className="guests-input"
              >
                {[1,2,3,4,5,6,7,8].map(num => (
                  <option key={num} value={num}>{num} Guest{num > 1 ? 's' : ''}</option>
                ))}
              </select>
            </div>
            
            <button type="submit" disabled={loading} className="search-button">
              {loading ? 'Searching...' : 'Search'}
            </button>
          </div>

          {/* Advanced Filters - Collapsible */}
          <details className="advanced-filters">
            <summary>Advanced Filters</summary>
            <div className="filters-content">
              <div className="filter-row">
                <div className="form-group">
                  <label>Rooms:</label>
                  <input
                    type="number"
                    name="rooms"
                    value={searchParams.rooms}
                    onChange={handleInputChange}
                    min="1"
                    max="10"
                  />
                </div>
                
                <div className="form-group">
                  <label>Min Price:</label>
                  <input
                    type="number"
                    name="minPrice"
                    value={searchParams.minPrice}
                    onChange={handleInputChange}
                    placeholder="Min price per night"
                  />
                </div>
                
                <div className="form-group">
                  <label>Max Price:</label>
                  <input
                    type="number"
                    name="maxPrice"
                    value={searchParams.maxPrice}
                    onChange={handleInputChange}
                    placeholder="Max price per night"
                  />
                </div>
                
                <div className="form-group">
                  <label>Min Rating:</label>
                  <select
                    name="minRating"
                    value={searchParams.minRating}
                    onChange={handleInputChange}
                  >
                    <option value="">Any Rating</option>
                    <option value="3">3+ Stars</option>
                    <option value="4">4+ Stars</option>
                    <option value="5">5 Stars</option>
                  </select>
                </div>
              </div>
              
              <button type="button" onClick={clearSearch} className="clear-button">
                Clear Filters
              </button>
            </div>
          </details>
        </form>
      </div>

      {error && (
        <div className="error-message">
          <p>Error: {error}</p>
        </div>
      )}

      <div className="results-section">
        {initialLoad && loading ? (
          <div className="loading-hotels">
            <div className="spinner"></div>
            <p>Loading hotels...</p>
          </div>
        ) : (
          <>
            <div className="results-header">
              <h3>
                {hotels.length > 0 
                  ? `${hotels.length} hotel${hotels.length > 1 ? 's' : ''} found` 
                  : 'No hotels found'
                }
              </h3>
            </div>

            {hotels.length > 0 && (
              <div className="hotels-grid">
                {hotels.map(hotel => (
                  <div key={hotel.hotelId} className="hotel-card">
                    <HotelImage hotel={hotel} showId={true} />

                    
                    <div className="hotel-content">
                      <h4>{hotel.hotelName}</h4>
                      <p className="hotel-location">
                        📍 {hotel.city}, {hotel.country}
                      </p>
                      
                      <div className="hotel-rating">
                        <span className="rating-stars">
                          {'★'.repeat(Math.floor(hotel.rating))}
                          {'☆'.repeat(5 - Math.floor(hotel.rating))}
                        </span>
                        <span className="rating-text">
                          {hotel.rating}/5 ({hotel.reviewCount} reviews)
                        </span>
                      </div>
                      
                      <p className="hotel-description">
                        {hotel.description.length > 120 
                          ? `${hotel.description.substring(0, 120)}...` 
                          : hotel.description
                        }
                      </p>
                      
                      <div className="hotel-amenities">
                        {hotel.amenities.slice(0, 3).map(amenity => (
                          <span key={amenity} className="amenity-tag">{amenity}</span>
                        ))}
                        {hotel.amenities.length > 3 && (
                          <span className="amenity-more">+{hotel.amenities.length - 3} more</span>
                        )}
                      </div>
                      
                      <div className="hotel-footer">
                        <div className="hotel-price">
                          <span className="price-amount">${hotel.lowestPrice}</span>
                          <span className="price-period">/night</span>
                        </div>
                        
                        <button 
                          className="view-hotel-button"
                          onClick={() => {
                            // TODO: Navigate to hotel details or implement booking
                            alert(`View details for ${hotel.hotelName}`);
                          }}
                        >
                          View Details
                        </button>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </>
        )}
      </div>
    </div>
  );
};

export default HotelSearch;