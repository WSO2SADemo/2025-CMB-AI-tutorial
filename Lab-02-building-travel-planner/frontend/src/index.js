import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './index.css'
import App from './App.jsx'
import { AsgardeoProvider } from '@asgardeo/react'
import authConfig from './config/auth.js'

createRoot(document.getElementById('root')).render(
  <StrictMode>
    <AsgardeoProvider
      clientId={authConfig.clientId}
      baseUrl={authConfig.baseUrl}
      scopes={authConfig.scopes}
      // redirectSignIn={authConfig.redirectSignIn}
      // redirectSignOut={authConfig.redirectSignOut}
      storage={authConfig.storage}
      resourceServerURLs={authConfig.resourceServerURLs}
      enablePKCE={authConfig.enablePKCE}
      clockTolerance={authConfig.clockTolerance}
    >
      <App />
    </AsgardeoProvider>
  </StrictMode>
)