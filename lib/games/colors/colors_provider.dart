import 'dart:async';
import 'dart:math';

import 'package:daki/games/colors/color_model.dart';
import 'package:flutter/material.dart';

const int noOfCircles = 9;
const int baseColor = 0xff000000;
const int whiteColor = 0xffffff;
const int maxTimePerLevel = 5;
const int timeRunOut = -1;

class ColorsProvider with ChangeNotifier {
  ColorsProvider(this.width, this.height, this.endGame) {
    size = width / 5;
    timeLeftInLevel = maxTimePerLevel;
    random = Random();
    background = Colors.white;
    bigCircleColor = generateMainColor();
    ticker = StreamController();

    generateCircles();
    initiateTimer();
  }

  double width;
  double height;
  Function endGame;
  Color background;
  double size;
  Random random;
  Color bigCircleColor;
  StreamController<int> ticker;
  Timer timer;
  int timeLeftInLevel;
  List<ColorModel> colorModels = [];
  Color currentColor;
  int points = 0;

  void initiateTimer() {
    timer = Timer.periodic(
        Duration(seconds: 1), (Timer t) => timeIntervalTrigger());
  }

  void startNextLevel() {
    ++points;
    generateCircles();
    timeLeftInLevel = maxTimePerLevel;
    ticker.add(null);
    notifyListeners();
  }

  void generateCircles() {
    colorModels.clear();
    bigCircleColor = generateMainColor();
    for (int i = 0; i < noOfCircles - 1; i++) {
      colorModels
          .add(ColorModel(generateMainColor(endColor: whiteColor), size, size));
    }
    colorModels.add(ColorModel(bigCircleColor, size, size));
    colorModels.shuffle();
  }

  void timeIntervalTrigger() {
    if (timeLeftInLevel == timeRunOut) {
      gameLost();
      return;
    }
    ticker.add(timeLeftInLevel);
    --timeLeftInLevel;
  }

  Color generateMainColor({int endColor = whiteColor}) {
    return Color(baseColor + random.nextInt(endColor));
  }

  void terminateStream() {
    ticker.close();
  }

  void terminateTimer() {
    timer.cancel();
  }

  void pressedColor(Color color) {
    if (color == bigCircleColor) {
      startNextLevel();
    } else {
      gameLost();
    }
  }

  void gameLost() {
    terminateStream();
    terminateTimer();

    endGame(points);
  }

  @override
  void dispose() {
    terminateStream();
    terminateTimer();
    super.dispose();
  }
}
