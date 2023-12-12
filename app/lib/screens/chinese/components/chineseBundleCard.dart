import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/screens/chinese/components/chineseBundle.dart';
import 'package:recipe_app/size_config.dart';

class ChineseBundleCard extends StatelessWidget {
  final ChineseBundle mexicanBundle;
  final Function press;

  const ChineseBundleCard({
    Key? key,
    required this.mexicanBundle,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double defaultsize = SizeConfig.defaultSize;
    return GestureDetector(
      onTap: press as void Function()?,
      onLongPress: press as void Function()?,
      child: Container(
        decoration: BoxDecoration(
          color: mexicanBundle.color,
          borderRadius: BorderRadius.circular(defaultsize * 1.8),
        ),
        child:Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(defaultsize * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Spacer(),
                    Text(
                      mexicanBundle.item,
                      style: TextStyle(
                        fontSize: defaultsize * 3.5,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: defaultsize * 0.5),
                    Spacer(),
                  ],
                ),
              ),
            ),
            SizedBox(width: defaultsize * 0.5,),
            AspectRatio(
              aspectRatio: 0.71,
              child: Image.network(
                mexicanBundle.imageSrc,
                fit: BoxFit.cover,
                alignment: Alignment.centerLeft,
              ),
            )
          ]
        )
      ),
    );
  }

  Row buildInfoRow(double defaultsize, {required String iconSrc, text}) {
    return Row(
      children: <Widget>[
        SvgPicture.asset(iconSrc),
        SizedBox(width: defaultsize * 0.5),
        Text(
          text,
          style: TextStyle(
            color: kTextColor,
          ),
        )
      ],
    );
  }
}