import 'package:daki/games/surround/surround_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SurroundFallingElement extends StatelessWidget {
  const SurroundFallingElement(this.position);

  final int position;

  @override
  Widget build(BuildContext context) {
    return Consumer<SurroundProvider>(
      builder: (context, provider, child) {
        return Positioned(
          top: provider.fallingModels[position].y,
          left: provider.fallingModels[position].x,
          child: Container(
            child: Container(
              width: provider.fallingModels[position].size,
              height: provider.fallingModels[position].size,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: provider.fallingModels[position].isDead
                      ? Colors.white
                      : Colors.pink),
            ),
          ),
        );
      },
    );
  }

  Widget getDeadElement() {
    return Container(
      height: 0,
    );
  }
}
