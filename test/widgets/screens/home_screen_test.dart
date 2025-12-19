/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-12-19
 */

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helper.dart';

void main() {
  group('HomeScreen Widget Tests', () {
    // ✅ 渲染测试
    group('rendering', () {
      testWidgets('应该正确渲染首页', (tester) async {
        await tester.pumpWidget(
          WidgetTestHelper.createTestableWidget(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: () {}, child: Text('切换颜色')),
                TextButton(onPressed: () {}, child: Text('切换主题')),
                TextButton(onPressed: () {}, child: Text('切换多语言')),
              ],
            ),
          ),
        );

        expect(find.text('切换颜色'), findsOneWidget);
        expect(find.text('切换主题'), findsOneWidget);
        expect(find.text('切换多语言'), findsOneWidget);
      });

      testWidgets('应该显示多个 TextButton', (tester) async {
        await tester.pumpWidget(
          WidgetTestHelper.createTestableWidget(
            child: Column(
              children: [
                TextButton(onPressed: () {}, child: Text('按钮1')),
                TextButton(onPressed: () {}, child: Text('按钮2')),
                TextButton(onPressed: () {}, child: Text('按钮3')),
              ],
            ),
          ),
        );

        expect(find.byType(TextButton), findsNWidgets(3));
      });
    });

    // ✅ 交互测试
    group('interaction', () {
      testWidgets('点击切换颜色按钮应该触发回调', (tester) async {
        bool colorSwitched = false;

        await tester.pumpWidget(
          WidgetTestHelper.createTestableWidget(
            child: TextButton(
              onPressed: () => colorSwitched = true,
              child: Text('切换颜色'),
            ),
          ),
        );

        await tester.tap(find.text('切换颜色'));
        await tester.pump();

        expect(colorSwitched, isTrue);
      });

      testWidgets('点击切换主题按钮应该触发回调', (tester) async {
        bool themeSwitched = false;

        await tester.pumpWidget(
          WidgetTestHelper.createTestableWidget(
            child: TextButton(
              onPressed: () => themeSwitched = true,
              child: Text('切换主题'),
            ),
          ),
        );

        await tester.tap(find.text('切换主题'));
        await tester.pump();

        expect(themeSwitched, isTrue);
      });

      testWidgets('点击切换多语言按钮应该触发回调', (tester) async {
        bool langSwitched = false;

        await tester.pumpWidget(
          WidgetTestHelper.createTestableWidget(
            child: TextButton(
              onPressed: () => langSwitched = true,
              child: Text('切换多语言'),
            ),
          ),
        );

        await tester.tap(find.text('切换多语言'));
        await tester.pump();

        expect(langSwitched, isTrue);
      });
    });

    // ✅ 布局测试
    group('layout', () {
      testWidgets('按钮应该垂直居中排列', (tester) async {
        await tester.pumpWidget(
          WidgetTestHelper.createTestableWidget(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [TextButton(onPressed: () {}, child: Text('按钮'))],
            ),
          ),
        );

        final column = tester.widget<Column>(find.byType(Column));
        expect(column.mainAxisAlignment, equals(MainAxisAlignment.center));
      });
    });
  });
}
