import 'package:flutter/material.dart';
import 'package:recipe_app/size_config.dart';
import 'package:recipe_app/screens/Pakistan/components/pakistanBundle.dart';
import 'package:recipe_app/screens/Pakistan/components/pakistanBundleCard.dart';

// import 'categories.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2),
              child: GridView.builder(
                itemCount: pakistanBundle.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: SizeConfig.orientation == Orientation.landscape ? 2 : 1,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: SizeConfig.orientation == Orientation.landscape ? SizeConfig.defaultSize * 2 : 0,
                  childAspectRatio: 2,
                ),
                itemBuilder: (context, index) => ChineseBundleCard(
                  mexicanBundle: pakistanBundle[index],
                  press: () {},
                ),
              )
            )
          )
        ],
      ) 
    );
  }
}
