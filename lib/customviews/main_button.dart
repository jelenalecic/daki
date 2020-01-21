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
            color: Colors.pinkAccent,
            fontSize: 30,
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        onTap();
      },
      shape: RoundedRectangleBorder(
          side: BorderSide(width: 5, color: Colors.green),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    );
  }
}
