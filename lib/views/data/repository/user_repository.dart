/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-26 08:33:42
 */

import 'package:sugar_talk/views/data/api/index.dart';

import '../models/index.dart';

class UserRepository {
  final UserApi _api;
  UserRepository(this._api);

  /// 获取用户列表
  Future<BaseResponse<List<UserEntity>>?> getUsers() async {
    // 构建请求 DTO
    final request = GetUsersRequestDto();

    // 调用 API，返回 UserDto
    final userDto = await _api.getUserList(request);

    // Dto 转成 Entity
    final data = userDto?.data ?? [];
    final dtoToEntity = data.map((user) => user.toEntity()).toList();

    // 转换成最终输出数据
    final convertData = userDto?.toEntity<List<UserEntity>>(dtoToEntity);
    return convertData;
  }
}
