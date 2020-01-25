import 'dart:async';
import 'dart:math';

import 'package:daki/games/falling/falling_model.dart';
import 'package:daki/pulse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const double elementSize = 80;
const double verticalSpaceBetweenItems = 90.0;
const int refreshRate = 16;

const double minYMovement = 0.6;
const double yMovementIncrement = 0.15;

class FallingProvider with ChangeNotifier {
  FallingProvider(this.width, this.height, this.noOfElements, this.endGame) {
    initialCreation();

    timer = Timer.periodic(
        Duration(milliseconds: refreshRate), (Timer t) => updateCoordinates());
  }

  void initialCreation() {
    for (int i = 0; i < noOfElements; i++) {
      fallingModels.add(FallingModel(getRandomX(i),
          -i * verticalSpaceBetweenItems, random.nextInt(fallingItems.length)));
    }
  }

  Timer timer;
  double itemsYMovementPerRefresh;

  Random random = Random();

  double width;
  double height;
  int noOfElements;
  Function endGame;
  bool isFinished = false;

  List<Widget> fallingItems = [
    SvgPicture.asset(
      'assets/images/dinos/dino.svg',
      fit: BoxFit.cover,
      width: elementSize,
      height: elementSize,
    ),
    SvgPicture.asset(
      'assets/images/dinos/dino1.svg',
      fit: BoxFit.cover,
      width: elementSize,
      height: elementSize,
    ),
    SvgPicture.asset(
      'assets/images/dinos/dino2.svg',
      fit: BoxFit.cover,
      width: elementSize,
      height: elementSize,
    ),
    SvgPicture.asset(
      'assets/images/dinos/dino3.svg',
      fit: BoxFit.cover,
      width: elementSize,
      height: elementSize,
    ),
    SvgPicture.asset(
      'assets/images/dinos/dino4.svg',
      fit: BoxFit.cover,
      width: elementSize,
      height: elementSize,
    ),
    SvgPicture.asset(
      'assets/images/dinos/dino5.svg',
      fit: BoxFit.cover,
      width: elementSize,
      height: elementSize,
    ),
    SvgPicture.asset(
      'assets/images/dinos/dino6.svg',
      fit: BoxFit.cover,
      width: elementSize,
      height: elementSize,
    ),
    SvgPicture.asset(
      'assets/images/dinos/dino7.svg',
      fit: BoxFit.cover,
      width: elementSize,
      height: elementSize,
    ),
    SvgPicture.asset(
      'assets/images/dinos/dino8.svg',
      fit: BoxFit.cover,
      width: elementSize,
      height: elementSize,
    ),
    SvgPicture.asset(
      'assets/images/dinos/dino9.svg',
      fit: BoxFit.cover,
      width: elementSize,
      height: elementSize,
    ),
    SvgPicture.asset(
      'assets/images/dinos/dino10.svg',
      fit: BoxFit.cover,
      width: elementSize,
      height: elementSize,
    ),
  ];

  Widget pulse = Pulse(elementSize);

  int points = 0;

  List<FallingModel> fallingModels = <FallingModel>[];

  void updateCoordinates() {
    itemsYMovementPerRefresh = getMovement();
    for (FallingModel model in fallingModels) {
      model.updateY(itemsYMovementPerRefresh);

      if (!model.isDead && model.y >= height - elementSize) {
        killTimer();
        endGame(points, false);
        isFinished = true;
        break;
      }
    }

    if (points == noOfElements) {
      endGame(points, true);
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

  Widget getImage(int position, int positionOfImage) {
    return fallingModels[position].isDead
        ? pulse
        : fallingItems[positionOfImage];
  }

  double getMovement() {
    return (points / 5) * yMovementIncrement + minYMovement;
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
