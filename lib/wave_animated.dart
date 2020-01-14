import 'dart:math' as math show sin, pi;

import 'package:flutter/material.dart';

enum SpinKitWaveType { start, end, center }

class WaveAnimated extends StatefulWidget {
  WaveAnimated({
    Key key,
    this.color = Colors.black,
    this.type = SpinKitWaveType.start,
    this.size = 50.0,
    this.duration = const Duration(milliseconds: 1200),
  });

  final Color color;
  final double size;
  final SpinKitWaveType type;
  final Duration duration;

  @override
  _SpinKitWaveState createState() => _SpinKitWaveState();
}

class _SpinKitWaveState extends State<WaveAnimated>
    with SingleTickerProviderStateMixin {
  AnimationController _scaleCtrl;

  @override
  void initState() {
    super.initState();
    _scaleCtrl = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void dispose() {
    _scaleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _bars;
    if (widget.type == SpinKitWaveType.start) {
      _bars = [
        _bar(0, -1.2),
        _bar(1, -1.1),
        _bar(2, -1.0),
        _bar(3, -.9),
        _bar(4, -.8),
      ];
    } else if (widget.type == SpinKitWaveType.end) {
      _bars = [
        _bar(0, -.8),
        _bar(1, -.9),
        _bar(2, -1.0),
        _bar(3, -1.1),
        _bar(4, -1.2),
      ];
    } else if (widget.type == SpinKitWaveType.center) {
      _bars = [
        _bar(0, -0.75),
        _bar(1, -0.95),
        _bar(2, -1.2),
        _bar(3, -0.95),
        _bar(4, -0.75),
      ];
    }
    return Center(
      child: SizedBox.fromSize(
        size: Size(widget.size * 1.25, widget.size),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _bars,
        ),
      ),
    );
  }

  Widget _bar(int index, double delay) {
    final _size = widget.size * 0.2;
    return ScaleYWidget(
      scaleY: DelayTween(
        begin: .4,
        end: 1.0,
        delay: delay,
      ).animate(_scaleCtrl),
      child: SizedBox.fromSize(
        size: Size(_size, widget.size),
        child: _itemBuilder(index),
      ),
    );
  }

  Widget _itemBuilder(int index) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: widget.color,
      ),
    );
  }
}

class ScaleYWidget extends AnimatedWidget {
  const ScaleYWidget({
    Key key,
    @required Animation<double> scaleY,
    @required this.child,
    this.alignment = Alignment.center,
  }) : super(key: key, listenable: scaleY);

  final Widget child;
  final Alignment alignment;

  Animation<double> get scaleY => listenable;

  @override
  Widget build(BuildContext context) {
    final double scaleValue = scaleY.value;
    final Matrix4 transform = Matrix4.identity()..scale(1.0, scaleValue, 1.0);
    return Transform(
      transform: transform,
      alignment: alignment,
      child: child,
    );
  }
}

class DelayTween extends Tween<double> {
  DelayTween({
    double begin,
    double end,
    this.delay,
  }) : super(begin: begin, end: end);

  final double delay;

  @override
  double lerp(double t) {
    return super.lerp((math.sin((t - delay) * 2 * math.pi) + 1) / 2);
  }

  @override
  double evaluate(Animation<double> animation) => lerp(animation.value);
}
