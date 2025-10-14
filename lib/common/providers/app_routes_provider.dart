/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-22 13:37:54
 */
import 'package:flutter_oxygen/flutter_oxygen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sugar_talk/views/pages/desktop/routes.dart';
import 'package:sugar_talk/views/pages/mobile/routes.dart';

import 'device_type_provider.dart';

/// 全局路由 Provider，根据设备类型返回不同路由列表
final flutterRouterListProvider = Provider<List<FlutterRouter>>((ref) {
  final deviceType = ref.watch(deviceTypeProvider);

  switch (deviceType) {
    case DeviceTypeEnum.mobile:
    case DeviceTypeEnum.iPad:
      return ref.watch(mobileRoutesProvider);
    case DeviceTypeEnum.desktop:
      return ref.watch(desktopRoutesProvider);
  }
});
