import 'dart:math';

import 'package:example/entity/lottery_result_entity.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rock_ui/utils/date_utils.dart';
import 'package:flutter_rock_ui/utils/object_utils.dart';
import 'package:flutter_rock_ui/utils/wechat_utils.dart';
import 'package:flutter_rock_ui/widget/animation/fade_opacity_animation.dart';
import 'package:flutter_rock_ui/widget/animation/scale_animation.dart';
import 'package:flutter_rock_ui/widget/animation/up_down_animation.dart';
import 'package:flutter_rock_ui/widget/common_widget.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// 2024四月大会相关弹框

/// 渐变色文字
Widget gradientText(String text,
    {List<Color> colors = const [Color(0xfffefcf4), Color(0xFFfedcb2)],
    AlignmentGeometry begin = Alignment.topCenter,
    AlignmentGeometry end = Alignment.bottomCenter,
    double fontSize = 30.0,
    FontWeight fontWeight = FontWeight.bold}) {
  return ShaderMask(
    shaderCallback: (Rect bounds) {
      return const LinearGradient(
        colors: <Color>[Color(0xfffefcf4), Color(0xFFfedcb2)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: <double>[0.0, 1.0],
        // tileMode: TileMode.mirror,
      ).createShader(bounds);
    },
    blendMode: BlendMode.srcATop,
    child: Center(
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
      ),
    ),
  );
}

/// 灵感发布成功弹框
class NormalDialog extends StatefulWidget {
  const NormalDialog({super.key, this.onTap, this.closeOnTap, this.point = 0, this.nextPoint = 0});

  final VoidCallback? onTap;

  final VoidCallback? closeOnTap;

  final int point;
  final int nextPoint;

  @override
  State<NormalDialog> createState() => _NormalDialogState();
}

class _NormalDialogState extends State<NormalDialog> with SingleTickerProviderStateMixin {
  FlipCardController? controller;

