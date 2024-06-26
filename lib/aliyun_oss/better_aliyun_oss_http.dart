import 'package:dio/dio.dart';

class BetterAliyunOssDioUtils {
  static Dio? _instance;

  static Dio getInstance(bool enableLog) {
    if (_instance == null) {
      _instance = Dio(BaseOptions(
          connectTimeout: const Duration(milliseconds: 1000 * 30),
          receiveTimeout: const Duration(milliseconds: 1000 * 30)));

      if (enableLog) {
        _instance!.interceptors.add(LogInterceptor(request: true, responseBody: true));
      }
    }

    return _instance!;
  }
}
