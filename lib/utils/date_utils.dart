/**
 * @Author: Sky24n
 * @GitHub: https://github.com/Sky24n
 * @Description: Date Util.
 * @Date: 2018/9/8
 */
import 'package:flutter/material.dart';

import 'object_utils.dart';

/// 一些常用格式参照。可以自定义格式，例如：'yyyy/MM/dd HH:mm:ss'，'yyyy/M/d HH:mm:ss'。
/// 格式要求
/// year -> yyyy/yy   month -> MM/M    day -> dd/d
/// hour -> HH/H      minute -> mm/m   second -> ss/s
class DateFormats {
  static String full = 'yyyy-MM-dd HH:mm:ss';
  static String custom = 'yyyy.MM.dd HH:mm';
  static String custom2 = 'yyyy.MM.dd';
  static String y_mo_d_h_m = 'yyyy-MM-dd HH:mm';
  static String y_mo_d = 'yyyy-MM-dd';
  static String y_mo = 'yyyy-MM';
  static String y_mo2 = 'yyyy.MM';
  static String mo_d = 'MM-dd';
  static String mo_d_h_m = 'MM-dd HH:mm';
  static String h_m_s = 'HH:mm:ss';
  static String h_m = 'HH:mm';

  static String zh_full = 'yyyy年MM月dd日 HH时mm分ss秒';
  static String zh_y_mo_d_h_m = 'yyyy年MM月dd日 HH时mm分';
  static String zh_y_mo_d = 'yyyy年MM月dd日';
  static String zh_y_mo = 'yyyy年MM月';
  static String zh_mo_d = 'MM月dd日';
  static String zh_mo_d_h_m = 'MM月dd日 HH时mm分';
  static String zh_h_m_s = 'HH时mm分ss秒';
  static String zh_h_m = 'HH时mm分';
}

/// month->days.
Map<int, int> MONTH_DAY = {
  1: 31,
  2: 28,
  3: 31,
  4: 30,
  5: 31,
  6: 30,
  7: 31,
  8: 31,
  9: 30,
  10: 31,
  11: 30,
  12: 31,
};

/// Date Util.
class DateUtil {
  /// get DateTime By DateStr.
  static DateTime? getDateTime(String dateStr, {bool? isUtc}) {
    DateTime? dateTime = DateTime.tryParse(dateStr);
    if (isUtc != null) {
      if (isUtc) {
        dateTime = dateTime?.toUtc();
      } else {
        dateTime = dateTime?.toLocal();
      }
    }
    return dateTime;
  }

  /// get DateTime By Milliseconds.
  static DateTime getDateTimeByMs(int ms, {bool isUtc = false}) {
    return DateTime.fromMillisecondsSinceEpoch(ms, isUtc: isUtc);
  }

  /// get DateMilliseconds By DateStr.
  static int? getDateMsByTimeStr(String dateStr, {bool? isUtc}) {
    DateTime? dateTime = getDateTime(dateStr, isUtc: isUtc);
    return dateTime?.millisecondsSinceEpoch;
  }

  /// get Now Date Milliseconds.
  static int getNowDateMs() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  /// get Now Date Str.(yyyy-MM-dd HH:mm:ss)
  static String getNowDateStr() {
    return formatDate(DateTime.now(), showO: true);
  }

  /// format date by milliseconds.
  /// milliseconds 日期毫秒
  static String formatDateMs(int ms,
      {bool isUtc = false, String? format, bool showO = false}) {
    return formatDate(getDateTimeByMs(ms, isUtc: isUtc),
        format: format, showO: showO);
  }

  /// format date by date str.
  /// dateStr 日期字符串
  static String formatDateStr(String dateStr,
      {bool? isUtc, String? format, bool showO = false}) {
    return formatDate(getDateTime(dateStr, isUtc: isUtc),
        format: format, showO: showO);
  }

  /// format date by DateTime.
  /// format 转换格式(已提供常用格式 DateFormats，可以自定义格式：'yyyy/MM/dd HH:mm:ss')
  /// 格式要求
  /// year -> yyyy/yy   month -> MM/M    day -> dd/d
  /// hour -> HH/H      minute -> mm/m   second -> ss/s
  static String formatDate(DateTime? dateTime,
      {String? format, bool showO = false}) {
    if (dateTime == null) return '';
    format = format ?? DateFormats.full;
    if (format.contains('yy')) {
      String year = dateTime.year.toString();
      if (format.contains('yyyy')) {
        format = format.replaceAll('yyyy', year);
      } else {
        format = format.replaceAll(
            'yy', year.substring(year.length - 2, year.length));
      }
    }

    format = _comFormat(dateTime.month, format, 'M', 'MM', showO: showO);
    format = _comFormat(dateTime.day, format, 'd', 'dd', showO: showO);
    format = _comFormat(dateTime.hour, format, 'H', 'HH', showO: showO);
    format = _comFormat(dateTime.minute, format, 'm', 'mm', showO: showO);
    format = _comFormat(dateTime.second, format, 's', 'ss', showO: showO);
    format = _comFormat(dateTime.millisecond, format, 'S', 'SSS', showO: showO);

    return format;
  }

