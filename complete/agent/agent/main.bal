import ballerina/ai;
import ballerina/http;
import ballerina/time;

listener ai:Listener travelPlannerListener = new (listenOn = check http:getDefaultListener());

service /travelPlanner on travelPlannerListener {
    resource function post chat(@http:Payload ai:ChatReqMessage request) returns ai:ChatRespMessage|error {
        string stringResult = check _travelPlannerAgent.run(string `User Name: ${"John Smith"}
User ID: ${"user_john_001"}
UTC Time now:
${time:utcToString(time:utcNow())}

User Query:
${request.message}
`, request.sessionId);
        return {message: stringResult};
    }
}