  @override
  void initState() {
    controller = FlipCardController();
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (controller != null) {
        controller!.toggleCard();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 341.5,
              width: 300,
              child: Stack(
                children: [
                  const Positioned(left: 20.0, child: CircleBackgroundAnimationWidget(size: 272.5)),
                  const StarBackgroundAnimationWidget(),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: FadeOpacityAnimation(
                      startDuration: const Duration(milliseconds: 200),
                      duration: const Duration(milliseconds: 200),
                      beginTween: 0,
                      endTween: 1,
                      child: gradientText("恭喜您", fontSize: 32.0),
                    ),
                  ),
                  FlipCard(
                    controller: controller,
                    front: _buildCard(),
                    back: _buildCard(),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                widget.closeOnTap?.call();
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  "assets/images/close5.png",
                  height: 28.63,
                  width: 28.63,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard() {
    return Stack(
      children: [
        Positioned(
          top: 54.5,
          child: Image.asset(
            "assets/images/inspiration_dialog_bg.webp",
            width: 300.0,
            fit: BoxFit.fitWidth,
          ),
        ),
        Positioned(
          top: 68.0,
          left: 0,
          right: 0,
          child: UpDownAnimation(
            child: Image.asset(
              "assets/images/inspiration_bubble.png",
              width: 80.0,
              height: 75.78,
            ),
          ),
        ),
        Positioned(
            bottom: 20.0,
            left: 73.5,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: widget.onTap,
              child: Container(
                height: 44.0,
                width: 153.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xfff944ff),
                      Color(0xffff3176),
                    ],
                  ),
                ),
                child: const Text(
                  "马上转发",
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
            )),
        Positioned(
          top: 170.0,
          left: 27.0,
          child: Container(
            width: 245.5,
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  "恭喜您获得${widget.point}π能量点",
                  style: const TextStyle(color: Color(0xff542d69), fontSize: 21.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4.0),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      const TextSpan(text: "继续转发好友或朋友圈\n"),
                      const TextSpan(text: "还能额外获得"),
                      TextSpan(
                        text: "${widget.nextPoint}π",
                        style: const TextStyle(color: Color(0xff4080ff), fontSize: 17.0),
                      ),
                      const TextSpan(text: "能量"),
                    ],
                    style: const TextStyle(color: Color(0xff6b677e), fontSize: 17.0, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// 交换名片弹框
class ChangeCardDialog extends StatefulWidget {
  const ChangeCardDialog({super.key, this.onTap, this.point = 0, this.imgUrl, this.enterpriseName, this.name});

  final VoidCallback? onTap;
  final int point;
  final String? imgUrl;
  final String? enterpriseName;
  final String? name;

  @override
  State<ChangeCardDialog> createState() => _ChangeCardDialogState();
}

class _ChangeCardDialogState extends State<ChangeCardDialog> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Offset>? _offsetAnimation;

  FlipCardController? controller;

  @override
  initState() {
    controller = FlipCardController();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.10),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.ease,
    ));

    Future.delayed(const Duration(milliseconds: 300), () {
      _controller!.forward();
    });

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (controller != null) {
        controller!.toggleCard();
      }
    });
  }

  @override
  dispose() {
    _controller!.stop();
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 395.44,
              width: 375.0,
              child: Stack(
                children: [
                  const Positioned(top: 80.0, left: 80.0, child: CircleBackgroundAnimationWidget(size: 235.5)),
                  const Positioned(top: 80.0, left: 40.0, child: StarBackgroundAnimationWidget()),
                  Positioned(
                    top: 50,
                    left: 0,
                    right: 0,
                    child: FadeOpacityAnimation(
                      startDuration: const Duration(milliseconds: 200),
                      duration: const Duration(milliseconds: 200),
                      beginTween: 0,
                      endTween: 1,
                      child: gradientText("申请与您交换名片", fontSize: 32.0),
                    ),
                  ),
                  FlipCard(
                    front: _buildCard(),
                    back: _buildCard(),
                    controller: controller,
                  )
                ],
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset("assets/images/close5.png", width: 28.63, height: 28.63),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard() {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 66.0,
          child: Image.asset(
            "assets/images/change_card_bg_bottom.webp",
            width: 243.0,
            fit: BoxFit.fitWidth,
          ),
        ),
        Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SlideTransition(
                position: _offsetAnimation!,
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/images/change_card_bg_hand.webp",
                      width: 398.62,
                      fit: BoxFit.fitWidth,
                    ),
                    Positioned(
                      top: 125.0,
                      left: 83.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Image.network(
                              'https://resoss.meiyeyanjiu.com/tkradar/image/20230727/827ef3902c5e11eeb5d0418ee4393348.jpg',
                              width: 40.0,
                              height: 40.0,
                            ),
                          ),
                          Container(
                            width: 220.0,
                            height: 41.0,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.enterpriseName ?? '',
                              style: const TextStyle(fontSize: 16.0, color: Color(0xff3c1551)),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            width: 220.0,
                            margin: const EdgeInsets.only(top: 3.0),
                            child: Text(
                              widget.name ?? '',
                              style: const TextStyle(fontSize: 12.0, color: Color(0xff3c1551)),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 285.0,
              left: 66.0,
              child: Container(
                width: 243.0,
                color: Colors.white,
                padding: const EdgeInsets.only(bottom: 40.0, top: 12.0),
                alignment: Alignment.topCenter,
                child: Text("交换名片成功，可以获得${widget.point}π能量",
                    style: const TextStyle(fontSize: 12.0, color: Color(0xff6b677e))),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 16.0,
          left: 111.0,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: widget.onTap,
            child: Image.asset(
              "assets/images/change_card_agree.webp",
              width: 153.0,
              fit: BoxFit.fitWidth,
            ),
          ),
        )
      ],
    );
  }
}

/// 规则弹框
class RuleDialog extends StatelessWidget {
  const RuleDialog({super.key, required this.rule});

