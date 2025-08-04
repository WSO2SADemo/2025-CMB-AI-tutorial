import ballerina/ai;

final ai:Wso2ModelProvider _greetingAgentModel = check ai:getDefaultModelProvider();
final ai:Agent _greetingAgentAgent = check new (
    systemPrompt = {role: "", instructions: string ``}, model = _greetingAgentModel, tools = []
);
