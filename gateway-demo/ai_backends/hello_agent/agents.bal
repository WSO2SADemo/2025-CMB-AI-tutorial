import ballerina/ai;
import ballerinax/ai.openai;

final openai:ModelProvider _greetingAgentModel = check new (token, "gpt-4.1", "https://gw.apim.com:8243/openaiapi/2.3.0", secureSocket = {
    enable: false
});
final ai:Agent _greetingAgentAgent = check new (
    systemPrompt = {role: "You are a hotel agent", instructions: string ``}, model = _greetingAgentModel, tools = [hotelMcp], verbose = true
);
final ai:McpToolKit hotelMcp = check new ("https://gw.apim.com:8243/hotelmcp/0.1/mcp", auth = {
    token: token
}, secureSocket = {
    enable: false
}, info = {
    name: "hi",
    version: "0.1.0"
});
