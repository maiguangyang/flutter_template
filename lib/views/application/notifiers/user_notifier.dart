/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-26 08:21:22
 */

import 'package:flutter_template/common/index.dart';
import 'package:flutter_template/views/data/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../providers/index.dart';

part 'user_notifier.g.dart';

/// Notifier 管理 UserState
/// - keepAlive: true 表示持久化
/// - PaginationMixin: 提供分页能力
/// - 缓存由 Repository 层负责
@Riverpod(keepAlive: true)
class AsyncUserNotifier extends _$AsyncUserNotifier with PaginationMixin {
  UserRepository get _repository => ref.watch(userRepositoryProvider);

  @override
  FutureOr<List<UserEntity>> build() async {
    resetPagination();
    return await _loadPage();
  }

  /// 获取分页数据
  Future<List<UserEntity>> _fetchPage() async {
    final result = await _repository.getUsers(
      page: currentPage,
      size: pageSize,
    );
    return result?.data ?? [];
  }

  /// 加载当前页
  Future<List<UserEntity>> _loadPage() async {
    final data = await _fetchPage();
    updatePagination(data.length);
    return data;
  }

  /// 加载更多
  Future<void> loadMore() => safeLoadMore(
    fetch: _fetchPage,
    onSuccess: (newData) {
      final current = state.value ?? [];
      state = AsyncValue.data([...current, ...newData]);
    },
  );

  /// 刷新（重新加载第一页）
  Future<void> refresh() async {
    resetPagination();
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_loadPage);
  }

  /// 刷新别名
  Future<void> getUsers() => refresh();

  /// 根据 ID 获取用户（从 Repository 缓存）
  Future<UserEntity?> getUserById(String id) => _repository.getUserById(id);

  /// 更新用户（更新列表状态）
  void updateUser(UserEntity user) {
    final list = state.value ?? [];
    final idx = list.indexWhere((u) => u.id == user.id);
    if (idx != -1) {
      state = AsyncValue.data([...list]..[idx] = user);
    }
  }

  /// 删除用户
  void deleteUser(String id) {
    state = AsyncValue.data(
      (state.value ?? []).where((u) => u.id != id).toList(),
    );
  }
}
