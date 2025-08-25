import ballerina/http;

// In-memory database to store user loyalty points
map<decimal> loyaltyPointsDb = {
    "user_john_001": 3.0
};

type LoyaltyResponse record {|
    string userId;
    decimal loyaltyDiscountInDollars;
|};

type AddLoyaltyRequest record {|
    string userId;
    decimal spendingAmount;
|};

type ResetLoyaltyRequest record {|
    string userId;
    decimal newPoints;
|};

type LoyaltyUpdateResponse record {|
    string userId;
    decimal totalLoyaltyPoints;
    string message;
|};

// HTTP service for loyalty API
service /loyalty on new http:Listener(9090) {
    
    // Get loyalty points for a specific user
    resource function post consume/[string userId]() returns LoyaltyResponse {
        
        if loyaltyPointsDb.hasKey(k = userId) {
            decimal loyaltyPoints = loyaltyPointsDb.get(k = userId);
            loyaltyPointsDb[userId] = 0; // Reset points after consumption
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

    // Add loyalty points based on spending (5% of spending amount)
    resource function post add(AddLoyaltyRequest request) returns LoyaltyUpdateResponse {
        string userId = request.userId;
        decimal spendingAmount = request.spendingAmount;
        
        // Calculate 5% loyalty points from spending
        decimal newLoyaltyPoints = spendingAmount * 0.05;
        
        // Get existing points or default to 0
        decimal existingPoints = 0;
        if loyaltyPointsDb.hasKey(k = userId) {
            existingPoints = loyaltyPointsDb.get(k = userId);
        }
        
        // Add new points to existing points
        decimal totalPoints = existingPoints + newLoyaltyPoints;
        loyaltyPointsDb[userId] = totalPoints;
        
        return {
            userId: userId,
            totalLoyaltyPoints: totalPoints,
            message: "Loyalty points added successfully"
        };
    }

    // Reset loyalty points for a user
    resource function post reset(ResetLoyaltyRequest request) returns LoyaltyUpdateResponse {
        string userId = request.userId;
        decimal newPoints = request.newPoints;
        
        // Set the new points value
        loyaltyPointsDb[userId] = newPoints;    
        
        return {
            userId: userId,
            totalLoyaltyPoints: newPoints,
            message: "Loyalty points reset successfully"
        };
    }
}
