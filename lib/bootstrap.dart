/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-22 10:08:05
 */
import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_oxygen/core/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/shared/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 只在网络问题或超时才重试
final networkErrorTypes = [
  DioExceptionType.connectionTimeout,
  DioExceptionType.sendTimeout,
  DioExceptionType.receiveTimeout,
  DioExceptionType.connectionError,
];

/// 监听器
base class AppProviderObserver extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? prevValue,
    Object? nextValue,
  ) {
    super.didUpdateProvider(context, prevValue, nextValue);

    if (nextValue is AsyncValue && nextValue.error != null) {
      final error = nextValue.error!;

      // 显示错误信息
      ToastUtilsCore.showToast(
        error.toString(),
        duration: const Duration(milliseconds: 3500),
      );
    }
  }
}

/// 启动入口
Future<ProviderContainer> bootstrap() async {
  final prefs = await SharedPreferences.getInstance();

  final container = ProviderContainer(
    observers: [AppProviderObserver()],
    overrides: [sharedPrefsProvider.overrideWithValue(prefs)],
    retry: (retryCount, err) {
      // 只处理 DioException
      if (err is! DioException) return null;

      // 判断是否网络问题
      final isNetworkError =
          networkErrorTypes.contains(err.type) ||
          (err.type == DioExceptionType.unknown &&
              err.error is SocketException);

      // 非网络问题或超过最大重试次数 → 不重试
      if (!isNetworkError || retryCount >= GlobalConstant.retryCount) {
        return null;
      }

      // 网络问题且未超过重试次数 → 延迟 5 秒重试
      return const Duration(milliseconds: 5000);
    },
  );

  // 初始化所有已注册的缓存并清理过期数据
  await CacheRegistry.initAll();
  await CacheRegistry.cleanExpiredAll();

  return container;
}
