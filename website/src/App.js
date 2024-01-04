// App.js
import React, { useState } from 'react';
import FoodItem from './FoodItem';
import Cuisines from './Cuisines';
import './App.css';

const App = () => {
  const [currentView, setCurrentView] = useState('main');

  const handleExploreClick = () => {
    // Change the view to 'cuisines' when the Explore button is clicked
    setCurrentView('cuisines');
  };

  return (
    <div>
      {currentView === 'main' && (
        <>
          <h1>
            Taste Of API
            <img src="/assets/TasteOfAPI.png" id="logo" alt="Taste Of API" />
          </h1>
          <nav>
            <ul>
              <a href="cuisines.html">
                <li>
                  <img src="/assets/chatbot.png" id="chatbot" alt="Chatbot" />
                </li>
              </a>
            </ul>
          </nav>

          <section className="items">
            <FoodItem cuisine="Indian" image="/assets/Indian.jpg" onExplore={handleExploreClick} />
            <FoodItem cuisine="Italian" image="/assets/Italian.jpg" onExplore={handleExploreClick} />
            <FoodItem cuisine="Canadian" image="/assets/Canadian.jpg" onExplore={handleExploreClick} />
          </section>
        </>
      )}

      {currentView === 'cuisines' && <Cuisines />}
    </div>
  );
};

export default App;
