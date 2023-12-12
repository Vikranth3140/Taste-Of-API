import 'package:flutter/material.dart';

class  ItalianBundle {
  final int id;
  final String item, imageSrc;
  final Color color;

  ItalianBundle({
    required this.id,
    required this.item,
    required this.imageSrc,
    required this.color,
  });
}

List<ItalianBundle> italianBundle = [
  ItalianBundle(
    id: 1,
    item: "Biryani",
    imageSrc: "https://www.indianhealthyrecipes.com/wp-content/uploads/2022/02/hyderabadi-biryani-recipe-chicken.jpg",
    color: Color(0xffff9933),
  ),
];