import ballerina/http;
import ballerina/log;

listener http:Listener hotelBookingService = new (port = 9081);

// In-memory data storage
Hotel[] hotels = initializeHotels();
Room[] rooms = initializeRooms();
User[] users = [];
Booking[] bookings = initializeBookings();
final Review[] reviews = initializeReviews();

service / on hotelBookingService {

    // Get Current User Profile (Protected endpoint)
    resource function get auth/profile(http:Request request) returns User|ErrorResponse {
        AuthContext|error authContext = extractAuthContext(request);

        if authContext is error {
            log:printError("Authentication failed", authContext);
            return {
                message: "Authentication required",
                errorCode: "AUTH_REQUIRED",
                timestamp: getCurrentTimestamp()
            };
        }

        User user = findOrCreateUser(users, authContext.userClaims);

        return user;
    }

    // Create Booking
    resource function post bookings(@http:Payload BookingRequest bookingRequest) returns BookingResponse|ErrorResponse {
        // Extract authentication context from gateway headers
        // Validate hotel exists
        Hotel? hotel = findHotelById(hotels, bookingRequest.hotelId);
        if hotel is () {
            return {
                message: "Hotel not found",
                errorCode: "HOTEL_NOT_FOUND",
                timestamp: getCurrentTimestamp()
            };
        }

        BookingPricing[] pricing = [];

        // Validate room exists and is available
        foreach RoomConfiguration roomRequest in bookingRequest.rooms {
            Room? room = findRoomById(rooms, roomRequest.roomId);
            if room is () {
                return {
                    message: "Room not found",
                    errorCode: "ROOM_NOT_FOUND",
                    timestamp: getCurrentTimestamp()
                };
            }
            if room.availableCount < roomRequest.numberOfRooms {
                return {
                    message: "Room not available for the requested dates",
                    errorCode: "ROOM_NOT_AVAILABLE",
                    timestamp: getCurrentTimestamp()
                };
            }

            // Calculate pricing
            pricing.push(calculateBookingPricing(
                    room.pricePerNight,
                    bookingRequest.checkInDate,
                    bookingRequest.checkOutDate,
                    bookingRequest.numberOfRooms
            ));

        }

        // Create booking
        string bookingId = generateBookingId(bookings);
        string confirmationNumber = generateConfirmationNumber();

        Booking newBooking = {
            bookingId: bookingId,
            hotelId: bookingRequest.hotelId,
            rooms: bookingRequest.rooms,
            userId: bookingRequest.userId,
            checkInDate: bookingRequest.checkInDate,
            checkOutDate: bookingRequest.checkOutDate,
            numberOfGuests: bookingRequest.numberOfGuests,
            primaryGuest: bookingRequest.primaryGuest,
            pricing: pricing,
            bookingStatus: "CONFIRMED",
            bookingDate: getCurrentTimestamp(),
            confirmationNumber: confirmationNumber,
            specialRequests: bookingRequest.specialRequests
        };

        bookings.push(newBooking);

        log:printInfo("Booking created for user: " + bookingRequest.userId + ", booking ID: " + bookingId);

        return {
            bookingId: bookingId,
            confirmationNumber: confirmationNumber,
            message: "Booking confirmed successfully",
            bookingDetails: newBooking
        };
    }

    // Get User Bookings (Protected endpoint)
    resource function get bookings(http:Request request) returns Booking[]|ErrorResponse {
        // Extract authentication context from gateway headers
        AuthContext|error authContext = extractAuthContext(request);

        if authContext is error {
            log:printError("Authentication failed", authContext);
            return {
                message: "Authentication required",
                errorCode: "AUTH_REQUIRED",
                timestamp: getCurrentTimestamp()
            };
        }

        AuthContext context = authContext;

        Booking[] userBookings = [];
        foreach Booking booking in bookings {
            if booking.userId == context.userId {
                userBookings.push(booking);
            }
        }

        return userBookings;
    }

    // Get Booking Details (Protected endpoint)
    resource function get bookings/[string bookingId](http:Request request) returns Booking|ErrorResponse {
        // Extract authentication context from gateway headers
        AuthContext|error authContext = extractAuthContext(request);

        if authContext is error {
            log:printError("Authentication failed", authContext);
            return {
                message: "Authentication required",
                errorCode: "AUTH_REQUIRED",
                timestamp: getCurrentTimestamp()
            };
        }

        AuthContext context = authContext;

        foreach Booking booking in bookings {
            if booking.bookingId == bookingId {
                // Check if user owns this booking
                if booking.userId != context.userId {
                    return {
                        message: "Unauthorized access to booking",
                        errorCode: "UNAUTHORIZED",
                        timestamp: getCurrentTimestamp()
                    };
                }
                return booking;
            }
        }

        return {
            message: "Booking not found",
            errorCode: "BOOKING_NOT_FOUND",
            timestamp: getCurrentTimestamp()
        };
    }
}
