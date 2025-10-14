import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sugar_talk/common/index.dart';
import 'package:sugar_talk/views/data/api/index.dart';
import 'package:sugar_talk/views/data/index.dart';

/// 提供 ModelApi 实例
final modelApiProvider = Provider<ModelApi>((ref) {
  final dio = ref.read(dioProvider);
  return ModelApi(dio);
});

/// 提供 ModelRepository 实例
final modelRepositoryProvider = Provider<ModelRepository>((ref) {
  final api = ref.read(modelApiProvider);
  return ModelRepository(api);
});
