import 'package:flutter/material.dart';

class SurroundFallingModel {
  SurroundFallingModel(this.x, this.y, this.size);

  final double x;
  double y;
  double size;

  Rect rect;

  bool isDead = false;

  void updateY(double yMovement) {
    y += yMovement;
    rect = Rect.fromLTWH(x, y, size, size);
  }

  bool checkIfInside(double surroundCircleX, double surroundCircleY,
      double surroundCircleSize) {
    if (isDead) {
      return false;
    }
    return isDead = contains(
        Rect.fromLTWH(surroundCircleX, surroundCircleY, surroundCircleSize,
            surroundCircleSize),
        rect);
  }

  static bool contains(Rect container, Rect child) {
    return container.right >= child.right &&
        container.left <= child.left &&
        container.top <= child.top &&
        container.bottom >= child.bottom;
  }
}
