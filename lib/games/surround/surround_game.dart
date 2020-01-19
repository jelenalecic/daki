import 'package:daki/customviews/current_points_view.dart';
import 'package:daki/dialogs.dart';
import 'package:daki/games/surround/surround_falling_element.dart';
import 'package:daki/games/surround/surround_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const int noOfElements = 500;

class SurroundGame extends StatefulWidget {
  @override
  _SurroundGameState createState() => _SurroundGameState();
}

class _SurroundGameState extends State<SurroundGame> {
  double screenWidth;
  double heightBelowAppBar;

  @override
  Widget build(BuildContext context) {
    screenWidth ??= MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Catcher',
          style: TextStyle(fontFamily: 'Freckles', fontSize: 30),
        ),
      ),
      body: Builder(builder: (BuildContext underAppBarContext) {
        heightBelowAppBar ??= MediaQuery.of(context).size.height - 100;
        return Container(
          color: Colors.white,
          child: ChangeNotifierProvider<SurroundProvider>(
              create: (_) => SurroundProvider(screenWidth, heightBelowAppBar,
                  screenWidth / 10, noOfElements, gameFinished),
              child: Stack(
                children: <Widget>[
                  Stack(
                    children: generateUiElements(noOfElements),
                  ),
                  Stack(
                    children: <Widget>[
                      //add other elements that are consumers
                      Consumer<SurroundProvider>(
                        builder: (context, provider, child) {
                          return Positioned(
                              top: provider?.surroundCircleY,
                              left: provider?.surroundCircleX,
                              child: Container(
                                  width: provider?.surroundCircleSize,
                                  height: provider?.surroundCircleSize,
                                  decoration: BoxDecoration(
                                      color: Colors.yellow.withOpacity(0.2),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.yellow
                                              .withOpacity(0.9)))));
                        },
                      )
                    ],
                  ),
                  Builder(
                    builder: (BuildContext builderContext) => GestureDetector(
                      onPanUpdate: (DragUpdateDetails details) {
                        Provider.of<SurroundProvider>(builderContext,
                                listen: false)
                            .updateCatcher(details.delta.dx, details.delta.dy);
                      },
                    ),
                  ),
                  Consumer<SurroundProvider>(
                    builder: (context, provider, child) {
                      return CurrentPointView(provider.points, Colors.black);
                    },
                  )
                ],
              )),
        );
      }),
    );
  }

  List<Widget> generateUiElements(int noOfElements) {
    List<SurroundFallingElement> elements = [];

    for (int i = 0; i < noOfElements; i++) {
      elements.add(SurroundFallingElement(i));
    }

    return elements;
  }

  void gameFinished() {
    showEndDialog(context, 'You lost', 'CLOSE');
  }
}
