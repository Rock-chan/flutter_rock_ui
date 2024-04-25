import 'package:flutter/material.dart';

import '../loading/bar_scale_loading.dart';

class BusyStateWidget extends StatelessWidget {
  final Color loadingColor;

  const BusyStateWidget({Key? key, this.loadingColor = const Color(0xff4080ff)}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      width: 25,
      height: 15,
      child: BarScaleLoading(
        color: loadingColor,
      ),
    ));
  }
}
