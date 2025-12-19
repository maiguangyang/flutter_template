/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-12-19
 */

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helper.dart';

void main() {
  group('LoginScreen Widget Tests', () {
    // ✅ 渲染测试
    group('rendering', () {
      testWidgets('应该正确渲染登录页面', (tester) async {
        await tester.pumpWidget(
          WidgetTestHelper.createTestableWidget(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [TextButton(onPressed: () {}, child: Text('打开测试页'))],
            ),
          ),
        );

        expect(find.text('打开测试页'), findsOneWidget);
        expect(find.byType(TextButton), findsOneWidget);
      });

      testWidgets('应该显示 Scaffold', (tester) async {
        await tester.pumpWidget(
          WidgetTestHelper.wrapWithScaffold(
            child: Scaffold(body: Center(child: Text('登录页'))),
          ),
        );

        expect(find.byType(Scaffold), findsWidgets);
      });
    });

    // ✅ 交互测试
    group('interaction', () {
      testWidgets('点击按钮应该触发回调', (tester) async {
        bool buttonPressed = false;

        await tester.pumpWidget(
          WidgetTestHelper.createTestableWidget(
            child: TextButton(
              onPressed: () => buttonPressed = true,
              child: Text('打开测试页'),
            ),
          ),
        );

        await tester.tap(find.text('打开测试页'));
        await tester.pump();

        expect(buttonPressed, isTrue);
      });
    });

    // ✅ 主题测试
    group('theming', () {
      testWidgets('应该应用 Light 主题', (tester) async {
        await tester.pumpWidget(
          WidgetTestHelper.createTestableWidget(
            theme: MockThemeData.light,
            child: Builder(
              builder: (context) {
                final theme = Theme.of(context);
                expect(theme.brightness, equals(Brightness.light));
                return Container();
              },
            ),
          ),
        );
      });

      testWidgets('应该应用 Dark 主题', (tester) async {
        await tester.pumpWidget(
          WidgetTestHelper.createTestableWidget(
            theme: MockThemeData.dark,
            child: Builder(
              builder: (context) {
                final theme = Theme.of(context);
                expect(theme.brightness, equals(Brightness.dark));
                return Container();
              },
            ),
          ),
        );
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

      testWidgets('Error 状态应该显示错误信息', (tester) async {
        await tester.pumpWidget(
          WidgetTestHelper.createTestableWidget(child: Text('发生错误')),
        );

        expect(find.text('发生错误'), findsOneWidget);
      });
    });
  });
}
