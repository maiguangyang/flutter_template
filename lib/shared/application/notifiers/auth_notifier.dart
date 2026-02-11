/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-26 08:21:22
 */

import 'package:flutter_template/shared/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_notifier.g.dart';

/// Notifier 管理 AuthState
@Riverpod(keepAlive: true)
class AsyncAuthNotifier extends _$AsyncAuthNotifier {
  AuthRepository get _repository => ref.watch(authRepositoryProvider);

  @override
  FutureOr<UserEntity?> build() async {
    return null;
  }

  // 内部私有方法，只返回数据，不操作 state
  Future<UserEntity?> _fetchData() async {
    final result = await _repository.login("1234", "5678");
    return result?.data;
  }

  /// login
  Future<void> login() async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(_fetchData);
  }

  /// 登出
  Future<void> logout() {
    return _repository.logout();
  }
}
