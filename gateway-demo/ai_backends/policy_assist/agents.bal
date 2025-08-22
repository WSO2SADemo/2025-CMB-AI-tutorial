import ballerina/ai;

final ai:Wso2ModelProvider _policyAgentModel = check ai:getDefaultModelProvider();
final ai:Agent _policyAgentAgent = check new (
    systemPrompt = {role: "Policy Agent", instructions: string ``}, model = _policyAgentModel, tools = [queryHotelPoliciesTool]
);

# Use this tool when you want to query hotel policies
@ai:AgentTool
@display {label: "", iconPath: ""}
isolated function queryHotelPoliciesTool(string question, string hotelId) returns string|error {
    string|error result = queryHotelPolicies(question, hotelId);
    return result;
}
