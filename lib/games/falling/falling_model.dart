class FallingModel {
  FallingModel(this.x, this.y, this.size);

  double x;
  double y;

  double size;

  bool isDead = false;

  void updateY(double yMovement) {
    y += yMovement;
  }
}
