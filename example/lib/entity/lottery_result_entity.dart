/// id : 35
/// lotteryId : 7
/// itemId : 28
/// itemName : "化妆品图书类"
/// itemPic : null
/// num : 1
/// prize : "奖品1"
/// prizePic : "https://img6.zhaoyl.com/findTrend/2021/4/o_1f3rl18pa1bvq19vbia4ddbtsp1k.png"
/// remark : null
/// limitFlag : "N"
/// sort : 1
/// nextLotteryItem : null
/// concurrentActivityImg : null
/// hadWinLottery : null
/// expireTime: "2024-03-21 23:59:59",

class LotteryResultEntity {
  LotteryResultEntity({
    int? id,
    int? lotteryId,
    int? itemId,
    String? itemName,
    dynamic itemPic,
    int? num,
    String? prize,
    String? prizePic,
    dynamic remark,
    String? limitFlag,
    int? sort,
    dynamic nextLotteryItem,
    dynamic concurrentActivityImg,
    bool? hadWinLottery,
    String? expireTime,
    String? qrCode,
  }) {
    _id = id;
    _lotteryId = lotteryId;
    _itemId = itemId;
    _itemName = itemName;
    _itemPic = itemPic;
    _num = num;
    _prize = prize;
    _prizePic = prizePic;
    _remark = remark;
    _limitFlag = limitFlag;
    _sort = sort;
    _nextLotteryItem = nextLotteryItem;
    _concurrentActivityImg = concurrentActivityImg;
    _hadWinLottery = hadWinLottery;
    _expireTime = expireTime;
    _qrCode = qrCode;
  }

  LotteryResultEntity.fromJson(dynamic json) {
    _id = json['id'];
    _lotteryId = json['lotteryId'];
    _itemId = json['itemId'];
    _itemName = json['itemName'];
    _itemPic = json['itemPic'];
    _num = json['num'];
    _prize = json['prize'];
    _prizePic = json['prizePic'];
    _remark = json['remark'];
    _limitFlag = json['limitFlag'];
    _sort = json['sort'];
    _nextLotteryItem = json['nextLotteryItem'];
    _concurrentActivityImg = json['concurrentActivityImg'];
    _hadWinLottery = json['hadWinLottery'];
    _expireTime = json['expireTime'];
    _qrCode = json['qrCode'];
  }

  int? _id;
  int? _lotteryId;
  int? _itemId;
  String? _itemName;
  dynamic _itemPic;
  int? _num;
  String? _prize;
  String? _prizePic;
  dynamic _remark;
  String? _limitFlag;
  int? _sort;
  dynamic _nextLotteryItem;
  dynamic _concurrentActivityImg;
  bool? _hadWinLottery;
  String? _expireTime;
  String? _qrCode;

  int? get id => _id;

  int? get lotteryId => _lotteryId;

  int? get itemId => _itemId;

  String? get itemName => _itemName;

  dynamic get itemPic => _itemPic;

  int? get num => _num;

  String? get prize => _prize;

  String? get prizePic => _prizePic;

  dynamic get remark => _remark;

  String? get limitFlag => _limitFlag;

  int? get sort => _sort;

  dynamic get nextLotteryItem => _nextLotteryItem;

  dynamic get concurrentActivityImg => _concurrentActivityImg;

  bool? get hadWinLottery => _hadWinLottery;

  String? get expireTime => _expireTime;

  String? get qrCode => _qrCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['lotteryId'] = _lotteryId;
    map['itemId'] = _itemId;
    map['itemName'] = _itemName;
    map['itemPic'] = _itemPic;
    map['num'] = _num;
    map['prize'] = _prize;
    map['prizePic'] = _prizePic;
    map['remark'] = _remark;
    map['limitFlag'] = _limitFlag;
    map['sort'] = _sort;
    map['nextLotteryItem'] = _nextLotteryItem;
    map['concurrentActivityImg'] = _concurrentActivityImg;
    map['hadWinLottery'] = _hadWinLottery;
    map['expireTime'] = _expireTime;
    map['qrCode'] = _qrCode;
    return map;
  }
}
