import 'package:example/widget/item_widget.dart';
import 'package:flutter/material.dart';

class AnimationPage extends StatelessWidget {
  const AnimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animation"),
      ),
      body: Wrap(
        children: [
          buildItem(
            "animation",
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
