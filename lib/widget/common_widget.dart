import 'package:flutter/material.dart';

const Color lineColor = Colors.black12;

///默认的线条（横向）
Container buildHorizontalLine(
    {double height = 0.5,
    double width = double.infinity,
    Color color = lineColor,
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    BoxDecoration? decoration,
    Key? key}) {
  return Container(
    key: key,
    height: height,
    width: width,
    margin: margin,
    color: decoration == null ? color : null,
    decoration: decoration,
  );
}

///默认的线条（纵向）
Container buildVerticalLine(double height,
    {double width = 0.5,
    Color color = lineColor,
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    BoxDecoration? decoration}) {
  return Container(
    margin: margin,
    width: width,
    height: height,
    color: decoration == null ? color : null,
    decoration: decoration,
  );
}

/// 到底了
Widget listLoadAll(
    {String content = '到底了',
    double top = 0,
    double bottom = 0,
    Color? bgColor,
    Color? textColor,
    Color? lineColor,
    double? lineWidth = 50,
    bool safeAreaTop = true,
    bool safeAreaBottom = true}) {
  return SafeArea(
    top: safeAreaTop,
    bottom: safeAreaBottom,
    child: Container(
      width: double.infinity,
      alignment: Alignment.center,
      color: bgColor,
      child: Padding(
        padding: EdgeInsets.only(top: top, bottom: bottom),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildHorizontalLine(
                width: lineWidth ?? 50,
                margin: const EdgeInsets.only(right: 24),
                color: lineColor ?? Colors.black.withOpacity(0.1)),
            Text(
              content,
              style: TextStyle(color: textColor ?? Colors.black.withOpacity(0.3), fontSize: 12),
            ),
            buildHorizontalLine(
                width: lineWidth ?? 50,
                margin: const EdgeInsets.only(left: 24),
                color: lineColor ?? Colors.black.withOpacity(0.1)),
          ],
        ),
      ),
    ),
  );
}
