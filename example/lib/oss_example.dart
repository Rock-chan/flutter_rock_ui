import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rock_ui/aliyun_oss/better_aliyun_oss_client.dart';
import 'package:flutter_rock_ui/aliyun_oss/better_aliyun_oss_credentials.dart';
import 'package:flutter_rock_ui/aliyun_oss/oss_utils.dart';
import 'package:flutter_rock_ui/extensions/app_extensions.dart';
import 'package:flutter_rock_ui/utils/object_utils.dart';
import 'package:image_picker/image_picker.dart';

import 'entity/oss_entity.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      locale: const Locale("en"),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late BetterAliyunOssClient ossClient;
  BetterAliyunOssClientRequest? simplePutRequest;
  OssEntity ossEntity = OssEntity();
  String imgUrl = "https://momentify.oss-cn-beijing.aliyuncs.com/img/community/20240109020808.jpg";

  @override
  initState() {
    ossClient = BetterAliyunOssClient(credentials);

    super.initState();
  }

  Future<BetterAliyunOssCredentials?> credentials() async {
    //第一步 从服务器获取stsinfo
    Dio dio = Dio();

    Map params = {}; //参数自理
    Response e = await dio.post("http://192.168.34.43:9988/oss/stsInfo", //地址自理s
        queryParameters: Map.from(params));
    ossEntity = OssEntity.fromJson(e.data['data']);

    final credentials = {
      "SecurityToken": ossEntity.securityToken,
      "AccessKeyId": ossEntity.accessKeyId,
      "AccessKeySecret": ossEntity.accessKeySecret,
      "Expiration": "2050-04-08T03:44:21Z",
    };
    return BetterAliyunOssCredentials.fromMap(credentials);
  }

  void selectPhoto() {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(
            title: const Text(
              '选择图片',
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
            actions: <Widget>[
              CupertinoActionSheetAction(
                onPressed: () async {
                  Navigator.pop(context);
                  final ImagePicker picker = ImagePicker();
                  final XFile? pickerImages = await picker.pickImage(source: ImageSource.camera);
                  if (pickerImages != null) {
                    if (!ObjectUtil.isEmptyString(pickerImages.path)) {
                      OssUtils.uploadImage(
                        pickerImages.path,
                        ossClient: ossClient,
                        simplePutRequest: simplePutRequest,
                        uploadCallBack: (BetterAliyunOssClientEvent event, String remoteUrl) async {
                          if (!ObjectUtil.isEmptyString(remoteUrl)) {
                            imgUrl = remoteUrl;
                            setState(() {});
                          }
                        },
                      );
                    } else {
                      '选择图片出错'.toast();
                    }
                  }
                },
                isDefaultAction: false,
                child: const Text(
                  '拍照',
                  style: TextStyle(fontSize: 19, color: Colors.blue),
                ),
              ),
              CupertinoActionSheetAction(
                onPressed: () async {
                  Navigator.pop(context);
                  final ImagePicker picker = ImagePicker();
                  final XFile? pickerImages = await picker.pickImage(source: ImageSource.gallery);
                  if (pickerImages != null) {
                    if (!ObjectUtil.isEmptyString(pickerImages.path)) {
                      OssUtils.uploadImage(pickerImages.path, ossClient: ossClient, simplePutRequest: simplePutRequest,
                          uploadCallBack: (BetterAliyunOssClientEvent event, String remoteUrl) async {
                        if (!ObjectUtil.isEmptyString(remoteUrl)) {
                          imgUrl = remoteUrl;
                          setState(() {});
                        }
                      });
                    } else {
                      '选择图片出错'.toast();
                    }
                  }
                },
                isDefaultAction: false,
                child: const Text('去相册选择', style: TextStyle(fontSize: 19, color: Colors.blue)),
              ),
              CupertinoActionSheetAction(
                onPressed: () async {
                  Navigator.pop(context);
                  // final pickerImages = await ImagePickers.pickerPaths();
                  final ImagePicker picker = ImagePicker();
                  final List<XFile> pickerImages = await picker.pickMultiImage();
                  List<String> localImages = [];
                  for (var element in pickerImages) {
                    if (!element.path.startsWith("http")) {
                      localImages.add(element.path);
                    }
                  }
                  if (!ObjectUtil.isEmptyList(pickerImages)) {
                    if (!ObjectUtil.isEmptyString(pickerImages.first.path)) {
                      OssUtils.uploadImages(
                        localImages,
                        ossClient: ossClient,
                        simplePutRequest: simplePutRequest,
                        multipleUploadCallBack: (List<String> remoteUrl) async {},
                      );
                      // success(pickerImages.first.path!);
                    } else {
                      '选择图片出错'.toast();
                    }
                  }
                },
                isDefaultAction: false,
                child: const Text('去相册选择多张', style: TextStyle(fontSize: 19, color: Colors.blue)),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              isDefaultAction: true,
              child: const Text('取消', style: TextStyle(fontSize: 19, color: Colors.blue)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Image.network(imgUrl),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          selectPhoto();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
