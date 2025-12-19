/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-12-19
 */

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_template/main.dart' as app;

/// E2E 集成测试 - 应用启动流程
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Launch E2E Tests', () {
    testWidgets('应用应该成功启动', (tester) async {
      // 启动应用
      app.main();
      await tester.pumpAndSettle(Duration(seconds: 3));

      // 验证应用已启动（MaterialApp 存在）
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('应该显示 Scaffold', (tester) async {
      app.main();
      await tester.pumpAndSettle(Duration(seconds: 3));

      expect(find.byType(Scaffold), findsWidgets);
    });
  });
}
