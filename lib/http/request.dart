import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_rock_ui/http/env_enum.dart';
import 'package:flutter_rock_ui/http/http_log.dart';
import 'package:flutter_rock_ui/http/options/req_options.dart';
import 'package:flutter_rock_ui/http/options/res_options.dart';
import 'package:flutter_rock_ui/http/response_entity.dart';
import 'package:flutter_rock_ui/utils/json_utils.dart';
import 'package:flutter_rock_ui/utils/time_utils.dart';

class Request {
  static Map<Env, String>? _baseUrlMap;

  static Env? _env;

  String? _baseUrl;

  static init(Map<Env, String> map, Env env) {
    _baseUrlMap = map;
    _env = env;
  }

  /// 单例模式
  static Request? _instance;

  /// 工厂函数：执行初始化
  factory Request() => _instance ?? Request._internal();

  /// 获取实例对象时，如果有则返回，没有则初始化
  static Request? get instance => _instance ?? Request._internal();

  /// dio实例
  static Dio? _dio;

  ///是否打印日志到控制台
  static bool enablePrintLog = true;

  ReqOptions? _options;

  ResOptions? _resOptions;

  /// 初始化
  Request._internal() {
    assert(_baseUrlMap != null);
    switch (_env!) {
      case Env.dev:
        enablePrintLog = true;
        break;
      case Env.test:
        enablePrintLog = false;
        break;
      case Env.prod:
        enablePrintLog = true;
        break;
    }
    _baseUrl = _baseUrlMap![_env];

    /// 初始化基本选项
    BaseOptions options = BaseOptions(
      baseUrl: _baseUrl!,
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 5000),
    );
    _instance = this;
    _dio = Dio(options);
    // _dio!.interceptors.add(InterceptorsWrapper(onRequest: _onRequest, onResponse: _onResponse, onError: _onError));
    _dio!.interceptors.add(CustomLogInterceptor());
  }

  void saveResponse(Response response) {
    var resOpt = ResOptions();
    resOpt.id = response.requestOptions.hashCode;
    resOpt.responseTime = DateTime.now();
    resOpt.statusCode = response.statusCode ?? 0;
    resOpt.data = response.data;
    resOpt.headers = response.headers.map;
    if (enablePrintLog) {
      log('request: url: ${_options?.url}');
      log('request: method: ${_options?.method}');
      log('request: params: ${_options?.params}');
      log('request: data: ${_options?.data}');
      log('request: duration: ${getTimeStr1(_options!.requestTime!)}');
      log('response: ${toJson(_resOptions?.data)}');
    }
  }

  Future<dynamic> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    var response = await _dio?.get(path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress);
    ResponseEntity entity = ResponseEntity.fromJson(jsonDecode(response.toString()));
    return entity.data;
  }

  Future<dynamic> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    var response = await _dio?.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
    ResponseEntity entity = ResponseEntity.fromJson(jsonDecode(response.toString()));
    return entity.data;
  }
}
