/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-10-22 20:05:00
 */
import 'package:flutter_template/core/index.dart';
import 'package:flutter_template/shared/index.dart';

/// 提供 ModelApiService 实例
final modelApiProvider = Provider<ModelApiService>((ref) {
  final dio = ref.read(dioProvider);
  return ModelApiService(dio);
});

/// 提供 ModelRepository 实例
final modelRepositoryProvider = Provider<ModelRepository>((ref) {
  final api = ref.read(modelApiProvider);
  return ModelRepository(api, useMock: false);
});
