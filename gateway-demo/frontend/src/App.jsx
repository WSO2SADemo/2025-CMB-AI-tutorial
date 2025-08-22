import React, { useEffect, useState } from 'react';
import { BrowserRouter, Routes, Route, Navigate, Link, useLocation } from 'react-router-dom';
import { SignedIn, SignedOut, SignOutButton, useAsgardeo, User } from '@asgardeo/react';
import { ProtectedRoute } from '@asgardeo/react-router';
import HotelSearch from './components/HotelSearch';
import UserBookings from './components/UserBookings';
import UserProfile from './components/UserProfile';
import AIAssistant from './components/AIAssistant'; // New component
import SignIn from './components/SignIn';
import './App.css';

// Icons as SVG components for better performance
const SearchIcon = () => (
  <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
    <path d="M21 21L16.514 16.506L21 21ZM19 10.5C19 15.194 15.194 19 10.5 19C5.806 19 2 15.194 2 10.5C2 5.806 5.806 2 10.5 2C15.194 2 19 5.806 19 10.5Z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
  </svg>
);

const BookingIcon = () => (
  <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
    <path d="M19 4H5C3.89543 4 3 4.89543 3 6V20C3 21.1046 3.89543 22 5 22H19C20.1046 22 21 21.1046 21 20V6C21 4.89543 20.1046 4 19 4Z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
    <path d="M16 2V6" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
    <path d="M8 2V6" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
    <path d="M3 10H21" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
  </svg>
);

const ProfileIcon = () => (
  <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
    <path d="M20 21V19C20 17.9391 19.5786 16.9217 18.8284 16.1716C18.0783 15.4214 17.0609 15 16 15H8C6.93913 15 5.92172 15.4214 5.17157 16.1716C4.42143 16.9217 4 17.9391 4 19V21" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
    <path d="M12 11C14.2091 11 16 9.20914 16 7C16 4.79086 14.2091 3 12 3C9.79086 3 8 4.79086 8 7C8 9.20914 9.79086 11 12 11Z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
  </svg>
);

const LogoutIcon = () => (
  <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
    <path d="M9 21H5C4.46957 21 3.96086 20.7893 3.58579 20.4142C3.21071 20.0391 3 19.5304 3 19V5C3 4.46957 3.21071 3.96086 3.58579 3.58579C3.96086 3.21071 4.46957 3 5 3H9" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
    <path d="M16 17L21 12L16 7" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
    <path d="M21 12H9" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
  </svg>
);

// Magic wand icon for AI Assistant
const MagicIcon = () => (
  <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
    <path d="M14.5 2.5C14.5 3.05228 14.0523 3.5 13.5 3.5C12.9477 3.5 12.5 3.05228 12.5 2.5C12.5 1.94772 12.9477 1.5 13.5 1.5C14.0523 1.5 14.5 1.94772 14.5 2.5Z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
    <path d="M8.5 16.5C8.5 17.0523 8.05228 17.5 7.5 17.5C6.94772 17.5 6.5 17.0523 6.5 16.5C6.5 15.9477 6.94772 15.5 7.5 15.5C8.05228 15.5 8.5 15.9477 8.5 16.5Z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
    <path d="M3 7H5" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
    <path d="M19 7H21" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
    <path d="M7 3V5" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
    <path d="M7 19V21" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
    <path d="M18.4246 3.92871L16.5354 5.81792" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
    <path d="M3.92871 18.4246L5.81792 16.5354" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
    <path d="M16.2426 15.7574L5.94975 5.46457C5.7545 5.26932 5.7545 4.95274 5.94975 4.75749L7.75736 2.94989C7.95261 2.75463 8.26919 2.75463 8.46444 2.94989L18.7574 13.2428C18.9526 13.438 18.9526 13.7546 18.7574 13.9498L16.9498 15.7574C16.7545 15.9527 16.4379 15.9527 16.2426 15.7574Z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
    <path d="M9.87866 7.87866L16.2426 14.2426" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
  </svg>
);

function AppContent() {
  const { signInSilently, isLoading, isSignedIn } = useAsgardeo();
  const location = useLocation();

  if (isLoading) {
    return (
      <div className="loading-container">
        <div className="modern-spinner">
          <div className="spinner-ring"></div>
          <div className="spinner-ring"></div>
          <div className="spinner-ring"></div>
        </div>
        <p className="loading-text">Preparing your travel experience...</p>
      </div>
    );
  }

  return (
    <div className="app">
      <SignedIn>
        <header className="app-header">
          <div className="header-content">
            <Link to="/search" className="logo">
              <div className="logo-container">
                <div className="logo-icon">
                  <svg width="32" height="32" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M12 2L2 7L12 12L22 7L12 2Z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
                    <path d="M2 17L12 22L22 17" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
                    <path d="M2 12L12 17L22 12" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
                  </svg>
                </div>
                <div className="logo-text">
                  <h1>O2 Trips</h1>
                  <span className="logo-subtitle">Your Travel Companion</span>
                </div>
              </div>
            </Link>
            
            <div className="user-header">
              <User>
                {(user) => (
                  <div className="user-info">
                    <div className="user-avatar">
                      {(user.displayName || user.given_name || user.username || 'U').charAt(0).toUpperCase()}
                    </div>
                    <div className="user-details">
                      <span className="welcome-text">Welcome back,</span>
                      <span className="user-name">
                        {user.displayName || user.given_name || user.username}
                      </span>
                    </div>
                  </div>
                )}
              </User>
              
              <SignOutButton className="signout-button">
                <LogoutIcon />
                <span>Sign Out</span>
              </SignOutButton>
            </div>
          </div>
        </header>

        <nav className="app-nav">
          <div className="nav-content">
            <div className="nav-links">
              <Link 
                to="/search" 
                className={`nav-link ${location.pathname === '/search' ? 'active' : ''}`}
              >
                <SearchIcon />
                <span>Search Hotels</span>
              </Link>
              <Link 
                to="/bookings" 
                className={`nav-link ${location.pathname === '/bookings' ? 'active' : ''}`}
              >
                <BookingIcon />
                <span>My Bookings</span>
              </Link>
              <Link 
                to="/profile" 
                className={`nav-link ${location.pathname === '/profile' ? 'active' : ''}`}
              >
                <ProfileIcon />
                <span>Profile</span>
              </Link>
              {/* New AI Assistant Tab */}
              <Link 
                to="/assistant" 
                className={`nav-link ${location.pathname === '/assistant' ? 'active' : ''}`}
              >
                <MagicIcon />
                <span>AI Assistant</span>
              </Link>
            </div>
            
            <div className="nav-indicator">
              <div className="indicator-line"></div>
            </div>
          </div>
        </nav>

        <main className="app-main">
          <div className="main-content">
            <Routes>
              <Route path="/" element={<Navigate to="/search" replace />} />
              <Route path="/search" element={<HotelSearch />} />
              <Route path="/bookings" element={<UserBookings />} />
              <Route path="/profile" element={<UserProfile />} />
              <Route path="/assistant" element={<AIAssistant />} />
              <Route path="/signin" element={<Navigate to="/search" replace />} />
            </Routes>
          </div>
        </main>
      </SignedIn>

      <SignedOut>
        <Routes>
          <Route path="*" element={<SignIn />} />
        </Routes>
      </SignedOut>
    </div>
  );
}

function App() {
  return (
    <BrowserRouter>
      <AppContent />
    </BrowserRouter>
  );
}

export default App;