import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton(this.onTap, this.text);

  final Function onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
            letterSpacing: 4,
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        onTap();
      },
      shape: RoundedRectangleBorder(
          side: BorderSide(width: 5, color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      color: Colors.black,
      colorBrightness: Brightness.dark,
      highlightColor: Colors.pink,
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
    );
  }
}
