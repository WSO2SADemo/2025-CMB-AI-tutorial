import { useMemo, useCallback } from 'react';
import apiConfig from '../config/api';

export const useBookingService = () => {
  const makeRequest = useCallback(async (url, options = {}) => {
    const response = await fetch(url, {
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        ...options.headers
      },
      ...options
    });

    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }

    return await response.json();
  }, []);

  const createBooking = useCallback(async (bookingData) => {
    return await makeRequest(`${apiConfig.bookingApiUrl}${apiConfig.bookingEndpoints.bookings}`, {
      method: 'POST',
      body: JSON.stringify(bookingData)
    });
  }, [makeRequest]);

  const getBookings = useCallback(async (userId) => {
    if (!userId) throw new Error('User ID is required');

    return await makeRequest(`${apiConfig.bookingApiUrl}${apiConfig.bookingEndpoints.bookings}?userId=${userId}`);
  }, [makeRequest]);

  const getBookingDetails = useCallback(async (bookingId) => {
    return await makeRequest(`${apiConfig.bookingApiUrl}${apiConfig.bookingEndpoints.bookingDetails.replace('{bookingId}', bookingId)}`);
  }, [makeRequest]);

  const cancelBooking = useCallback(async (bookingId) => {
    return await makeRequest(`${apiConfig.bookingApiUrl}${apiConfig.bookingEndpoints.cancelBooking.replace('{bookingId}', bookingId)}`, {
      method: 'PUT'
    });
  }, [makeRequest]);

  const deleteAllBookings = useCallback(async (userId) => {
    if (!userId) throw new Error('User ID is required');

    return await makeRequest(`${apiConfig.bookingApiUrl}${apiConfig.bookingEndpoints.bookings}?userId=${userId}`, {
      method: 'DELETE'
    });
  }, [makeRequest]);

  const getBookingApiProfile = useCallback(async () => {
    return await makeRequest(`${apiConfig.bookingApiUrl}${apiConfig.bookingEndpoints.profile}`);
  }, [makeRequest]);

  return useMemo(() => ({
    createBooking,
    getBookings,
    getBookingDetails,
    cancelBooking,
    deleteAllBookings,
    getBookingApiProfile
  }), [createBooking, getBookings, getBookingDetails, cancelBooking, deleteAllBookings, getBookingApiProfile]);
};