# Activity Analyzer

## Description
Analyzes existing hotel bookings, transforms data into a proper structure and uses an LLM to build a structured LLM-friendly personalized profile then inserts into a PostgreSQL database. This service follows the **Data Processing & Personalization Pattern** where raw booking data is analyzed to create enriched user profiles.

## LLM Pattern
This project implements a **Data Analytics and Profile Generation Pattern** where:
- Raw hotel booking data is retrieved and analyzed
- LLM processes the data to extract user preferences and patterns
- Structured personalized profiles are generated for future use
- Data is persisted to PostgreSQL for retrieval by other services

## Configuration

Create a `Config.toml` file in the project root with the following structure:

```toml
# User identifier for processing
userId = "user_john_001"

# PostgreSQL database connection settings
pgHost = "localhost"
pgPort = 5432
pgDatabase = "hotel_analytics"
pgUser = "postgres"
pgPassword = "your_password"

# External API endpoints for hotel data retrieval
hotelSearchApiUrl = "http://localhost:9083"
hotelAdminApiUrl = "http://localhost:9080"
```

### Configuration Notes
- `userId`: The target user ID whose booking history will be analyzed
- `pgHost`, `pgPort`, `pgDatabase`, `pgUser`, `pgPassword`: PostgreSQL connection parameters for storing personalized profiles
- `hotelSearchApiUrl`, `hotelAdminApiUrl`: API endpoints for retrieving booking and hotel data

## Tools & Features
- Database integration for profile storage
- Hotel booking data retrieval and analysis
- LLM-powered user preference extraction
- Structured profile generation
