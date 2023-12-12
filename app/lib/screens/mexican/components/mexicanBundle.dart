import 'package:flutter/material.dart';

class  MexicanBundle {
  final int id;
  final String item, imageSrc;
  final Color color;

  MexicanBundle({
    required this.id,
    required this.item,
    required this.imageSrc,
    required this.color,
  });
}

List<MexicanBundle> mexicanBundle = [
  MexicanBundle(
    id: 1,
    item: "Biryani",
    imageSrc: "https://www.indianhealthyrecipes.com/wp-content/uploads/2022/02/hyderabadi-biryani-recipe-chicken.jpg",
    color: Colors.yellow.shade100,
  ),
];