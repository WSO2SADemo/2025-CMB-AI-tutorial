import React from 'react';
import { SignInButton } from '@asgardeo/react';

const SignIn = () => {
  return (
    <div className="signin-page">
      <div className="signin-container">
        <h1>Hotel Booking App</h1>
        <p>Please sign in to search and book hotels</p>
        <SignInButton className="signin-button">
          Sign In with Asgardeo
        </SignInButton>
      </div>
    </div>
  );
};

export default SignIn;