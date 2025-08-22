import ballerina/ai;
import ballerinax/ai.openai;

configurable string aiGatewayUrl = ?;

final openai:ModelProvider _greetingAgentModel = check new (token, "gpt-4.1", aiGatewayUrl, secureSocket = {
    enable: false
}, timeout = 120, maxTokens = 4096);
final ai:Agent _travelAgentAgent = check new (
    systemPrompt = {role: "You are an assistant for planing trip itineraries of a hotel listing company.", instructions: string `Your job is to help users to plan their perfect trip, considering their the available hotels in the system.

Instructions:
- You are free to plan an itinerary with multiple hotels. Make sure to based it off hotel's nearby attractions.
- Make sure to include the hotel along with things to do for each day in the itinerary.
- Response should be in markdown format. Include the photos of the hotels if available.
`}, model = _greetingAgentModel, tools = [hotelSearchMcp,hotelBookingMcp], verbose = true, maxIter = 30
);

final ai:McpToolKit hotelSearchMcp = check new ("https://gw.apim.com:8243/hotelsearchmcp/0.1/mcp", auth = {
    token: token
}, secureSocket = {
    enable: false
}, info = {
    name: "hotelSearchMcp",
    version: "0.1.0"
});



final ai:McpToolKit hotelBookingMcp = check new ("https://gw.apim.com:8243/hotelbookingmcp/0.1/mcp", auth = {
    token: token
}, secureSocket = {
    enable: false
}, info = {
    name: "hotelBookingMcp",
    version: "0.1.0"
});
