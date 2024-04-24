import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rock_ui/widget/multiple_photo_widget.dart';

class SwiperPhoto extends StatelessWidget {
  const SwiperPhoto({super.key, required this.imgUrlList, this.isAssets = true});

  final List<String> imgUrlList;
  final bool isAssets;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Swiper(
        loop: false,
        itemCount: imgUrlList.length,
        pagination: SwiperPagination(
          // margin: EdgeInsets.only(bottom: 30),
          alignment: Alignment.bottomCenter,
          builder: DotSwiperPaginationBuilder(
            color: Colors.grey.withOpacity(0.5),
            size: 5.0,
            activeSize: 5.0,
            activeColor: Colors.red,
          ),
        ),
        itemBuilder: (context, index) {
          return MultiplePhotoWidget(
            imgList: imgUrlList,
            height: 50,
            width: 50,
            index: index,
            isAssets: isAssets,
          );
        },
      ),
    );
  }
}
