import 'package:flutter/material.dart';

class ColorElement extends StatelessWidget {
  const ColorElement(
      this.color, this.width, this.height, this.position, this.onPress);

  final Color color;
  final double width;
  final double height;

  final int position;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            onPress(color);
          },
          child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        ));
  }
}
