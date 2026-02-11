/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-22 13:37:54
 */
import 'package:flutter_oxygen/flutter_oxygen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deviceTypeProvider = Provider<DeviceTypeEnum>((ref) {
  // 可以根据屏幕尺寸、平台返回 DeviceTypeEnum
  return DeviceUtilsCore.getDeviceType();
});
