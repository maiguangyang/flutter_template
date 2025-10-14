/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-22 13:37:54
 */
import 'dart:ui';

import 'package:flutter_oxygen/flutter_oxygen.dart';
import 'package:riverpod/riverpod.dart';

class LocaleProvider extends Notifier<Locale> {
  @override
  Locale build() {
    // 从缓存中恢复语言
    final lang = CacheServiceCore.getString("lang") ?? "en";
    return _toLocale(lang);
  }

  /// 切换语言
  void setLang(String lang) {
    final locale = _toLocale(lang);
    state = locale;
    CacheServiceCore.setString("lang", lang);
  }

  /// 工具函数：字符串 -> Locale
  Locale _toLocale(String lang) {
    final parts = lang.split("_");
    return parts.length == 1 ? Locale(parts[0]) : Locale(parts[0], parts[1]);
  }
}

final localeProvider = NotifierProvider<LocaleProvider, Locale>(
  LocaleProvider.new,
);
