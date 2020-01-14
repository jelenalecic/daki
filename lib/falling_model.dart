class FallingModel {
  FallingModel(this.x, this.y);

  double x;
  double y;

  bool isDead = false;

  void updateY(int yMovement) {
    y += yMovement;
  }
}
