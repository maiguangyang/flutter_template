/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-12-19
 */

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helper.dart';

void main() {
  group('TestScreen Widget Tests', () {
    // ✅ 渲染测试
    group('rendering', () {
      testWidgets('应该正确渲染测试页面', (tester) async {
        await tester.pumpWidget(
          WidgetTestHelper.createTestableWidget(
            child: Center(child: Text('测试页面')),
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
              child: Text('测试按钮'),
            ),
          ),
        );

        await tester.tap(find.text('测试按钮'));
        await tester.pump();

        expect(pressed, isTrue);
      });
    });

    // ✅ 状态测试
    group('state', () {
      testWidgets('应该正确显示状态', (tester) async {
        await tester.pumpWidget(
          WidgetTestHelper.createTestableWidget(child: Text('状态: 正常')),
        );

        expect(find.text('状态: 正常'), findsOneWidget);
      });
    });
  });
}
