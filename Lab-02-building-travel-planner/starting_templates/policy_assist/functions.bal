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

