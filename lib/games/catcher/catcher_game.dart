import 'package:daki/customviews/best_result_view.dart';
import 'package:daki/customviews/current_points_view.dart';
import 'package:daki/customviews/game_title.dart';
import 'package:daki/dialogs.dart';
import 'package:daki/games/catcher/catcher_falling_element.dart';
import 'package:daki/games/catcher/catcher_provider.dart';
import 'package:daki/storage/app_persistent_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

const int noOfElements = 200;

class CatcherGame extends StatefulWidget {
  @override
  _SurroundGameState createState() => _SurroundGameState();
}

class _SurroundGameState extends State<CatcherGame> {
  double screenWidth;
  double heightBelowAppBar;

  @override
  Widget build(BuildContext context) {
    screenWidth ??= MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: GameTitle('Catcher'),
      ),
      body: Builder(builder: (BuildContext underAppBarContext) {
        heightBelowAppBar ??= MediaQuery.of(context).size.height - 100;
        return Container(
          color: Colors.white,
          child: ChangeNotifierProvider<CatcherProvider>(
            create: (_) => CatcherProvider(screenWidth, heightBelowAppBar,
                screenWidth / 11, noOfElements, gameFinished),
            child: Stack(
              children: <Widget>[
                Stack(
                  children: generateUiElements(noOfElements),
                ),
                Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: BestResult(
                            Provider.of<AppPersistentDataProvider>(context)
                                .getMaxForGame('catcher')),
                      ),
                    ),
                    //add other elements that are consumers
                    Consumer<CatcherProvider>(
                      builder: (context, provider, child) {
                        return Positioned(
                            top: provider?.netY,
                            left: provider?.netX,
                            child: Container(
                              width: provider?.netSize,
                              height: provider?.netSize,
                              child: SvgPicture.asset(
                                'assets/images/net3.svg',
                                fit: BoxFit.cover,
                                width: provider?.netSize,
                                height: provider?.netSize,
                              ),
                            ));
                      },
                    )
                  ],
                ),
                Builder(
                  builder: (BuildContext builderContext) => GestureDetector(
                    onPanUpdate: (DragUpdateDetails details) {
                      Provider.of<CatcherProvider>(builderContext,
                              listen: false)
                          .updateCatcher(details.delta.dx, details.delta.dy);
                    },
                  ),
                ),
                Consumer<CatcherProvider>(
                  builder: (context, provider, child) {
                    return CurrentPointView(
                      provider.points,
                      Colors.black,
                      maxPoints: noOfElements,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  List<Widget> generateUiElements(int noOfElements) {
    List<CatcherFallingElement> elements = [];

    for (int i = 0; i < noOfElements; i++) {
      elements.add(CatcherFallingElement(i));
    }

    return elements;
  }

  void gameFinished(int result, bool hasWon) {
    if (Provider.of<AppPersistentDataProvider>(context, listen: false)
        .isBestResult('catcher', result)) {
      showCongratulationsDialog(context, result, 'catcher', hasWon);
    } else {
      showEndDialog(context, 'CLOSE');
    }
  }
}
