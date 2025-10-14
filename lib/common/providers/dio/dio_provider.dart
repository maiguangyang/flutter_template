/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-22 13:13:07
 */
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sugar_talk/config/config.dart';

import 'interceptors/index.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: Config.project.apiUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {"Accept": Headers.jsonContentType},
    ),
  );
  // 添加拦截器
  dio.interceptors.add(ApiHeader());
  return dio;
});
