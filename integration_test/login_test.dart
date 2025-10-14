
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_template/app.dart';
import 'package:flutter_template/common/index.dart';
import 'package:flutter_template/views/pages/mobile/screens/home_screen/home_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('login screen integration test', (tester) async {
    developer.log('Starting login screen integration test');

    // 1. Load app
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // 2. To Account
    final accountBtn = find.text('Me');
    expect(accountBtn, findsOneWidget);
    await tester.tap(accountBtn);
    await tester.pumpAndSettle();

    // 3. To Login
    final toLoginBtn = find.text('登入');
    expect(toLoginBtn, findsOneWidget);
    await tester.tap(toLoginBtn);
    await tester.pumpAndSettle();

    // 4. 输入电话
    final phoneField = find.byKey(UIKeys.loginPhoneField);
    await tester.enterText(phoneField, '7788778877');
    await tester.pumpAndSettle();

    // 5. 输入验证码
    final codeField = find.byKey(UIKeys.loginCodeField);
    await tester.enterText(codeField, '666666');
    await tester.pumpAndSettle();

    // 6. 点击登录按钮
    final buttonFinder = find.byKey(UIKeys.loginButton);
    expect(buttonFinder, findsOneWidget);
    await tester.tap(buttonFinder.first);
    await tester.pumpAndSettle();

    // 7. 验证跳转到首页
    expect(find.byType(HomeScreen), findsOneWidget);

    // 8. 验证导航栈
    final NavigatorState navigator = tester.state(find.byType(Navigator));
    expect(navigator.canPop(), isFalse); 

    developer.log('Test completed successfully');

  });

}
