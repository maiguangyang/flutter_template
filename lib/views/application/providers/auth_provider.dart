/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-26 08:42:07
 */
/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-15 13:56:59
 */
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/common/index.dart';
import 'package:flutter_template/views/data/index.dart';

/// 提供 AuthApiService 实例
final authApiProvider = Provider<AuthApiService>((ref) {
  final dio = ref.read(dioProvider);
  return AuthApiService(dio);
});

/// 提供 AuthRepository 实例
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final api = ref.read(authApiProvider);
  return AuthRepository(api);
});
