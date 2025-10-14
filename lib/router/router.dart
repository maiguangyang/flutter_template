/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2024-08-01 09:44:06
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sugar_talk/common/index.dart';

import '../views/pages/desktop/routes.dart';
import '../views/pages/mobile/routes.dart';

/// 自定义路由
final routeProvider = Provider<RouteStrategy>((ref) {
  final deviceType = DeviceUtilsCore.getDeviceType();

  final mobileRoutes = ref.read(mobileRoutesProvider);
  final desktopRoutes = ref.read(desktopRoutesProvider);

  // 根据设备类型选择路由
  final routeMap = {
    DeviceTypeEnum.mobile: mobileRoutes,
    DeviceTypeEnum.iPad: mobileRoutes,
    DeviceTypeEnum.desktop: desktopRoutes,
  };

  final routeStrategy = RouteStrategy.init(
    routeMap: routeMap,
    deviceType: deviceType,
  );

  // 注入中间件
  routeStrategy.observers = [RouteMiddlewareCore(), RouteObserver<PageRoute>()];

  // 注入重定向逻辑
  routeStrategy.redirect = authRedirectMiddleware;

  return routeStrategy;
});
