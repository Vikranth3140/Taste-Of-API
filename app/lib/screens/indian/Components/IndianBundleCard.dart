import 'package:flutter/material.dart';
import 'package:recipe_app/size_config.dart';
import 'package:recipe_app/screens/indian/Components/IndianBundle.dart';

class IndianBundleCard extends StatefulWidget {
  final IndianBundle indianBundle;
  final Function press;

  const IndianBundleCard({
    Key? key,
    required this.indianBundle,
    required this.press,
  }) : super(key: key);

  @override
  _IndianBundleCardState createState() => _IndianBundleCardState();
}

class _IndianBundleCardState extends State<IndianBundleCard> {
  bool _isFlipped = false;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;

    return GestureDetector(
      onTap: () {

      },
      onLongPress: () {setState(() {
          _isFlipped = !_isFlipped;
        });
      },
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: !_isFlipped
            ? _buildFrontCard(defaultSize)
            : _buildBackCard(defaultSize),
      ),
    );
  }

  Widget _buildFrontCard(double defaultSize) {
    return Container(
      key: ValueKey<bool>(_isFlipped),
      decoration: BoxDecoration(
        color: widget.indianBundle.color,
        borderRadius: BorderRadius.circular(defaultSize * 1.8),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(defaultSize * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Spacer(),
                  Text(
                    widget.indianBundle.item,
                    style: TextStyle(
                      fontSize: defaultSize * 3.5,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: defaultSize * 0.5),
                  Spacer(),
                ],
              ),
            ),
          ),
          SizedBox(width: defaultSize * 0.5),
          AspectRatio(
            aspectRatio: 0.71,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              child: Image.network(
                widget.indianBundle.imageSrc,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackCard(double defaultSize) {
    return Container(
      key: ValueKey<bool>(_isFlipped),
      decoration: BoxDecoration(
        color: widget.indianBundle.color,
        borderRadius: BorderRadius.circular(defaultSize * 1.8),
      ),
      child: Center(
        child: Text(
          'Calories: 400\nProtein: 30g\nFats: 10g\nEnergy: 200kcal', // Customize this with your back card content
          style: TextStyle(
            fontSize: defaultSize * 3.5,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
    );
  }
}
