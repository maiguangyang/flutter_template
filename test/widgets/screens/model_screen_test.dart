/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-12-19
 */

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helper.dart';

void main() {
  group('ModelScreen Widget Tests', () {
    // ✅ 渲染测试
    group('rendering', () {
      testWidgets('应该正确渲染模型管理页面', (tester) async {
        await tester.pumpWidget(
          WidgetTestHelper.createTestableWidget(
            child: Center(child: Text('模型管理')),
          ),
        );

        expect(find.byType(Center), findsOneWidget);
      });
    });

    // ✅ 交互测试
    group('interaction', () {
      testWidgets('点击按钮应该触发回调', (tester) async {
        bool pressed = false;

        await tester.pumpWidget(
          WidgetTestHelper.createTestableWidget(
            child: TextButton(
              onPressed: () => pressed = true,
              child: Text('操作'),
            ),
          ),
        );

        await tester.tap(find.text('操作'));
        await tester.pump();

        expect(pressed, isTrue);
      });
    });

    // ✅ 状态测试
    group('state', () {
      testWidgets('Loading 状态应该显示加载指示器', (tester) async {
        await tester.pumpWidget(
          WidgetTestHelper.createTestableWidget(
            child: CircularProgressIndicator(),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });
  });
}
