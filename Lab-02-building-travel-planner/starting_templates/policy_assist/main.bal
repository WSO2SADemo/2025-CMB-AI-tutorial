import ballerina/ai;
import ballerina/http;

listener ai:Listener policyAgentListener = new (listenOn = check http:getDefaultListener());

service /policyAgent on policyAgentListener {
    resource function post chat(@http:Payload ai:ChatReqMessage request) returns ai:ChatRespMessage|error {
        string stringResult = check _policyAgentAgent.run(string `
Hotel ID: ${"hotel_srilanka_knuckles_001"}

User Query:
${request.message}
`, request.sessionId);
        return {message: stringResult};
    }
}
