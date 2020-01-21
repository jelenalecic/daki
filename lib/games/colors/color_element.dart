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
      child: Container(
          width: width,
          height: height,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
                customBorder: CircleBorder(),
                splashColor: Colors.black,
//                splashColor: Colors.black,
                onTap: () {
                  onPress(color);
                }),
          ),
          decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
    );
  }
}
