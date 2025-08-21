import ballerina/ai;
import ballerinax/ai.pinecone;

final pinecone:VectorStore pineconeVectorstore = check new (pineconeServiceUrl, pineconeApiKey);
final ai:Wso2EmbeddingProvider aiWso2embeddingprovider = check ai:getDefaultEmbeddingProvider();
final ai:VectorKnowledgeBase aiVectorknowledgebase = new (pineconeVectorstore, aiWso2embeddingprovider);

