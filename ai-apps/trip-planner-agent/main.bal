import ballerina/http;
import ballerinax/ai;

listener ai:Listener TravelPlannerListener = new (listenOn = check http:getDefaultListener());

service /TravelPlanner on TravelPlannerListener {
    resource function post chat(@http:Payload ai:ChatReqMessage request) returns ai:ChatRespMessage|error {

        string stringResult = check _TravelPlannerAgent->run(request.message, request.sessionId);
        return {message: stringResult};
    }
}
