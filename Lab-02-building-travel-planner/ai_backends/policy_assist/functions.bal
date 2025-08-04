import ballerina/ai;

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

isolated function queryHotelPolicies(string question, string hotelId) returns string|error {
    ai:QueryMatch[] aiQuerymatch = check aiVectorknowledgebase.retrieve(question, getHotelFilters(hotelId));
    ai:ChatUserMessage aiChatusermessage = ai:augmentUserQuery(aiQuerymatch, question);
    ai:ChatAssistantMessage aiChatassistantmessage = check _policyAgentModel->chat(aiChatusermessage, []);
    return aiChatassistantmessage.content.ensureType();
}
