/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-26 08:33:42
 */

import 'package:flutter_template/views/data/index.dart';

class AuthRepository {
  final AuthApiService _api;
  AuthRepository(this._api);

  /// 登录
  Future<BaseResponse<UserEntity>?> login(
    String username,
    String password,
  ) async {
    // 构建请求 DTO
    final request = LoginRequestDto(username: username, password: password);

    // 调用 API，返回 UserDto
    final userDto = await _api.login(request);

    // Dto 转成 Entity
    final dtoToEntity = userDto?.data?.toEntity();

    // 转换成最终输出数据
    final convertData = userDto?.toEntity<UserEntity>(dtoToEntity);
    return convertData;
  }

  /// 登出
  Future<void> logout() async {
    return await _api.logout();
  }
}
