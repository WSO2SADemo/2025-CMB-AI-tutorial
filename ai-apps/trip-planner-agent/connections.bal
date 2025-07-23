import trip_planner_agent.hotel_admin_api;
import trip_planner_agent.hotel_api;

import ballerinax/ai;
import ballerinax/openweathermap;
import ballerinax/postgresql;
import ballerinax/postgresql.driver as _;

final hotel_admin_api:Client hotelAdminApiClient = check new (serviceUrl = "http://localhost:8000");
final hotel_api:Client hotelApiClient = check new (serviceUrl = "http://localhost:8080");
final ai:OpenAiProvider aiOpenaiprovider = check new (openAiKey, "chatgpt-4o-latest");
final openweathermap:Client openweathermapClient = check new ({
    appid: openWeatherApiKey
});
final postgresql:Client postgresqlClient = check new (dbHost, dbUsername, dbPassword, dbName, dbPort);
