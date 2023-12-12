import 'package:flutter/material.dart';

class  ChineseBundle {
  final int id;
  final String item, imageSrc;
  final Color color;

  ChineseBundle({
    required this.id,
    required this.item,
    required this.imageSrc,
    required this.color,
  });
}

List<ChineseBundle> chineseBundle = [
  ChineseBundle(
    id: 1,
    item: "Biryani",
    imageSrc: "https://www.indianhealthyrecipes.com/wp-content/uploads/2022/02/hyderabadi-biryani-recipe-chicken.jpg",
    color: Colors.yellow.shade100,
  ),
];