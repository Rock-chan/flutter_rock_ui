import 'package:flutter/material.dart';
import 'package:flutter_rock_ui/page/photo_view_multiple_page.dart';
import 'package:flutter_rock_ui/router_builder/fade_route.dart';

class MultiplePhotoWidget extends StatelessWidget {
  const MultiplePhotoWidget({
    Key? key,
    required this.imgList,
    required this.index,
    this.height = 100,
    this.width = 100,
    this.isAssets = true,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  /// 图片高度
  final double height;

  /// 图片宽度
  final double width;

  /// 图片列表
  final List<String> imgList;

  /// 当前图片的索引
  final int index;

  /// 是否是本地图片
  final bool isAssets;

  /// 点击回调
  final GestureTapCallback? onTap;

  /// 长按回调
  final GestureLongPressCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.of(context).push(
          FadeRoute(
            page: PhotoViewMultiplePage(
              isAssets: isAssets,
              images: imgList,
              index: index,
              onLongPress: onLongPress,
              heroTag: "tag$index",
              onTap: onTap,
            ),
          ),
        );
      },
      child: SizedBox(
        height: height,
        width: width,
        child: isAssets
            ? Image.asset(
                imgList[index],
                errorBuilder: (context, object, stack) {
                  return Container(
                    color: Colors.grey.withOpacity(0.4),
                    child: const Icon(Icons.image_not_supported_outlined),
                  );
                },
              )
            : Image.network(
                imgList[index],
                errorBuilder: (context, object, stack) {
                  return Container(
                    color: Colors.grey.withOpacity(0.4),
                    child: const Icon(Icons.image_not_supported_outlined),
                  );
                },
              ),
      ),
    );
  }
}
