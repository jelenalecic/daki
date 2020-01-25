import 'dart:async';
import 'dart:math';

import 'package:daki/games/falling/falling_model.dart';
import 'package:daki/pulse.dart';
import 'package:flutter/material.dart';

const double elementSize = 60;
const double verticalSpaceBetweenItems = 110.0;
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
      fallingModels.add(FallingModel(
          getRandomX(i),
          -i * verticalSpaceBetweenItems,
          (random.nextInt(50) + 50).toDouble()));
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

  Widget pulse = Pulse(elementSize);

  int points = 0;

  List<FallingModel> fallingModels = <FallingModel>[];

  void updateCoordinates() {
    if (isFinished) {
      return;
    }
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
      killTimer();
      endGame(points, true);
      isFinished = true;
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
    return width * (random.nextInt(7) + 1);
  }

  Widget getImage(int position) {
    return fallingModels[position].isDead
        ? pulse
        : Container(
            height: fallingModels[position].size,
            width: fallingModels[position].size,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.deepPurple),
          );
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
