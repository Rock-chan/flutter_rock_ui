import 'package:example/page/animation_page.dart';
import 'package:example/widget/item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rock_ui/widget/count_down/count_down_widget.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rock UI Demo"),
      ),
      body: _buildCountDown(),
    );
  }

  _buildCountDown() {
    return CountDownWidget(
      countDownTime: 1000,
      builder: (context, day, hour, minute, second) {
        return Row(
          children: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.0), color: const Color(0xfffaefff)),
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1.0),
              child: Text(
                "$day",
                style: const TextStyle(
                  fontSize: 13.0,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Color(0xfffaefff),
                ),
              ),
            ),
            const Text("天", style: TextStyle(fontSize: 12, color: Color(0xffa29bb0))),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.0), color: const Color(0xfffaefff)),
              padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 1.0),
              child: Text(
                "$hour",
                style: const TextStyle(fontSize: 13.0, color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
            const Text("时", style: TextStyle(fontSize: 12, color: Color(0xffa29bb0))),
            Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.0), color: const Color(0xfffaefff)),
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1.0),
                child: Text("$minute",
                    style: const TextStyle(fontSize: 13.0, color: Colors.red, fontWeight: FontWeight.bold))),
            const Text("分", style: TextStyle(fontSize: 12, color: Color(0xffa29bb0))),
            Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.0), color: const Color(0xfffaefff)),
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1.0),
                child: Text("$second",
                    style: const TextStyle(fontSize: 13.0, color: Colors.red, fontWeight: FontWeight.bold))),
            const Text("秒", style: TextStyle(fontSize: 12, color: Color(0xffa29bb0))),
          ],
        );
      },
    );
  }
}