  /// com format.
  static String _comFormat(int value, String format, String single, String full,
      {bool showO = false}) {
    /// 单位数是否显示0
    if (full == 'MM' || full == 'dd') {
      showO = showO;
    } else {
      showO = true;
    }
    if (format.contains(single)) {
      if (format.contains(full)) {
        format = format.replaceAll(
            full, value < 10 ? '${showO ? '0' : ''}$value' : value.toString());
      } else {
        format = format.replaceAll(single, value.toString());
      }
    }
    return format;
  }

  /// get WeekDay.
  /// dateTime
  /// isUtc
  /// languageCode zh or en
  /// short
  static String getWeekday(DateTime? dateTime,
      {String languageCode = 'en',
      bool short = false,
      bool realShort = false}) {
    if (dateTime == null) return "";
    String weekday = "";
    switch (dateTime.weekday) {
      case 1:
        weekday = languageCode == 'zh' ? '星期一' : 'Monday';
        break;
      case 2:
        weekday = languageCode == 'zh' ? '星期二' : 'Tuesday';
        break;
      case 3:
        weekday = languageCode == 'zh' ? '星期三' : 'Wednesday';
        break;
      case 4:
        weekday = languageCode == 'zh' ? '星期四' : 'Thursday';
        break;
      case 5:
        weekday = languageCode == 'zh' ? '星期五' : 'Friday';
        break;
      case 6:
        weekday = languageCode == 'zh' ? '星期六' : 'Saturday';
        break;
      case 7:
        weekday = languageCode == 'zh' ? '星期日' : 'Sunday';
        break;
      default:
        break;
    }
    return languageCode == 'zh'
        ? (short ? weekday.replaceAll('星期', realShort ? '' : '周') : weekday)
        : weekday.substring(0, short ? 3 : weekday.length);
  }

  /// get WeekDay By Milliseconds.
  static String getWeekdayByMs(int milliseconds,
      {bool isUtc = false, String languageCode = 'en', bool short = false}) {
    DateTime dateTime = getDateTimeByMs(milliseconds, isUtc: isUtc);
    return getWeekday(dateTime, languageCode: languageCode, short: short);
  }

  /// get day of year.
  /// 在今年的第几天.
  static int getDayOfYear(DateTime dateTime) {
    int year = dateTime.year;
    int month = dateTime.month;
    int days = dateTime.day;
    for (int i = 1; i < month; i++) {
      days = days + MONTH_DAY[i]!;
    }
    if (isLeapYearByYear(year) && month > 2) {
      days = days + 1;
    }
    return days;
  }

  /// get day of year.
  /// 在今年的第几天.
  static int getDayOfYearByMs(int ms, {bool isUtc = false}) {
    return getDayOfYear(DateTime.fromMillisecondsSinceEpoch(ms, isUtc: isUtc));
  }

