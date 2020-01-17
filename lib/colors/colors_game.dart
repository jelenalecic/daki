import 'package:daki/colors/color_element.dart';
import 'package:daki/colors/color_model.dart';
import 'package:daki/colors/colors_provider.dart';
import 'package:daki/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColorsGame extends StatefulWidget {
  @override
  _ColorsGameState createState() => _ColorsGameState();
}

class _ColorsGameState extends State<ColorsGame> {
  double screenHeight;
  double screenWidth;

  double bigCircleSize;

  @override
  Widget build(BuildContext context) {
    screenHeight ??= MediaQuery.of(context).size.height;
    screenWidth ??= MediaQuery.of(context).size.width;
    bigCircleSize ??= screenHeight / 6;
    return ChangeNotifierProvider<ColorsProvider>(
        create: (_) => ColorsProvider(screenWidth, screenHeight, onEndGame),
        child: Consumer<ColorsProvider>(
          builder: (context, provider, child) {
            return Container(
              color: provider.background,
              child: Stack(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          height: bigCircleSize,
                          width: bigCircleSize,
                          margin: EdgeInsets.only(top: screenHeight / 7),
                          child: StreamBuilder<int>(
                            stream: provider.ticker.stream,
                            builder: (context, snapshot) => Center(
                              child: snapshot.data != null
                                  ? Text('${snapshot.data}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 45,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.bold))
                                  : Container(),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: provider.bigCircleColor,
                            shape: BoxShape.circle,
                          )),
                      Container(
                        height: 40,
                      ),
                      Container(
                        width: screenWidth,
                        height: screenWidth,
                        child: GridView.count(
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 0,
                          padding: EdgeInsets.all(0),
                          crossAxisCount: 3,
                          children: generateUiElements(provider),
                        ),
                      )
                    ],
                  ),
                  SafeArea(
                    child: Container(
                      child: Text(
                        '${provider.points}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none),
                      ),
                      alignment: Alignment.topCenter,
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }

  List<Widget> generateUiElements(ColorsProvider provider) {
    List<ColorElement> elements = [];

    for (int i = 0; i < provider.colorModels.length; i++) {
      ColorModel model = provider.colorModels[i];
      elements.add(ColorElement(model.color, model.width, model.height, i,
          (Color color) {
        provider?.pressedColor(color);
      }));
    }

    return elements;
  }

  void onEndGame() {
    showEndDialog(context, 'You lost', 'CLOSE');
  }
}
