import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoViewMultiplePage extends StatefulWidget {
  PhotoViewMultiplePage({
    super.key,
    @required this.images,
    this.index = 0,
    this.pageController,
    this.heroTag = '',
    this.minScale = PhotoViewComputedScale.contained,
    this.maxScale = PhotoViewComputedScale.covered,
    this.isAssets = true,
    this.onLongPress,
    this.onTap,
  }) {
    pageController = PageController(initialPage: index ?? 0);
  }

  /// 图片列表
  final List<String>? images;

  /// 当前图片下标
  final int? index;

  /// tag
  final String? heroTag;

  /// 页面控制
  PageController? pageController;

  /// 最小倍数，默认PhotoViewComputedScale.contained
  final dynamic minScale;

  /// 最大倍数，默认PhotoViewComputedScale.covered
  final dynamic maxScale;

  /// 判断是网络图片还是本地图片，默认为true
  final bool isAssets;

  /// 点击回调
  final GestureTapCallback? onTap;

  /// 长按回调
  final GestureLongPressCallback? onLongPress;

  @override
  State<PhotoViewMultiplePage> createState() => _PhotoViewMultiplePageState();
}

class _PhotoViewMultiplePageState extends State<PhotoViewMultiplePage> {
  int currentIndex = 0;

  ImageProvider? imageProvider;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.pop(context);
        widget.onTap?.call();
      },
      onLongPress: widget.onLongPress,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            PhotoViewGallery.builder(
              itemCount: widget.images?.length,
              pageController: widget.pageController,
              enableRotation: false,
              onPageChanged: (index) {
                {
                  setState(() {
                    currentIndex = index;
                  });
                }
              },
              builder: (context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: widget.isAssets
                      ? AssetImage(widget.images![index])
                      : NetworkImage(widget.images![index]) as ImageProvider,
                  minScale: widget.minScale,
                  maxScale: widget.maxScale,
                  heroAttributes: PhotoViewHeroAttributes(tag: "${widget.heroTag}"),
                );
              },
            ),
            // 图片index展示
            if (widget.images?.length != 1)
              Positioned(
                top: MediaQuery.of(context).padding.top + 15,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    "${currentIndex + 1} / ${widget.images?.length}",
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            // 关闭按钮
            Positioned(
              right: 10,
              top: 50,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
