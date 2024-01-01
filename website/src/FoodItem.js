// FoodItem.js
import React from 'react';

const FoodItem = ({ cuisine, image, onExplore }) => {
    const handleExploreClick = () => {
        // Call the callback function to trigger the change
        onExplore();
    };

    return (
        <div className="item">
            <img src={image} alt={`${cuisine} Cuisine`} />
            <div className="overlay">
                <h4>{cuisine} Cuisine</h4>
            </div>
            <button onClick={handleExploreClick}>Explore</button>
        </div>
    );
};

export default FoodItem;
