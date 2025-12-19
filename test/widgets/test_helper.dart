/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-12-19
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// Widget 测试辅助类
class WidgetTestHelper {
  /// 创建一个用于 Widget 测试的包装器
  /// 包含 MaterialApp、ProviderScope 等必要的上下文
  static Widget createTestableWidget({
    required Widget child,
    ThemeData? theme,
  }) {
    return ProviderScope(
      child: MaterialApp(
        theme: theme ?? ThemeData.light(),
        home: Scaffold(body: child),
      ),
    );
  }

  /// 创建带有 Scaffold 的测试包装器
  static Widget wrapWithScaffold({required Widget child}) {
    return ProviderScope(child: MaterialApp(home: child));
  }

  /// 创建带有导航的测试包装器
  static Widget wrapWithNavigation({
    required Widget child,
    Map<String, WidgetBuilder>? routes,
  }) {
    return ProviderScope(
      child: MaterialApp(home: child, routes: routes ?? {}),
    );
  }
}

/// 常用的 Widget Finder 扩展
extension WidgetFinderExtensions on CommonFinders {
  /// 根据 Key 查找 Widget
  Finder byKeyString(String key) => byKey(Key(key));
}

/// 测试用的 Mock ThemeData
class MockThemeData {
  static ThemeData get light => ThemeData.light(useMaterial3: true);
  static ThemeData get dark => ThemeData.dark(useMaterial3: true);
}
