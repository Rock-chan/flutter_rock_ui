import 'package:flutter/material.dart';
import 'package:flutter_rock_ui/widget/count_down/count_down_widget.dart';

class CountdownWidgetPage extends StatefulWidget {
  const CountdownWidgetPage({super.key});

  @override
  State<CountdownWidgetPage> createState() => _CountdownWidgetPageState();
}

class _CountdownWidgetPageState extends State<CountdownWidgetPage> {
  int? timeStamp;

  @override
  void initState() {
    super.initState();
    timeStamp = DateTime.now().add(const Duration(days: 299)).millisecondsSinceEpoch;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Countdown Widget"),
      ),
      body: _buildCountDown(),
    );
  }

  _buildCountDown() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          DateTime.fromMillisecondsSinceEpoch(timeStamp ?? 0).toString(),
          style: const TextStyle(fontSize: 20.0),
        ),
        const SizedBox(height: 10.0),
        CountDownWidget(
          countDownTime: timeStamp ?? 0,
          builder: (context, day, hour, minute, second) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.0), color: const Color(0xfffaefff)),
                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1.0),
                  child: Text(
                    "$day",
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Color(0xfffaefff),
                    ),
                  ),
                ),
                const Text("天", style: TextStyle(fontSize: 20.0, color: Color(0xffa29bb0))),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.0), color: const Color(0xfffaefff)),
                  padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 1.0),
                  child: Text(
                    "$hour",
                    style: const TextStyle(fontSize: 20.0, color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
                const Text("时", style: TextStyle(fontSize: 20.0, color: Color(0xffa29bb0))),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.0), color: const Color(0xfffaefff)),
                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1.0),
                  child: Text(
                    "$minute",
                    style: const TextStyle(fontSize: 20.0, color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
                const Text("分", style: TextStyle(fontSize: 20.0, color: Color(0xffa29bb0))),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.0), color: const Color(0xfffaefff)),
                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1.0),
                  child: Text(
                    "$second",
                    style: const TextStyle(fontSize: 20.0, color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
                const Text("秒", style: TextStyle(fontSize: 20, color: Color(0xffa29bb0))),
              ],
            );
          },
        ),
      ],
    );
  }
}
