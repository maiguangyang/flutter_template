/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-02-11 14:28:55
 */

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_oxygen/flutter_oxygen.dart';
import 'package:riverpod/riverpod.dart';
import 'package:flutter_template/config/config.dart';

/// 主题状态
class ThemeState {
  /// 主题模式
  final ThemeMode themeMode;

  /// 主题色
  final String primaryColorHex;

  const ThemeState({required this.themeMode, required this.primaryColorHex});

  /// 跟随系统
  Brightness get brightness => PlatformDispatcher.instance.platformBrightness;

  /// 获取当前主题模式
  ThemeMode get getThemeMode =>
      themeMode != ThemeMode.system ? themeMode : ThemeMode.light;

  /// 是否为暗黑模式
  bool get isDark => getThemeMode == ThemeMode.dark;

  /// 主题颜色集
  ThemeColor get color => ThemeColor.generate(hexColor(primaryColorHex));

  /// 主题色
  Color get primary => color.primary;

  /// 功能色
  /// --------------------------------------------------------------------------
  /// #FFFFFF 白色
  Color get white => isDark ? const Color(0xFF000000) : const Color(0xFFFFFFFF);

  /// #000000 黑色
  Color get black => isDark ? const Color(0xFFFFFFFF) : const Color(0xFF000000);

  /// #F5222D 红色 \
  /// 鲜艳的红色，常用于警告或错误提示
  Color get red => isDark ? const Color(0xFFCF1C1F) : const Color(0xFFF5222D);

  /// #FA541C 火山红 \
  /// 类似火山岩浆的橙红色，温暖且醒目
  Color get volcano =>
      isDark ? const Color(0xFFD84C1D) : const Color(0xFFFA541C);

  /// #FA8C16 橙色 \
  /// 明亮的橙色，适合强调或高亮显示
  Color get orange =>
      isDark ? const Color(0xFFD76B0A) : const Color(0xFFFA8C16);

  /// #FAAD14 金色 \
  /// 类似金色的暖黄色，常用于高亮或重要提示
  Color get gold => isDark ? const Color(0xFFD88E08) : const Color(0xFFFAAD14);

  /// #FADB14 黄色 \
  /// 鲜艳的黄色，适合警告或注意提示
  Color get yellow =>
      isDark ? const Color(0xFFD6B215) : const Color(0xFFFADB14);

  /// #A0D911 青柠色 \
  /// 清新的黄绿色，常用于成功或积极状态
  Color get lime => isDark ? const Color(0xFF7A9C0C) : const Color(0xFFA0D911);

  /// #52C41A 绿色 \
  /// 鲜艳的绿色，代表成功或通过状态
  Color get green => isDark ? const Color(0xFF2D6B0D) : const Color(0xFF52C41A);

  /// #13C2C2 青色 \
  /// 清新的青色，适合信息提示或次要内容
  Color get cyan => isDark ? const Color(0xFF0F9C9C) : const Color(0xFF13C2C2);

  /// #1677FF 蓝色 \
  /// 经典的蓝色，常用于链接或主要操作
  Color get blue => isDark ? const Color(0xFF145BBF) : const Color(0xFF1677FF);

  /// #2F54EB 极客蓝 \
  /// 深蓝色，适合技术或专业场景
  Color get geekBlue =>
      isDark ? const Color(0xFF2A4D8A) : const Color(0xFF2F54EB);

  /// #722ED1 紫色 \
  /// 鲜艳的紫色，常用于特殊或高亮内容
  Color get purple =>
      isDark ? const Color(0xFF5B1D96) : const Color(0xFF722ED1);

  /// #EB2F96 洋红色 \
  /// 鲜艳的粉红色，适合强调或女性化设计
  Color get magenta =>
      isDark ? const Color(0xFF9F1D7C) : const Color(0xFFEB2F96);

  /// #666666 灰色 \
  /// 中性灰色，常用于次要文本或边框
  Color get grey => isDark ? const Color(0xFF999999) : const Color(0xFF666666);

  /// #EBEBEB 灰色背景
  Color get grayBackground =>
      isDark ? const Color(0xFF2B2B2B) : const Color(0xFFEBEBEB);

  /// 品牌色
  /// 后续如果觉得颜色顺序不对，可以进行调换
  // --------------------------------------------------------------------------

  /// 主题色
  Color get primaryColor => isDark ? color.shade800 : color.shade600;

  /// 按钮背景色
  Color get buttonBackgroundColor => isDark ? color.shade700 : color.shade500;

  /// 按钮 hover 背景色
  Color get buttonHoverBackgroundColor =>
      isDark ? color.shade800 : color.shade400;

