import 'dart:async';

import 'package:daki/falling_element.dart';
import 'package:daki/falling_game_provider.dart';
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
              provider =
                  FallingGameProvider(width, height, noOfElements, killTimer);
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
}
