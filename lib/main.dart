import 'package:daki/games/colors/colors_game.dart';
import 'package:daki/games/falling/falling_game.dart';
import 'package:daki/games/surround/surround_game.dart';
import 'package:flutter/material.dart';

void main() => runApp(DakiApp());

class DakiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.pink[800],
      ),
      home: Stack(
        children: <Widget>[
          Container(
            color: Colors.pink,
          ),
          Container(
            width: double.infinity,
//            color: Colors.blue.withOpacity(0.5),
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
                        )),
                Container(
                  height: 50,
                ),
                Builder(
                    builder: (context) => RaisedButton(
                          child: Text(
                            'SURROUND',
                            style: TextStyle(
                                color: Colors.pinkAccent,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            openSurround(context);
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
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => FallingGame()));
  }

  void openColors(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => ColorsGame()));
  }

  void openSurround(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => SurroundGame()));
  }
}
