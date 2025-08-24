import ballerina/http;

// In-memory database to store user loyalty points
map<decimal> loyaltyPointsDb = {
    "user_john_001": 3.0
};

type LoyaltyResponse record {|
    string userId;
    decimal loyaltyDiscountInDollars;
|};

// HTTP service for loyalty API
service /loyalty on new http:Listener(9090) {
    
    // Get loyalty points for a specific user
    resource function get [string userId]() returns LoyaltyResponse {
        
        if loyaltyPointsDb.hasKey(k = userId) {
            decimal loyaltyPoints = loyaltyPointsDb.get(k = userId);
            return  {
                "userId": userId,
                loyaltyDiscountInDollars: loyaltyPoints
            };
        } 

        return {
            "userId": userId,
            loyaltyDiscountInDollars: 0
        };
    }
}
