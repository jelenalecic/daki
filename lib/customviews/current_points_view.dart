import 'package:flutter/material.dart';

class CurrentPointView extends StatelessWidget {
  CurrentPointView(this.points, this.color, {this.maxPoints});

  final Color color;
  final int points;
  final int maxPoints;

  @override
  Widget build(BuildContext context) {
    List<Shadow> shadows = [
      Shadow(
          // bottomLeft
          offset: Offset(-0.5, -0.5),
          color: Colors.white),
      Shadow(
          // bottomRight
          offset: Offset(0.5, -0.5),
          color: Colors.white),
      Shadow(
          // topRight
          offset: Offset(0.5, 0.5),
          color: Colors.white),
      Shadow(
          // topLeft
          offset: Offset(-0.5, 0.5),
          color: Colors.white),
    ];

    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '$points',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 50,
                      shadows: shadows,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none),
                ),
                if (maxPoints != null)
                  Text(
                    ' / $maxPoints',
                    style: TextStyle(
                        color: Colors.black,
                        shadows: shadows,
                        fontSize: 20,
                        decoration: TextDecoration.none),
                  ),
              ],
            ),
          ],
        ),
        alignment: Alignment.topCenter,
      ),
    );
  }
}
