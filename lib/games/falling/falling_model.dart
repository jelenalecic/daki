class FallingModel {
  FallingModel(this.x, this.y, this.positionOfImage);

  double x;
  double y;

  int positionOfImage;

  bool isDead = false;

  void updateY(int yMovement) {
    y += yMovement;
  }
}
