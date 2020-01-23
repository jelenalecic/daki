class FallingModel {
  FallingModel(this.x, this.y, this.positionOfImage);

  double x;
  double y;

  int positionOfImage;

  bool isDead = false;

  void updateY(double yMovement) {
    y += yMovement;
  }
}
