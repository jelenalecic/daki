import 'package:daki/pulse_painter.dart';
import 'package:flutter/material.dart';

class Pulse extends StatefulWidget {
  const Pulse(this.size);

  final double size;

  @override
  _State createState() => _State();
}

class _State extends State<Pulse> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
    );

    _startAnimation();
  }

  void _startAnimation() {
    _controller.stop();
    _controller.reset();
    _controller.repeat(
      period: Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: PulsePainter(_controller),
      child: Container(
        width: widget.size,
        height: widget.size,
      ),
    );
  }
}
