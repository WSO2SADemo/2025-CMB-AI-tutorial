import ballerina/ai;
import ballerina/http;
import ballerina/log;
import ballerina/time;

listener ai:Listener travelPlannerListener = new (listenOn = check new http:Listener(9090, timeout = 120));

@http:ServiceConfig {
    cors: {
        allowOrigins: ["http://localhost:3000", "https://94358233727d.ngrok-free.app"], // Specify exact origin instead of "*"
        allowMethods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"],
        allowHeaders: ["Content-Type", "Authorization", "Accept"],
        allowCredentials: true, // This is the key missing configuration
        maxAge: 84900
    }
}
service /travelPlanner on travelPlannerListener {
    resource function post chat(@http:Payload ai:ChatReqMessage request) returns ai:ChatRespMessage|error {
        string|ai:Error agentResp = _travelAgentAgent.run(string `User Name: ${"John Smith"}
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
