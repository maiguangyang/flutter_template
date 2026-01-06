/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-26 08:22:22
 */

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/common/index.dart';
import 'package:flutter_template/views/data/index.dart';

/// 提供 UserListCache 实例（使用 CacheStrategy）
final userListCacheProvider = Provider<CacheStrategy<List<UserEntity>>>((ref) {
  return CacheStrategy<List<UserEntity>>(
    cacheKey: 'user_list_cache',
    maxSize: 20,
    expiration: const Duration(minutes: 5),
    fromJson: (json) => (json['items'] as List)
        .map((e) => UserEntity.fromJson(e as Map<String, dynamic>))
        .toList(),
    toJson: (list) => {'items': list.map((e) => e.toJson()).toList()},
  );
});

/// 提供 UserCache 实例（使用 CacheStrategy）
final userCacheProvider = Provider<CacheStrategy<UserEntity>>((ref) {
  return CacheStrategy<UserEntity>(
    cacheKey: 'user_cache',
    maxSize: 100,
    expiration: const Duration(hours: 1),
    fromJson: UserEntity.fromJson,
    toJson: (e) => e.toJson(),
  );
});

/// 提供 UserApiService 实例
final userApiProvider = Provider<UserApiService>((ref) {
  final dio = ref.read(dioProvider);
  return UserApiService(dio);
});

/// 提供 UserRepository 实例
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final api = ref.read(userApiProvider);
  final listCache = ref.read(userListCacheProvider);
  final userCache = ref.read(userCacheProvider);

  final repo = UserRepository(api, listCache: listCache, userCache: userCache);
  repo.init();
  return repo;
});
