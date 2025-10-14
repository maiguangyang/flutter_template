/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2024-04-29 09:42:15
 */
import 'package:dio/dio.dart';
import 'package:sugar_talk/common/index.dart';

class ApiHeader extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = 'Bearer ${CacheServiceCore.getString(CacheKeys.token)}';

    options.headers["Authorization"] = token;

    super.onRequest(options, handler);
  }
}
