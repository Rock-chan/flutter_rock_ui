import 'package:flutter/cupertino.dart';

class ErrorStateWidget extends StatelessWidget {
  const ErrorStateWidget({Key? key, this.onTap}) : super(key: key);

  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: 300,
          height: 400,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Image.asset('assets/images/network_error.webp', width: 200, height: 120),
              const SizedBox(height: 15),
              const Text('加载失败，请检查网络！', style: TextStyle(fontSize: 15, color: Color(0xFF999999))),
              const SizedBox(height: 16),
              Container(
                  width: 110,
                  height: 29,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2), border: Border.all(width: 0.5, color: Color(0xFF999999))),
                  child: const Text('重新加载', style: TextStyle(fontSize: 15, color: Color(0xFF999999)))),
            ],
          ),
        ),
      ),
    );
  }
}
