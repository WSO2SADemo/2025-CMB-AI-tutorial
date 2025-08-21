import ballerina/ai;

final ai:Wso2ModelProvider _policyAgentModel = check ai:getDefaultModelProvider();
final ai:Agent _policyAgentAgent = check new (
    systemPrompt = {role: "Policy Agent", instructions: string ``}, model = _policyAgentModel, tools = []
);
