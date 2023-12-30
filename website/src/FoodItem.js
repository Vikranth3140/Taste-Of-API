import React from 'react';

const FoodItem = ({ cuisine, image }) => {
    return (
        <div className="item">
            <img src={image} alt={`${cuisine} Cuisine`} />
            <div className="overlay">
                <h4>{cuisine} Cuisine</h4>
            </div>
            <button>Explore</button>
        </div>
    );
};

export default FoodItem;
