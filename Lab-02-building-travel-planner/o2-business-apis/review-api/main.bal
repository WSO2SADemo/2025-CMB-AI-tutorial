import ballerina/http;
import ballerina/log;

listener http:Listener hotelReviewService = new (port = 9082);

// In-memory data storage
Hotel[] hotels = initializeHotels();
Room[] rooms = initializeRooms();
User[] users = [];
Booking[] bookings = initializeBookings();
final Review[] reviews = initializeReviews();

service / on hotelReviewService {

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

    // Add Hotel Review (Protected endpoint)
    resource function post hotels/[string hotelId]/reviews(http:Request request, @http:Payload ReviewRequest reviewRequest) returns SuccessResponse|ErrorResponse {
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
        User user = findOrCreateUser(users, context.userClaims);

        Hotel? hotel = findHotelById(hotels, hotelId);
        if hotel is () {
            return {
                message: "Hotel not found",
                errorCode: "HOTEL_NOT_FOUND",
                timestamp: getCurrentTimestamp()
            };
        }

        Review newReview = {
            reviewId: generateReviewId(reviews),
            hotelId: hotelId,
            userId: user.userId,
            userName: user.firstName + " " + user.lastName.substring(0, 1) + ".",
            rating: reviewRequest.rating,
            title: reviewRequest.title,
            comment: reviewRequest.comment,
            reviewDate: getCurrentTimestamp(),
            categories: reviewRequest.categories,
            isVerifiedStay: true
        };

        reviews.push(newReview);

        log:printInfo("Review added for hotel: " + hotelId + " by user: " + user.userId);

        return {
            message: "Review added successfully",
            timestamp: getCurrentTimestamp()
        };
    }

    // Get Hotel Reviews (Public endpoint)
    resource function get hotels/[string hotelId]/reviews() returns Review[]|ErrorResponse {
        Hotel? hotel = findHotelById(hotels, hotelId);
        if hotel is () {
            return {
                message: "Hotel not found",
                errorCode: "HOTEL_NOT_FOUND",
                timestamp: getCurrentTimestamp()
            };
        }

        return getHotelReviews(reviews, hotelId);
    }

    // Get User Reviews (Protected endpoint)
    resource function get reviews(http:Request request) returns Review[]|ErrorResponse {
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

        Review[] filteredReviews = [];
        foreach Review review in reviews {
            if review.userId == context.userId {
                filteredReviews.push(review);
            }
        }
        return filteredReviews;
    }

}
