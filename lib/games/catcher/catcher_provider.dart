import 'dart:async';
import 'dart:math';

import 'package:daki/games/catcher/catcher_falling_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const double bugSize = 50;

const double minCircleSize = 40;
const double maXCircleSize = 200;
const double yIncrement = 100.0;
const double minYMovement = 0.7;
const double yMovementIncrement = 0.2;

const int refreshRate = 16;

class CatcherProvider with ChangeNotifier {
  CatcherProvider(this.screenWidth, this.screenHeight, this.chunkWidth,
      this.noOfElements, this.endGame) {
    catcherRect = Rect.fromLTWH(surroundCircleX, surroundCircleY,
        surroundCircleSize, surroundCircleSize);
    for (int i = 0; i < noOfElements; i++) {
      fallingModels.add(CatcherFallingModel(getRandomX(i), -i * yIncrement,
          bugSize, random.nextInt(fallingItems.length)));
    }
    timer = Timer.periodic(
        Duration(milliseconds: refreshRate), (Timer t) => updateCoordinates());
  }

  List<Widget> fallingItems = [
    SvgPicture.asset('assets/images/bugs/bug1.svg',
        fit: BoxFit.cover, width: bugSize, height: bugSize),
    SvgPicture.asset('assets/images/bugs/bug2.svg',
        fit: BoxFit.cover, width: bugSize, height: bugSize),
    SvgPicture.asset('assets/images/bugs/bug3.svg',
        fit: BoxFit.cover, width: bugSize, height: bugSize),
    SvgPicture.asset('assets/images/bugs/bug4.svg',
        fit: BoxFit.cover, width: bugSize, height: bugSize),
    SvgPicture.asset('assets/images/bugs/bug5.svg',
        fit: BoxFit.cover, width: bugSize, height: bugSize),
    SvgPicture.asset('assets/images/bugs/bug6.svg',
        fit: BoxFit.cover, width: bugSize, height: bugSize),
    SvgPicture.asset('assets/images/bugs/bug7.svg',
        fit: BoxFit.cover, width: bugSize, height: bugSize),
    SvgPicture.asset('assets/images/bugs/bug8.svg',
        fit: BoxFit.cover, width: bugSize, height: bugSize),
    SvgPicture.asset('assets/images/bugs/bug9.svg',
        fit: BoxFit.cover, width: bugSize, height: bugSize),
    SvgPicture.asset('assets/images/bugs/bug10.svg',
        fit: BoxFit.cover, width: bugSize, height: bugSize),
    SvgPicture.asset('assets/images/bugs/bug11.svg',
        fit: BoxFit.cover, width: bugSize, height: bugSize),
    SvgPicture.asset('assets/images/bugs/bug12.svg',
        fit: BoxFit.cover, width: bugSize, height: bugSize),
    SvgPicture.asset('assets/images/bugs/bug13.svg',
        fit: BoxFit.cover, width: bugSize, height: bugSize),
    SvgPicture.asset('assets/images/bugs/bug14.svg',
        fit: BoxFit.cover, width: bugSize, height: bugSize),
    SvgPicture.asset('assets/images/bugs/bug1.svg',
        fit: BoxFit.cover, width: bugSize, height: bugSize),
    SvgPicture.asset('assets/images/bugs/bug15.svg',
        fit: BoxFit.cover, width: bugSize, height: bugSize),
    SvgPicture.asset('assets/images/bugs/bug16.svg',
        fit: BoxFit.cover, width: bugSize, height: bugSize),
    SvgPicture.asset('assets/images/bugs/bug17.svg',
        fit: BoxFit.cover, width: bugSize, height: bugSize),
    SvgPicture.asset('assets/images/bugs/bug18.svg',
        fit: BoxFit.cover, width: bugSize, height: bugSize),
    SvgPicture.asset('assets/images/bugs/bug19.svg',
        fit: BoxFit.cover, width: bugSize, height: bugSize),
    SvgPicture.asset('assets/images/bugs/bug20.svg',
        fit: BoxFit.cover, width: bugSize, height: bugSize),
    SvgPicture.asset('assets/images/bugs/bug21.svg',
        fit: BoxFit.cover, width: bugSize, height: bugSize),
  ];

