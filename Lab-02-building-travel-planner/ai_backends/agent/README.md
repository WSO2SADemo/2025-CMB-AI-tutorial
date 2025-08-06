# Agent

## Description
Main agent for the travel planning application. This comprehensive AI agent uses multiple tools and external integrations to assist users in planning their perfect trip itineraries. The agent considers user preferences, hotel availability, and provides personalized recommendations.

## LLM Pattern
This project implements an **Advanced Multi-Tool Agent Pattern** where:
- Complex travel planning logic with multiple external API integrations
- Tool-calling capabilities for hotel search, booking, and policy queries
- Personalized recommendations based on user profiles
- Multi-step reasoning for itinerary planning
- CORS-enabled web service for frontend integration

## Configuration

Create a `Config.toml` file in the project root with the following structure:

```toml
# User identification for personalized services
userId = "user_john_001"

# PostgreSQL database connection for user profiles
pgHost = "localhost"
pgPort = 5432
pgDatabase = "travel_planning"
pgUser = "postgres"
pgPassword = "your_password"

# Pinecone vector database for policy retrieval
pineconeApiKey = "your-pinecone-api-key"
pineconeServiceUrl = "https://your-index-xxxxxx.svc.your-region.pinecone.io"

# External hotel service APIs
hotelSearchApiUrl = "http://localhost:9083"
bookingApiUrl = "http://localhost:9081"
```

Additionally, Go to VSCode Command palette(View -> Command Palette) and search for "Configure Default wso2 model provider" to set up the default model provider configuration.

### Configuration Notes
- `userId`: Default user identifier for personalization and profile retrieval
- `pgHost`, `pgPort`, `pgDatabase`, `pgUser`, `pgPassword`: PostgreSQL connection for accessing user profiles and preferences
- `pineconeApiKey`, `pineconeServiceUrl`: Vector database access for policy and document retrieval
- `hotelSearchApiUrl`: API endpoint for hotel search and availability checking
- `bookingApiUrl`: API endpoint for creating hotel bookings

## Tools & Features
- **Multi-API Integration**: Hotel search, booking, and policy management
- **Personalization**: User profile-based recommendations
- **Advanced Planning**: Multi-hotel itinerary creation
- **Real-time Availability**: Hotel availability checking before recommendations
- **Policy Assistance**: Hotel policy queries and information retrieval
- **Weather Integration**: MCP server integration for weather forecasts
- **CORS Support**: Frontend integration with React applications

## Agent Tools
- `queryHotelPolicyTool`: Retrieves hotel policies and information
- `getPersonalizedProfile`: Accesses user preferences and interests from database
- `searchHotelsTool`: Searches available hotels with filtering options
- `getHotelInfoTool`: Retrieves detailed hotel information
- `createBookingTool`: Creates hotel bookings through the booking API
- `checkHotelAvailabilityTool`: Verifies hotel availability before recommendations
- `mcpServer7`: Weather forecast integration via MCP (Model Context Protocol) server

## API Endpoints
- `POST /travelPlanner/chat`: Main chat interface for travel planning assistance
