import React, { useState, useRef, useEffect } from 'react';
import { User } from '@asgardeo/react';

const AIAssistant = () => {
  const [messages, setMessages] = useState([
    { 
      role: 'assistant', 
      content: 'Hi there! I\'m your travel assistant. I can help you find hotels, recommend destinations, or provide travel tips. What can I help you with today?' 
    }
  ]);
  const [input, setInput] = useState('');
  const [isTyping, setIsTyping] = useState(false);
  const [mapLocation, setMapLocation] = useState({ lat: 6.9271, lng: 79.8612 }); // Default to Colombo, Sri Lanka
  const messagesEndRef = useRef(null);

  // Scroll to bottom of messages on new message
  useEffect(() => {
    if (messagesEndRef.current) {
      messagesEndRef.current.scrollIntoView({ behavior: 'smooth' });
    }
  }, [messages]);

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!input.trim()) return;

    // Add user message
    const newMessage = { role: 'user', content: input };
    setMessages(prev => [...prev, newMessage]);
    setInput('');
    setIsTyping(true);

    // Mock response delay
    setTimeout(() => {
      // Sample assistant responses with location updates
      let responseContent = '';
      let newLocation = { ...mapLocation };

      if (input.toLowerCase().includes('new york')) {
        responseContent = 'New York is a great destination! The city offers iconic landmarks like Times Square, Central Park, and the Statue of Liberty. Would you like me to recommend some hotels in Manhattan?';
        newLocation = { lat: 40.7128, lng: -74.0060 };
      } else if (input.toLowerCase().includes('paris')) {
        responseContent = 'Paris, the city of lights! You\'ll love exploring the Eiffel Tower, Louvre Museum, and charming neighborhoods like Montmartre. The best time to visit is spring or fall to avoid crowds.';
        newLocation = { lat: 48.8566, lng: 2.3522 };
      } else if (input.toLowerCase().includes('tokyo')) {
        responseContent = 'Tokyo is an amazing blend of modern technology and traditional culture. Be sure to visit neighborhoods like Shibuya, Shinjuku, and the traditional Asakusa district with its temples.';
        newLocation = { lat: 35.6762, lng: 139.6503 };
      } else if (input.toLowerCase().includes('hotel')) {
        responseContent = 'I can help you find the perfect hotel. What destination are you interested in, and do you have any preferences for amenities or price range?';
      } else {
        responseContent = 'That\'s an interesting question! I can help you find hotels, recommend destinations, or provide general travel advice. Feel free to ask about specific cities or travel requirements.';
      }

      setMessages(prev => [...prev, { role: 'assistant', content: responseContent }]);
      setMapLocation(newLocation);
      setIsTyping(false);
    }, 1500);
  };

  // Format timestamp
  const formatTime = () => {
    const now = new Date();
    return now.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
  };

  return (
    <div className="ai-assistant-container">
      <div className="ai-assistant-header">
        <h2>
          <span className="magic-icon">✨</span> AI Travel Assistant
        </h2>
        <p>Ask me anything about travel destinations, hotels, or recommendations!</p>
      </div>
      
      <div className="ai-assistant-content">
        <div className="chat-container">
          <div className="messages-container">
            <div className="messages-list">
              {messages.map((message, index) => (
                <div 
                  key={index} 
                  className={`message ${message.role === 'user' ? 'user-message' : 'assistant-message'}`}
                >
                  <div className="message-avatar">
                    {message.role === 'user' ? (
                      <User>
                        {(user) => (
                          <div className="user-message-avatar">
                            {(user.displayName || user.given_name || user.username || 'U').charAt(0).toUpperCase()}
                          </div>
                        )}
                      </User>
                    ) : (
                      <div className="assistant-message-avatar">
                        ✨
                      </div>
                    )}
                  </div>
                  <div className="message-content">
                    <div className="message-text">{message.content}</div>
                    <div className="message-time">{formatTime()}</div>
                  </div>
                </div>
              ))}
              {isTyping && (
                <div className="message assistant-message">
                  <div className="message-avatar">
                    <div className="assistant-message-avatar">
                      ✨
                    </div>
                  </div>
                  <div className="message-content">
                    <div className="typing-indicator">
                      <span></span>
                      <span></span>
                      <span></span>
                    </div>
                  </div>
                </div>
              )}
              <div ref={messagesEndRef} />
            </div>
          </div>
          
          <form onSubmit={handleSubmit} className="chat-input-container">
            <input
              type="text"
              value={input}
              onChange={(e) => setInput(e.target.value)}
              placeholder="Ask about destinations, hotels, or travel tips..."
              className="chat-input"
              disabled={isTyping}
            />
            <button 
              type="submit" 
              className="chat-send-button"
              disabled={isTyping || !input.trim()}
            >
              <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M22 2L11 13" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
                <path d="M22 2L15 22L11 13L2 9L22 2Z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
              </svg>
            </button>
          </form>
        </div>
        
        <div className="map-container">
          <div className="map-header">
            <h3>Location</h3>
            <div className="map-coordinates">
              Lat: {mapLocation.lat.toFixed(4)}, Lng: {mapLocation.lng.toFixed(4)}
            </div>
          </div>
          <div className="map-content">
            {/* Google Maps iframe with dynamic location */}
            <iframe
              title="Location Map"
              width="100%"
              height="100%"
              frameBorder="0"
              style={{ border: 0 }}
              src={`https://www.google.com/maps/embed/v1/view?key=AIzaSyBFw0Qbyq9zTFTd-tUY6dZWTgaQzuU17R8&center=${mapLocation.lat},${mapLocation.lng}&zoom=12`}
              allowFullScreen
            />
          </div>
          <div className="map-footer">
            <div className="map-suggestion">
              <p>Try asking about: <span>New York</span>, <span>Paris</span>, or <span>Tokyo</span></p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default AIAssistant;