import ballerina/ai;

isolated function queryHotelPolicy(string question, string hotelId) returns string|error {
    ai:QueryMatch[] aiQuerymatch = check aiVectorknowledgebase.retrieve(question, getHotelFilters(hotelId));
    ai:ChatUserMessage aiChatusermessage = ai:augmentUserQuery(aiQuerymatch, question);
    ai:ChatAssistantMessage aiChatassistantmessage = check _travelPlannerModel->chat(aiChatusermessage, []);
    return aiChatassistantmessage.content.ensureType();

}

isolated function getPersonalziedProfile(string userId) returns string|error {
    string personalizedProfile = check postgresqlClient->queryRow(`SELECT activity_analysis from user_activities where user_id=${userId}`);
    return personalizedProfile;
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
