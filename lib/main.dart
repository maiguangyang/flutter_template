/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2024-04-15 09:59:05
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_oxygen/flutter_oxygen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:meta_seo/meta_seo.dart';
import 'package:sugar_talk/config/config.dart';
import 'package:window_manager/window_manager.dart';

import 'app.dart';
import 'bootstrap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 桌面端
  if (DeviceUtilsCore.isDesktop) {
    await windowManager.ensureInitialized();
  }

  // App开启霸屏模式
  if (DeviceUtilsCore.isApp) {
    // neil: 要禁用旋转, 设置只支持竖屏模式
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  //  Web端配置
  if (DeviceUtilsCore.isWeb) {
    MetaSEO().config();
  }

  await CacheServiceCore.init(Config.project.env);

  // web使用path路由
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  final container = await bootstrap();

  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}
