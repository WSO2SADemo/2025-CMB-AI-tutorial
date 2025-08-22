import ballerina/ai;
import ballerina/http;
import ballerina/log;
import ballerina/time;

listener ai:Listener greetingAgentListener = new (listenOn = check http:getDefaultListener());

service /greetingAgent on greetingAgentListener {
    resource function post chat(@http:Payload ai:ChatReqMessage request) returns ai:ChatRespMessage|error {
        string|ai:Error agentResp = _greetingAgentAgent.run(string `User Name: ${"John Smith"}
User ID: ${"user_john_001"}
UTC Time now:
${time:utcToString(time:utcNow())}

User Query:
${request.message}
`, request.sessionId);
        if agentResp is error {
            if agentResp.message() == "Unable to obtain valid answer from the agent" {
                return {message: "For safety and policy reasons, I can’t respond to that."};
            }
            log:printError("Error in agent", 'error = agentResp);
            return {message: "Unknown error occurred"};
        }
        return {message: agentResp};
    }
}
