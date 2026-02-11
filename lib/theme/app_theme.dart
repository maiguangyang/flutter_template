/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-11-14 08:17:36
 */
import 'dart:ui';

import 'package:flutter_template/core/index.dart';
import 'package:flutter_template/theme/index.dart';

class AppTheme {
  /// 主题模式
  final ThemeMode themeMode;

  /// 主题数据
  final ThemeData themeData;

  /// 配色方案
  final FlexScheme flexScheme;

  /// 颜色方案
  final ColorScheme colorScheme;

  /// 自定义颜色
  final AppColors colors;

  const AppTheme({
    required this.themeMode,
    required this.themeData,
    required this.flexScheme,
    required this.colorScheme,
    required this.colors,
  });

  /// 跟随系统
  Brightness get brightness => PlatformDispatcher.instance.platformBrightness;

  /// 获取当前主题模式
  ThemeMode get getThemeMode =>
      themeMode != ThemeMode.system ? themeMode : ThemeMode.light;

  /// 是否为暗黑模式
  bool get isDark => getThemeMode == ThemeMode.dark;

  /// 间距常量
  Spacing get spacing => Spacing();

  /// 字体大小常量
  FontSizes get fontSize => FontSizes();

  /// 行高常量
  LineHeights get lineHeight => LineHeights();

  /// 字重常量
  FontWeights get fontWeight => FontWeights();

  /// 复制当前状态
  AppTheme copyWith({
    ThemeMode? themeMode,
    ThemeData? themeData,
    FlexScheme? flexScheme,
    ColorScheme? colorScheme,
    AppColors? colors,
  }) {
    return AppTheme(
      themeMode: themeMode ?? this.themeMode,
      themeData: themeData ?? this.themeData,
      colorScheme: colorScheme ?? this.colorScheme,
      flexScheme: flexScheme ?? this.flexScheme,
      colors: colors ?? this.colors,
    );
  }
}
