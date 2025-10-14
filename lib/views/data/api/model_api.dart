/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-23 10:45:54
 */
import 'package:dio/dio.dart';
import 'package:flutter_template/common/index.dart';

import '../models/index.dart';

class ModelApi {
  final Dio _dio;
  ModelApi(this._dio);

  /// 登录接口
  Future<BaseResponse<List<ModelResponseDto>>?> getModel(
    GetModelsRequestDto request,
  ) async {
    const url = ApiEndpoints.models;

    try {
      final response = await _dio.post<BaseResponse<List<ModelResponseDto>>>(
        url,
        data: request.toJson(),
      );

      // 假设接口返回 JSON
      // final data = response.data as Map<String, dynamic>;
      // return ModelResponseDto.fromJson(data);

      return response.data;
    } on DioException catch (e) {
      // 可以在这里抛出或映射异常
      throw e;
    }
  }
}
