import 'package:example/page/activity_dialog_page.dart';
import 'package:example/widget/item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        ],
      ),
    );
  }
}
