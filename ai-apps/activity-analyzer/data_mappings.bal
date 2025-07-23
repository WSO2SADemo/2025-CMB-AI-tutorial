import activity_analyzer.hotel_admin_api;
import activity_analyzer.hotel_api;

function bookingMap(hotel_admin_api:Booking booking, hotel_api:HotelDetailsResponse hotel) returns BookingDetailsItem => {
    hotelId: booking.hotelId,
    hotelName: hotel.hotel.hotelName,
    hotelDescription: hotel.hotel.description,
    hotelCity: hotel.hotel.city,
    hotelCountry: hotel.hotel.country,
    hotelAmenities: hotel.hotel.amenities,
    hotelType: hotel.hotel.propertyType,
    roomDetails: from var roomsItem in hotel.rooms
        select {
            roomName: roomsItem.roomId,
            roomDescription: roomsItem.description,
            roomAminities: roomsItem.amenities
        },
    noOfGuests: (booking.numberOfGuests).toString(),
    checkInDate: booking.checkInDate,
    specialRequirements: booking.specialRequests.toString(),
    nearByAttractions: hotel.nearbyAttractions.toString(),
    recentReviews: hotel.recentReviews.toString()
};

function reviewMap(hotel_admin_api:Review review) returns ReviewDetailsItem => {
    hotelId: review.hotelId,
    comment: review.comment,
    rating: review.rating
};
