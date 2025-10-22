/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-26 08:42:36
 */

import 'package:dio/dio.dart';
import 'package:flutter_template/common/index.dart';

import '../../models/index.dart';

class AuthApiService {
  final Dio _dio;
  AuthApiService(this._dio);

  /// 登录接口
  Future<BaseResponse<UserResponseDto>?> login(LoginRequestDto request) async {
    const url = ApiEndpoints.login;

    try {
      final response = await _dio.post<BaseResponse<UserResponseDto>>(
        url,
        data: request.toJson(),
      );

      // 假设接口返回 JSON
      // final data = response.data as Map<String, dynamic>;
      // return AuthDto.fromJson(data);

      return response.data;
    } on DioException catch (e) {
      // 可以在这里抛出或映射异常
      throw e;
    }
  }

  Future<void> logout() async {
    await _dio.post('/auth/logout');
  }
}
