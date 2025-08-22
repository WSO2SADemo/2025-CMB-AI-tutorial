# Lab 02: Building a Travel Planner with Generative AI

This repository contains the codebase for WSO2Con Asia 2nd lab on building generative AI applications using Ballerina integrator. The use case demonstrates creating an intelligent agent that provides personalized trip planning capabilities.

## Overview

This project showcases a complete travel planning system where an AI agent acts as both the intelligent backend and Backend-for-Frontend (BFF), coordinating with multiple business APIs to provide personalized travel recommendations.

### Architecture

- **AI Backends** (`ai_backends/`): Contains Ballerina projects for each step in the session, demonstrating progressive development of AI capabilities
- **Frontend** (`frontend/`): React-based web application for user interaction
- **O2 Business APIs** (`o2-business-apis/`): Microservices providing core travel-related business functionality. These are assumed to be the API already existing for the traditional travel planner application.
- **Agent as BFF**: The main agent serves as the single point of entry, orchestrating calls to business APIs

## Project Structure

```
Lab-02-building-travel-planner/
├── ai_backends/                    # AI agent implementations
│   ├── activity_analyzer/          # Analyzes travel activities
│   ├── agent/                      # Main travel planning agent (BFF)
│   ├── hello_agent/               # Basic agent implementation
│   ├── ingest/                    # Data ingestion agent
│   └── policy_assist/             # Policy assistance agent
├── frontend/                      # React frontend application
├── o2-business-apis/              # Business microservices
│   ├── admin-api/                 # Admin operations (Port: 9080)
│   ├── booking-api/               # Hotel booking service (Port: 9081)
│   ├── review-api/                # Reviews and ratings (Port: 9082)
│   └── search-api/                # Hotel search service (Port: 9083)
└── resources/                     # API specifications and prompts
```

## Prerequisites

- **Ballerina**: Latest version installed ([Download](https://ballerina.io/downloads/))
- **Node.js**: Version 22+ ([Download](https://nodejs.org/))
- **npm**: Comes with Node.js

## Getting Started

### 1. Start the Business APIs

Each business API runs on a different port. Start them in separate terminals:

#### Admin API (Port: 9080)
```bash
cd o2-business-apis/admin-api
bal run
```

#### Booking API (Port: 9081)
```bash
cd o2-business-apis/booking-api
bal run
```

#### Review API (Port: 9082)
```bash
cd o2-business-apis/review-api
bal run
```

#### Search API (Port: 9083)
```bash
cd o2-business-apis/search-api
bal run
```

### 2. Start the AI Agent (BFF)

The main agent acts as the Backend-for-Frontend and coordinates with all business APIs:

Setup the configurables required for the agent. Instructions can be found in the `ai_backends/agent/README.md`.

```bash
cd ai_backends/agent
bal run
```

The agent will be available at: `http://localhost:9090` (default Ballerina AI listener port)

### 3. Start the Frontend

Prerequisite: 

1. Asgradeo public client application should be created (https://wso2.com/asgardeo/docs/references/app-settings/oidc-settings-for-app/)

2. Create a .env file in the `frontend` directory by making a copy of `.env.example` and updating the values as needed. 

```bash
cd frontend
npm install
npm start
```

The frontend will be available at: `http://localhost:3000`
