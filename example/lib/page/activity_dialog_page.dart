import 'package:example/entity/lottery_result_entity.dart';
import 'package:example/widget/dialog/dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivityDialogPage extends StatelessWidget {
  const ActivityDialogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("活动弹窗"),
        ),
        body: SizedBox(
          width: 375.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  showDialog(context: context, builder: (context) => ShakeDialog());
                  // showProductDevTreasureDialog();
                },
                child: const Text("摇奖Dialog"),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(context: context, builder: (context) => CouponDialog());
                  // showProductDevTreasureDialog();
                },
                child: const Text("领取奖券Dialog"),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return ChangeCardDialog(
                          imgUrl:
                              "https://resoss.meiyeyanjiu.com/tkradar/image/20230727/827ef3902c5e11eeb5d0418ee4393348.jpg",
                          name: "李小明李小明李小明李小明李小明李小明李小明李小明李小明李小明李小明李小明李小明李小明李小明李小明李小明李小明李小明李小明",
                          enterpriseName: "广州新数智能有限公司广州新数智能有限公司广州新数智能有限公司",
                        );
                      });
                  // Get.dialog(ChangeCardDialog(
                  //   imgUrl:
                  //       "https://resoss.meiyeyanjiu.com/tkradar/image/20230727/827ef3902c5e11eeb5d0418ee4393348.jpg",
                  //   name: "李小明李小明李小明李小明李小明李小明李小明李小明李小明李小明李小明李小明李小明李小明李小明李小明李小明李小明李小明李小明",
                  //   enterpriseName: "广州新数智能有限公司广州新数智能有限公司广州新数智能有限公司",
                  // ));
                  // showProductDevTreasureDialog();
                },
                child: const Text("交换名片Dialog"),
              ),
              ElevatedButton(
                onPressed: () {
                  LotteryResultEntity result = LotteryResultEntity.fromJson({
                    "id": 134,
                    "lotteryId": 33,
                    "itemId": 126,
                    "itemName": "二等奖",
                    "itemPic": null,
                    "num": 94,
                    "prize": "奖品名称：奖品名称奖品名称奖品名称奖品名称奖品名称奖品名称奖品名称奖品名称奖品名称奖品名称奖品名称奖品名称奖品名称奖品名称奖品名称",
                    "prizePic": "https://resoss.meiyeyanjiu.com/image/20240229/1709175206828.png",
                    "remark": "奖品描述：ipad",
                    "limitFlag": "Y",
                    "itemType": 0,
                    "itemData": null,
                    "sort": 2,
                    "nextLotteryItem": null,
                    "concurrentActivityImg": null,
                    "hadWinLottery": true,
                    "expireTime": "2024-03-21 23:59:59",
                    "qrCode": "MzM6MTQ3MTQ4NToxNjgzMzg2NzU0OTMzNjQ1MzEz"
                  });
                  showDialog(context: context, builder: (context) => PrizeDialog(prize: result));
                  // showProductDevTreasureDialog();
                },
                child: const Text("中奖Dialog"),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(context: context, builder: (context) => NormalDialog());
                  // showProductDevTreasureDialog();
                },
                child: const Text("灵感发布成功Dialog"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
