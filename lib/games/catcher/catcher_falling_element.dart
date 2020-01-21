import 'package:daki/games/catcher/catcher_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatcherFallingElement extends StatelessWidget {
  const CatcherFallingElement(this.position);

  final int position;

  @override
  Widget build(BuildContext context) {
    return Consumer<CatcherProvider>(
      builder: (context, provider, child) {
        return Positioned(
          top: provider.fallingModels[position].y,
          left: provider.fallingModels[position].x,
          child: provider.getImage(
              position, provider.fallingModels[position].positionOfImage),
        );
      },
    );
  }
}
