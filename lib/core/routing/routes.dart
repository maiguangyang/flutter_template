/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2024-07-29 19:16:48
 */

import 'package:flutter_oxygen/flutter_oxygen.dart';

/// 路由集合
/// name：路由名称，跳转的时候使用
/// path：路由路径
///
/// 所有path不能用驼峰
class Routes {
  /// 首页
  static Route home = const Route(name: 'home', path: '/home');

  /// 测试页
  static Route test = const Route(name: 'test', path: '/test');

  /// 测试页
  static Route model = const Route(name: 'model', path: '/model');

  /// welcome页面

  /// 登录
  static Route login = const Route(name: 'login', path: '/login');
}
