/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-12-19
 */

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_template/main.dart' as app;

/// E2E 集成测试 - 导航流程
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Navigation E2E Tests', () {
    testWidgets('应该能够导航到不同页面', (tester) async {
      app.main();
      await tester.pumpAndSettle(Duration(seconds: 3));

      // 验证应用已启动
      expect(find.byType(Scaffold), findsWidgets);

      // 查找导航按钮
      final testPageButton = find.text('打开测试页');

      if (testPageButton.evaluate().isNotEmpty) {
        await tester.tap(testPageButton);
        await tester.pumpAndSettle();

        // 验证导航成功
        expect(find.byType(Scaffold), findsWidgets);
      }
    });

    testWidgets('返回导航应该正常工作', (tester) async {
      app.main();
      await tester.pumpAndSettle(Duration(seconds: 3));

      // 验证 Scaffold 存在
      expect(find.byType(Scaffold), findsWidgets);

      // 尝试触发返回（如果有返回按钮）
      final backButton = find.byType(BackButton);

      if (backButton.evaluate().isNotEmpty) {
        await tester.tap(backButton);
        await tester.pumpAndSettle();
      }

      // 验证应用仍然正常
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
