/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-26 08:42:36
 */

import 'package:dio/dio.dart';
import 'package:flutter_template/shared/index.dart';

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
    } on DioException catch (e) {
      throw e;
    }
  }
}
