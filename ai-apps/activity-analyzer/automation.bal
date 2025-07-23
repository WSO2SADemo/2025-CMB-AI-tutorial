import activity_analyzer.hotel_admin_api;
import activity_analyzer.hotel_api;

import ballerina/log;
import ballerina/sql;
import ballerinax/ai;

public function main(string userId) returns error? {
    do {
        hotel_admin_api:Booking[] userBookings = check hotelAdminApiClient->/user/bookings/[userId].get();

        BookingDetails bookingDetails = [];

        foreach hotel_admin_api:Booking booking in userBookings {
            hotel_api:HotelDetailsResponse|hotel_api:ErrorResponse hotelDetails = check hotelApiClient->/hotels/[booking.hotelId].get();
            if hotelDetails is hotel_api:ErrorResponse {
                continue;
            }
            BookingDetailsItem bookingDetail = bookingMap(booking, hotelDetails);
            bookingDetails.push(bookingDetail);
        }

        ReviewDetails reviewDetails = [];

        hotel_admin_api:Review[] userReviews = check hotelAdminApiClient->/user/reviews/[userId].get();
        foreach hotel_admin_api:Review review in userReviews {
            ReviewDetailsItem reviewDetail = reviewMap(review);
            reviewDetails.push(reviewDetail);
        }

        UserActivity activities = {
            bookingDetails: bookingDetails,
            reviewDetails: reviewDetails
        };

        string systemPrompt = string `You are a user activity analyzer to extract information that is useful to help them during trip planning.

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

Output everything in a structured Markdown format. If any category has no clear insight, write Not enough data to determine.`;

        string userPrompt = string `Analyze these hotel activities: 
${activities.toString()}`;
        ai:ChatAssistantMessage chatResponse = check aiOpenaiprovider->chat([
            {
                role: "system",
                content: systemPrompt
            },
            {
                role: "user",
                content: userPrompt
            }
        ], []);

        log:printInfo(string `Analysis results: ${chatResponse.content ?: "Empty response"}`);

        sql:ExecutionResult sqlExecutionresult = check postgresqlClient->execute(`INSERT INTO user_activities (user_id, activity_analysis)
VALUES (${userId}, ${chatResponse.content})
ON CONFLICT (user_id) DO UPDATE
SET activity_analysis = EXCLUDED.activity_analysis;`);

    } on fail error e {
        log:printError("Error occurred", 'error = e);
        return e;
    }
}
