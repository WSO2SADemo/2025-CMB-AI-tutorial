# Securing AI Agents with Asgardeo

As AI agents become more prevalent, securing them becomes a critical concern. How do you ensure that only authorized users can interact with your AI agents? How do you control what actions an AI agent can perform on behalf of a user? How do you prevent malicious actors from exploiting your AI agents to gain unauthorized access to your systems?

This project demonstrates how to secure AI agents using [Asgardeo](https://wso2.com/asgardeo/). We use a hotel booking system as a practical use case to showcase how to implement robust security measures for your AI agents, ensuring that they operate within a secure and controlled environment. In this project, we demonstrate,

- **Manage Agent Identities:** Securely manage the identities of your AI agents, ensuring that they can be trusted and verified.
- **Authenticate and Authorize Agents:** Secure your AI agents by ensuring that only authenticated and authorized agents can invoke actions on their own or on behalf of users.
- **Implement Fine-Grained Access Control:** Use OAuth 2.0 scopes to define and enforce fine-grained permissions for your AI agents, controlling what actions they can perform.
- **Secure Communication:** Protect the communication between your frontend, backend, and AI agents using industry-standard protocols.

## The Gardeo Hotel: A Secure AI Use Case

Gardeo Hotel is a modern, AI-powered hotel booking website. it allows users to book rooms and view their reservations. It also features an AI assistant that helps visitors to book rooms using natural language.

Unlike a pre programmed simple chatbot, the AI assistant is a powerful tool that can access and modify sensitive user data. Therefore, it is crucial to ensure that it is secure.

## Architecture Overview

Please refer to the [Architecture Documentation](ARCHITECTURE.md) to learn more about the system architecture used in this demo project.

## Getting Started

To get started with this project, you can use either Docker or a native setup. For detailed instructions, please refer to the [SETUP.md](SETUP.md) file.

### Prerequisites

- Python 3.11+, Node.js 16+, and other dependencies listed in `SETUP.md` (for native setup)
- An Asgardeo account and a configured application

### Quick Start

1. Clone the repository.

   ```bash
   git clone https://github.com/wso2con/2025-CMB-AI-tutorial.git
   cd 2025-CMB-AI-tutorial/Lab-03-hotel-booking-system
   ```

2. Create a copy of `.env.example` files in `ai-agents`, `backend`, `frontend` directories and rename those to `.env`. [Configure your Asgardeo organization specific settings](#asgardeo-setup) in the `.env` files.

```bash
cp ai-agents/.env.example .env
cp frontend/.env.example .env
cp backend/.env.example .env
```

3. Start the services using:
   ```bash
   sh start-services.sh
   ```

4. The application will be available at `http://localhost:3000`

## Configuration

### Asgardeo Setup

1. Create an API resource in Asgardeo. Configure the following OAuth scopes.

- `create_bookings` - Create new bookings in the system.
- `admin_read_bookings` - Fetch all bookings in the system
- `admin_read_staff` - Fetch staff details
- `admin_update_bookings` - Update any booking in the system

2. Create a standard based application.
   - Switch to the "API Authorization" tab and authorize the API resource created in step 02.
   - Navigate to "Protocol" tab and set up the necessary redirect URLs and allowed origins.

3. Update the `.env` files with the Asgardeo credentials.

### AI Agent Configuration

1. On Asgardeo console, navigate to "Agents".
2. Create two agents `Hotel Assistant` and `Assignment Agent`.
3. Copy the agent credentials and update the `.env` files in `ai-agents` directory accordingly.

## API Documentation

The backend and AI agent services provide OpenAPI documentation for their respective APIs:

- **Backend API:** [http://localhost:8001/docs](http://localhost:8001/docs)
- **AI Agents API:** [http://localhost:8000/docs](http://localhost:8000/docs)
- **Authentication Flows:** [http://localhost:8002/docs](http://localhost:8002/docs)

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
