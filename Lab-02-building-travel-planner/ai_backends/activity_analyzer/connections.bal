import activity_analyzer.adminApi;
import activity_analyzer.hotelSearchApi;

import ballerina/ai;
import ballerinax/postgresql;
import ballerinax/postgresql.driver as _;

final hotelSearchApi:Client hotelsearchapiClient = check new (serviceUrl = hotelSearchApiUrl);
final adminApi:Client adminapiClient = check new (serviceUrl = hotelAdminApiUrl);
final ai:Wso2ModelProvider aiWso2modelprovider = check ai:getDefaultModelProvider();
final postgresql:Client postgresqlClient = check new (pgHost, pgUser, pgPassword, pgDatabase, pgPort);