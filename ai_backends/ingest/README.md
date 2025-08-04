# Ingest

## Description
Covers the ingestion part of the RAG (Retrieval-Augmented Generation) pipeline. Ingests PDF files from a directory into a Pinecone vector database for semantic search and retrieval. This service follows the **Document Ingestion Pattern** for RAG systems.

## LLM Pattern
This project implements the **RAG Ingestion Pattern** where:
- PDF documents are processed and chunked
- Text embeddings are generated using LLM models
- Vector embeddings are stored in Pinecone vector database
- Semantic search capabilities are enabled for downstream retrieval

## Configuration

Create a `Config.toml` file in the project root with the following structure:

```toml
# Pinecone vector database configuration
pineConeServiceUrl = "https://your-index-xxxxxx.svc.your-region.pinecone.io"
pineConeApiKey = "your-pinecone-api-key"
```

### Configuration Notes
- `pineConeServiceUrl`: The service URL for your Pinecone vector database index
- `pineConeApiKey`: Your Pinecone API key for authentication and access

## Tools & Features
- PDF document processing and chunking
- Text embedding generation
- Vector database integration with Pinecone
- Batch document ingestion capabilities
- Semantic indexing for efficient retrieval
