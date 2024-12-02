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
    this.shouldStart = true,
    this.reverse = true,
    this.repeat = true,
    this.isHorizontal = false,
  });

  final Widget child;
  final double beginTween;
  final double endTween;
  final Duration duration;
  final Duration startDuration;
  final bool shouldStart;
  final bool reverse;
  final bool repeat;
  final bool isHorizontal;

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

    if (widget.shouldStart) {
      if (widget.repeat) {
        Future.delayed(widget.startDuration, () {
          if (_controller != null) {
            _controller!.repeat(reverse: widget.reverse);
          }
        });
        return;
      }
      Future.delayed(widget.startDuration, () {
        if (_controller != null) {
          _controller!.forward();
        }
      });
    }

    super.initState();
  }

  @override
  dispose() {
    _controller!.stop();
    _controller!.dispose();
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation!,
      builder: (context, child) {
        return Transform.translate(
          offset: widget.isHorizontal ? Offset(_animation!.value, 0) : Offset(0, _animation!.value),
          child: widget.child,
        );
      },
    );
  }
}
