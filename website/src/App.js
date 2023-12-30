import React from 'react';
import FoodItem from './FoodItem';
import './App.css';

const App = () => {

  return (
    <div>
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
        <FoodItem cuisine="Indian" image="/assets/Indian.jpg" />
        <FoodItem cuisine="Italian" image="/assets/Italian.jpg" />
        <FoodItem cuisine="Canadian" image="/assets/Canadian.jpg" />
      </section>
    </div>
  );
};

export default App;
