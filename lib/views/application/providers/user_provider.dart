/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-26 08:22:22
 */

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/common/index.dart';
import 'package:flutter_template/views/data/index.dart';

/// 提供 UserApiService 实例
final userApiProvider = Provider<UserApiService>((ref) {
  final dio = ref.read(dioProvider);
  return UserApiService(dio);
});

/// 提供 UserRepository 实例
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final api = ref.read(userApiProvider);
  return UserRepository(api);
});
