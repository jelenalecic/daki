import 'package:flutter/material.dart';

///widget with slide in animation from the bottom of the screen
///and semi transparent background
class SlideFromBottom extends StatefulWidget {
  const SlideFromBottom(this.child);

  final Widget child;

  @override
  _SlideFromBottomState createState() => _SlideFromBottomState();
}

class _SlideFromBottomState extends State<SlideFromBottom>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();

    return Stack(
      children: <Widget>[
        Container(
          color: Colors.grey[850].withOpacity(0.5),
        ),
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1.0),
            end: Offset(0, 0),
          ).animate(_animation),
          child: widget.child,
        ),
      ],
    );
  }
}
