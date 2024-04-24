import 'dart:math';

import 'package:flutter/material.dart';

class RedDotPage extends StatefulWidget {
  final Offset? startPosition;
  final Offset? endPosition;
  final Duration? animationDuration;
  final Color? pointColor;
  final double? pointSize;

  const RedDotPage(
      {Key? key,
      this.startPosition,
      this.endPosition,
      this.animationDuration = const Duration(milliseconds: 800),
      this.pointColor = Colors.red,
      this.pointSize = 14.0})
      : super(key: key);

  @override
  RedDotPageState createState() => RedDotPageState();
}

class RedDotPageState extends State<RedDotPage> with SingleTickerProviderStateMixin {
  /// 动画controller
  AnimationController? _controller;

  /// 动画
  Animation<double>? _animation;

  /// 小圆点的left（动态计算）
  double? left;

  ///小圆点的right（动态计算）
  double? top;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.animationDuration, vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller!.view);

    // 二阶贝塞尔曲线用值
    var x0 = widget.startPosition?.dx;
    var y0 = widget.startPosition?.dy;

    // 结束
    var x2 = widget.endPosition?.dx;
    var y2 = widget.endPosition?.dy;

    var x1 = widget.startPosition!.dx + (x2! - x0!);
    var y1 = widget.startPosition!.dy - 100;

    _animation?.addListener(() {
      // t 动态变化的值
      var t = _animation?.value;
      if (mounted) {
        setState(() {
          left = pow(1 - t!, 2) * x0 + 2 * t * (1 - t) * x1 + pow(t, 2) * x2;
          top = pow(1 - t, 2) * y0! + 2 * t * (1 - t) * y1 + pow(t, 2) * y2!;
        });
      }
    });

    // 初始化小圆点的位置
    left = widget.startPosition?.dx;
    top = widget.startPosition?.dy;

    // 显示小圆点的时候动画就开始
    _controller?.forward();
  }

  @override
  Widget build(BuildContext context) {
    // 用 Stack -> Positioned 来控制小圆点的位置
    return Stack(
      children: <Widget>[
        Positioned(
          left: left,
          top: top,
          child: ClipOval(
            child: Container(
              width: widget.pointSize,
              height: widget.pointSize,
              color: widget.pointColor,
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
