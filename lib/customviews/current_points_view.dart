import 'package:flutter/material.dart';

class CurrentPointView extends StatelessWidget {
  CurrentPointView(this.points, this.color,
      {this.maxPoints, this.bestEverPoints});

  final Color color;
  final int points;
  final int maxPoints;
  final int bestEverPoints;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        child: Text(
          '$points',
          style: TextStyle(
              color: Colors.black,
              fontSize: 40,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none),
        ),
        alignment: Alignment.topCenter,
      ),
    );
  }
}
