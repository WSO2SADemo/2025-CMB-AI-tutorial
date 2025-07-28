import ballerina/http;
import ballerinax/ai;

listener ai:Listener TravelPlannerListener = new (listenOn = check http:getDefaultListener());

@http:ServiceConfig {
    cors: {
        allowOrigins: ["http://localhost:3000"], // Specify exact origin instead of "*"
        allowMethods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"],
        allowHeaders: ["Content-Type", "Authorization", "Accept"],
        allowCredentials: true, // This is the key missing configuration
        maxAge: 84900
    }
}
service /TravelPlanner on TravelPlannerListener {
    resource function post chat(@http:Payload ai:ChatReqMessage request) returns ai:ChatRespMessage|error {

        string stringResult = check _TravelPlannerAgent->run(request.message, request.sessionId);
        return {message: stringResult};
    }
}
