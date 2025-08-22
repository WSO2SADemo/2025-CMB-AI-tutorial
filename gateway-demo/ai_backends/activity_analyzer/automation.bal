import activity_analyzer.adminApi;
import activity_analyzer.hotelSearchApi;

import ballerina/log;
import ballerina/sql;

public function main() returns error? {
    do {
        // Create UserActivity based on user's previous bookings and reviews
        UserActivity userActivity = check createUserActivity(userId);

        log:printInfo("Successfully created UserActivity", userActivity = userActivity);
        string llmResponse = check aiWso2modelprovider->generate(`You are a user activity analyzer to extract information that is useful to help them during trip planning.

You are given a UserActivity object, which contains a user’s past hotel bookings (BookingDetails) and reviews (ReviewDetails). Your task is to analyze the data to extract explicit preferences, inferred behaviors, and sentiment-driven insights. Go beyond summarization — find behavioral patterns, inconsistencies, and personas supported by evidence.

### Output Format:
Structure the response into the following named sections:

1. Hotel Type Preferences
List preferred hotel types (e.g., Boutique, Resort, Business) with justification based on frequency in hotelType.

2. Amenity Preferences
List top hotel and room amenities consistently booked (e.g., "Pool", "Wi-Fi", "Balcony") based on hotelAmenities and roomAmenities.

3. Location & Climate Preferences
Identify most common cities/countries. Infer climate preferences (e.g., warm coastal areas, urban cities, mountains) based on booking locations. Explain assumptions if any.

4. Travel Purpose Patterns
Infer likely purposes (e.g., business, leisure, honeymoon, family trip) from specialRequirements and travel context.

5. Group Size & Guest Trends
Note common noOfGuests patterns — solo, couple, group, family. Highlight variations.

6. Attraction Preferences
Extract recurring types of nearByAttractions — nature, culture, urban, adventure, etc.

7. Review Sentiment Themes
List common positive themes and negative themes from reviewDetails.comment.
For each theme, mention example phrases or paraphrased evidence.

8. Rating Behavior / Tolerance
Analyze if user tends to be lenient (high ratings despite issues) or critical (low ratings for minor flaws).

9. Booking vs. Review Alignment
Highlight contradictions or consistencies between what was booked and how it was reviewed.

10. User Persona Summary
Provide a concise paragraph summarizing the user’s travel persona, such as:
“This user is a nature-loving couple traveler who prefers beachfront resorts with spas and values peace and cleanliness.”

11. Predictive Preferences
Suggest the types of hotels, destinations, or amenities the user is most likely to prefer in future bookings.

### Guidelines:

- Use reasoning — don’t just repeat data.
- Infer patterns only when evidence is clear (e.g., same hotel type appears in 3+ bookings).
- Justify conclusions briefly where needed.
- Keep the tone analytical and objective, not conversational.

Output everything in a structured Markdown format. If any category has no clear insight, write Not enough data to determine.

Analyze these hotel activities:
${userActivity}
`);
        sql:ExecutionResult sqlExecutionresult = check postgresqlClient->execute(`INSERT INTO user_activities (user_id, activity_analysis)
VALUES (${userId}, ${llmResponse})
ON CONFLICT (user_id) DO UPDATE
SET activity_analysis = EXCLUDED.activity_analysis;
`);

    } on fail error e {
        log:printError("Error occurred", 'error = e);
        return e;
    }
}

function createUserActivity(string userId) returns UserActivity|error {
    // Fetch user bookings and reviews
    adminApi:Booking[] bookings = check adminapiClient->/user/bookings/[userId];
    adminApi:Review[] reviews = check adminapiClient->/user/reviews/[userId];

    // Process bookings to create detailed booking information
    BookingDetails bookingDetails = check processBookings(bookings);

    // Process reviews to create review details
    ReviewDetails reviewDetails = processReviews(reviews);

    // Create and return UserActivity
    UserActivity userActivity = {
        bookingDetails: bookingDetails,
        reviewDetails: reviewDetails
    };

    return userActivity;
}

function processBookings(adminApi:Booking[] bookings) returns BookingDetails|error {
    BookingDetails bookingDetails = [];

    foreach adminApi:Booking booking in bookings {
        // Fetch hotel details
        hotelSearchApi:HotelDetailsResponse hotelDetailsResponse = check hotelsearchapiClient->/hotels/[booking.hotelId];
        hotelSearchApi:Hotel hotel = hotelDetailsResponse.hotel;

        // Fetch nearby attractions
        hotelSearchApi:NearbyAttractionsResponse attractionsResponse = check hotelsearchapiClient->/hotels/[booking.hotelId]/attractions;

        // Process room details
        RoomDetails roomDetails = processRoomDetails(hotelDetailsResponse.rooms, booking.rooms);

        // Create booking details item
        BookingDetailsItem bookingItem = {
            hotelId: booking.hotelId,
            hotelName: hotel.hotelName,
            hotelDescription: hotel.description,
            hotelType: hotel.propertyType,
            hotelAmenities: hotel.amenities,
            hotelCity: hotel.city,
            hotelCountry: hotel.country,
            roomDetails: roomDetails,
            noOfGuests: booking.numberOfGuests.toString(),
            checkInDate: booking.checkInDate,
            specialRequirements: processSpecialRequirements(booking.specialRequests),
            nearByAttractions: processNearbyAttractions(attractionsResponse.attractions),
            recentReviews: processRecentReviews(hotelDetailsResponse.recentReviews)
        };

        bookingDetails.push(bookingItem);
    }

    return bookingDetails;
}

function processRoomDetails(hotelSearchApi:Room[] availableRooms, adminApi:RoomConfiguration[] bookedRooms) returns RoomDetails {
    RoomDetails roomDetails = [];

    foreach adminApi:RoomConfiguration bookedRoom in bookedRooms {
        // Find matching room from available rooms
        foreach hotelSearchApi:Room room in availableRooms {
            if room.roomId == bookedRoom.roomId {
                RoomDetailsItem roomItem = {
                    roomName: room.roomName,
                    roomDescription: room.description,
                    roomAminities: room.amenities
                };
                roomDetails.push(roomItem);
                break;
            }
        }
    }

    return roomDetails;
}

function processReviews(adminApi:Review[] reviews) returns ReviewDetails {
    ReviewDetails reviewDetails = [];

    foreach adminApi:Review review in reviews {
        ReviewDetailsItem reviewItem = {
            hotelId: review.hotelId,
            comment: review.comment,
            rating: review.rating
        };
        reviewDetails.push(reviewItem);
    }

    return reviewDetails;
}

function processSpecialRequirements(adminApi:SpecialRequests? specialRequests) returns string {
    if specialRequests is () {
        return "";
    }

    string[] requirements = [];

    string? dietaryRequirements = specialRequests.dietaryRequirements;
    if dietaryRequirements is string {
        requirements.push("Dietary: " + dietaryRequirements);
    }

    string? accessibilityNeeds = specialRequests.accessibilityNeeds;
    if accessibilityNeeds is string {
        requirements.push("Accessibility: " + accessibilityNeeds);
    }

    string? bedPreference = specialRequests.bedPreference;
    if bedPreference is string {
        requirements.push("Bed: " + bedPreference);
    }

    string? otherRequests = specialRequests.otherRequests;
    if otherRequests is string {
        requirements.push("Other: " + otherRequests);
    }

    boolean? petFriendly = specialRequests.petFriendly;
    if petFriendly is boolean && petFriendly {
        requirements.push("Pet-friendly required");
    }

    return string:'join(", ", ...requirements);
}

function processNearbyAttractions(hotelSearchApi:NearbyAttractions[] attractions) returns string {
    string[] attractionNames = [];

    foreach hotelSearchApi:NearbyAttractions attraction in attractions {
        string attractionInfo = attraction.name + " (" + attraction.distance.toString() + "km)";
        attractionNames.push(attractionInfo);
    }

    return string:'join(", ", ...attractionNames);
}

function processRecentReviews(hotelSearchApi:Review[] recentReviews) returns string {
    string[] reviewSummaries = [];

    foreach hotelSearchApi:Review review in recentReviews {
        string reviewSummary = review.userName + ": " + review.rating.toString() + "/5 - " + review.comment;
        reviewSummaries.push(reviewSummary);
    }

    return string:'join(" | ", ...reviewSummaries);
}