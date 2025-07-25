import ballerina/http;
import ballerina/log;

listener http:Listener hotelBookingService = new (port = 8081);

// In-memory data storage
Hotel[] hotels = initializeHotels();
Room[] rooms = initializeRooms();
User[] users = [];
Booking[] bookings = initializeBookings();
final Review[] reviews = initializeReviews();

@http:ServiceConfig {
    cors: {
        allowOrigins: ["http://localhost:3000"], // Specify exact origin instead of "*"
        allowMethods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"],
        allowHeaders: ["Content-Type", "Authorization", "Accept"],
        allowCredentials: true, // This is the key missing configuration
        maxAge: 84900
    }
}
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

    // Search Hotels (Public endpoint)
    resource function get hotels/search(string? destination, string? checkInDate, string? checkOutDate,
            int guests = 2, int rooms = 1, decimal? minPrice = (), decimal? maxPrice = (),
            decimal? minRating = (), string[]? amenities = (), string[]? propertyTypes = (),
            string? sortBy = (), int page = 1, int pageSize = 10) returns HotelSearchResponse {

        HotelSearchRequest searchRequest = {
            destination: destination,
            checkInDate: checkInDate,
            checkOutDate: checkOutDate,
            guests: guests,
            rooms: rooms,
            minPrice: minPrice,
            maxPrice: maxPrice,
            minRating: minRating,
            amenities: amenities,
            propertyTypes: propertyTypes,
            sortBy: sortBy,
            page: page,
            pageSize: pageSize
        };

        Hotel[] filteredHotels = searchHotels(hotels, searchRequest);
        Hotel[] paginatedHotels = paginateResults(filteredHotels, page, pageSize);

        int totalPages = (filteredHotels.length() + pageSize - 1) / pageSize;

        SearchFilters appliedFilters = {
            destination: destination,
            checkInDate: checkInDate,
            checkOutDate: checkOutDate,
            guests: guests,
            rooms: rooms,
            priceRange: minPrice is decimal || maxPrice is decimal ?
                {min: minPrice ?: 0.0, max: maxPrice ?: 999999.0} : (),
            minRating: minRating,
            amenities: amenities,
            propertyTypes: propertyTypes
        };

        SearchMetadata metadata = {
            totalResults: filteredHotels.length(),
            currentPage: page,
            totalPages: totalPages,
            pageSize: pageSize,
            appliedFilters: appliedFilters
        };

        return {
            hotels: paginatedHotels,
            metadata: metadata
        };
    }

    // Get Hotel Details (Public endpoint)
    resource function get hotels/[string hotelId]() returns HotelDetailsResponse|ErrorResponse {
        Hotel? hotel = findHotelById(hotels, hotelId);
        if hotel is () {
            return {
                message: "Hotel not found",
                errorCode: "HOTEL_NOT_FOUND",
                timestamp: getCurrentTimestamp()
            };
        }

        Room[] hotelRooms = getAvailableRooms(rooms, hotelId);
        Review[] hotelReviews = getHotelReviews(reviews, hotelId);

        NearbyAttractions[] nearbyAttractions = [
            {name: "Central Park", category: "Park", distance: 0.5, unit: "km"},
            {name: "Museum of Modern Art", category: "Museum", distance: 1.2, unit: "km"},
            {name: "Times Square", category: "Entertainment", distance: 2.1, unit: "km"}
        ];

        return {
            hotel: hotel,
            rooms: hotelRooms,
            recentReviews: hotelReviews,
            nearbyAttractions: nearbyAttractions
        };
    }

    // Check Room Availability (Public endpoint)
    resource function get hotels/[string hotelId]/availability(string checkInDate, string checkOutDate,
            int guests = 2, int roomCount = 1) returns AvailabilityResponse|ErrorResponse {
        Hotel? hotel = findHotelById(hotels, hotelId);
        if hotel is () {
            return {
                message: "Hotel not found",
                errorCode: "HOTEL_NOT_FOUND",
                timestamp: getCurrentTimestamp()
            };
        }

        Room[] availableRooms = getAvailableRooms(rooms, hotelId);

        return {
            hotelId: hotelId,
            checkInDate: checkInDate,
            checkOutDate: checkOutDate,
            availableRooms: availableRooms,
            totalAvailable: availableRooms.length()
        };
    }

    // Create Booking (Protected endpoint)
    resource function post bookings(http:Request request, @http:Payload BookingRequest bookingRequest) returns BookingResponse|ErrorResponse {
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

        User user = findOrCreateUser(users, authContext.userClaims);

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
            userId: user.userId,
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

        // Update room availability
        foreach int i in 0 ..< rooms.length() {
            foreach RoomConfiguration roomRequest in bookingRequest.rooms {
                if rooms[i].roomId == roomRequest.roomId && rooms[i].availableCount >= roomRequest.numberOfRooms {
                    rooms[i] = {
                        roomId: rooms[i].roomId,
                        hotelId: rooms[i].hotelId,
                        roomType: rooms[i].roomType,
                        roomName: rooms[i].roomName,
                        description: rooms[i].description,
                        maxOccupancy: rooms[i].maxOccupancy,
                        pricePerNight: rooms[i].pricePerNight,
                        images: rooms[i].images,
                        amenities: rooms[i].amenities,
                        bedConfiguration: rooms[i].bedConfiguration,
                        roomSize: rooms[i].roomSize,
                        availableCount: rooms[i].availableCount - bookingRequest.numberOfRooms
                    };
                    break;
                } else {
                    return {
                        message: "Insufficient room availability",
                        errorCode: "INSUFFICIENT_ROOM_AVAILABILITY",
                        timestamp: getCurrentTimestamp()
                    };
                }
            }
        }
        log:printInfo("Booking created for user: " + user.userId + ", booking ID: " + bookingId);

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
