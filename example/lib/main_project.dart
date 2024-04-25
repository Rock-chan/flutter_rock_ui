import 'package:example/page/activity_dialog_page.dart';
import 'package:example/page/countdown_widget_page.dart';
import 'package:example/page/oss_example_page.dart';
import 'package:example/page/photo_view_page.dart';
import 'package:example/widget/item_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Rock UI Demo"),
      ),
      body: Wrap(
        children: [
          buildItem(
            "Dialog",
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ActivityDialogPage()));
              // Navigator.push(MaterialPageRoute(builder: (context) => const ActivityDialogPage()));
            },
          ),
          buildItem('PhotoView', onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => PhotoViewPage()));
          }),
          buildItem("Countdown Widget", onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const CountdownWidgetPage()));
          }),
          buildItem("Oss Example", onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const OssExamplePage(title: "Oss Example")));
          }),
        ],
      ),
    );
  }
}