  Timer timer;
  double surroundCircleX = 200;
  double surroundCircleY = 500;
  double surroundCircleSize = minCircleSize;
  double yMovement = 3;
  int noOfElements;
  List<CatcherFallingModel> fallingModels = [];
  Random random = Random();
  Rect catcherRect;
  int points = 0;
  bool isFinished = false;

  final double screenWidth;
  final double screenHeight;
  final double chunkWidth;
  final Function endGame;

  double getRandomX(int position) {
    return chunkWidth * (random.nextInt(8) + 1);
  }

  void updateCatcher(double deltaX, double deltaY) {
    surroundCircleX += deltaX;
    surroundCircleSize += deltaY;

    if (surroundCircleX <= 0) {
      surroundCircleX = 0;
    } else if (surroundCircleX >= screenWidth - surroundCircleSize) {
      surroundCircleX = screenWidth - surroundCircleSize;
    }

    if (surroundCircleSize < minCircleSize) {
      surroundCircleSize = minCircleSize;
    } else if (surroundCircleSize > maXCircleSize) {
      surroundCircleSize = maXCircleSize;
    }

    notifyListeners();
  }

  void updateCoordinates() {
    yMovement = getMovementForLevel();

    for (CatcherFallingModel model in fallingModels) {
      if (model.isDead) {
        continue;
      }

      model.updateY(yMovement);

      if (!isFinished) {
        if (model.checkIfInside(
            surroundCircleX, surroundCircleY, surroundCircleSize)) {
          surroundCircleX =
              surroundCircleX + surroundCircleSize / 2 - minCircleSize / 2;
          surroundCircleSize = minCircleSize;

          ++points;
        }
      }

      if (!model.isDead && model.y >= screenHeight - model.size) {
        timer.cancel();
        endGame();
        isFinished = true;
        break;
      }
    }
    notifyListeners();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  double getMovementForLevel() {
    if (points < 5) {
      return minYMovement;
    } else if (points < 10) {
      return minYMovement + yMovementIncrement * 1;
    } else if (points < 15) {
      return minYMovement + yMovementIncrement * 2;
    } else if (points < 20) {
      return minYMovement + yMovementIncrement * 3;
    } else if (points < 25) {
      return minYMovement + yMovementIncrement * 4;
    } else if (points < 30) {
      return minYMovement + yMovementIncrement * 5;
    } else if (points < 35) {
      return minYMovement + yMovementIncrement * 6;
    } else if (points < 40) {
      return minYMovement + yMovementIncrement * 7;
    } else if (points < 45) {
      return minYMovement + yMovementIncrement * 8;
    } else if (points < 50) {
      return minYMovement + yMovementIncrement * 9;
    } else if (points < 55) {
      return minYMovement + yMovementIncrement * 10;
    } else if (points < 60) {
      return minYMovement + yMovementIncrement * 11;
    } else if (points < 65) {
      return minYMovement + yMovementIncrement * 12;
    } else if (points < 70) {
      return minYMovement + yMovementIncrement * 13;
    } else if (points < 75) {
      return minYMovement + yMovementIncrement * 14;
    } else if (points < 75) {
      return minYMovement + yMovementIncrement * 15;
    } else if (points < 80) {
      return minYMovement + yMovementIncrement * 16;
    } else if (points < 85) {
      return minYMovement + yMovementIncrement * 17;
    } else if (points < 90) {
      return minYMovement + yMovementIncrement * 18;
    } else if (points < 95) {
      return minYMovement + yMovementIncrement * 19;
    } else if (points < 100) {
      return minYMovement + yMovementIncrement * 20;
    } else if (points < 105) {
      return minYMovement + yMovementIncrement * 21;
    } else if (points < 110) {
      return minYMovement + yMovementIncrement * 22;
    } else if (points < 115) {
      return minYMovement + yMovementIncrement * 23;
    } else
      return minYMovement + yMovementIncrement * 24;
  }

  Widget getImage(int position, int positionOfImage) {
    return fallingModels[position].isDead
        ? getDeadElement()
        : fallingItems[positionOfImage];
  }

  Widget getDeadElement() {
    return Container(
      height: 1,
      width: 1,
    );
  }
}
