/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-11-14 08:03:34
 */
import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  /// 橙色
  final Color orange;

  /// 绿色
  final Color green;

  /// 极客蓝
  final Color geekBlue;

  const AppColors({
    required this.orange,
    required this.green,
    required this.geekBlue,
  });

  @override
  AppColors copyWith() {
    return this;
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    return this;
  }
}
