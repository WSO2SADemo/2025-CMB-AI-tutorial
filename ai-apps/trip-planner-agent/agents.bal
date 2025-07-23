import trip_planner_agent.hotel_api;

import ballerina/time;
import ballerinax/ai;
import ballerinax/openweathermap;

final ai:OpenAiProvider _TravelPlannerModel = check new (openAiKey, ai:GPT_4O);
final ai:Agent _TravelPlannerAgent = check new (
    systemPrompt = {
        role: "You are a assistant for travel planing",
        instructions: string `Your job is to help users to plan their perfect trip, considering their preferences.

Instructions:
- Make sure that you plan to trip such that, we have hotels closer to provide accomadations. 

User Name: ${"John Smith"}
User ID: ${"asgardeo_user_123"}
UTC Time now: ${time:utcNow().toString()}`
    }, model = _TravelPlannerModel, tools = [searchHotel, getHotelInfo, getWeatherData, getUserActivityAnalysis], verbose = true
);

# Can be used to search hotels using different filters such as amenities, destination, availablity, price range etc. Returns a paginated response, so will have to use multiple times if results are paginated. 
@ai:AgentTool
@display {label: "", iconPath: "https://bcentral-packageicons.azureedge.net/images/nadheesh_ai_demo_0.1.0.png"}
isolated function searchHotel(string? destination, string? checkInDate, string? checkOutDate, int guests, int rooms, decimal? minPrice, decimal? maxPrice, decimal? minRating, string[]? amenities, string[]? propertyTypes, string? sortBy, int page, int pageSize) returns hotel_api:HotelSearchResponse|hotel_api:ErrorResponse|error {
    hotel_api:HotelSearchResponse searchResult = check hotelApiClient->/hotels/search.get(queries =
        {
        destination,
        checkInDate,
        checkOutDate,
        guests,
        rooms,
        minPrice,
        maxPrice,
        minRating,
        amenities,
        propertyTypes,
        sortBy,
        page,
        pageSize
    });

    return searchResult;
}

# Can be used to get information about specific hotel including nearby locations, recent reviews recieved etc. Very useful to find nearby locations.
@ai:AgentTool
@display {label: "", iconPath: "https://bcentral-packageicons.azureedge.net/images/nadheesh_ai_demo_0.1.0.png"}
isolated function getHotelInfo(string hotelId) returns hotel_api:HotelDetailsResponse|hotel_api:ErrorResponse|error {
    hotel_api:HotelDetailsResponse|hotel_api:ErrorResponse hotelApiHoteldetailsresponseHotelApiErrorresponse = check hotelApiClient->/hotels/[hotelId].get();
    return hotelApiHoteldetailsresponseHotelApiErrorresponse;
}

# Can be used to find weather data. q - City name, or city name and country code. For the query value, type the city name and optionally the country code divided by comma; use ISO 3166 country codes. id - City ID. Example: `2172797`. The List of city
# + return - Current weather data of the given location 
@ai:AgentTool
@display {label: "", iconPath: "https://bcentral-packageicons.azureedge.net/images/ballerinax_openweathermap_1.5.1.png"}
isolated function getWeatherData(string? q, string? id, string? lat, string? lon, string? zip) returns openweathermap:CurrentWeatherData|error {
    openweathermap:CurrentWeatherData openweathermapCurrentweatherdata = check openweathermapClient->getCurretWeatherData(q, id, lat, lon, zip);
    return openweathermapCurrentweatherdata;
}

# Can be used to fetch user's activity analysis to understand their travel preferences and interests instead of asking them back. 
@ai:AgentTool
@display {label: "", iconPath: ""}
isolated function getUserActivityAnalysis(string userId) returns string|error {
    string result = check fetchUserActivityAnalysis(userId);
    return result;
}