  /// is today.
  /// 是否是当天.
  static bool isToday(int? milliseconds, {bool isUtc = false, int? locMs}) {
    if (milliseconds == null || milliseconds == 0) return false;
    DateTime old =
        DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: isUtc);
    DateTime now;
    if (locMs != null) {
      now = DateUtil.getDateTimeByMs(locMs);
    } else {
      now = isUtc ? DateTime.now().toUtc() : DateTime.now().toLocal();
    }
    return old.year == now.year && old.month == now.month && old.day == now.day;
  }

  /// is yesterday by dateTime.
  /// 是否是昨天.
  static bool isYesterday(DateTime dateTime, DateTime locDateTime) {
    if (yearIsEqual(dateTime, locDateTime)) {
      int spDay = getDayOfYear(locDateTime) - getDayOfYear(dateTime);
      return spDay == 1;
    } else {
      return ((locDateTime.year - dateTime.year == 1) &&
          dateTime.month == 12 &&
          locDateTime.month == 1 &&
          dateTime.day == 31 &&
          locDateTime.day == 1);
    }
  }

  /// is yesterday by millis.
  /// 是否是昨天.
  static bool isYesterdayByMs(int ms, int locMs) {
    return isYesterday(DateTime.fromMillisecondsSinceEpoch(ms),
        DateTime.fromMillisecondsSinceEpoch(locMs));
  }

  /// is Week.
  /// 是否是本周.
  static bool isWeek(int? ms, {bool isUtc = false, int? locMs}) {
    if (ms == null || ms <= 0) {
      return false;
    }
    DateTime _old = DateTime.fromMillisecondsSinceEpoch(ms, isUtc: isUtc);
    DateTime _now;
    if (locMs != null) {
      _now = DateUtil.getDateTimeByMs(locMs, isUtc: isUtc);
    } else {
      _now = isUtc ? DateTime.now().toUtc() : DateTime.now().toLocal();
    }

    DateTime old =
        _now.millisecondsSinceEpoch > _old.millisecondsSinceEpoch ? _old : _now;
    DateTime now =
        _now.millisecondsSinceEpoch > _old.millisecondsSinceEpoch ? _now : _old;
    return (now.weekday >= old.weekday) &&
        (now.millisecondsSinceEpoch - old.millisecondsSinceEpoch <=
            7 * 24 * 60 * 60 * 1000);
  }

  /// year is equal.
  /// 是否同年.
  static bool yearIsEqual(DateTime dateTime, DateTime locDateTime) {
    return dateTime.year == locDateTime.year;
  }

  /// year is equal.
  /// 是否同年.
  static bool yearIsEqualByMs(int ms, int locMs) {
    return yearIsEqual(DateTime.fromMillisecondsSinceEpoch(ms),
        DateTime.fromMillisecondsSinceEpoch(locMs));
  }

  /// Return whether it is leap year.
  /// 是否是闰年
  static bool isLeapYear(DateTime dateTime) {
    return isLeapYearByYear(dateTime.year);
  }

  /// Return whether it is leap year.
  /// 是否是闰年
  static bool isLeapYearByYear(int year) {
    return year % 4 == 0 && year % 100 != 0 || year % 400 == 0;
  }

  /// 是否周末
  static bool isWeekend() {
    const holiday = [0, 6]; //周六周日
    return holiday.contains(DateTime.now().weekday);
  }

  /// 活动展示时间
  static String getActivityTime(
      String? activityStTime, String? activityEndTime) {
    if (ObjectUtil.isEmptyString(activityStTime) ||
        ObjectUtil.isEmptyString(activityEndTime)) {
      return '';
    }
    DateTime? startDate = DateUtil.getDateTime(activityStTime!);
    DateTime? endDate = DateUtil.getDateTime(activityEndTime!);
    if (DateUtils.isSameDay(startDate, endDate)) {
      return '${DateUtil.formatDate(startDate, format: DateFormats.custom)} - ${DateUtil.formatDate(endDate, format: DateFormats.h_m)}';
    } else {
      return '${DateUtil.formatDate(startDate, format: DateFormats.custom2)} - ${DateUtil.formatDate(endDate, format: DateFormats.custom2)}';
    }
  }

  /// 开始时间
  static String getStartTime(String? activityStTime) {
    if (ObjectUtil.isEmptyString(activityStTime)) {
      return '';
    }
    DateTime? startDate = DateUtil.getDateTime(activityStTime!);
    return DateUtil.formatDate(startDate, format: DateFormats.custom);
  }

  /// 发布时间
  static String getPosterTime(String time) {
    DateTime? createTime = DateUtil.getDateTime(time);
    if (createTime == null) {
      return '';
    }
    if (DateUtil.isToday(createTime.millisecondsSinceEpoch)) {
      return '今天${DateUtil.formatDate(createTime, format: 'HH:mm', showO: true)}';
    }
    if (DateUtil.isYesterday(createTime, DateTime.now())) {
      return '昨天${DateUtil.formatDate(createTime, format: 'HH:mm', showO: true)}';
    }
    if (DateUtil.yearIsEqualByMs(createTime.millisecondsSinceEpoch,
        DateTime.now().millisecondsSinceEpoch)) {
      return DateUtil.formatDate(createTime, format: 'MM月dd日');
    }
    return DateUtil.formatDate(createTime, format: 'yyyy年MM月dd日');
  }

  /// 格式创建时间
  static String formatCreateTime(String time) {
    DateTime? createTime = DateUtil.getDateTime(time);
    if (createTime == null) {
      return '';
    }
    if (DateUtil.isToday(createTime.millisecondsSinceEpoch)) {
      return '今天${DateUtil.formatDate(createTime, format: 'HH:mm', showO: true)}';
    }
    if (DateUtil.isYesterday(createTime, DateTime.now())) {
      return '昨天${DateUtil.formatDate(createTime, format: 'HH:mm', showO: true)}';
    }
    if (DateUtil.yearIsEqualByMs(createTime.millisecondsSinceEpoch,
        DateTime.now().millisecondsSinceEpoch)) {
      return DateUtil.formatDate(createTime, format: 'MM-dd', showO: true);
    }
    return DateUtil.formatDate(createTime, format: 'yyyy-MM-dd', showO: true);
  }

  /// 判断今天是在startTime跟endTime之间
  static bool isTodayInRange(String startTime, String endTime) {
    DateTime start = DateTime.parse(startTime);
    DateTime end = DateTime.parse(endTime);
    DateTime now = DateTime.now();
    return now.isAfter(start) && now.isBefore(end);
  }

  ///判断dateTime是否在expireTime之前或者当天
  static bool isBeforeOrOnExpireDay(DateTime dateTime, DateTime expireTime) {
    // 获取 dateTime 和 expireTime 的年、月和日
    int dateTimeYear = dateTime.year;
    int dateTimeMonth = dateTime.month;
    int dateTimeDay = dateTime.day;

    int expireYear = expireTime.year;
    int expireMonth = expireTime.month;
    int expireDay = expireTime.day;

    // 比较年、月和日
    if (dateTimeYear < expireYear) {
      return true;
    } else if (dateTimeYear == expireYear) {
      if (dateTimeMonth < expireMonth) {
        return true;
      } else if (dateTimeMonth == expireMonth) {
        return dateTimeDay <= expireDay;
      }
    }

    return false;
  }
}
