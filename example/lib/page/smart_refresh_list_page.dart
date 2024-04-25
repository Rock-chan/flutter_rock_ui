import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rock_ui/widget/refresh/smart_refresh_list.dart';

class SmartRefreshListPage extends StatelessWidget {
  const SmartRefreshListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SmartRefreshList"),
      ),
      body: SmartRefreshList(
        loadDataCallBack: (int offset) {
          return Future.delayed(const Duration(seconds: 2), () {
            return List.generate(10, (index) => 'item$index');
            throw Exception();
          });
        },
        buildListItemCallBack: (BuildContext context, data, int index) {
          return Container(
            height: 50,
            //随机色
            color: Color.fromARGB(255, Random().nextInt(256), Random().nextInt(256), Random().nextInt(256)),
            alignment: Alignment.center,
            child: Text("$data"),
          );
        },
      ),
    );
  }
}
