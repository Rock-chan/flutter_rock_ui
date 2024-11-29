import 'dart:math';

import 'package:flutter/material.dart';

class CircleAnimation extends StatefulWidget {
  const CircleAnimation({super.key, required this.child});

  final Widget child;

  @override
  CircleAnimationState createState() => CircleAnimationState();
}

class CircleAnimationState extends State<CircleAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
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
