import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rock_ui/widget_flutter_binding/screen_adapter_binding.dart';
import 'package:flutter_rock_ui/widget_flutter_binding/ui_blueprints_rectangle.dart';

var uiSize = const BlueprintsRectangle(375, 812);

void main() {
  runZonedGuarded(() async {
    FxWidgetsFlutterBinding.ensureInitialized(uiBlueprints: uiSize);

    // checkCameraPermission();

    runApp(const MyApp2());
  }, (error, stack) {});
}

class MyApp2 extends StatefulWidget {
  const MyApp2({super.key});

  @override
  State<MyApp2> createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyApp3(),
    );
  }
}

class MyApp3 extends StatelessWidget {
  const MyApp3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 100,
              width: 100,
              color: Colors.red,
            ),
            SizedBox(
              height: 0,
              width: 100,
              child: OverflowBox(
                alignment: Alignment.bottomCenter,
                maxHeight: 120,
                minWidth: 100,
                minHeight: 100,
                child: Container(
                  height: 190,
                  width: 100,
                  color: Colors.blue,
                ),
              ),
            ),
            Container(
              height: 100,
              width: 100,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
