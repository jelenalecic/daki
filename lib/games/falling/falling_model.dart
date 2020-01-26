class FallingModel {
  FallingModel(this.x, this.y, this.size, this.positionInColors, this.isBomb);

  double x;
  double y;

  double size;
  int positionInColors;

  bool isBomb;
  bool isExploded = false;

  bool isDead = false;

  void updateY(double yMovement) {
    y += yMovement;
  }
}
