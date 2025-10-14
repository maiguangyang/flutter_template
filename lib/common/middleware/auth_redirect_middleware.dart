/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-07-08 21:33:12
 */
import 'package:flutter/material.dart';
import 'package:flutter_oxygen/flutter_oxygen.dart';
import 'package:go_router/go_router.dart';

import '../../router/index.dart';
import '../constants/index.dart';

String? authRedirectMiddleware(BuildContext context, GoRouterState state) {
  final token = CacheServiceCore.getString(CacheKeys.token);

  /// 是否登录
  final isLoggedIn = token != null && token.isNotEmpty;

  /// 当前访问的路由名
  final currentRouteName = state.topRoute?.name;

  /// 是否在登录页
  final isLoginPage = currentRouteName == Routes.login.name;

  /// 所有路由
  final routes = RouteStrategy().allRoutes;

  /// 当前路由
  final currentRoute = routes
      .where((item) => item.name == currentRouteName)
      .firstOrNull;

  /// 设置初始化路由
  if (currentRoute != null) {
    RouteStrategy().initRoute = currentRoute;
  }

  /// 已登录但在登录页 -> 重定向到首页
  if (isLoggedIn && isLoginPage) {
    return '/${Routes.home.name}';
  }

  /// 未登录且访问受保护路径 -> 重定向到登录页
  if (!isLoggedIn && currentRoute?.auth == true) {
    return Routes.login.path;
  }

  /// 其他情况不拦截
  return null;
}
