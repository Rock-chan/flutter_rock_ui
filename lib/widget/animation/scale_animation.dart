import 'package:flutter/material.dart';

/// 从小到大动画
class ScaleAnimation extends StatefulWidget {
  const ScaleAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 700),
    this.isRepeat = false,
    this.beginTween = 0,
    this.endTween = 3,
    this.startDuration = Duration.zero,
  });

  final Widget child;
  final Duration duration;
  final bool isRepeat; // 是否重复
  final double beginTween;
  final double endTween;
  final Duration startDuration;

  @override
  State<ScaleAnimation> createState() => _ScaleAnimationState();
}

class _ScaleAnimationState extends State<ScaleAnimation> with SingleTickerProviderStateMixin {
  AnimationController? _circleAnimationController;
  Animation<double>? _circleScaleAnimation;

  @override
  initState() {
    _circleAnimationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    // 创建大小变化的动画
    _circleScaleAnimation =
        Tween<double>(begin: widget.beginTween, end: widget.endTween).animate(_circleAnimationController!);

    Future.delayed(widget.startDuration, () {
      // 开始动画
      if (widget.isRepeat) {
        _circleAnimationController?.repeat();
      } else {
        _circleAnimationController?.forward();
      }
    });

    super.initState();
  }

  @override
  dispose() {
    _circleAnimationController!.stop();
    _circleAnimationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: _circleScaleAnimation!, child: widget.child);
  }
}
