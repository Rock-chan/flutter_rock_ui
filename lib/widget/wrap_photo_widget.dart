import 'package:flutter/material.dart';
import 'package:flutter_rock_ui/widget/multiple_photo_widget.dart';

class WrapPhotoWidget extends StatelessWidget {
  const WrapPhotoWidget({
    super.key,
    required this.imgUrlList,
    this.maxImgCount = 9,
    this.spacing = 10,
    this.runSpacing = 10,
    this.size = 100,
    this.isAssets = true,
    this.onTap,
    this.onLongPress,
  });

  /// 图片地址列表
  final List<String> imgUrlList;

  /// 图片最大显示数量
  final int maxImgCount;

  /// 主轴间距
  final double spacing;

  /// 纵轴间距
  final double runSpacing;

  /// 图片大小
  final double size;

  /// 判断是网络图片还是本地图片，默认为true
  final bool isAssets;

  /// 点击回调
  final GestureTapCallback? onTap;

  /// 长按回调
  final GestureLongPressCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: spacing,
      runSpacing: runSpacing,
      children: List.generate(
        imgUrlList.length <= maxImgCount ? imgUrlList.length : maxImgCount,
        (index) {
          return Stack(
            children: [
              MultiplePhotoWidget(
                isAssets: isAssets,
                imgList: imgUrlList,
                index: index,
                height: size,
                width: size,
                onTap: onTap,
                onLongPress: onLongPress,
              ),
              if (index == maxImgCount - 1 && imgUrlList.length > maxImgCount)
                IgnorePointer(
                  child: Container(
                    height: size,
                    width: size,
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: Text(
                        "+${imgUrlList.length - maxImgCount}",
                        style: const TextStyle(fontSize: 22.0, color: Colors.white),
                      ),
                    ),
                  ),
                )
            ],
          );
        },
      ),
    );
  }
}
