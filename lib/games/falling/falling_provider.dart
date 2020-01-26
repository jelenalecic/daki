import 'dart:async';
import 'dart:math';

import 'package:daki/games/falling/falling_model.dart';
import 'package:daki/pulse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      bool isBomb = random.nextInt(12) == 2;
      fallingModels.add(FallingModel(
          getRandomX(i),
          -i * verticalSpaceBetweenItems,
          (random.nextInt(50) + 50).toDouble(),
          random.nextInt(colors.length),
          isBomb));
    }
  }

  Timer timer;
  double itemsYMovementPerRefresh;

  Random random = Random();

  Widget bomb = SvgPicture.asset('assets/images/bomb2.svg',
      fit: BoxFit.cover, width: 50, height: 50);

  Widget flame = SvgPicture.asset('assets/images/flame.svg',
      fit: BoxFit.cover, width: 100, height: 100);

  List<Color> colors = [
    Color(0xff6d0f56),
    Color(0xffeb58ea),
    Color(0xff280c1b),
    Color(0xffbe24af),
    Color(0xff9a8d98),
    Color(0xffa91592),
    Color(0xff0e0209),
    Color(0xff751d6b),
    Color(0xffde61d8),
    Color(0xffef82f9),
    Color(0xff72005f),
    Color(0xff1e061b),
    Color(0xff790367),
    Color(0xffd14fce),
    Color(0xffc207a1),
    Color(0xffee7af6),
    Color(0xff511d47),
    Color(0xffdb49d7),
    Color(0xff260017),
    Color(0xffd143c7),
    Color(0xffdabcd6),
    Color(0xff7d3871),
    Color(0xff841877),
  ];

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
        if (model.isBomb) {
          model.isDead = true;
          ++points;
        } else {
          killTimer();
          endGame(points, false);
          isFinished = true;
          break;
        }
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
    if (fallingModels[position].isBomb) {
      fallingModels[position].isExploded = true;
      killTimer();
      isFinished = true;

      Future.delayed(Duration(milliseconds: 300), () {
        endGame(points, false);
      });
    } else if (!fallingModels[position].isDead) {
      ++points;
      fallingModels[position].isDead = true;
    }

    notifyListeners();
  }

  double getRandomX(int position) {
    return width * (random.nextInt(7) + 1);
  }

  Widget getImage(int position) {
    if (fallingModels[position].isExploded) {
      return flame;
    } else if (fallingModels[position].isDead) {
      return pulse;
    } else if (fallingModels[position].isBomb) {
      return bomb;
    }

    return Container(
      height: fallingModels[position].size,
      width: fallingModels[position].size,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colors[fallingModels[position].positionInColors]),
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
