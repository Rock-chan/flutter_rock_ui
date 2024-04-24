import 'package:flutter/material.dart';
import 'package:flutter_rock_ui/utils/network_check.dart';
import 'package:flutter_rock_ui/widget/multiple_photo_widget.dart';
import 'package:flutter_rock_ui/widget/swiper_photo.dart';
import 'package:flutter_rock_ui/widget/wrap_photo_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NetWorkCheck.check();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("PhotoView"),
        ),
        body: MyDemo(),
      ),
    );
  }
}

class MyDemo extends StatelessWidget {
  MyDemo({Key? key}) : super(key: key);

  final List<String> galleryItems = [
    "assets/images/photo1.jpg",
    "assets/images/photo2.JPG",
    "assets/images/photo3.png",
    "assets/images/photo4.jpeg",
    "assets/images/photo1.jpg",
    "assets/images/photo2.JPG",
    "assets/images/photo3.png",
    "assets/images/photo4.jpeg",
    "assets/images/photo1.jpg",
    "assets/images/photo2.JPG",
    "assets/images/photo3.png",
    "assets/images/photo4.jpeg",
    "assets/images/photo1.jpg",
    "assets/images/photo2.JPG",
    "assets/images/photo3.png",
    "assets/images/photo4.jpeg",
    "assets/images/photo1.jpg",
    "assets/images/photo2.JPG",
    "assets/images/photo3.png",
    "assets/images/photo4.jpeg",
    "assets/images/photo1.jpg",
    "assets/images/photo2.JPG",
    "assets/images/photo3.png",
    "assets/images/photo4.jpeg",
  ];
  final List<String> galleryNetworkItems = [
    "https://img.51miz.com/Photo/2017/04/27/17/P1078592_16e027191373354ed707deb4f3d92d77.jpg",
    "https://th.bing.com/th/id/R.39d1feb6e2881ffd0be351d37ce0c9b1?rik=80KqiObQdxvcKA&riu=http%3a%2f%2fwall8.com%2f070420%2ffengjing%2fmingsheng%2fpic007.jpg&ehk=DgMPfO5Q7oBcFanCCHaaAW00DkSojcWZLB7YEKjIlvU%3d&risl=&pid=ImgRaw&r=0",
    "https://gss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/zhidao/pic/item/8ad4b31c8701a18bb43af496902f07082938fe12.jpg",
    "https://img.51miz.com/Photo/2017/04/27/17/P1078592_16e027191373354ed707deb4f3d92d77.jpg",
    "https://th.bing.com/th/id/R.39d1feb6e2881ffd0be351d37ce0c9b1?rik=80KqiObQdxvcKA&riu=http%3a%2f%2fwall8.com%2f070420%2ffengjing%2fmingsheng%2fpic007.jpg&ehk=DgMPfO5Q7oBcFanCCHaaAW00DkSojcWZLB7YEKjIlvU%3d&risl=&pid=ImgRaw&r=0",
    "https://gss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/zhidao/pic/item/8ad4b31c8701a18bb43af496902f07082938fe12.jpg",
    "https://img.51miz.com/Photo/2017/04/27/17/P1078592_16e027191373354ed707deb4f3d92d77.jpg",
    "https://th.bing.com/th/id/R.39d1feb6e2881ffd0be351d37ce0c9b1?rik=80KqiObQdxvcKA&riu=http%3a%2f%2fwall8.com%2f070420%2ffengjing%2fmingsheng%2fpic007.jpg&ehk=DgMPfO5Q7oBcFanCCHaaAW00DkSojcWZLB7YEKjIlvU%3d&risl=&pid=ImgRaw&r=0",
    "https://gss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/zhidao/pic/item/8ad4b31c8701a18bb43af496902f07082938fe12.jpg",
    "https://img.51miz.com/Photo/2017/04/27/17/P1078592_16e027191373354ed707deb4f3d92d77.jpg",
    "https://th.bing.com/th/id/R.39d1feb6e2881ffd0be351d37ce0c9b1?rik=80KqiObQdxvcKA&riu=http%3a%2f%2fwall8.com%2f070420%2ffengjing%2fmingsheng%2fpic007.jpg&ehk=DgMPfO5Q7oBcFanCCHaaAW00DkSojcWZLB7YEKjIlvU%3d&risl=&pid=ImgRaw&r=0",
    "https://gss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/zhidao/pic/item/8ad4b31c8701a18bb43af496902f07082938fe12.jpg",
    "https://img.51miz.com/Photo/2017/04/27/17/P1078592_16e027191373354ed707deb4f3d92d77.jpg",
    "https://th.bing.com/th/id/R.39d1feb6e2881ffd0be351d37ce0c9b1?rik=80KqiObQdxvcKA&riu=http%3a%2f%2fwall8.com%2f070420%2ffengjing%2fmingsheng%2fpic007.jpg&ehk=DgMPfO5Q7oBcFanCCHaaAW00DkSojcWZLB7YEKjIlvU%3d&risl=&pid=ImgRaw&r=0",
    "https://gss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/zhidao/pic/item/8ad4b31c8701a18bb43af496902f07082938fe12.jpg",
    "https://img.51miz.com/Photo/2017/04/27/17/P1078592_16e027191373354ed707deb4f3d92d77.jpg",
    "https://th.bing.com/th/id/R.39d1feb6e2881ffd0be351d37ce0c9b1?rik=80KqiObQdxvcKA&riu=http%3a%2f%2fwall8.com%2f070420%2ffengjing%2fmingsheng%2fpic007.jpg&ehk=DgMPfO5Q7oBcFanCCHaaAW00DkSojcWZLB7YEKjIlvU%3d&risl=&pid=ImgRaw&r=0",
    "https://gss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/zhidao/pic/item/8ad4b31c8701a18bb43af496902f07082938fe12.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text("this is photo data"),
          Container(
            alignment: Alignment.center,
            child: WrapPhotoWidget(
              imgUrlList: galleryNetworkItems,
              spacing: 5,
              runSpacing: 5,
              size: 100,
              maxImgCount: 9,
              isAssets: false,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: SwiperPhoto(
              imgUrlList: galleryNetworkItems,
              isAssets: false,
            ),
          ),
          singlePhoto(
            "https://img.51miz.com/Photo/2017/04/27/17/P1078592_16e027191373354ed707deb4f3d92d77.jpg",
            isAssets: false,
            width: 200,
            height: 500,
          ),
        ],
      ),
    );
  }

  Widget singlePhoto(String imageUrl, {double height = 50, double width = 50, bool isAssets = true}) {
    return MultiplePhotoWidget(
      imgList: [imageUrl],
      height: height,
      width: width,
      index: 0,
      isAssets: isAssets,
    );
  }
}
