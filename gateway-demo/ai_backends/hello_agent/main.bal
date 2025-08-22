import ballerina/ai;
import ballerina/http;

listener ai:Listener greetingAgentListener = new (listenOn = check http:getDefaultListener());

service /greetingAgent on greetingAgentListener {
    resource function post chat(@http:Payload ai:ChatReqMessage request) returns ai:ChatRespMessage|error {
        string stringResult = check _greetingAgentAgent.run(request.message, request.sessionId);
        return {message: stringResult};
    }
}
