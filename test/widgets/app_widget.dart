/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2024-05-06 21:43:21
 */
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:sugar_talk/providers_setup.dart';
import 'package:sugar_talk/router.dart';
import 'package:provider/provider.dart';
import 'package:sugar_talk/utils/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;

class TestAppWidget extends riverpod.ConsumerWidget {
  final Widget child;

  const TestAppWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context, riverpod.WidgetRef ref) {
    final deviceType = DeviceUtils.getDeviceType();
    final routeStrategy = CustomRouter.init(deviceType);
    routeStrategy.navigatorKey ??= GlobalKey<NavigatorState>();

    NavigatorUtils().isDesktop = true;

    return MultiProvider(
      providers: [],
      child: MaterialApp.router(
        // routerConfig: CustomRoute.generateRoutes(),
        routerConfig: routeStrategy.generateRoutes(),
        builder: FlutterSmartDialog.init(),
      ),
    );
  }
}
