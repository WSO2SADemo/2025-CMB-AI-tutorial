# Securing AI Agents with Asgardeo

This project demonstrates how to secure AI agents using [Asgardeo](https://wso2.com/asgardeo/). We use a hotel booking system as a practical use case to showcase how to implement robust security measures for your AI agents, ensuring that they operate within a secure and controlled environment.


## The Challenge: Securing AI Agents

As AI agents become more prevalent, securing them becomes a critical concern. How do you ensure that only authorized users can interact with your AI agents? How do you control what actions an AI agent can perform on behalf of a user? How do you prevent malicious actors from exploiting your AI agents to gain unauthorized access to your systems?

This project provides a comprehensive solution to these challenges, demonstrating how to:

- **Manage Agent Identities:** Securely manage the identities of your AI agents, ensuring that they can be trusted and verified.
- **Authenticate and Authorize Agents:** Secure your AI agents by ensuring that only authenticated and authorized agents can invoke actions on their own or on behalf of users.
- **Implement Fine-Grained Access Control:** Use OAuth 2.0 scopes to define and enforce fine-grained permissions for your AI agents, controlling what actions they can perform.
- **Secure Communication:** Protect the communication between your frontend, backend, and AI agents using industry-standard protocols.

## The Gardeo Hotel: A Secure AI Use Case

To illustrate these security concepts, we've built the Gardeo Hotel, a modern, AI-powered hotel booking website. The Gardeo Hotel website allows users to book rooms and view their reservations. It also features an AI assistant that can be used to book rooms using natural language.

This is not just a simple chatbot. The AI assistant is a powerful tool that can access and modify sensitive user data. Therefore, it is crucial to ensure that it is secure.

## Architecture Overview

The architecture of the Gardeo Hotel booking system is designed to provide a secure and efficient environment for users to interact with AI agents. It leverages modern web technologies and best practices in security, implementing a multi-layered security approach with proper separation of concerns.

![Architecture Diagram](docs/resources/image.png)

### System Components

The system is composed of several key components working together to provide a secure AI agent experience:

#### User-Facing Layer
- **User Facing Front End:** A React application that provides the user interface for searching, booking, and managing hotel reservations. Specially the chat interface that users can interact with the AI agent.

#### AI Agent Layer
- **Booking Assistant Agent:** An interactive agent that can understand natural language requests and perform booking operations
- **Staff Allocation Agent:** A  ambient agent that run on background and handles staff scheduling and resource allocation.

#### Backend Services Layer
- **Gateway (Auth GW):** Central authentication and authorization service powered by Asgardeo
- **Staff Management Services:** Handles employee data, scheduling, and staff-related operations
- **Booking System Backend Services:** Core business logic for hotel reservations, room management, and booking operations

### Security Architecture

The security model implements several key principles:

#### 1. **Identity-Based Security**
- Each AI agent has its own identity managed through Asgardeo
- All interactions are traced back to authenticated identities

#### 2. **Tool-Based Access Control**
- AI agents access backend services through controlled "Tools" interfaces
- Each tool represents a specific capability (e.g., room booking, staff scheduling)
- Tools act as security boundaries, ensuring agents can only perform authorized actions

#### 3. **OAuth 2.0 Integration**
- The Auth Gateway implements OAuth 2.0 flows for secure token-based authentication
- Fine-grained scopes control what each agent can access
- Tokens are validated at multiple layers to ensure security

### Data Flow and Security

1. **User Authentication:** Users authenticate through the frontend, which coordinates with Asgardeo via the Auth Gateway
2. **Agent Authorization:** When users interact with AI agents, the agents must authorized by users and present valid tokens to access backend services
3. **Controlled Access:** AI agents can only access backend services through predefined tools, each with specific permissions
4. **Audit Trail:** All interactions are logged and can be traced back to specific users and agents

## Key Security Features

### Agent Security
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

## Getting Started

To get started with this project, you can use either Docker or a native setup. For detailed instructions, please refer to the [SETUP.md](SETUP.md) file.

### Prerequisites

- Python 3.11+, Node.js 16+, and other dependencies listed in `SETUP.md` (for native setup)
- An Asgardeo account and application configuration

### Quick Start

1. Clone the repository:
   ```bash
   git clone https://github.com/wso2con/2025-CMB-AI-tutorial.git
   cd Lab-03-hotel-booking-system
   ```

2. Configure your Asgardeo settings in the environment variables

3. Start the services using:
   ```bash
   sh start-services.sh
   ```

4. The application will be available at `http://localhost:3000`

## Configuration

### Asgardeo Setup

1. Create an application in Asgardeo
2. Configure OAuth 2.0 scopes for different agent capabilities
3. Set up the necessary redirect URLs and allowed origins
4. Configure the environment variables with your Asgardeo credentials

### AI Agent Configuration

Each AI agent requires specific configuration:
- **Model Selection:** Choose appropriate LLM models for each agent type
- **Tool Permissions:** Define which tools each agent can access
- **Security Policies:** Set up rate limiting and access controls

## API Documentation

The backend and AI agent services provide OpenAPI documentation for their respective APIs:

- **Backend API:** [http://localhost:8001/docs](http://localhost:8001/docs)
- **AI Agents API:** [http://localhost:8000/docs](http://localhost:8000/docs)
- **Authentication Flows:** [http://localhost:8002/docs](http://localhost:8002/docs)

## Security Best Practices

When implementing this system:

1. **Regular Token Rotation:** Implement automatic token refresh mechanisms
2. **Monitoring and Alerting:** Set up monitoring for unusual agent behavior
3. **Input Validation:** Validate all inputs to AI agents to prevent prompt injection
4. **Audit Logging:** Maintain comprehensive logs of all agent actions
5. **Regular Security Reviews:** Periodically review and update agent permissions

## Troubleshooting

Common issues and solutions:

- **Authentication Errors:** Check Asgardeo configuration and network connectivity
- **Agent Permission Denied:** Verify OAuth scopes and tool configurations
- **Token Expiration:** Ensure proper token refresh mechanisms are in place

## Contributing

Contributions are welcome! Please feel free to open an issue or submit a pull request. When contributing:

1. Follow the existing code style and security patterns
2. Include tests for new security features
3. Update documentation for any architectural changes
4. Ensure all security validations are maintained

## License

This project is licensed under the MIT License. See the `LICENSE` file for more details.

## Additional Resources

- [Asgardeo Documentation](https://wso2.com/asgardeo/docs/)
- [OAuth 2.0 Security Best Practices](https://tools.ietf.org/html/draft-ietf-oauth-security-topics)

---

**Note:** This is a demonstration project. For production use, additional security hardening and compliance measures may be required based on your specific use case and regulatory requirements.
