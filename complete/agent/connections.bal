import agent.bookingApi;
import agent.hotelSearchApi;

import ballerina/ai;
import ballerinax/ai.pinecone;
import ballerinax/postgresql;
import ballerinax/postgresql.driver as _;

final pinecone:VectorStore pineconeVectorstore = check new (pineconeServiceUrl, pineconeApiKey);
final ai:Wso2EmbeddingProvider aiWso2embeddingprovider = check ai:getDefaultEmbeddingProvider();
final ai:VectorKnowledgeBase aiVectorknowledgebase = new (pineconeVectorstore, aiWso2embeddingprovider);

final hotelSearchApi:Client hotelsearchapiClient = check new (serviceUrl = hotelSearchApiUrl);
final postgresql:Client postgresqlClient = check new (pgHost, pgUser, pgPassword, pgDatabase, pgPort);
final bookingApi:Client bookingapiClient = check new (serviceUrl = bookingApiUrl);