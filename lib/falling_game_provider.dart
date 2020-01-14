import 'package:daki/falling_model.dart';
import 'package:daki/pulse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const int randomFactor = 92751486;
const double elementSize = 80;
const double yIncrement = 90.0;

class FallingGameProvider with ChangeNotifier {
  FallingGameProvider(
      this.width, this.height, this.noOfElements, this.endGame) {
    initialCreation();
  }

  void initialCreation() {
    for (int i = 0; i < noOfElements; i++) {
      fallingModels.add(FallingModel(getRandomX(i), -i * yIncrement));
    }
  }

  int yMovement = 3;

  double width;
  double height;
  int noOfElements;
  Function endGame;
  bool isFinished = false;

  int levelIncrement = 5;

  Widget fallingItem = SvgPicture.asset(
    'assets/images/dino.svg',
    fit: BoxFit.cover,
    width: elementSize,
    height: elementSize,
  );

  Widget pulse = Pulse(elementSize);

  int points = 0;

  List<FallingModel> fallingModels = <FallingModel>[];

  void updateCoordinates() {
    yMovement = getMovement();
    for (FallingModel model in fallingModels) {
      model.updateY(yMovement);

      if (!model.isDead && model.y >= height - elementSize) {
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
    return width * (getRandomNumber(position));
  }

  int getRandomNumber(int position) {
    int first = randomFactor - position;
    int second = position + randomFactor;

    int randomNumber = (first * second * position) % 8 + 1;

    return randomNumber;
  }

  Widget getImage(int position) {
    return fallingModels[position].isDead ? pulse : fallingItem;
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
    }
    return 14;
  }
}
