import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget(
      {Key? key,
      this.onTap,
      this.img = "assets/images/data_package_search_empty.webp",
      this.tips,
      this.imgHeight = 120,
      this.height = 400,
      this.bottomPadding})
      : super(key: key);

  final GestureTapCallback? onTap;
  final String img;
  final String? tips;
  final double height;
  final double imgHeight;
  final double? bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: 300,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Image.asset(img, width: 200, height: imgHeight),
              const SizedBox(height: 10),
              Text(
                tips ?? '暂时没搜索结果哦~',
                style: const TextStyle(fontSize: 12, color: Color(0xff6b677e)),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: bottomPadding ?? 0,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyStateWidget2 extends StatelessWidget {
  const EmptyStateWidget2(
      {Key? key,
      this.onTap,
      this.img = "assets/images/data_package_search_empty.webp",
      this.tips,
      this.top = 200,
      this.imgWidth = 130})
      : super(key: key);

  final GestureTapCallback? onTap;
  final String img;
  final String? tips;
  final double top;
  final double imgWidth;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: onTap,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: top),
              Image.asset(img, width: imgWidth, fit: BoxFit.fitWidth),
              Text(
                tips ?? '暂时没搜索结果哦~',
                style: const TextStyle(fontSize: 12, color: Color(0xff6b677e)),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
