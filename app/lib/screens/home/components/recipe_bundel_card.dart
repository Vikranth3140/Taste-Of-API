import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_app/models/RecipeBundel.dart';

import '../../../size_config.dart';

class RecipeBundelCard extends StatelessWidget {
  final RecipeBundel recipeBundle;
  final Function press;

  const RecipeBundelCard({Key? key, required this.recipeBundle, required this.press})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    // Now we dont this Aspect ratio
    return GestureDetector(
      onTap: press as void Function()?,
      child: Container(
        decoration: BoxDecoration(
          color: recipeBundle.COLOR,
          borderRadius: BorderRadius.circular(defaultSize * 1.8), //18
        ),
        child: Row( 
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(defaultSize * 2), //20
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Spacer(),
                    Text(
                      recipeBundle.Cuisine,
                      style: TextStyle(
                          fontSize: defaultSize * 3.5, //22
                          color: const Color.fromARGB(255, 0, 0, 0)),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: defaultSize * 0.5), // 5
                    SizedBox(height: defaultSize * 0.5), //5
                    Spacer(),
                  ],
                ),
              ),
            ),
            SizedBox(width: defaultSize * 0.5), //5
            AspectRatio(
              aspectRatio: 1,
              child: Image.asset(
                recipeBundle.ImageSRC,
                fit: BoxFit.cover,
                alignment: Alignment.centerLeft,
              ),
            )
          ],
        ),
      ),
    );
  }

  Row buildInfoRow(double defaultSize, {required String iconSrc, text}) {
    return Row(
      children: <Widget>[
        SvgPicture.asset(iconSrc),
        SizedBox(width: defaultSize), // 10
        Text(
          text,
          style: TextStyle(
            color: Color.fromARGB(255, 179, 255, 0),
          ),
        )
      ],
    );
  }
}
