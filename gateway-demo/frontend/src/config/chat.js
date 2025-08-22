const chatConfig = {
  baseUrl: process.env.REACT_APP_CHAT_API_URL || "http://localhost:9090",
  endpoints: {
    chat: "/chat"
  },
  timeout: 30000 // 30 seconds timeout
};

export default chatConfig;