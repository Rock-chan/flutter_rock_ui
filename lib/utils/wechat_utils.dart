import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:vibration/vibration.dart';

/// 模仿微信扫码的震动跟音效
Future<void> wechatScanMock() async {
  await Vibration.vibrate(duration: 10);
  AssetsAudioPlayer.newPlayer().open(
    Audio("assets/audio/qrcode_completed.mp3"),
    showNotification: false,
  );
}

/// 模仿微信摇一摇的震动跟音效
Future<void> wechatShakeMock() async {
  await Vibration.vibrate();
  AssetsAudioPlayer.newPlayer().open(
    Audio("assets/audio/wechat_shake.mp3"),
    showNotification: false,
  );
}

/// 模仿微信摇一摇结果音效
void wechatShakeResultMock() {
  AssetsAudioPlayer.newPlayer().open(
    Audio("assets/audio/wechat_shake_result.wav"),
    showNotification: false,
  );
}
