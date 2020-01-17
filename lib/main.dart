import 'package:daki/colors/colors_game.dart';
import 'package:daki/falling/falling_game.dart';
import 'package:flutter/material.dart';

void main() => runApp(DakiApp());

class DakiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(
        children: <Widget>[
          Container(
            child: Image.asset(
              'assets/images/background.jpg',
              height: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.blue.withOpacity(0.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Builder(
                    builder: (context) => RaisedButton(
                          child: Text(
                            'FALLING',
                            style: TextStyle(
                                color: Colors.pinkAccent,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            openFalling(context);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        )),
                Container(
                  height: 50,
                ),
                Builder(
                    builder: (context) => RaisedButton(
                          child: Text(
                            'COLORS',
                            style: TextStyle(
                                color: Colors.pinkAccent,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            openColors(context);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ))
              ],
            ),
          )
        ],
      ),
    );
  }

  void openFalling(BuildContext context) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => FallingGame()));
  }

  void openColors(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) => ColorsGame()));
  }
}
