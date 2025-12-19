/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-12-19
 */

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/common/providers/dio/dio_provider.dart';
import 'package:flutter_template/views/application/providers/auth_provider.dart';
import 'package:flutter_template/views/application/providers/user_provider.dart';
import 'package:flutter_template/views/data/index.dart';

void main() {
  group('Provider Dependency Chain Tests', () {
    late ProviderContainer container;
    late Dio testDio;

    setUp(() {
      // 创建一个真实的 Dio 实例用于测试
      testDio = Dio(BaseOptions(baseUrl: 'https://test.api.com'));
      container = ProviderContainer(
        overrides: [dioProvider.overrideWithValue(testDio)],
      );
    });

    tearDown(() {
      container.dispose();
      testDio.close();
    });

    group('Auth Provider Chain', () {
      test('authApiProvider 应该正确创建 AuthApiService', () {
        final authApi = container.read(authApiProvider);

        expect(authApi, isA<AuthApiService>());
      });

      test('authRepositoryProvider 应该正确创建 AuthRepository', () {
        final authRepository = container.read(authRepositoryProvider);

        expect(authRepository, isA<AuthRepository>());
      });

      test('Provider 链应该正确连接: Dio -> Api -> Repository', () {
        // 读取 repository 应该触发整个依赖链
        final repository = container.read(authRepositoryProvider);

        expect(repository, isNotNull);
        // Repository 内部应该有正确的 Api 实例
        expect(repository, isA<AuthRepository>());
      });
    });

    group('User Provider Chain', () {
      test('userApiProvider 应该正确创建 UserApiService', () {
        final userApi = container.read(userApiProvider);

        expect(userApi, isA<UserApiService>());
      });

      test('userRepositoryProvider 应该正确创建 UserRepository', () {
        final userRepository = container.read(userRepositoryProvider);

        expect(userRepository, isA<UserRepository>());
      });
    });

    group('Provider Overrides', () {
      test('应该能够成功 override repository', () {
        final mockRepository = _MockAuthRepository();

        final overriddenContainer = ProviderContainer(
          overrides: [authRepositoryProvider.overrideWithValue(mockRepository)],
        );

        final repository = overriddenContainer.read(authRepositoryProvider);

        expect(repository, equals(mockRepository));

        overriddenContainer.dispose();
      });
    });

    group('Provider Caching', () {
      test('同一个 container 应该返回相同的实例', () {
        final authApi1 = container.read(authApiProvider);
        final authApi2 = container.read(authApiProvider);

        expect(identical(authApi1, authApi2), isTrue);
      });

      test('同一个 container 应该返回相同的 repository 实例', () {
        final repo1 = container.read(userRepositoryProvider);
        final repo2 = container.read(userRepositoryProvider);

        expect(identical(repo1, repo2), isTrue);
      });
    });
  });
}

/// Mock for override test
class _MockAuthRepository implements AuthRepository {
  @override
  bool get useMock => true;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  Future<BaseResponse<UserEntity>?> login(
    String username,
    String password,
  ) async {
    return null;
  }

  @override
  Future<void> logout() async {}
}
