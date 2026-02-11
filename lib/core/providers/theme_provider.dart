/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-02-11 14:28:55
 */

import 'package:flutter/scheduler.dart';
import 'package:flutter_template/core/index.dart';

class ThemeProvider extends Notifier<AppTheme> {
  @override
  AppTheme build() {
    // 获取缓存
    final modeIndex =
        CacheServiceCore.getInt("themeModeIndex") ?? ThemeMode.system.index;

    // 主题色
    final _primary =
        CacheServiceCore.getString("primaryColor") ??
        Config.project.primaryColor;

    final FlexScheme initialScheme = FlexScheme.values.firstWhere(
      (e) => e.name == _primary,
      orElse: () => FlexScheme.shadBlue,
    );

    /// 获取当前主题模式下的亮度
    final brightness = _getBrightness(ThemeMode.values[modeIndex]);

    final themeData = brightness == Brightness.light
        ? FlexThemeData.light(
            scheme: initialScheme,
            useMaterial3: true,
            fontFamily: 'NunitoSans',
            fontFamilyFallback: ['Roboto', 'NotoSansSC'],
            extensions: const <ThemeExtension<AppColors>>[lightColors],
          )
        : FlexThemeData.dark(
            scheme: initialScheme,
            useMaterial3: true,
            fontFamily: 'NunitoSans',
            fontFamilyFallback: ['Roboto', 'NotoSansSC'],
            extensions: const <ThemeExtension<AppColors>>[darkColors],
          );

    return AppTheme(
      themeMode: ThemeMode.values[modeIndex],
      themeData: themeData,
      flexScheme: initialScheme,
      colorScheme: themeData.colorScheme,
      colors: themeData.extension<AppColors>()!,
    );
  }

  /// 设置主题模式
  void setThemeMode(ThemeMode value) {
    if (state.themeMode != value) {
      // 重新生成 themeData
      final brightness = _getBrightness(value);
      final themeData = _generateThemeData(state.flexScheme, brightness);

      state = state.copyWith(
        themeMode: value,
        themeData: themeData,
        colorScheme: themeData.colorScheme,
        colors: themeData.extension<AppColors>()!,
      );
      CacheServiceCore.setInt("themeModeIndex", value.index);
    }
  }

  // 提供一个方法来改变颜色方案
  void changeScheme(FlexScheme scheme) {
    if (state.flexScheme != scheme) {
      // 重新生成 themeData
      final brightness = _getBrightness(state.themeMode);
      final themeData = _generateThemeData(scheme, brightness);

      state = state.copyWith(
        flexScheme: scheme,
        themeData: themeData,
        colorScheme: themeData.colorScheme,
        colors: themeData.extension<AppColors>()!,
      );
      CacheServiceCore.setString("primaryColor", scheme.name);
    }
  }

  /// 生成 ThemeData
  ThemeData _generateThemeData(FlexScheme scheme, Brightness brightness) {
    return brightness == Brightness.light
        ? FlexThemeData.light(
            scheme: scheme,
            useMaterial3: true,
            fontFamily: 'NunitoSans',
            fontFamilyFallback: ['Roboto', 'NotoSansSC'],
            extensions: const <ThemeExtension<AppColors>>[lightColors],
          )
        : FlexThemeData.dark(
            scheme: scheme,
            useMaterial3: true,
            fontFamily: 'NunitoSans',
            fontFamilyFallback: ['Roboto', 'NotoSansSC'],
            extensions: const <ThemeExtension<AppColors>>[darkColors],
          );
  }
}

/// 主题状态
final themeProvider = NotifierProvider<ThemeProvider, AppTheme>(
  ThemeProvider.new,
);

/// 辅助方法：在没有 BuildContext 的情况下获取亮度 (可以复用)
Brightness _getBrightness(ThemeMode themeMode) {
  switch (themeMode) {
    case ThemeMode.light:
      return Brightness.light;
    case ThemeMode.dark:
      return Brightness.dark;
    case ThemeMode.system:
      return SchedulerBinding.instance.platformDispatcher.platformBrightness;
  }
}
