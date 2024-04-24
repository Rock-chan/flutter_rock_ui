import 'dart:io';

import 'package:flutter_rock_ui/aliyun_oss/better_aliyun_oss_client.dart';
import 'package:flutter_rock_ui/utils/toast_utils.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

typedef UploadCallBack = void Function(BetterAliyunOssClientEvent event, String remoteUrl);
typedef MultipleUploadCallBack = void Function(List<String> remoteUrlList);

class OssUtils {
  //是否为上传多个文件
  static bool isMultipleUpload = false;
  static int _uploadCount = 0; //多个文件上传统计次数用
  static final List<String> _multipleUrls = <String>[]; //上传完的多个url
  static List<String> _multipleLocalPathList = <String>[]; //本地上传的路径

  /// 上传图片
  static void uploadImage(
    String path, {
    required BetterAliyunOssClient ossClient,
    required BetterAliyunOssClientRequest? simplePutRequest,
    UploadCallBack? uploadCallBack,
    MultipleUploadCallBack? multipleUploadCallBack,
    String dateFormat = 'yyyyMMddhhmmss',
    String bucket = 'momentify',
    String endpoint = 'oss-cn-beijing.aliyuncs.com',
    String objectPath = 'img/community/',
    String contentType = "application/octet-stream",
  }) {
    File file = File(path);
    DateTime now = DateTime.now();
    var formatter = DateFormat(dateFormat);
    String timeStr = formatter.format(now);
    simplePutRequest = ossClient.putObject(
      bucket: bucket,
      endpoint: endpoint,
      objectPath: "$objectPath$timeStr${p.extension(file.path)}",
      contentType: lookupMimeType(file.path) ?? contentType,
      //buffer: bytes,
      path: file.path,
    );
    ossClient.eventStream.listen((event) {
      String remoteUrl = "https://$bucket.$endpoint/$objectPath$timeStr${p.extension(file.path)}";
      if (event.event == BetterAliyunOssClientEventEnum.success) {
        uploadCallBack?.call(event, remoteUrl);
      } else if (event.event == BetterAliyunOssClientEventEnum.failure) {
        uploadCallBack?.call(event, '');
      } else {
        uploadCallBack?.call(event, '');
      }
    });
  }

  /// 上传图片
  static uploadImages(
    List<String> paths, {
    required BetterAliyunOssClient ossClient,
    required BetterAliyunOssClientRequest? simplePutRequest,
    String dateFormat = 'yyyyMMddhhmmss',
    String bucket = 'momentify',
    String endpoint = 'oss-cn-beijing.aliyuncs.com',
    String preObjectPath = 'img/multiple/',
    String contentType = "application/octet-stream",
    MultipleUploadCallBack? multipleUploadCallBack,
  }) {
    _uploadCount = 0;
    isMultipleUpload = true;
    _multipleLocalPathList = paths;
    _multipleUrls.clear();
    for (String compressPath in paths) {
      File imgFile = File(compressPath);
      if (!imgFile.existsSync()) {
        ToastUtils.showToast("文件不存在");
        _multipleLocalPathList.remove(compressPath);
        return null;
      }
      DateTime now = DateTime.now();
      var formatter = DateFormat(dateFormat);
      String timeStr = formatter.format(now);
      String objectPath = "$preObjectPath$timeStr-${const Uuid().v1().replaceAll("-", "")}${p.extension(compressPath)}";
      _multipleUrls.add('https://$bucket.$endpoint/$objectPath');
      simplePutRequest = ossClient.putObject(
        bucket: bucket,
        endpoint: endpoint,
        objectPath: "$objectPath",
        contentType: lookupMimeType(compressPath) ?? contentType,
        //buffer: bytes,
        path: compressPath,
      );
      ossClient.eventStream.listen((event) {
        if (isMultipleUpload) {
          if (event.event == BetterAliyunOssClientEventEnum.success) {
            _uploadCount++;
            if ((_uploadCount == _multipleLocalPathList.length)) {
              multipleUploadCallBack?.call(_multipleUrls);
            }
          } else if (event.event == BetterAliyunOssClientEventEnum.failure) {
            multipleUploadCallBack?.call([]);
          }
          return;
        }
      });
    }
  }
}
