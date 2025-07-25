import ballerina/http;
import ballerina/jwt;
import ballerina/uuid;

// Authentication Helper Functions
public isolated function extractAuthContext(http:Request request) returns AuthContext|error {
    // Extract JWT token from x-assertion-header
    string|error assertionHeader = request.getHeader("x-jwt-assertion");

    if assertionHeader is error {
        return error("Missing x-jwt-assertion");
    }

    [jwt:Header, jwt:Payload] [header, payload] = check jwt:decode(assertionHeader);

    string? sub = payload.sub;
    if sub is () {
        return error("Missing sub in x-jwt-assertion");
    }

    UserClaims userClaims = {
        sub,
        email: payload.get("email").toString(),
        given_name: payload.get("given_name").toString(),
        family_name: payload.get("family_name").toString(),
        preferred_username: payload.get("preferred_username").toString()
    };

    return {
        userId: sub,
        userClaims
    };
}

public function createUserFromClaims(UserClaims claims) returns User {
    return {
        userId: claims.sub,
        email: claims.email,
        firstName: claims.given_name,
        lastName: claims.family_name,
        phoneNumber: claims.phone_number,
        profilePicture: claims.picture,
        registrationDate: getCurrentTimestamp(),
        userType: determineUserType(claims),
        authClaims: claims
    };
}

public function determineUserType(UserClaims claims) returns string {
    // Check if user has premium role or is in premium group
    if claims.roles is string[] {
        string[] roles = claims.roles ?: [];
        foreach string role in roles {
            if role.toLowerAscii().includes("premium") || role.toLowerAscii().includes("vip") {
                return "PREMIUM";
            }
        }
    }

    if claims.groups is string[] {
        string[] groups = claims.groups ?: [];
        foreach string group in groups {
            if group.toLowerAscii().includes("premium") || group.toLowerAscii().includes("vip") {
                return "PREMIUM";
            }
        }
    }

    return "GUEST";
}

public isolated function getCurrentTimestamp() returns string {
    return "2024-01-15T10:30:00Z"; // Simplified timestamp
}

// Hotel Search Functions
public function searchHotels(Hotel[] hotels, HotelSearchRequest searchRequest) returns Hotel[] {
    Hotel[] filteredHotels = hotels;

    // Filter by destination
    string? reqDestination = searchRequest.destination;
    if reqDestination is string {
        string destination = reqDestination;
        Hotel[] destinationFiltered = [];
        foreach Hotel hotel in filteredHotels {
            if hotel.city.toLowerAscii().includes(destination.toLowerAscii()) ||
                hotel.country.toLowerAscii().includes(destination.toLowerAscii()) {
                destinationFiltered.push(hotel);
            }
        }
        filteredHotels = destinationFiltered;
    }

    // Filter by price range
    if searchRequest.minPrice is decimal || searchRequest.maxPrice is decimal {
        Hotel[] priceFiltered = [];
        foreach Hotel hotel in filteredHotels {
            boolean includeHotel = true;
            if searchRequest.minPrice is decimal && hotel.lowestPrice < searchRequest.minPrice {
                includeHotel = false;
            }
            if searchRequest.maxPrice is decimal && hotel.lowestPrice > searchRequest.maxPrice {
                includeHotel = false;
            }
            if includeHotel {
                priceFiltered.push(hotel);
            }
        }
        filteredHotels = priceFiltered;
    }

    // Filter by rating
    decimal? reqMinRating = searchRequest.minRating;
    if reqMinRating is decimal {
        decimal minRating = reqMinRating;
        Hotel[] ratingFiltered = [];
        foreach Hotel hotel in filteredHotels {
            if hotel.rating >= minRating {
                ratingFiltered.push(hotel);
            }
        }
        filteredHotels = ratingFiltered;
    }

    // Filter by amenities
    string[]? reqAmenities = searchRequest.amenities;
    if reqAmenities is string[] {
        string[] requiredAmenities = reqAmenities;
        Hotel[] amenityFiltered = [];
        foreach Hotel hotel in filteredHotels {
            boolean hasAllAmenities = true;
            foreach string amenity in requiredAmenities {
                boolean hasAmenity = false;
                foreach string hotelAmenity in hotel.amenities {
                    if hotelAmenity.toLowerAscii().includes(amenity.toLowerAscii()) {
                        hasAmenity = true;
                        break;
                    }
                }
                if !hasAmenity {
                    hasAllAmenities = false;
                    break;
                }
            }
            if hasAllAmenities {
                amenityFiltered.push(hotel);
            }
        }
        filteredHotels = amenityFiltered;
    }

    // Sort results
    string? reqSortBy = searchRequest.sortBy;
    if reqSortBy is string {
        string sortBy = reqSortBy;
        if sortBy == "price_low" {
            filteredHotels = sortHotelsByPrice(filteredHotels, true);
        } else if sortBy == "price_high" {
            filteredHotels = sortHotelsByPrice(filteredHotels, false);
        } else if sortBy == "rating" {
            filteredHotels = sortHotelsByRating(filteredHotels);
        }
    }

    return filteredHotels;
}

