import { useAsgardeo } from '@asgardeo/react';
import apiConfig from '../config/api';

export const useHotelService = () => {
  const { http, isSignedIn } = useAsgardeo();

  const searchHotels = async (searchParams) => {
    if (!isSignedIn) throw new Error('User not authenticated');

    const queryParams = new URLSearchParams();
    Object.entries(searchParams).forEach(([key, value]) => {
      if (value !== null && value !== undefined && value !== '') {
        if (Array.isArray(value)) {
          value.forEach(item => queryParams.append(key, item));
        } else {
          queryParams.append(key, value);
        }
      }
    });

    const response = await http.request({
      url: `${apiConfig.baseUrl}${apiConfig.endpoints.hotelSearch}?${queryParams}`,
      method: 'GET',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      }
    });

    return response.data;
  };

  const getHotelDetails = async (hotelId) => {
    if (!isSignedIn) throw new Error('User not authenticated');

    const response = await http.request({
      url: `${apiConfig.baseUrl}${apiConfig.endpoints.hotelDetails}/${hotelId}`,
      method: 'GET',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      }
    });

    return response.data;
  };

  const checkAvailability = async (hotelId, availabilityParams) => {
    if (!isSignedIn) throw new Error('User not authenticated');

    const queryParams = new URLSearchParams(availabilityParams);

    const response = await http.request({
      url: `${apiConfig.baseUrl}${apiConfig.endpoints.hotelAvailability.replace('{hotelId}', hotelId)}?${queryParams}`,
      method: 'GET',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      }
    });

    return response.data;
  };

  const createBooking = async (bookingData) => {
    if (!isSignedIn) throw new Error('User not authenticated');

    const response = await http.request({
      url: `${apiConfig.baseUrl}${apiConfig.endpoints.bookings}`,
      method: 'POST',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      data: bookingData
    });

    return response.data;
  };

  const getBookings = async () => {
    if (!isSignedIn) throw new Error('User not authenticated');

    const response = await http.request({
      url: `${apiConfig.baseUrl}${apiConfig.endpoints.bookings}`,
      method: 'GET',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      }
    });

    return response.data;
  };

  const getBookingDetails = async (bookingId) => {
    if (!isSignedIn) throw new Error('User not authenticated');

    const response = await http.request({
      url: `${apiConfig.baseUrl}${apiConfig.endpoints.bookingDetails.replace('{bookingId}', bookingId)}`,
      method: 'GET',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      }
    });

    return response.data;
  };

  const cancelBooking = async (bookingId) => {
    if (!isSignedIn) throw new Error('User not authenticated');

    const response = await http.request({
      url: `${apiConfig.baseUrl}${apiConfig.endpoints.cancelBooking.replace('{bookingId}', bookingId)}`,
      method: 'PUT',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      }
    });

    return response.data;
  };

  // Only call your hotel API profile endpoint, not Asgardeo's SCIM API
  const getHotelApiProfile = async () => {
    if (!isSignedIn) throw new Error('User not authenticated');

    const response = await http.request({
      url: `${apiConfig.baseUrl}${apiConfig.endpoints.profile}`,
      method: 'GET',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      }
    });

    return response.data;
  };

  return {
    searchHotels,
    getHotelDetails,
    checkAvailability,
    createBooking,
    getBookings,
    getBookingDetails,
    cancelBooking,
    getHotelApiProfile // Only hotel API profile, not Asgardeo profile
  };
};