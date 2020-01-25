import 'dart:async';
import 'dart:math';

import 'package:daki/games/catcher/catcher_falling_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const double bugSize = 50;

const double minNetSize = 40;
const double maxNetSize = 200;

const double itemsVerticalSpacing = 100.0;

const double minYMovement = 0.6;
const double yMovementIncrement = 0.15;

const int refreshRate = 16;

class CatcherProvider with ChangeNotifier {
  CatcherProvider(this.screenWidth, this.screenHeight, this.chunkWidth,
      this.noOfElements, this.finishedTheGame) {
    netY = screenHeight - maxNetSize;
    netX = screenWidth / 2;
    netRect = Rect.fromLTWH(netX, netY, netSize, netSize);
    for (int i = 0; i < noOfElements; i++) {
      fallingModels.add(CatcherFallingModel(
          getRandomX(i),
          -i * itemsVerticalSpacing,
          bugSize,
          random.nextInt(fallingItems.length)));
    }
    timer = Timer.periodic(
        Duration(milliseconds: refreshRate), (Timer t) => updateItems());
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

  int noOfElements;

  Timer timer;

  double netX;
  double netY;
  double netSize = minNetSize;
  Rect netRect;

  double itemsYMovementPerRefresh;

  List<CatcherFallingModel> fallingModels = [];
  Random random = Random();

  int points = 0;
  bool isFinished = false;

  final double screenWidth;
  final double screenHeight;
  final double chunkWidth;

  final Function finishedTheGame;

  double getRandomX(int position) {
    return chunkWidth * (random.nextInt(8) + 1);
  }

  ///triggered from [GestureDetector]
  ///changes appearance of the net
  void updateCatcher(double deltaX, double deltaY) {
    netX += deltaX;
    netSize += deltaY;

    //left and right borders
    if (netX <= 0) {
      netX = 0;
    } else if (netX >= screenWidth - netSize) {
      netX = screenWidth - netSize;
    }

    if (netSize < minNetSize) {
      netSize = minNetSize;
    } else if (netSize > maxNetSize) {
      netSize = maxNetSize;
    }

    notifyListeners();
  }

  ///called from timer, on every [refreshRate]ms
  ///moves items down the screen, checks if some item is left the screen
  ///not killed
  void updateItems() {
    if (isFinished) {
      return;
    }
    itemsYMovementPerRefresh = getMovementForLevel();

    for (CatcherFallingModel model in fallingModels) {
      if (model.isDead) {
        continue;
      }

      model.updateY(itemsYMovementPerRefresh);

      if (!isFinished) {
        if (model.checkIfInside(netX, netY, netSize)) {
          netX = netX + netSize / 2 - minNetSize / 2;
          netSize = minNetSize;

          ++points;
        }
      }

      //if item was not killed, but is getting out of the screen
      if (!model.isDead && model.y >= screenHeight - model.size) {
        timer.cancel();
        finishedTheGame(points, false);
        isFinished = true;
        break;
      }
    }

    if (points == noOfElements) {
      timer.cancel();
      finishedTheGame(points, true);
      isFinished = true;
    }

    notifyListeners();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  double getMovementForLevel() {
    return (points / 5) * yMovementIncrement + minYMovement;
  }

  Widget getImage(int position, int positionOfImage) {
    return fallingModels[position].isDead
        ? getDeadElement()
        : fallingItems[positionOfImage];
  }

  Widget getDeadElement() {
    return Container();
  }
}
