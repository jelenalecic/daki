import 'package:daki/games/falling/falling_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FallingElement extends StatelessWidget {
  const FallingElement(this.position);

  final int position;

  @override
  Widget build(BuildContext context) {
    return Consumer<FallingProvider>(
      builder: (context, provider, child) {
        return Positioned(
          top: provider.fallingModels[position].y,
          left: provider.fallingModels[position].x,
          child: Container(
            child: GestureDetector(
              onTap: () {
                killIt(provider);
              },
              child: provider.getImage(
                  position, provider.fallingModels[position].positionOfImage),
            ),
          ),
        );
      },
    );
  }

  void killIt(FallingProvider provider) {
    provider.killElement(position);
  }
}
