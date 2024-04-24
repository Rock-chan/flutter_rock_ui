import 'dart:async';

// 默认时长
const _defaultDuration = Duration(milliseconds: 500);

enum FilterType {
  debounce,
  throttle,
}

class InputUtil {
  static final Map<String, Timer> _wrappers = {};

  static void debounce(String sign, Function function,
      {Duration duration = _defaultDuration}) {
    execute(sign, function,
        duration: duration, filterType: FilterType.debounce);
  }

  static void throttle(String sign, Function function,
      {Duration duration = _defaultDuration}) {
    execute(sign, function,
        duration: duration, filterType: FilterType.throttle);
  }

  static void execute(String sign, Function function,
      {Duration duration = _defaultDuration,
      FilterType filterType = FilterType.debounce}) {
    switch (filterType) {
      case FilterType.debounce:
        {
          _wrappers[sign]?.cancel();
        }
        break;
      case FilterType.throttle:
        {
          if (_wrappers.containsKey(sign)) {
            return;
          } else {
            function.call();
          }
        }
        break;
    }

    _wrappers[sign] = Timer(duration, () {
      if (filterType == FilterType.debounce) {
        function.call();
      }
      _wrappers[sign]?.cancel();
      _wrappers.remove(sign);
    });
  }

  // 在state的dispose方法里溢出Timer
  static void remove(String sign) {
    if (_wrappers.containsKey(sign)) {
      _wrappers[sign]?.cancel();
      _wrappers.remove(sign);
    }
  }

  // 移除所有Timer
  static void clear() {
    _wrappers.forEach((key, value) {
      remove(key);
    });
    _wrappers.clear();
  }
}
