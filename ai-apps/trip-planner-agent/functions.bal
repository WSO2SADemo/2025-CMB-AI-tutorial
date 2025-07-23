
# Can be used to fetch user activity analysis to know about their traveling preferences. 
isolated function fetchUserActivityAnalysis(string userId) returns string|error {
    string activityAnalysis = check postgresqlClient->queryRow(`SELECT activity_analysis from user_activities where user_id=${userId}`);

    return activityAnalysis;
}
