import 'package:flutter/material.dart';

class  ArabicBundle {
  final int id;
  final String item, imageSrc;
  final Color color;

  ArabicBundle({
    required this.id,
    required this.item,
    required this.imageSrc,
    required this.color,
  });
}

List<ArabicBundle> arabicBundle = [
  ArabicBundle(
    id: 1,
    item: "Biryani",
    imageSrc: "https://www.indianhealthyrecipes.com/wp-content/uploads/2022/02/hyderabadi-biryani-recipe-chicken.jpg",
    color: Colors.yellow.shade100,
  ),
];