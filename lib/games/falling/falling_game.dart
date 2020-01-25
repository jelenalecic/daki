import 'package:daki/customviews/best_result_view.dart';
import 'package:daki/customviews/current_points_view.dart';
import 'package:daki/dialogs.dart';
import 'package:daki/games/falling/falling_element.dart';
import 'package:daki/games/falling/falling_provider.dart';
import 'package:daki/storage/app_persistent_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const int numberOfXChunks = 10;
const int noOfElements = 200;

class FallingGame extends StatefulWidget {
  @override
  _FallingGameState createState() => _FallingGameState();
}

class _FallingGameState extends State<FallingGame> {
  List<Widget> fallingElements = <Widget>[];

  double chunkWidth;
  double heightBelowAppBar;

  @override
  Widget build(BuildContext context) {
    chunkWidth ??= MediaQuery.of(context).size.width / numberOfXChunks;
    heightBelowAppBar ??= MediaQuery.of(context).size.height - 100;
    return Scaffold(
      appBar: AppBar(
        title: Text('Falling',
            style: TextStyle(fontFamily: 'Freckles', fontSize: 30)),
      ),
      body: Container(
          color: Colors.white,
          child: ChangeNotifierProvider<FallingProvider>(
              create: (_) => FallingProvider(
                  chunkWidth, heightBelowAppBar, noOfElements, gameFinished),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: BestResult(
                          Provider.of<AppPersistentDataProvider>(context)
                              .getMaxForGame('falling')),
                    ),
                  ),
                  Stack(
                    children: generateUiElements(noOfElements),
                  ),
                  Consumer<FallingProvider>(
                    builder: (context, provider, child) {
                      return CurrentPointView(
                        provider.points,
                        Colors.black,
                        maxPoints: noOfElements,
                      );
                    },
                  )
                ],
              ))),
    );
  }

  List<FallingElement> generateUiElements(int noOfElements) {
    List<FallingElement> elements = [];

    for (int i = 0; i < noOfElements; i++) {
      elements.add(FallingElement(i));
    }

    return elements;
  }

  void gameFinished(int result, bool hasWon) {
    if (Provider.of<AppPersistentDataProvider>(context, listen: false)
        .isBestResult('falling', result)) {
      showCongratulationsDialog(context, result, 'falling', hasWon);
    } else {
      showEndDialog(context, 'You lost', 'CLOSE');
    }
  }
}
