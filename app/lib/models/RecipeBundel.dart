import 'package:flutter/material.dart';
import 'package:recipe_app/screens/indian/Indian.dart';
import 'package:recipe_app/screens/italian/Italian.dart';
import 'package:recipe_app/screens/mexican/Mexican.dart';
import 'package:recipe_app/screens/chinese/Chinese.dart';

class RecipeBundel {
  final int id;
  final String Cuisine, ImageSRC;
  final Color COLOR;
  final Widget? Destination;

  RecipeBundel(
      {required this.id,
      required this.Cuisine,
      required this.ImageSRC,
      required this.COLOR,
      this.Destination});

  bool destinationchecker() {
    if (Destination != null) {
      return true;
    }
    return false;
  }

  Widget getDestination() {
    return Destination!;
  }
}

// Demo list
List<RecipeBundel> recipeBundle = [
  RecipeBundel(
    id: 1,
    // recipes: 95,
    Cuisine: "Indian",
    ImageSRC: "assets/images/final 1.png",
    COLOR: Colors.yellow.shade100,
    Destination: Indian()
  ),
  RecipeBundel(
    id: 2,
    // recipes: 26,
    Cuisine: "Chinese",
    ImageSRC: "assets/images/Chinese 1.png",
    COLOR: Colors.yellow.shade100,
    Destination: Chinese()
  ),
  RecipeBundel(
    id: 3,
    // recipes: 43,
    Cuisine: "Italian",
    ImageSRC: "assets/images/food_court@2x.png",
    COLOR: Colors.yellow.shade100,
    Destination: Italian()
  ),
  RecipeBundel(
    id: 4, 
    Cuisine: "Mexican",
    ImageSRC: "assets/images/food_court@2x.png",
    COLOR: Colors.yellow.shade100,
    Destination: Mexican()
  ),
  RecipeBundel(
    id: 5, 
    Cuisine: "Bangladesh",
    ImageSRC: "assets/images/food_court@2x.png",
    COLOR: Colors.yellow.shade100,
    Destination: Mexican()
  ),
  RecipeBundel(
    id: 6, 
    Cuisine: "Pakistan",
    ImageSRC: "assets/images/food_court@2x.png",
    COLOR: Colors.yellow.shade100,
    Destination: Mexican()
  ),
  RecipeBundel(
    id: 7, 
    Cuisine: "Germany",
    ImageSRC: "assets/images/food_court@2x.png",
    COLOR: Colors.yellow.shade100,
    Destination: Mexican()
  ),
  RecipeBundel(
    id: 8, 
    Cuisine: "France",
    ImageSRC: "assets/images/food_court@2x.png",
    COLOR: Colors.yellow.shade100,
    Destination: Mexican()
  ),
  RecipeBundel(
    id: 9, 
    Cuisine: "American",
    ImageSRC: "assets/images/food_court@2x.png",
    COLOR: Colors.yellow.shade100,
    Destination: Mexican()
  ),
  RecipeBundel(
    id: 10, 
    Cuisine: "Arabic",
    ImageSRC: "assets/images/food_court@2x.png",
    COLOR: Colors.yellow.shade100,
    Destination: Mexican()
  ),
];
