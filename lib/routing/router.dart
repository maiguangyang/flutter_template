/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2026-02-12 08:56:46
 */
import 'package:flutter_template/core/index.dart';
import 'package:go_router/go_router.dart';

import 'navigator_keys.dart';
import 'routes.dart';

List<RouteBase> buildRoutes(List<FlutterRouter> routers) {
  return routers.map((router) {
    if (router.isShell) {
      return ShellRoute(
        builder: (context, state, child) {
          return Scaffold(
            appBar: router.appBar,
            body: child,
            bottomNavigationBar: router.bottomNavigationBar,
          );
        },
        routes: buildRoutes(router.routes ?? []),
      );
    } else {
      return GoRoute(
        name: router.name,
        path: router.path,
        builder: router.builder,
        pageBuilder: router.pageBuilder,
      );
    }
  }).toList();
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final routes = ref.watch(routesProvider);

  /// 观察监听
  final observers = [RouteMiddlewareCore(), RouteObserver<PageRoute>()];

  /// 重定向
  // final redirect = authRedirectMiddleware;

  FlutterRouter? initRoute =
      routes.where((route) => route.isDefault).firstOrNull ??
      routes.firstOrNull;

  return GoRouter(
    initialLocation: initRoute?.path,
    routes: buildRoutes(routes),
    navigatorKey: rootNavigatorKey,
    observers: observers,
    // redirect: redirect,
  );
});