  /// 按钮 active 背景色
  Color get buttonActiveBackgroundColor =>
      isDark ? color.shade900 : color.shade600;

  /// 卡片背景色
  Color get cardBackgroundColor =>
      isDark ? Colors.grey.shade900 : Colors.grey.shade100;

  /// 卡片边框色
  Color get cardBorderColor =>
      isDark ? Colors.grey.shade800 : Colors.grey.shade300;

  /// 链接颜色
  Color get linkColor => isDark ? Colors.blue.shade300 : Colors.blue.shade700;

  /// 链接 hover 颜色
  Color get linkHoverColor =>
      isDark ? Colors.blue.shade200 : Colors.blue.shade600;

  /// 输入框边框色
  Color get inputBorderColor =>
      isDark ? Colors.grey.shade700 : Colors.grey.shade300;

  /// 输入框 hover 边框色
  Color get inputHoverBorderColor =>
      isDark ? Colors.grey.shade600 : Colors.grey.shade400;

  /// 输入框 focus 边框色
  Color get inputFocusBorderColor =>
      isDark ? Colors.grey.shade500 : Colors.grey.shade500;

  /// 警告背景色
  Color get warningBackgroundColor =>
      isDark ? Colors.orange.shade900 : Colors.orange.shade100;

  /// 警告文字颜色
  Color get warningTextColor =>
      isDark ? Colors.orange.shade100 : Colors.orange.shade900;

  /// 成功背景色
  Color get successBackgroundColor =>
      isDark ? Colors.green.shade800 : Colors.green.shade200;

  /// 成功文字颜色
  Color get successTextColor =>
      isDark ? Colors.green.shade100 : Colors.green.shade800;

  /// 错误背景色
  Color get errorBackgroundColor =>
      isDark ? Colors.red.shade900 : Colors.red.shade100;

  /// 错误文字颜色
  Color get errorTextColor =>
      isDark ? Colors.red.shade100 : Colors.red.shade900;

  /// 禁用背景色
  Color get disabledBackgroundColor =>
      isDark ? Colors.grey.shade800 : Colors.grey.shade100;

  /// 禁用文字颜色
  Color get disabledTextColor =>
      isDark ? Colors.grey.shade300 : Colors.grey.shade500;

  /// 禁用按钮颜色
  Color get disabledButtonColor =>
      isDark ? const Color(0xFF2E2F35) : const Color(0xFFE5E6EB);

  /// 表格行 hover 背景色
  Color get tableRowHoverBackgroundColor =>
      isDark ? Colors.grey.shade800 : Colors.grey.shade100;

  /// 表格行选中背景色
  Color get tableRowSelectedBackgroundColor =>
      isDark ? Colors.grey.shade700 : Colors.grey.shade200;

  /// 工具提示背景色
  Color get tooltipBackgroundColor =>
      isDark ? Colors.grey.shade800 : Colors.grey.shade600;

  /// 工具提示文字颜色
  Color get tooltipTextColor =>
      isDark ? Colors.grey.shade100 : Colors.grey.shade900;

  /// 中性色
  /// --------------------------------------------------------------------------
  /// 文本标题颜色
  Color get textTitleColor =>
      isDark ? const Color(0xD9FFFFFF) : const Color(0xE0000000);

  /// 主要文本颜色
  Color get textPrimaryColor =>
      isDark ? const Color(0xD9FFFFFF) : const Color(0xE0000000);

  /// 次要文本颜色
  Color get textSecondaryColor =>
      isDark ? const Color(0xA6FFFFFF) : const Color(0xA6000000);

  /// 禁用文本颜色
  Color get textDisabledColor =>
      isDark ? const Color(0x40FFFFFF) : const Color(0x40000000);

  /// 边框颜色
  Color get borderPrimaryColor =>
      isDark ? const Color(0xFF424242) : const Color(0xFFD9D9D9);

  /// 分割线颜色
  Color get dividerColor =>
      isDark ? const Color(0x1FFDFDFD) : const Color(0x0F050505);

  /// 背景色
  Color get backgroundColor =>
      isDark ? const Color(0xFF121212) : const Color(0xFFFFFFFF);

  /// 图标颜色
  Color get iconColor =>
      isDark ? const Color(0xD9FFFFFF) : const Color(0xE0000000);

  /// 补充暗黑模式的颜色
  Color get iconSecondaryColor => const Color(0xFF86909C);

  /// 成功颜色
  Color get successColor => green;

  /// 警告颜色
  Color get warningColor => gold;

  /// 错误颜色
  Color get errorColor => const Color(0xFFFF4D4F);

