/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2026-02-12 09:23:57
 */

import 'package:flutter_template/core/index.dart';
import 'package:flutter_template/routing/index.dart';
import 'package:go_router/go_router.dart';

/// GoRouter Provider
final goRouterProvider = Provider<GoRouter>((ref) {
  final routes = ref.watch(routesProvider);

  /// 初始化 RouteStrategy 并缓存（authRedirectMiddleware 依赖它）
  final routeStrategy = RouteStrategy();
  routeStrategy.navigatorKey = rootNavigatorKey;
  routeStrategy.allRoutes = RouteStrategy.extractRoutes(routes);
  setRouteStrategyCache(routeStrategy);

  /// 路由观察者
  final observers = [RouteMiddlewareCore(), RouteObserver<PageRoute>()];

  /// 初始路由：优先使用 isDefault 标记的路由，否则取第一个
  final initRoute =
      routes.where((route) => route.isDefault).firstOrNull ??
      routes.firstOrNull;

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: initRoute?.path ?? RoutePath.home.path,
    debugLogDiagnostics: true,
    observers: observers,
    redirect: (context, state) {
      final routeName = state.topRoute?.name;

      // 1. 同步当前路由到 NavigatorUtilsCore（触发窗口管理 + MetaSEO）
      NavigatorUtilsCore.instance.setCurrentRoute(routeName);

      // 2. 页面埋点
      _trackPageView(routes, routeName);

      // 3. 权限控制（委托已有的 authRedirectMiddleware）
      return authRedirectMiddleware(context, state);
    },
    routes: _buildRoutes(routes),
  );
});

/// 构建路由列表（支持 ShellRoute 和嵌套路由）
List<RouteBase> _buildRoutes(List<FlutterRouter> routes) {
  return routes.map((route) {
    // ShellRoute：共享 appBar / bottomNavigationBar 的布局容器
    if (route.isShell) {
      return ShellRoute(
        builder: (context, state, child) {
          return Scaffold(
            appBar: route.appBar,
            body: child,
            bottomNavigationBar: route.bottomNavigationBar,
          );
        },
        routes: _buildRoutes(route.routes ?? []),
      );
    }

    // 普通路由
    return GoRoute(
      name: route.name,
      path: route.path,
      pageBuilder:
          route.pageBuilder ??
          (context, state) {
            return NoTransitionPage(
              key: state.pageKey,
              child:
                  route.builder?.call(context, state) ??
                  const Center(child: Text('页面未找到')),
            );
          },
      routes: route.routes != null ? _buildRoutes(route.routes!) : [],
    );
  }).toList();
}

/// 页面埋点
void _trackPageView(List<FlutterRouter> routes, String? routeName) {
  if (routeName == null) return;

  final currentRouter = routes
      .where((route) => route.name == routeName)
      .firstOrNull;

  if (currentRouter != null) {
    // 集成第三方埋点 SDK（如 Firebase Analytics、友盟统计等）
    // Analytics.instance.logEvent(
    //   name: 'page_view',
    //   parameters: {
    //     'page_name': currentRouter.name,
    //     'page_path': currentRouter.path,
    //     'page_title': currentRouter.title,
    //     'timestamp': DateTime.now().toIso8601String(),
    //   },
    // );
    debugPrint('📊 页面埋点: ${currentRouter.name} - ${currentRouter.path}');
  }
}

/// 路由扩展方法
extension GoRouterExtension on BuildContext {
  /// 获取当前路由路径
  String? get currentRoutePath {
    return GoRouterState.of(this).uri.path;
  }

  /// 获取当前路由名称
  String? get currentRouteName {
    return GoRouterState.of(this).name;
  }

  /// 获取当前路由的 FlutterRouter 对象
  FlutterRouter? get currentFlutterRouter {
    return NavigatorUtilsCore.instance.currentRoute;
  }

  /// 判断是否是当前路由
  bool isCurrentRoute(String path) {
    return currentRoutePath == path;
  }

  /// 判断底部导航是否高亮（当前 tab 判断）
  bool isCurrentTab(String path) {
    return NavigatorUtilsCore.instance.currentRoute?.path == path;
  }
}
