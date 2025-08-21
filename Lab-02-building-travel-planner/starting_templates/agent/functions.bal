import ballerina/ai;

isolated function queryHotelPolicy(string question, string hotelId) returns string|error {
    ai:QueryMatch[] aiQuerymatch = check aiVectorknowledgebase.retrieve(question, getHotelFilters(hotelId));
    ai:ChatUserMessage aiChatusermessage = ai:augmentUserQuery(aiQuerymatch, question);
    ai:ChatAssistantMessage aiChatassistantmessage = check _travelPlannerModel->chat(aiChatusermessage, []);
    return aiChatassistantmessage.content.ensureType();

}

isolated function getHotelFilters(string hotelId) returns ai:MetadataFilters {
    ai:MetadataFilters filters = {
        filters: [
            {
                key: "id",
                value: hotelId
            }
        ]
    };
    return filters;
};
