import 'dart:math';

import 'package:flutter/material.dart';

class CircleAnimation extends StatefulWidget {
  const CircleAnimation({super.key, required this.child, this.milliseconds = 5000});

  final Widget child;

  final int milliseconds;

  @override
  CircleAnimationState createState() => CircleAnimationState();
}

class CircleAnimationState extends State<CircleAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.milliseconds),
      vsync: this,
    )..repeat(); // 动画重复
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2.0 * pi, // 2π
          child: widget.child,
        );
      },
    );
  }
}
