import ballerina/ai;

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
    }, maxIter = 20, model = _travelPlannerModel, tools = [queryHotelPolicyTool], verbose = true
);

# Can be used to query about hotel policies.
@ai:AgentTool
@display {label: "", iconPath: ""}
isolated function queryHotelPolicyTool(string question, string hotelId) returns string|error {
    string|error result = queryHotelPolicy(question, hotelId);
    return result;
}