  final String rule;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        child: Container(
          height: 516.0,
          width: 335,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
          ),
          // alignment: Alignment.center,
          child: Stack(
            children: [
              Image.asset("assets/images/rule_dialog_bg_top.png", fit: BoxFit.fitWidth),
              Positioned(
                right: 0,
                top: 0,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Image.asset(
                        'assets/images/bottom_sheet_close.png',
                        width: 20,
                        height: 20,
                        color: Color(0xff333333),
                      )),
                ),
              ),
              SizedBox(
                width: 375.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40.0),
                    const Text("规则说明",
                        style: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      height: 414.0,
                      width: 295.0,
                      child: Scrollbar(
                        thickness: 3.0,
                        radius: const Radius.circular(3.5),
                        child: SingleChildScrollView(
                          child: Text(
                            rule,
                            style: const TextStyle(fontSize: 14.0, color: Colors.black, height: 1.4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// 中奖弹框
class PrizeDialog extends StatefulWidget {
  const PrizeDialog({super.key, required this.prize});

  final LotteryResultEntity prize;

  @override
  State<PrizeDialog> createState() => _PrizeDialogState();
}

class _PrizeDialogState extends State<PrizeDialog> {
  FlipCardController? controller;

  @override
  void initState() {
    controller = FlipCardController();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (controller != null) {
        controller!.toggleCard();
        wechatShakeResultMock();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Stack(
          children: [
            const Positioned(left: 35.5, child: CircleBackgroundAnimationWidget(size: 222.0)),
            const StarBackgroundAnimationWidget(),
            FlipCard(
              front: _buildCard(),
              back: _buildCard(),
              controller: controller,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 62.5,
                      child: Image.asset(
                        "assets/images/prize_dialog_bg_top_icon.png",
                        width: 153.51,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Container(
                      width: 300,
                      margin: const EdgeInsets.only(top: 60.0),
                      padding: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(24.0),
                          topRight: Radius.circular(24.0),
                        ),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/prize_dialog_bg_top.png'),
                          alignment: Alignment.topCenter,
                        ),
                        border: Border.all(width: 0, color: Colors.white),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 18.0),
                            padding: EdgeInsets.only(top: 58.5),
                            child: Text(
                              '${widget.prize.itemName} ${widget.prize.prize}',
                              style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (!ObjectUtil.isEmptyString(widget.prize.expireTime))
                            Padding(
                                padding: EdgeInsets.only(bottom: 6, top: 6.0),
                                child: Text(
                                  '有效期至：${DateUtil.formatDateStr(widget.prize.expireTime ?? '', format: 'yyyy-MM-dd HH:mm', showO: true)}',
                                  style: const TextStyle(
                                      fontSize: 11, color: Color(0xffa29bb0), fontWeight: FontWeight.w400),
                                )),
                          Container(
                            height: 129.0,
                            width: 185.0,
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.88)),
                              child: Image.network(
                                "https://img6.zhaoyl.com/findTrend/2021/4/o_1f3rl18pa1bvq19vbia4ddbtsp1k.png",
                                width: 185.0,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          const Text(
                            '兑奖资格仅限当日有效,如若中奖,请及时到"兑奖处"领奖',
                            style: TextStyle(fontSize: 10, color: Color(0xffa29bb0), fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 64.5,
                      top: 60.0,
                      child: Image.asset(
                        "assets/images/prize_dialog_top_icon.png",
                        width: 171.0,
                        height: 39.0,
                        fit: BoxFit.fitWidth,
                      ),
                    )
                  ],
                ),
              ],
            ),
            Container(
              width: 300,
              constraints: const BoxConstraints(minHeight: 29),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/case_prize_line.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: buildHorizontalLine(margin: const EdgeInsets.symmetric(horizontal: 20)),
            ),
            Container(
              // height: 90.0,
              width: 335,
              padding: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 0, color: Colors.white),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24.0),
                  bottomRight: Radius.circular(24.0),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 42.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: const Color(0xFFD0D0D0), width: .5),
                    ),
                    child: Opacity(
                      opacity: 1,
                      child: QrImageView(
                        size: 66,
                        data: 'prizeWriteOff?code=${widget.prize.qrCode ?? ''}',
                        padding: const EdgeInsets.all(5),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "请在活动现场的“兑奖处”",
                        style: TextStyle(fontSize: 13.0, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        "向工作人员出示此码兑奖",
                        style: TextStyle(fontSize: 11.0, color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                    ],
                  )
                ],
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.pop(context);
                // _lotteryId = null;
                // haveScanWin.value = false;
              },
              child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Image.asset('assets/images/close5.png', color: Colors.white, width: 28, height: 28)),
            ),
          ],
        ),
      ),
    );
  }
}

