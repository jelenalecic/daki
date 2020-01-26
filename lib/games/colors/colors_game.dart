import 'package:daki/customviews/best_result_view.dart';
import 'package:daki/customviews/current_points_view.dart';
import 'package:daki/customviews/game_title.dart';
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
    bigCircleSize ??= screenHeight / 7;
    return Scaffold(
      appBar: AppBar(
        title: GameTitle('Colors'),
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
                    getBackground(provider),
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: <Widget>[
                        CurrentPointView(
                          provider.points,
                          Colors.black,
                          maxPoints: noOfElements,
                        ),
                        Center(
                          child: Container(
                              margin: EdgeInsets.only(top: 20),
                              height: bigCircleSize,
                              width: bigCircleSize,
                              child: StreamBuilder<int>(
                                stream: provider.ticker.stream,
                                builder: (context, snapshot) => Center(
                                  child: snapshot.data != null
                                      ? Text('${snapshot.data}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 35,
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
                          width: screenWidth * 0.8,
                          height: screenWidth * 0.8,
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
      showEndDialog(context);
    }
  }

  Widget getBackground(ColorsProvider provider) {
    if (provider.points < noOfElements / 4) {
      return Container();
    } else if (provider.points < noOfElements / 2) {
      return getGradientContainer(Colors.pink, Colors.yellow);
    } else if (provider.points < noOfElements * 2 / 3) {
      return getGradientContainer(Colors.black, Colors.white);
    } else {
      return Container(color: Colors.black);
    }
  }

  Widget getGradientContainer(Color color1, Color color2) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: <Color>[color1, color2],
        ),
      ),
    );
  }
}
