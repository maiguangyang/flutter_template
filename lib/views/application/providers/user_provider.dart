/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-26 08:22:22
 */

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sugar_talk/common/index.dart';
import 'package:sugar_talk/views/data/api/index.dart';
import 'package:sugar_talk/views/data/index.dart';

/// 提供 UserApi 实例
final userApiProvider = Provider<UserApi>((ref) {
  final dio = ref.read(dioProvider);
  return UserApi(dio);
});

/// 提供 UserRepository 实例
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final api = ref.read(userApiProvider);
  return UserRepository(api);
});
