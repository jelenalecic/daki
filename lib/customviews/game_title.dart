import 'package:flutter/material.dart';

class GameTitle extends StatelessWidget {
  const GameTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style:
            TextStyle(fontFamily: 'Freckles', fontSize: 30, letterSpacing: 2));
  }
}
