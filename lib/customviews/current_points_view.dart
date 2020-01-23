import 'package:flutter/material.dart';

class CurrentPointView extends StatelessWidget {
  CurrentPointView(this.points, this.color, {this.maxPoints});

  final Color color;
  final int points;
  final int maxPoints;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 20),
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
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none),
                ),
                if (maxPoints != null)
                  Text(
                    ' /$maxPoints',
                    style: TextStyle(
                        color: Colors.black,
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
