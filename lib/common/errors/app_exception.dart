/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-26 09:21:54
 */
/// 应用内的统一异常定义
class AppException implements Exception {
  final String message;
  final String? code;
  final Exception? original;

  AppException(this.message, {this.code, this.original});

  @override
  String toString() => 'AppException($code): $message';
}

/// 网络错误
class NetworkException extends AppException {
  NetworkException(String message, {String? code, Exception? original})
    : super(message, code: code, original: original);
}

/// 认证错误
class AuthException extends AppException {
  AuthException(String message, {String? code, Exception? original})
    : super(message, code: code, original: original);
}

/// 服务端错误
class ServerException extends AppException {
  ServerException(String message, {String? code, Exception? original})
    : super(message, code: code, original: original);
}
