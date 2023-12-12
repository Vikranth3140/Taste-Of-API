import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recipe_app/components/my_bottom_nav_bar.dart';
import 'package:recipe_app/size_config.dart';
import 'package:recipe_app/screens/italian/components/Body.dart';


class Italian extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        // Adjust the value of 'top' in EdgeInsets to change the distance
        padding: EdgeInsets.only(top: SizeConfig.defaultSize * 0.1), // Example: 2 * 10 (defaultSize) = 20
        child: Body(),
      ),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/menu.svg"),
        onPressed: () {},
      ),
      backgroundColor: Colors.teal.shade600,
      // On Android by default its false
      centerTitle: true,
      title: Image.asset("assets/images/Logo Preview 1.png"),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/icons/search.svg"),
          onPressed: () {},
        ),
        SizedBox(
          // It means 5 because by out defaultSize = 10
          width: SizeConfig.defaultSize * 0.5,
        ),
      ],
    );
  }
}
