const authConfig = {
  clientId: window.REACT_APP_ASGARDEO_CLIENT_ID || "gN3C2joaMJxlesWx1KpGRejn8Oca",
  baseUrl: window.REACT_APP_ASGARDEO_BASE_URL || "https://api.asgardeo.io/t/nadheesh",
  scopes: ["openid", "profile", "email"],
  redirectSignIn: window.REACT_APP_REDIRECT_SIGN_IN || window.location.origin,
  redirectSignOut: window.REACT_APP_REDIRECT_SIGN_OUT || window.location.origin,
  storage: "localStorage",
  // This is crucial - must include your hotel API base URL
  resourceServerURLs: [
    window.REACT_APP_HOTEL_API_BASE_URL || "http://localhost:9090"
  ],
  enablePKCE: true,
  clockTolerance: 300
};

export default authConfig;