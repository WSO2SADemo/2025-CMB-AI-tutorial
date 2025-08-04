import ballerina/ai;

import wso2/agent.bookingApi;
import wso2/agent.hotelSearchApi;

final ai:Wso2ModelProvider _travelPlannerModel = check ai:getDefaultModelProvider();
final ai:Agent _travelPlannerAgent = check new (
    systemPrompt = {
        role: "You are an assistant for planing trip itineraries of a hotel listing company.",
        instructions: string `Your job is to help users to plan their perfect trip, considering their preferences and the available hotels.

Instructions:
- Match hotels nearby attractions with users interests when prioritizing hotels.
- You are free to plan an itinerary with multiple hotels. Make sure to based it off user interests and hotel's nearby attractions.
- Make sure to include the hotel along with things to do for each day in the itinerary.
- Response should be in markdown format. Include the photos of the hotels if available.
`
    }, maxIter = 20, model = _travelPlannerModel, tools = [queryHotelPolicyTool, getPersonalizedProfile, searchHotelsTool, getHotelInfoTool, createBookingTool, checkHotelAvailabilityTool, mcpServer7], verbose = true
);

# Can be used to query about hotel policies.
@ai:AgentTool
@display {label: "", iconPath: ""}
isolated function queryHotelPolicyTool(string question, string hotelId) returns string|error {
    string|error result = queryHotelPolicy(question, hotelId);
    return result;
}

# Always use this to get the personalized profile of the user. This will contains what kind of interests the user has and so on
@ai:AgentTool
@display {label: "", iconPath: ""}
isolated function getPersonalizedProfile(string userId) returns string|error {
    string|error result = getPersonalziedProfile(userId);
    return result;
}

# Use this to search the listed hotels in the system
@ai:AgentTool
@display {label: "", iconPath: "https://bcentral-packageicons.azureedge.net/images/wso2_agent_0.1.0.png"}
isolated function searchHotelsTool(string|() checkInDate, string|() checkOutDate, string|() destination, int guests, decimal|() maxPrice, decimal|() minPrice, decimal|() minRating, int page, int pageSize, int rooms, string|() sortBy) returns hotelSearchApi:HotelSearchResponse|error {
    hotelSearchApi:HotelSearchResponse hotelsearchapiHotelsearchresponse = check hotelsearchapiClient->/hotels/search.get(rooms = rooms, checkOutDate = checkOutDate, minPrice = minPrice, destination = destination, guests = guests, minRating = minRating, pageSize = pageSize, sortBy = sortBy, maxPrice = maxPrice, page = page, checkInDate = checkInDate);
    return hotelsearchapiHotelsearchresponse;
}

# Use this tool to get full information about a specific hotel
@ai:AgentTool
@display {label: "", iconPath: "https://bcentral-packageicons.azureedge.net/images/wso2_agent_0.1.0.png"}
isolated function getHotelInfoTool(string hotelId) returns hotelSearchApi:HotelDetailsResponse|error {
    hotelSearchApi:HotelDetailsResponse hotelsearchapiHoteldetailsresponse = check hotelsearchapiClient->/hotels/[hotelId].get();
    return hotelsearchapiHoteldetailsresponse;
}

# Use this tool to create a booking
@ai:AgentTool
@display {label: "", iconPath: "https://bcentral-packageicons.azureedge.net/images/wso2_agent_0.1.0.png"}
isolated function createBookingTool(bookingApi:BookingRequest payload) returns bookingApi:BookingResponse|bookingApi:ErrorResponse|error {
    bookingApi:BookingResponse|bookingApi:ErrorResponse bookingapiBookingresponseBookingapiErrorresponse = check bookingapiClient->/bookings.post(payload);
    return bookingapiBookingresponseBookingapiErrorresponse;
}

# Always use this tool before suggesting a hotel to make sure the hotel is avaialable. 
@ai:AgentTool
@display {label: "", iconPath: "https://bcentral-packageicons.azureedge.net/images/wso2_agent_0.1.0.png"}
isolated function checkHotelAvailabilityTool(string checkInDate, string checkOutDate, int guests, string hotelId, int roomCount) returns hotelSearchApi:AvailabilityResponse|error {
    hotelSearchApi:AvailabilityResponse hotelsearchapiAvailabilityresponse = check hotelsearchapiClient->/hotels/[hotelId]/availability.get(roomCount = roomCount, checkOutDate = checkOutDate, guests = guests, checkInDate = checkInDate);
    return hotelsearchapiAvailabilityresponse;
}

final ai:McpToolKit mcpServer7 = check new ("http://localhost:3001/stream", ["get-weather-forecast"], httpVersion = "1.1", info = {
    name: "",
    version: ""
});
