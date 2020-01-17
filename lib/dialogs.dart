import 'package:daki/transparent_slide_in_dialog_route.dart';
import 'package:flutter/material.dart';

void showEndDialog(BuildContext context, String text, String buttonText) {
  Navigator.of(context).push(TransparentSlideInDialogRoute(Center(
    child: Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
          ),
          Container(
            height: 20,
          ),
          RaisedButton(
            color: Colors.pink,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(buttonText,
                style: TextStyle(fontSize: 20, color: Colors.white)),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          )
        ],
      ),
    ),
  )));
}
