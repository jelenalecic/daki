import 'dart:async';
import 'dart:math';

import 'package:daki/games/colors/color_model.dart';
import 'package:flutter/material.dart';

const int noOfCircles = 9;
const int baseColor = 0xff000000;
const int white = 0xffffffff;
const int nonTransparentWhite = 0x00ffffff;
const int maxTimePerLevel = 5;
const int timeRunOut = -1;
const int colorMax = 255;

class ColorsProvider with ChangeNotifier {
  ColorsProvider(this.width, this.height, this.noOfElements, this.endGame) {
    size = width / 5;
    timeLeftInLevel = maxTimePerLevel;
    random = Random();
    background = Colors.white;
    bigCircleColor = generateRandomColor();
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
  int noOfElements;

  void initiateTimer() {
    timer = Timer.periodic(
        Duration(seconds: 1), (Timer t) => timeIntervalTrigger());
  }

  void startNextLevel() {
    ++points;
    generateCircles();
    timeLeftInLevel = maxTimePerLevel;
    ticker.add(null);

    if (points == noOfElements) {
      finishGame(true);
    }

    notifyListeners();
  }

  void generateCircles() {
    colorModels.clear();
    bigCircleColor = generateRandomColor();
    for (int i = 0; i < noOfCircles - 1; i++) {
      colorModels.add(ColorModel(
          generateSimilarColor(bigCircleColor, getSimilarityFactor()),
          size,
          size));
    }
    colorModels.add(ColorModel(bigCircleColor, size, size));
    colorModels.shuffle();
  }

  void timeIntervalTrigger() {
    if (timeLeftInLevel == timeRunOut) {
      finishGame(false);
      return;
    }
    ticker.add(timeLeftInLevel);
    --timeLeftInLevel;
  }

  Color generateRandomColor() {
    return Color(baseColor + random.nextInt(nonTransparentWhite));
  }

  Color generateSimilarColor(Color bigCircleColor, double similarityFactor) {
    int red =
        ((bigCircleColor.red + random.nextInt(colorMax) * similarityFactor))
                .toInt() %
            colorMax;
    int green =
        ((bigCircleColor.green + random.nextInt(colorMax) * similarityFactor))
                .toInt() %
            colorMax;
    int blue =
        ((bigCircleColor.blue + random.nextInt(colorMax) * similarityFactor))
                .toInt() %
            colorMax;

    return Color.fromARGB(colorMax, red, green, blue);
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
      finishGame(false);
    }
  }

  void finishGame(bool hasWon) {
    terminateStream();
    terminateTimer();

    endGame(points, hasWon);
  }

  @override
  void dispose() {
    terminateStream();
    terminateTimer();
    super.dispose();
  }

  ///0 is most similar
  double getSimilarityFactor() {
    return (noOfElements - points) / noOfElements;
  }
}
