import activity_analyzer.hotel_admin_api;
import activity_analyzer.hotel_api;

import ballerinax/ai;
import ballerinax/postgresql;
import ballerinax/postgresql.driver as _;

final hotel_admin_api:Client hotelAdminApiClient = check new (serviceUrl = "http://localhost:8000");
final hotel_api:Client hotelApiClient = check new (serviceUrl = "http://localhost:8080");
final ai:OpenAiProvider aiOpenaiprovider = check new (openAiKey, "chatgpt-4o-latest");
final postgresql:Client postgresqlClient = check new (dbHost, dbUsername, dbPassword, dbName, dbPort);
