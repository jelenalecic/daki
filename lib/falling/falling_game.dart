import 'dart:async';

import 'package:daki/falling/falling_element.dart';
import 'package:daki/falling/falling_game_provider.dart';
import 'package:daki/transparent_slide_in_dialog_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FallingGame extends StatefulWidget {
  @override
  _FallingGameState createState() => _FallingGameState();
}

class _FallingGameState extends State<FallingGame> {
  FallingGameProvider provider;
  List<Widget> fallingElements = <Widget>[];
  int noOfElements = 500;

  Timer timer;
  double width;
  double height;

  @override
  void initState() {
    timer = Timer.periodic(
        Duration(milliseconds: 64), (Timer t) => provider?.updateCoordinates());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width ??= MediaQuery.of(context).size.width / 10;
    height ??= MediaQuery.of(context).size.height;
    return Container(
        color: Colors.pinkAccent,
        child: ChangeNotifierProvider<FallingGameProvider>(
            create: (_) {
              provider = FallingGameProvider(
                  width, height, noOfElements, gameFinished);
              return provider;
            },
            child: Stack(
              children: <Widget>[
                Stack(
                  children: generateElements(noOfElements),
                ),
                Consumer<FallingGameProvider>(
                  builder: (context, provider, child) {
                    return SafeArea(
                      child: Container(
                        child: Text(
                          '${provider.points}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none),
                        ),
                        alignment: Alignment.topCenter,
                      ),
                    );
                  },
                )
              ],
            )));
  }

  @override
  void dispose() {
    killTimer();
    super.dispose();
  }

  void killTimer() {
    timer.cancel();
  }

  List<FallingElement> generateElements(int noOfElements) {
    List<FallingElement> elements = [];

    for (int i = 0; i < noOfElements; i++) {
      elements.add(FallingElement(i));
    }

    return elements;
  }

  void gameFinished() {
    killTimer();
    showEndDialog();
  }

  void showEndDialog() {
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
              'You lost :(',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
            ),
            Container(
              height: 20,
            ),
            RaisedButton(
              color: Colors.pink,
              padding: EdgeInsets.symmetric(
                  horizontal: 20, vertical: 10),
              child: Text('CLOSE',
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
}
