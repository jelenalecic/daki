import 'package:daki/dialogs.dart';
import 'package:daki/falling/falling_element.dart';
import 'package:daki/falling/falling_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const int numberOfXChunks = 10;
const int noOfElements = 500;

class FallingGame extends StatefulWidget {
  @override
  _FallingGameState createState() => _FallingGameState();
}

class _FallingGameState extends State<FallingGame> {
  List<Widget> fallingElements = <Widget>[];

  double chunkWidth;
  double screenHeight;

  @override
  Widget build(BuildContext context) {
    chunkWidth ??= MediaQuery.of(context).size.width / numberOfXChunks;
    screenHeight ??= MediaQuery.of(context).size.height;
    return Container(
        color: Colors.pinkAccent,
        child: ChangeNotifierProvider<FallingProvider>(
            create: (_) => FallingProvider(
                chunkWidth, screenHeight, noOfElements, gameFinished),
            child: Stack(
              children: <Widget>[
                Stack(
                  children: generateUiElements(noOfElements),
                ),
                Consumer<FallingProvider>(
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

  List<FallingElement> generateUiElements(int noOfElements) {
    List<FallingElement> elements = [];

    for (int i = 0; i < noOfElements; i++) {
      elements.add(FallingElement(i));
    }

    return elements;
  }

  void gameFinished() {
    showEndDialog(context, 'You lost', 'CLOSE');
  }
}