  /// **************
  /// 以下都是字体大小相关
  /// **************

  /// 10px
  double get fontSize10 => 10.0;

  /// 12px
  double get fontSize12 => 12.0;

  /// 14px
  double get fontSize14 => 14.0;

  /// 16px
  double get fontSize16 => 16.0;

  /// 20px
  double get fontSize20 => 20.0;

  /// 24px
  double get fontSize24 => 24.0;

  /// 30px
  double get fontSize30 => 30.0;

  /// 38px
  double get fontSize38 => 38.0;

  /// 46px
  double get fontSize46 => 46.0;

  /// 56px
  double get fontSize56 => 56.0;

  /// 68px
  double get fontSize68 => 68.0;

  /// 小字体 12px
  double get fontSizeSmall => fontSize12;

  /// 默认字体大小 14px
  double get fontSize => fontSize14;

  /// 中字体 16px
  double get fontSizeMedium => fontSize16;

  /// 大字体 20px
  double get fontSizeLarge => fontSize20;

  /// **************
  /// 以下都是行高相关
  /// **************

  /// 行高 20px
  double get lineHeight20 => 20.0;

  /// 行高 22px
  double get lineHeight22 => 22.0;

  /// 行高 24px
  double get lineHeight24 => 24.0;

  /// 行高 28px
  double get lineHeight28 => 28.0;

  /// 行高 32px
  double get lineHeight32 => 32.0;

  /// 行高 38px
  double get lineHeight38 => 38.0;

  /// 行高 46px
  double get lineHeight46 => 46.0;

  /// 行高 54px
  double get lineHeight54 => 54.0;

  /// 行高 64px
  double get lineHeight64 => 64.0;

  /// 行高 76px
  double get lineHeight76 => 76.0;

  /// 行高 20px
  double get lineHeightSmall => lineHeight20;

  /// 默认行高大小 22px
  double get lineHeight => lineHeight22;

  /// 中行高 24px
  double get lineHeightMedium => lineHeight24;

  /// 大行高 28px
  double get lineHeightLarge => lineHeight28;

  /// **************
  /// 以下都是字重相关
  /// **************

  /// 默认字重
  FontWeight get fontWeightNormal => FontWeight.normal;

  /// 中字重
  FontWeight get fontWeightMedium => FontWeight.w500;

  /// 粗字重
  FontWeight get fontWeightBold => FontWeight.bold;

  /// **************
  /// 以下都是间距相关
  /// **************

  /// 间距 4px
  double get spacing4 => 4.0;

  /// 间距 5px
  double get spacing5 => 5.0;

  /// 间距 6px
  double get spacing6 => 6.0;

  /// 间距 8px
  double get spacing8 => 8.0;

  /// 默认间距 10px
  double get spacing10 => 10.0;

  /// 间距 12px
  double get spacing12 => 12.0;

  /// 间距 14px
  double get spacing14 => 14.0;

  /// 间距 16px
  double get spacing16 => 16.0;

  /// 间距 18px
  double get spacing18 => 18.0;

  /// 间距 20px
  double get spacing20 => 20.0;

  /// 间距 24px
  double get spacing24 => 24.0;

  /// 间距 50px
  double get spacing50 => 50.0;

  /// 复制当前状态
  ThemeState copyWith({ThemeMode? themeMode, String? colorHex}) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      primaryColorHex: colorHex ?? this.primaryColorHex,
    );
  }
}

/// 主题管理
class ThemeProvider extends Notifier<ThemeState> {
  @override
  ThemeState build() {
    // 获取缓存
    final modeIndex =
        CacheServiceCore.getInt("themeModeIndex") ?? ThemeMode.system.index;

    // 主题色
    String _primary =
        CacheServiceCore.getString("primaryColor") ??
        Config.project.primaryColor;

    return ThemeState(
      themeMode: ThemeMode.values[modeIndex],
      primaryColorHex: _primary,
    );
  }

  /// 设置主题模式
  void setThemeMode(ThemeMode value) {
    if (state.themeMode != value) {
      state = state.copyWith(themeMode: value);
      CacheServiceCore.setInt("themeModeIndex", value.index);
    }
  }

  /// 设置主题模式
  void setPrimaryColor(Color value) {
    if (state.primary.toARGB32() != value.toARGB32()) {
      final newValue = ThemeColor.colorToHex(value);
      state = state.copyWith(colorHex: newValue);
      CacheServiceCore.setString("primaryColor", newValue);
    }
  }
}

final themeProvider = NotifierProvider<ThemeProvider, ThemeState>(
  ThemeProvider.new,
);
