import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/common/index.dart';
import 'package:flutter_template/views/data/index.dart';

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