/// 摇奖弹框
class ShakeDialog extends StatefulWidget {
  const ShakeDialog({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  State<ShakeDialog> createState() => _ShakeDialogState();
}

class _ShakeDialogState extends State<ShakeDialog> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;
  // final developController = Get.find<DevelopController>();

  int _cycleCount = 0; // 用来跟踪周期数

  @override
  initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 180), // 动画持续时间
      vsync: this,
    );

    // 使用Tween定义开始和结束状态
    _animation = Tween<double>(begin: 0.2, end: -0.05).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeInOut, // 定义动画的曲线
      ),
    );

    // 添加监听器来重复动画
    _animation!.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        if (_cycleCount % 2 < 2) {
          // 如果未完成两个周期
          _controller!.reverse(); // 完成一个来回后反向
        }
      } else if (status == AnimationStatus.dismissed) {
        _cycleCount++; // 一个来回完成，增加半个周期
        if (_cycleCount < 2) {
          // 如果未完成两个周期
          _controller!.forward(); // 开始下一个来回
          wechatShakeMock();
        } else {
          Future.delayed(const Duration(milliseconds: 800), () {
            _cycleCount = 0;
            _controller!.forward();
          });
        }
      }
    });

    // developController.activityOnShake = shake;

    super.initState();
  }

  @override
  dispose() {
    _controller!.stop();
    _controller!.dispose();
    // developController.activityOnShake = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 373.0,
              width: 319,
              child: Column(
                children: [
                  FadeOpacityAnimation(
                    startDuration: const Duration(milliseconds: 200),
                    duration: const Duration(milliseconds: 200),
                    beginTween: 0,
                    endTween: 1,
                    child: gradientText("摇动手机,赢好礼"),
                  ),
                  ScaleAnimation(
                    duration: const Duration(milliseconds: 300),
                    endTween: 1,
                    child: Container(
                      height: 305.72,
                      width: 375.0,
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          const StarBackgroundAnimationWidget(),
                          Container(
                            height: 305.72,
                            width: 295.04,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(top: 60.0),
                            child: Image.asset(
                              "assets/images/hand_shake_bg.webp",
                              width: 186.0,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          AnimatedBuilder(
                              animation: _animation!,
                              builder: (context, child) {
                                return Transform.rotate(
                                  angle: _animation!.value,
                                  child: Container(
                                    child: Image.asset(
                                      "assets/images/hand_shake.webp",
                                      width: 295.04,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                );
                              }),
                          Positioned(
                            bottom: 16.0,
                            left: 71.0,
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: shake,
                              child: Image.asset(
                                "assets/images/hand_shake_button.png",
                                width: 153.0,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Text(
                    "点我帮你摇",
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  )
                ],
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset("assets/images/close5.png", width: 28.63, height: 28.63),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 摇奖(点击)操作
  void shake() {
    _controller!.forward();
    Future.delayed(const Duration(milliseconds: 2250), () {
      _controller!.stop();
      Navigator.pop(context);
      if (widget.onTap != null) {
        widget.onTap!.call();
      }
    });
  }
}

/// 领奖券弹框
class CouponDialog extends StatefulWidget {
  const CouponDialog({super.key, this.cancelOnTap});

  final VoidCallback? cancelOnTap;

  @override
  State<CouponDialog> createState() => _CouponDialogState();
}

class _CouponDialogState extends State<CouponDialog> {
  @override
  initState() {
    super.initState();
    wechatShakeResultMock();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 400.0,
              width: 286.1,
              child: Stack(
                children: [
                  const Positioned(
                    left: 60.5,
                    top: 47.5,
                    child: CircleBackgroundAnimationWidget(),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: FadeOpacityAnimation(
                      startDuration: const Duration(milliseconds: 200),
                      duration: const Duration(milliseconds: 200),
                      beginTween: 0,
                      endTween: 1,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(0.5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white.withOpacity(0),
                                  Colors.white.withOpacity(0.25),
                                  Colors.white.withOpacity(0)
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                stops: const [0, 0.5, 1.0],
                              ),
                              border: Border.all(
                                width: 0.5,
                                color: Colors.transparent, // 设置边框颜色为透明
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 6.5),
                            child: Column(
                              children: const [
                                Text(
                                  "叠加奖券能够增加中大奖机会",
                                  style: TextStyle(fontSize: 15.0, color: Color(0xFFfedcb2)),
                                ),
                                SizedBox(height: 3.0),
                                Text(
                                  "大会尾声抽大奖,最高可中MacBook",
                                  style: TextStyle(fontSize: 13.0, color: Color(0xFFfedcb2)),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 17.5),
                          gradientText("恭喜您获得一张奖券"),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    top: 0,
                    child: ScaleAnimation(
                      duration: const Duration(milliseconds: 180),
                      endTween: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 20.0),
                        child: Image.asset(
                          "assets/images/coupon_dialog.webp",
                          width: 177.0,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    top: 0,
                    child: ScaleAnimation(
                      duration: const Duration(milliseconds: 300),
                      startDuration: const Duration(milliseconds: 180),
                      endTween: 1,
                      child: Image.asset(
                        "assets/images/coupon_decoration.png",
                        width: 272.0,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 26,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.pop(context);
                        widget.cancelOnTap?.call();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset("assets/images/close5.png", width: 28.63, height: 28.63),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 圆圈背景（从小到大、从有到无）
class CircleBackgroundAnimationWidget extends StatefulWidget {
  const CircleBackgroundAnimationWidget(
      {super.key, this.duration = const Duration(milliseconds: 1000), this.size = 177.0});

  final Duration? duration;
  final double? size;

  @override
  State<CircleBackgroundAnimationWidget> createState() => _CircleBackgroundAnimationWidgetState();
}

class _CircleBackgroundAnimationWidgetState extends State<CircleBackgroundAnimationWidget>
    with SingleTickerProviderStateMixin {
  // 背景圆圈
  Animation<double>? _circleFadeAnimation;
  AnimationController? _circleAnimationController;

  @override
  initState() {
    // 创建动画控制器
    _circleAnimationController = AnimationController(
      vsync: this,
      duration: widget.duration, // 动画持续时间为2秒
    );

    final curve = CurvedAnimation(parent: _circleAnimationController!, curve: Curves.easeInOut);

    // 创建淡入淡出动画 透明度0-1
    _circleFadeAnimation = Tween<double>(begin: 1, end: 0).animate(curve);

    // 开始动画
    _circleAnimationController?.forward();

    super.initState();
  }

  @override
  dispose() {
    _circleAnimationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: FadeTransition(
        opacity: _circleFadeAnimation!,
        child: ScaleAnimation(
          child: Image.asset("assets/images/circle_bg.png", width: widget.size, fit: BoxFit.fitWidth),
        ),
      ),
    );
  }
}

/// 星星背景（从小到大）
class StarBackgroundAnimationWidget extends StatelessWidget {
  const StarBackgroundAnimationWidget({super.key, this.duration = const Duration(milliseconds: 900)});

  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ScaleAnimation(
        duration: duration,
        isRepeat: true,
        child: Image.asset(
          "assets/images/star_bg.png",
          width: 299.0,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}

class Bezier extends StatefulWidget {
  const Bezier({
    super.key,
    required this.child,
    this.startPosition,
    this.endPosition,
    this.animationDuration = const Duration(milliseconds: 1000),
  });

  final Offset? startPosition;
  final Offset? endPosition;
  final Duration? animationDuration;
  final Widget child;

  @override
  State<Bezier> createState() => _BezierState();
}

class _BezierState extends State<Bezier> with SingleTickerProviderStateMixin {
  /// 小圆点的left（动态计算）
  double? left;

  ///小圆点的right（动态计算）
  double? top;

  /// 动画controller
  AnimationController? _controller;

  /// 动画
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.animationDuration, vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller!.view);

    // 二阶贝塞尔曲线用值
    var x0 = widget.startPosition?.dx;
    var y0 = widget.startPosition?.dy;

    // 结束
    var x2 = widget.endPosition?.dx;
    var y2 = widget.endPosition?.dy;

    var x1 = widget.startPosition!.dx / 2;
    var y1 = widget.endPosition!.dy - 100;

    _animation?.addListener(() {
      // t 动态变化的值
      var t = _animation?.value;
      if (mounted) {
        setState(() {
          left = pow(1 - t!, 2) * x0! + 2 * t * (1 - t) * x1 + pow(t, 2) * x2!;
          top = pow(1 - t, 2) * y0! + 2 * t * (1 - t) * y1 + pow(t, 2) * y2!;
        });
      }
    });

    // 初始化小圆点的位置
    left = widget.startPosition?.dx;
    top = widget.startPosition?.dy;

    // 显示小圆点的时候动画就开始
    // Future.delayed(Duration(milliseconds: 2000), () {
    //   _controller?.forward();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          left: left,
          top: top,
          child: widget.child,
        )
      ],
    );
  }
}