public function sortHotelsByPrice(Hotel[] hotels, boolean 'ascending) returns Hotel[] {
    Hotel[] sortedHotels = hotels.clone();
    int n = sortedHotels.length();
    foreach int i in 0 ..< n - 1 {
        foreach int j in 0 ..< n - i - 1 {
            boolean shouldSwap = 'ascending ?
                sortedHotels[j].lowestPrice > sortedHotels[j + 1].lowestPrice :
                sortedHotels[j].lowestPrice < sortedHotels[j + 1].lowestPrice;
            if shouldSwap {
                Hotel temp = sortedHotels[j];
                sortedHotels[j] = sortedHotels[j + 1];
                sortedHotels[j + 1] = temp;
            }
        }
    }
    return sortedHotels;
}

public function sortHotelsByRating(Hotel[] hotels) returns Hotel[] {
    Hotel[] sortedHotels = hotels.clone();
    int n = sortedHotels.length();
    foreach int i in 0 ..< n - 1 {
        foreach int j in 0 ..< n - i - 1 {
            if sortedHotels[j].rating < sortedHotels[j + 1].rating {
                Hotel temp = sortedHotels[j];
                sortedHotels[j] = sortedHotels[j + 1];
                sortedHotels[j + 1] = temp;
            }
        }
    }
    return sortedHotels;
}

public function paginateResults(Hotel[] hotels, int page, int pageSize) returns Hotel[] {
    int startIndex = (page - 1) * pageSize;
    int endIndex = startIndex + pageSize;

    if startIndex >= hotels.length() {
        return [];
    }

    if endIndex > hotels.length() {
        endIndex = hotels.length();
    }

    Hotel[] paginatedHotels = [];
    foreach int i in startIndex ..< endIndex {
        paginatedHotels.push(hotels[i]);
    }

    return paginatedHotels;
}

// Hotel and Room Helper Functions
public function findHotelById(Hotel[] hotels, string hotelId) returns Hotel? {
    foreach Hotel hotel in hotels {
        if hotel.hotelId == hotelId {
            return hotel;
        }
    }
    return ();
}

public function findRoomById(Room[] rooms, string roomId) returns Room? {
    foreach Room room in rooms {
        if room.roomId == roomId {
            return room;
        }
    }
    return ();
}

public function getAvailableRooms(Room[] rooms, string hotelId) returns Room[] {
    Room[] availableRooms = [];
    foreach Room room in rooms {
        if room.hotelId == hotelId && room.availableCount > 0 {
            availableRooms.push(room);
        }
    }
    return availableRooms;
}

// Booking Helper Functions
public function generateBookingId(Booking[] bookings) returns string {
    return "BK" + (bookings.length() + 1).toString().padStart(6, "0");
}

public function generateConfirmationNumber() returns string {
    return "CONF" + uuid:createRandomUuid();
}

public function calculateBookingPricing(decimal roomRate, string checkInDate, string checkOutDate, int numberOfRooms) returns BookingPricing {
    // Simplified calculation - in real implementation, would parse dates properly
    int numberOfNights = 3; // Simplified
    decimal subtotal = roomRate * numberOfNights * numberOfRooms;
    decimal taxes = subtotal * 0.12; // 12% tax
    decimal serviceFees = subtotal * 0.05; // 5% service fee
    decimal totalAmount = subtotal + taxes + serviceFees;

    return {
        roomRate: roomRate,
        numberOfNights: numberOfNights,
        subtotal: subtotal,
        taxes: taxes,
        serviceFees: serviceFees,
        totalAmount: totalAmount,
        currency: "USD"
    };
}

// Review Helper Functions
public function getHotelReviews(Review[] reviews, string hotelId) returns Review[] {
    Review[] hotelReviews = [];
    foreach Review review in reviews {
        if review.hotelId == hotelId {
            hotelReviews.push(review);
        }
    }
    return hotelReviews;
}

public function generateReviewId(Review[] reviews) returns string {
    return "REV" + (reviews.length() + 1).toString().padStart(3, "0");
}

// User Management Functions
public function findOrCreateUser(User[] users, UserClaims claims) returns User {
    // Try to find existing user
    foreach User user in users {
        if user.userId == claims.sub {
            // Update user with latest claims
            User updatedUser = {
                userId: user.userId,
                email: claims.email,
                firstName: claims.given_name,
                lastName: claims.family_name,
                phoneNumber: claims.phone_number,
                profilePicture: claims.picture,
                registrationDate: user.registrationDate,
                userType: determineUserType(claims),
                authClaims: claims
            };
            return updatedUser;
        }
    }

    // Create new user if not found
    User newUser = createUserFromClaims(claims);
    users.push(newUser);
    return newUser;
}
