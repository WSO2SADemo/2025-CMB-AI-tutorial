import ballerina/http;

// In-memory data storage
Hotel[] hotels = initializeHotels();
Room[] rooms = initializeRooms();
User[] users = [];
Booking[] bookings = initializeBookings();
final Review[] reviews = initializeReviews();

listener http:Listener hotelAdminService = new (port = 9090);

service / on hotelAdminService {

    // Get User Reviews (Internal endpoint)
    resource function get user/reviews/[string userId]() returns Review[] {
        // Extract authentication context from gateway headers
        Review[] filteredReviews = [];
        foreach Review review in reviews {
            if review.userId == userId {
                filteredReviews.push(review);
            }
        }
        return filteredReviews;
    }

    // Get User booking data (Internal endpoint)
    resource function get user/bookings/[string userId]() returns Booking[] {
        // Extract authentication context from gateway headers
        Booking[] filteredBookings = [];
        foreach Booking booking in bookings {
            if booking.userId == userId {
                filteredBookings.push(booking);
            }
        }
        return filteredBookings;
    }

}
