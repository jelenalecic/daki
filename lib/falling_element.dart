import 'package:daki/falling_game_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FallingElement extends StatelessWidget {
  const FallingElement(this.position);

  final int position;

  @override
  Widget build(BuildContext context) {
    return Consumer<FallingGameProvider>(
      builder: (context, provider, child) {
        child ??= provider.fallingItem;
        return Positioned(
          top: provider.fallingModels[position].y,
          left: provider.fallingModels[position].x,
          child: Container(
            child: GestureDetector(
              onTap: () {
                killIt(provider);
              },
              child: provider.getImage(position),
            ),
          ),
        );
      },
    );
  }

  void killIt(FallingGameProvider provider) {
    provider.killElement(position);
  }
}
