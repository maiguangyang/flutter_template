/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-26 09:22:08
 */
import 'package:dio/dio.dart';
import 'package:flutter_template/abstracts/index.dart';

/// 把 Dio 或其他异常转成统一的 AppException
class ErrorMapper {
  final WidgetRef ref;
  ErrorMapper(this.ref);

  AppException map(Exception error) {
    final lang = ref.lang;

    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          return NetworkException(lang.sendTimeout, original: error);
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          if (statusCode == 401) {
            return AuthException(
              lang.authException,
              code: "401",
              original: error,
            );
          }
          return ServerException(
            "${lang.serverException}($statusCode)",
            original: error,
          );
        default:
          return NetworkException(lang.networkException, original: error);
      }
    }

    return AppException(lang.appException, original: error);
  }
}
