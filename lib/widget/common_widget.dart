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
