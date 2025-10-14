/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-26 08:21:22
 */

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_template/views/data/index.dart';

import '../providers/index.dart';

part 'user_notifier.g.dart';

/// Notifier 管理 UserState
@Riverpod(keepAlive: true)
class AsyncUserNotifier extends _$AsyncUserNotifier {
  UserRepository get _repository => ref.watch(userRepositoryProvider);

  @override
  FutureOr<List<UserEntity>> build() async {
    return _fetchData();
  }

  // 内部私有方法，只返回数据，不操作 state
  Future<List<UserEntity>> _fetchData() async {
    final result = await _repository.getUsers();
    return result?.data ?? [];
  }

  /// getUsers
  Future<void> getUsers() async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(_fetchData);
  }
}
