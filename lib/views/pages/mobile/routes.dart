/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2024-04-24 20:01:06
 */
import 'package:flutter_template/core/index.dart';

import 'screens/home_screen/home_screen.dart';
import 'screens/login_screen/login_screen.dart';
import 'screens/test_screen/test_screen.dart';

/// Mobile 路由 Provider
final mobileRoutesProvider = Provider<List<FlutterRouter>>((ref) {
  final lang = ref.watch(langProvider);

  return [
    FlutterRouter(
      name: Routes.home.name,
      path: Routes.home.path,
      title: lang.homePage,
      width: 720,
      height: 480,
      hideTitleBar: true,
      maximize: false,
      minimize: false,
      resizable: false,
      builder: (context, state) => const HomeScreen(),
    ),
    FlutterRouter(
      name: Routes.login.name,
      path: Routes.login.path,
      title: lang.loginPage,
      hideTitleBar: true,
      builder: (context, state) => const LoginScreen(),
    ),
    FlutterRouter(
      name: Routes.test.name,
      path: Routes.test.path,
      title: lang.testPage,
      hideTitleBar: true,
      builder: (context, state) => const TestScreen(),
    ),
  ];
});
