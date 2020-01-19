import 'dart:async';
import 'dart:math';

import 'package:daki/games/falling/falling_model.dart';
import 'package:daki/pulse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const double elementSize = 80;
const double yIncrement = 90.0;
const int refreshRate = 64;

class FallingProvider with ChangeNotifier {
  FallingProvider(this.width, this.height, this.noOfElements, this.endGame) {
    mills.add(DateTime.now().millisecondsSinceEpoch);
    mills.add(DateTime.now().millisecondsSinceEpoch ~/ 9);
    mills.add(DateTime.now().millisecondsSinceEpoch ~/ 5);
    mills.add(DateTime.now().millisecondsSinceEpoch ~/ 2);

    initialCreation();

    timer = Timer.periodic(
        Duration(milliseconds: refreshRate), (Timer t) => updateCoordinates());
  }

  void initialCreation() {
    for (int i = 0; i < noOfElements; i++) {
      fallingModels.add(FallingModel(
          getRandomX(i), -i * yIncrement, random.nextInt(fallingItems.length)));
    }
  }

  Timer timer;
  int yMovement = 3;
  List<int> mills = [];

  Random random = Random();

  double width;
  double height;
  int noOfElements;
  Function endGame;
  bool isFinished = false;

  int levelIncrement = 5;

  List<Widget> fallingItems = [
    SvgPicture.asset(
      'assets/images/dino.svg',
      fit: BoxFit.cover,
      width: elementSize,
      height: elementSize,
    ),
    SvgPicture.asset(
      'assets/images/dino3.svg',
      fit: BoxFit.cover,
      width: elementSize,
      height: elementSize,
    ),
    SvgPicture.asset(
      'assets/images/dino4.svg',
      fit: BoxFit.cover,
      width: elementSize,
      height: elementSize,
    ),
    SvgPicture.asset(
      'assets/images/dino5.svg',
      fit: BoxFit.cover,
      width: elementSize,
      height: elementSize,
    ),
    SvgPicture.asset(
      'assets/images/dino7.svg',
      fit: BoxFit.cover,
      width: elementSize,
      height: elementSize,
    ),
    SvgPicture.asset(
      'assets/images/dino8.svg',
      fit: BoxFit.cover,
      width: elementSize,
      height: elementSize,
    ),
    SvgPicture.asset(
      'assets/images/dino9.svg',
      fit: BoxFit.cover,
      width: elementSize,
      height: elementSize,
    ),
    SvgPicture.asset(
      'assets/images/dino10.svg',
      fit: BoxFit.cover,
      width: elementSize,
      height: elementSize,
    ),
    SvgPicture.asset(
      'assets/images/dino11.svg',
      fit: BoxFit.cover,
      width: elementSize,
      height: elementSize,
    )
  ];

  Widget pulse = Pulse(elementSize);

  int points = 0;

  List<FallingModel> fallingModels = <FallingModel>[];

  void updateCoordinates() {
    yMovement = getMovement();
    for (FallingModel model in fallingModels) {
      model.updateY(yMovement);

      if (!model.isDead && model.y >= height - elementSize) {
        killTimer();
        endGame();
        isFinished = true;
        break;
      }
    }
    notifyListeners();
  }

  void killElement(int position) {
    if (isFinished) {
      return;
    }
    if (!fallingModels[position].isDead) {
      ++points;
      fallingModels[position].isDead = true;
    }

    notifyListeners();
  }

  double getRandomX(int position) {
    return width * (random.nextInt(8));
  }

  int getRandomNumber(int position, int mod) {
    int randomNumber = (mills[position % mills.length] * position) % mod + 1;

    return randomNumber;
  }

  Widget getImage(int position, int positionOfImage) {
    return fallingModels[position].isDead
        ? pulse
        : fallingItems[positionOfImage];
  }

  int getMovement() {
    if (points < levelIncrement) {
      return 4;
    } else if (points < levelIncrement * 2) {
      return 5;
    } else if (points < levelIncrement * 3) {
      return 6;
    } else if (points < levelIncrement * 4) {
      return 7;
    } else if (points < levelIncrement * 5) {
      return 8;
    } else if (points < levelIncrement * 6) {
      return 9;
    } else if (points < levelIncrement * 7) {
      return 10;
    } else if (points < levelIncrement * 8) {
      return 11;
    } else if (points < levelIncrement * 9) {
      return 12;
    } else if (points < levelIncrement * 10) {
      return 13;
    } else if (points < levelIncrement * 11) {
      return 14;
    } else if (points < levelIncrement * 12) {
      return 15;
    } else if (points < levelIncrement * 13) {
      return 16;
    }
    return 17;
  }

  void killTimer() {
    timer.cancel();
  }

  @override
  void dispose() {
    killTimer();
    super.dispose();
  }
}
