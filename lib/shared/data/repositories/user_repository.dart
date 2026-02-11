/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-26 08:33:42
 */

import 'package:flutter_template/core/index.dart';
import 'package:flutter_template/shared/index.dart';

class UserRepository {
  final UserApiService _api;

  /// 列表缓存（使用 CacheStrategy）
  final CacheStrategy<List<UserEntity>>? _listCache;

  /// 单用户缓存（使用 CacheStrategy）
  final CacheStrategy<UserEntity>? _userCache;

  /// 是否使用mock
  final bool useMock;

  /// 是否已初始化
  bool _initialized = false;

  UserRepository(
    this._api, {
    CacheStrategy<List<UserEntity>>? listCache,
    CacheStrategy<UserEntity>? userCache,
    this.useMock = false,
  }) : _listCache = listCache,
       _userCache = userCache;

  /// 初始化缓存（需要在使用前调用）
  Future<void> init() async {
    if (_initialized) return;
    await _listCache?.init();
    await _userCache?.init();
    _initialized = true;
  }

  /// 获取用户列表（支持分页，优先从缓存读取）
  ///
  /// [forceRefresh] 强制刷新，忽略缓存
  Future<BaseResponse<List<UserEntity>>?> getUsers({
    int page = 1,
    int size = 20,
    bool forceRefresh = false,
  }) async {
    final cacheKey = 'page_${page}_size_$size';

    // mock 数据
    if (useMock) {
      return BaseResponse()
        ..code = 200
        ..data = [];
    }

    // 1. 非强制刷新时，先查缓存
    if (!forceRefresh) {
      final cached = _listCache?.get(cacheKey);
      if (cached != null) {
        // 同时缓存单个用户
        for (final user in cached) {
          _userCache?.put(user.id, user);
        }
        return BaseResponse<List<UserEntity>>()
          ..code = 200
          ..success = true
          ..data = cached;
      }
    }

    // 2. 调用 API
    final request = GetUsersRequestDto(page: page, size: size);
    final userDto = await _api.getUserList(request);

    // Dto 转成 Entity
    final data = userDto?.data ?? [];
    final entities = data.map((user) => user.toEntity()).toList();

    // 3. 存入缓存
    if (entities.isNotEmpty) {
      await _listCache?.put(cacheKey, entities);
      // 同时缓存单个用户
      for (final user in entities) {
        await _userCache?.put(user.id, user);
      }
    }

    // 转换成最终输出数据
    return userDto?.toEntity<List<UserEntity>>(entities);
  }

  /// 根据 ID 获取用户（优先从缓存读取）
  Future<UserEntity?> getUserById(String id) async {
    // 1. 先查缓存
    final cached = _userCache?.get(id);
    if (cached != null) return cached;

    // 2. TODO: 调用单用户 API（如果有的话）
    // final result = await _api.getUser(id);
    // if (result != null) {
    //   await _userCache?.put(id, result);
    // }
    // return result;

    return null;
  }

  /// 清空所有缓存
  Future<void> clearCache() async {
    await _listCache?.clear();
    await _userCache?.clear();
  }

  /// 清理过期缓存
  Future<void> cleanExpiredCache() async {
    await _listCache?.cleanExpired();
    await _userCache?.cleanExpired();
  }
}
