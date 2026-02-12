/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2026-02-12 09:23:57
 */

/// 路由使用示例
///
/// 本文件展示如何使用 router.dart 中实现的各种功能

import 'package:flutter/material.dart';
import 'package:flutter_template/routing/index.dart';
import 'package:go_router/go_router.dart';

/// 示例 1: 底部导航栏使用路由高亮
class BottomNavigationExample extends StatelessWidget {
  const BottomNavigationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _getCurrentIndex(context),
      onTap: (index) => _onTabTapped(context, index),
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: context.isCurrentTab(RoutePath.home.path)
                ? Colors.blue
                : Colors.grey,
          ),
          label: '首页',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.model_training,
            color: context.isCurrentTab(RoutePath.model.path)
                ? Colors.blue
                : Colors.grey,
          ),
          label: '模型',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.science,
            color: context.isCurrentTab(RoutePath.test.path)
                ? Colors.blue
                : Colors.grey,
          ),
          label: '测试',
        ),
      ],
    );
  }

  int _getCurrentIndex(BuildContext context) {
    final currentPath = context.currentRoutePath;
    switch (currentPath) {
      case '/home':
        return 0;
      case '/model':
        return 1;
      case '/test':
        return 2;
      default:
        return 0;
    }
  }

  void _onTabTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.goNamed(RoutePath.home.name);
        break;
      case 1:
        context.goNamed(RoutePath.model.name);
        break;
      case 2:
        context.goNamed(RoutePath.test.name);
        break;
    }
  }
}

/// 示例 2: 获取当前路由信息
class CurrentRouteInfoExample extends StatelessWidget {
  const CurrentRouteInfoExample({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRouter = context.currentFlutterRouter;

    return Column(
      children: [
        Text('当前路径: ${context.currentRoutePath ?? "未知"}'),
        Text('当前名称: ${context.currentRouteName ?? "未知"}'),
        if (currentRouter != null) ...[
          Text('路由名称: ${currentRouter.name}'),
          Text('路由标题: ${currentRouter.title}'),
        ],
      ],
    );
  }
}

/// 示例 3: 判断当前 Tab
class CurrentTabExample extends StatelessWidget {
  const CurrentTabExample({super.key});

  @override
  Widget build(BuildContext context) {
    final isHome = context.isCurrentTab(RoutePath.home.path);

    return Text(
      isHome ? '当前在首页' : '不在首页',
      style: const TextStyle(fontSize: 16),
    );
  }
}

/// 示例 4: 权限控制（在 authRedirectMiddleware 中实现）
///
/// 权限控制通过 `FlutterRouter.auth` 字段配置：
///
/// ```dart
/// FlutterRouter(
///   name: RoutePath.profile.name,
///   path: RoutePath.profile.path,
///   title: '个人中心',
///   auth: true, // 需要登录才能访问
///   builder: (context, state) => ProfileScreen(),
/// ),
/// ```
///
/// `authRedirectMiddleware` 会自动检查：
/// - 未登录且路由 `auth == true` → 重定向到登录页
/// - 已登录但在登录页 → 重定向到首页

/// 示例 5: 页面埋点（在 goRouterProvider redirect 中自动触发）
///
/// 每次路由变化时，`_trackPageView` 方法会自动被调用。
/// 集成第三方 SDK 时，只需在 `_trackPageView` 中添加对应的代码即可。
