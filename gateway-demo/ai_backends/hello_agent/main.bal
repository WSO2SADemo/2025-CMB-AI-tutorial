import ballerina/ai;
import ballerina/http;
import ballerina/log;
import ballerina/time;
import ballerina/lang.value;

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
        if agentResp is ai:Error {
            boolean|error guardrailTriggered = isGuardRailsTriggered(agentResp);
            if guardrailTriggered is boolean && guardrailTriggered {
                return {message: "For safety and policy reasons, I can’t respond to that."};
            }
            log:printError("Error from AI service", 'error = agentResp);
            return {message: "Unknown error occurred"};
        }
        return {message: agentResp};
    }
}


function isGuardRailsTriggered(ai:Error aiError) returns boolean|error {
    map<value:Cloneable> & readonly detail = aiError.detail();
    value:Cloneable & readonly steps = detail.get("steps");
    if steps is error[] {
        foreach error err in steps {
            error? cause = err.cause();
            if cause is () {
                continue;
            }
            map<value:Cloneable> & readonly detailResult = cause.detail();
            if detailResult.hasKey("statusCode") {
                int statusCode = check detailResult.get("statusCode").ensureType();
                if statusCode == 446 {
                    return true;
                }
            }
        }
    }

    return false;
}
