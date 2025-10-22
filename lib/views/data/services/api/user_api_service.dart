/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-26 08:42:36
 */

import 'package:dio/dio.dart';
import 'package:flutter_template/common/index.dart';

import '../../models/index.dart';

class UserApiService {
  final Dio _dio;
  UserApiService(this._dio);

  Future<BaseResponse<List<UserResponseDto>>?> getUserList(
    GetUsersRequestDto request,
  ) async {
    const url = ApiEndpoints.users;

    try {
      final response = await _dio.post<BaseResponse<List<UserResponseDto>>>(
        url,
        data: request.toJson(),
      );

      // 假设接口返回 JSON
      // final data = response.data as Map<String, dynamic>;
      // return UserResponseDto.fromJson(data);

      return response.data;
    } on DioException catch (_) {
      // 可以在这里抛出或映射异常
      // throw e;

      // 下面是测试数据，后面记得删除
      List<UserResponseDto> users = [];

      users.add(
        UserResponseDto(
          id: "1",
          sex: "男",
          age: 18,
          city: "上海",
          email: "1@qq.com",
          username: "Marlon.M",
        ),
      );

      return BaseResponse()..data = users;
    }
  }
}
