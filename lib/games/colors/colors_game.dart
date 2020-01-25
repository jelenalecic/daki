import 'package:daki/customviews/best_result_view.dart';
import 'package:daki/customviews/current_points_view.dart';
import 'package:daki/dialogs.dart';
import 'package:daki/games/colors/color_element.dart';
import 'package:daki/games/colors/color_model.dart';
import 'package:daki/games/colors/colors_provider.dart';
import 'package:daki/storage/app_persistent_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const int noOfElements = 100;

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Colors',
          style: TextStyle(fontFamily: 'Freckles', fontSize: 30),
        ),
      ),
      body: ChangeNotifierProvider<ColorsProvider>(
          create: (_) => ColorsProvider(
              screenWidth, screenHeight, noOfElements, onEndGame),
          child: Consumer<ColorsProvider>(
            builder: (context, provider, child) {
              return Container(
                color: provider.background,
                child: Stack(
                  children: <Widget>[
                    Wrap(
                      children: <Widget>[
                        CurrentPointView(
                          provider.points,
                          Colors.black,
                        ),
                        Center(
                          child: Container(
                              height: bigCircleSize,
                              width: bigCircleSize,
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
                        ),
                        Container(
                          height: 20,
                        ),
                        Container(
                          width: screenWidth,
                          height: screenWidth,
                          child: GridView.count(
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0,
                            padding: EdgeInsets.all(20),
                            crossAxisCount: 3,
                            children: generateUiElements(provider),
                          ),
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: BestResult(
                            Provider.of<AppPersistentDataProvider>(context)
                                .getMaxForGame('colors')),
                      ),
                    )
                  ],
                ),
              );
            },
          )),
    );
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

  void onEndGame(int result, bool hasWon) {
    if (Provider.of<AppPersistentDataProvider>(context, listen: false)
        .isBestResult('colors', result)) {
      showCongratulationsDialog(context, result, 'colors', hasWon);
    } else {
      showEndDialog(context, 'You lost', 'CLOSE');
    }
  }
}
