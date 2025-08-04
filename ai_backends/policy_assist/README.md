# Policy Assist

## Description
Handles the retrieval part of the RAG (Retrieval-Augmented Generation) pipeline. Retrieves embeddings from the vector database based on user queries and synthesizes responses using LLM. This service follows the **RAG Retrieval Pattern** and provides a chat interface for policy-related queries.

## LLM Pattern
This project implements the **RAG Retrieval & Synthesis Pattern** where:
- User queries are processed and converted to embeddings
- Relevant document chunks are retrieved from Pinecone vector database
- Retrieved context is provided to LLM for response generation
- AI Agent synthesizes final responses based on retrieved policy information

## Configuration

Create a `Config.toml` file in the project root with the following structure:

```toml
# User identifier for personalized responses
userId = "user_john_001"

# Pinecone vector database configuration for policy retrieval
pineconeApiKey = "your-pinecone-api-key"
pineconeServiceUrl = "https://your-index-xxxxxx.svc.your-region.pinecone.io"
```

### Configuration Notes
- `userId`: User identifier for tracking and personalizing policy assistance
- `pineconeApiKey`: Your Pinecone API key for accessing stored policy documents
- `pineconeServiceUrl`: The service URL for your Pinecone vector database index containing policy embeddings

## Tools & Features
- **Hotel Policy Query Tool**: Retrieves relevant policy information based on questions and hotel ID
- Vector similarity search for relevant policy documents
- AI Agent with chat interface for natural language interaction
- Context-aware response generation using retrieved policy information
- RESTful API endpoint at `/policyAgent/chat` for integration

## Agent Tools
- `queryHotelPoliciesTool`: Searches and retrieves hotel policies based on user questions and hotel identifiers
