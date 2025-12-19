/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-12-19
 */

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_template/main.dart' as app;

/// E2E 集成测试 - 用户交互流程
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('User Interaction E2E Tests', () {
    testWidgets('按钮点击应该有响应', (tester) async {
      app.main();
      await tester.pumpAndSettle(Duration(seconds: 3));

      // 查找任意 TextButton
      final buttons = find.byType(TextButton);

      if (buttons.evaluate().isNotEmpty) {
        // 点击第一个按钮
        await tester.tap(buttons.first);
        await tester.pumpAndSettle();

        // 验证应用仍然正常运行
        expect(find.byType(MaterialApp), findsOneWidget);
      }
    });

    testWidgets('滚动应该正常工作', (tester) async {
      app.main();
      await tester.pumpAndSettle(Duration(seconds: 3));

      // 查找可滚动的 Widget
      final scrollables = find.byType(Scrollable);

      if (scrollables.evaluate().isNotEmpty) {
        // 执行滚动
        await tester.drag(scrollables.first, Offset(0, -200));
        await tester.pumpAndSettle();

        expect(find.byType(MaterialApp), findsOneWidget);
      }
    });

    testWidgets('长按应该正常工作', (tester) async {
      app.main();
      await tester.pumpAndSettle(Duration(seconds: 3));

      final buttons = find.byType(TextButton);

      if (buttons.evaluate().isNotEmpty) {
        await tester.longPress(buttons.first);
        await tester.pumpAndSettle();

        expect(find.byType(MaterialApp), findsOneWidget);
      }
    });
  });
}
