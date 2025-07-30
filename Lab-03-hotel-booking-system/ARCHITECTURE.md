# Architecture

The architecture of the Gardeo Hotel booking system is designed to provide a secure and efficient environment for users to interact with AI agents. It leverages modern web technologies and best practices in security, implementing a multi-layered security approach with proper separation of concerns.

![Architecture Diagram](docs/resources/image.png)

### System Components

The system is composed of several key components working together to provide a secure AI agent experience:

#### User-Facing Layer
- **Browser:** The client interface where users interact with the system
- **User Facing Front End:** A React application that provides the user interface for searching, booking, and managing hotel reservations

#### AI Agent Layer
- **Booking Assistant Agent:** An intelligent agent powered by a Large Language Model (LLM) that can understand natural language requests and perform booking operations
- **Staff Allocation Agent:** A specialized agent that handles staff scheduling and resource allocation, also powered by the same LLM infrastructure

#### Backend Services Layer
- **Auth Gateway (Auth GW):** Central authentication and authorization service powered by Asgardeo
- **Staff Management Services:** Handles employee data, scheduling, and staff-related operations
- **Booking System Backend Services:** Core business logic for hotel reservations, room management, and booking operations

### Security Architecture

The security model implements several key principles:

#### 1. **Identity-Based Security**
- Each AI agent has its own secure identity managed through Asgardeo
- Users must authenticate before interacting with any AI agents
- All interactions are traced back to authenticated identities

#### 2. **Tool-Based Access Control**
- AI agents access backend services through controlled "Tools" interfaces
- Each tool represents a specific capability (e.g., room booking, staff scheduling)
- Tools act as security boundaries, ensuring agents can only perform authorized actions

#### 3. **OAuth 2.0 Integration**
- The Auth Gateway implements OAuth 2.0 flows for secure token-based authentication
- Fine-grained scopes control what each agent can access
- Tokens are validated at multiple layers to ensure security

#### 4. **Separation of Concerns**
- Frontend handles user experience and basic validation
- AI agents focus on natural language processing and decision-making
- Backend services handle business logic and data persistence
- Authentication is centralized through Asgardeo

### Data Flow and Security

1. **User Authentication:** Users authenticate through the frontend, which coordinates with Asgardeo via the Auth Gateway
2. **Agent Authorization:** When users interact with AI agents, the agents must present valid tokens to access backend services
3. **Controlled Access:** AI agents can only access backend services through predefined tools, each with specific permissions
4. **Audit Trail:** All interactions are logged and can be traced back to specific users and agents

## Key Security Features

### Multi-Agent Security
- **Agent Isolation:** Each AI agent operates with its own security context and permissions
- **Cross-Agent Communication:** Secure communication channels between different AI agents when needed
- **Centralized Identity Management:** All agent identities managed through a single, secure system

### Fine-Grained Permissions
- **Scope-Based Access:** OAuth 2.0 scopes define exactly what each agent can do
- **Dynamic Authorization:** Permissions can be adjusted in real-time based on user roles and context
- **Principle of Least Privilege:** Agents only receive the minimum permissions necessary for their function

### Secure Tool Integration
- **API Gateway Pattern:** All backend access goes through controlled tool interfaces
- **Token Validation:** Every tool call includes token validation and scope checking
- **Rate Limiting:** Prevents abuse and ensures system stability

## Security Best Practices

When implementing this system,

1. **Regular Token Rotation:** Implement automatic token refresh mechanisms
2. **Monitoring and Alerting:** Set up monitoring for unusual agent behavior
3. **Input Validation:** Validate all inputs to AI agents to prevent prompt injection
4. **Audit Logging:** Maintain comprehensive logs of all agent actions
5. **Regular Security Reviews:** Periodically review and update agent permissions