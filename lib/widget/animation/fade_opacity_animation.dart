import 'package:flutter/material.dart';

/// 从无到有动画
class FadeOpacityAnimation extends StatefulWidget {
  const FadeOpacityAnimation(
      {super.key,
      required this.child,
      this.beginTween = 1.0,
      this.endTween = 0.0,
      this.duration = const Duration(milliseconds: 700),
      this.startDuration = Duration.zero});

  final Widget child;
  final double beginTween;
  final double endTween;
  final Duration duration;
  final Duration startDuration; // 间隔多久后开始

  @override
  State<FadeOpacityAnimation> createState() => _FadeOpacityAnimationState();
}

class _FadeOpacityAnimationState extends State<FadeOpacityAnimation> with SingleTickerProviderStateMixin {
  Animation<double>? _circleFadeAnimation;
  AnimationController? _circleAnimationController;

  @override
  initState() {
    // 创建动画控制器
    _circleAnimationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    final curve = CurvedAnimation(parent: _circleAnimationController!, curve: Curves.easeInOut);

    // 创建淡入淡出动画 透明度0-1
    _circleFadeAnimation = Tween<double>(begin: widget.beginTween, end: widget.endTween).animate(curve);

    // 开始动画
    Future.delayed(widget.startDuration, () {
      _circleAnimationController?.forward();
    });

    super.initState();
  }

  @override
  dispose() {
    _circleAnimationController!.stop();
    _circleAnimationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _circleFadeAnimation!, child: widget.child);
  }
}
