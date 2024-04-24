import 'package:flutter/material.dart';

/// 上下摆动动画
class UpDownAnimation extends StatefulWidget {
  const UpDownAnimation({
    super.key,
    required this.child,
    this.beginTween = -5.0,
    this.endTween = 15.0,
    this.duration = const Duration(milliseconds: 700),
    this.startDuration = Duration.zero,
  });

  final Widget child;
  final double beginTween;
  final double endTween;
  final Duration duration;
  final Duration startDuration;

  @override
  State<UpDownAnimation> createState() => _UpDownAnimationState();
}

class _UpDownAnimationState extends State<UpDownAnimation> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  initState() {
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween(begin: widget.beginTween, end: widget.endTween).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOut,
    ));

    Future.delayed(widget.startDuration, () {
      _controller!.repeat(reverse: true);
    });

    super.initState();
  }

  @override
  dispose() {
    _controller!.stop();
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation!,
      builder: (context, child) {
        return Transform.translate(offset: Offset(0, _animation!.value), child: widget.child);
      },
    );
  }
}
