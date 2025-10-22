/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-17 20:34:56
 */

import 'package:flutter_template/views/data/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../providers/index.dart';

part 'model_notifier.g.dart';

/// Notifier 管理 ModelState
@Riverpod(keepAlive: true)
class AsyncModelNotifier extends _$AsyncModelNotifier {
  ModelRepository get _repository => ref.watch(modelRepositoryProvider);

  @override
  FutureOr<List<ModelEntity>> build() async {
    return _fetchData();
  }

  // 内部私有方法，只返回数据，不操作 state
  Future<List<ModelEntity>> _fetchData() async {
    final result = await _repository.getModels();
    return result?.data ?? [];
  }

  /// getModels
  Future<void> getModels() async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(_fetchData);
  }
}
