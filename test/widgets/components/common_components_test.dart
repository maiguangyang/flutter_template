/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-12-19
 */

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helper.dart';

void main() {
  group('Common Components Widget Tests', () {
    // ✅ TextButton 组件测试
    group('TextButton', () {
      testWidgets('应该正确渲染 TextButton', (tester) async {
        await tester.pumpWidget(
          WidgetTestHelper.createTestableWidget(
            child: TextButton(onPressed: () {}, child: Text('测试按钮')),
          ),
        );

        expect(find.text('测试按钮'), findsOneWidget);
        expect(find.byType(TextButton), findsOneWidget);
      });

      testWidgets('禁用状态的按钮不应该响应点击', (tester) async {
        bool pressed = false;

        await tester.pumpWidget(
          WidgetTestHelper.createTestableWidget(
            child: TextButton(
              onPressed: null, // 禁用
              child: Text('禁用按钮'),
            ),
          ),
        );

        await tester.tap(find.text('禁用按钮'));
        await tester.pump();

        expect(pressed, isFalse);
      });
    });

    // ✅ TextField 组件测试
    group('TextField', () {
      testWidgets('应该正确渲染 TextField', (tester) async {
        await tester.pumpWidget(
          WidgetTestHelper.createTestableWidget(
            child: TextField(decoration: InputDecoration(hintText: '请输入')),
          ),
        );

        expect(find.byType(TextField), findsOneWidget);
        expect(find.text('请输入'), findsOneWidget);
      });

      testWidgets('输入文本应该正确显示', (tester) async {
        await tester.pumpWidget(
          WidgetTestHelper.createTestableWidget(child: TextField()),
        );

        await tester.enterText(find.byType(TextField), '测试文本');
        await tester.pump();

        expect(find.text('测试文本'), findsOneWidget);
      });

      testWidgets('清空文本应该正常工作', (tester) async {
        final controller = TextEditingController(text: '初始文本');

        await tester.pumpWidget(
          WidgetTestHelper.createTestableWidget(
            child: TextField(controller: controller),
          ),
        );

        expect(find.text('初始文本'), findsOneWidget);

        controller.clear();
        await tester.pump();

        expect(find.text('初始文本'), findsNothing);
      });
    });

    // ✅ CircularProgressIndicator 测试
    group('Loading Indicator', () {
      testWidgets('应该正确渲染加载指示器', (tester) async {
        await tester.pumpWidget(
          WidgetTestHelper.createTestableWidget(
            child: CircularProgressIndicator(),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });

    // ✅ SnackBar 测试
    group('SnackBar', () {
      testWidgets('应该正确显示 SnackBar', (tester) async {
        await tester.pumpWidget(
          WidgetTestHelper.createTestableWidget(
            child: Builder(
              builder: (context) => TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('提示信息')));
                },
                child: Text('显示提示'),
              ),
            ),
          ),
        );

        await tester.tap(find.text('显示提示'));
        await tester.pump();
        await tester.pump(Duration(milliseconds: 100));

        expect(find.text('提示信息'), findsOneWidget);
      });
    });

    // ✅ Dialog 测试
    group('Dialog', () {
      testWidgets('应该正确显示 AlertDialog', (tester) async {
        await tester.pumpWidget(
          WidgetTestHelper.createTestableWidget(
            child: Builder(
              builder: (context) => TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('标题'),
                      content: Text('内容'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('确定'),
                        ),
                      ],
                    ),
                  );
                },
                child: Text('显示对话框'),
              ),
            ),
          ),
        );

        await tester.tap(find.text('显示对话框'));
        await tester.pumpAndSettle();

        expect(find.text('标题'), findsOneWidget);
        expect(find.text('内容'), findsOneWidget);
        expect(find.text('确定'), findsOneWidget);
      });

      testWidgets('点击确定应该关闭对话框', (tester) async {
        await tester.pumpWidget(
          WidgetTestHelper.createTestableWidget(
            child: Builder(
              builder: (context) => TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('标题'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('确定'),
                        ),
                      ],
                    ),
                  );
                },
                child: Text('显示对话框'),
              ),
            ),
          ),
        );

        await tester.tap(find.text('显示对话框'));
        await tester.pumpAndSettle();

        expect(find.text('标题'), findsOneWidget);

        await tester.tap(find.text('确定'));
        await tester.pumpAndSettle();

        expect(find.text('标题'), findsNothing);
      });
    });
  });
}
