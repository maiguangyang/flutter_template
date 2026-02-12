/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2024-04-24 20:01:06
 */

import 'package:flutter_template/core/index.dart';
import 'package:flutter_template/features/index.dart';
import 'package:flutter_template/routing/index.dart';

/// routes 路由 Provider
final routesProvider = Provider<List<FlutterRouter>>((ref) {
  final lang = ref.watch(langProvider);

  return [
    FlutterRouter(
      name: RoutePath.home.name,
      path: RoutePath.home.path,
      title: lang.homePage,
      width: 720,
      height: 480,
      hideTitleBar: true,
      isDefault: true,
      maximize: false,
      minimize: false,
      resizable: false,
      builder: (context, state) => HomeScreen(),
    ),
    FlutterRouter(
      name: RoutePath.login.name,
      path: RoutePath.login.path,
      title: lang.loginPage,
      hideTitleBar: true,
      builder: (context, state) => LoginScreen(),
    ),
    FlutterRouter(
      name: RoutePath.test.name,
      path: RoutePath.test.path,
      title: lang.testPage,
      hideTitleBar: true,
      builder: (context, state) => TestScreen(),
    ),

    FlutterRouter(
      name: RoutePath.model.name,
      path: RoutePath.model.path,
      title: lang.modelPage,
      width: 1560,
      height: 880,
      hideTitleBar: true,
      maximize: false,
      minimize: false,
      resizable: false,
      builder: (context, state) => ModelScreen(),
    ),
  ];
});
