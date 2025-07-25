import ballerina/http;

listener http:Listener hotelSearchService = new (port = 9090);

// In-memory data storage
Hotel[] hotels = initializeHotels();
Room[] rooms = initializeRooms();
User[] users = [];
Booking[] bookings = initializeBookings();
final Review[] reviews = initializeReviews();

service / on hotelSearchService {

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
}
