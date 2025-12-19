/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-12-19
 */

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/views/data/models/index.dart';
import 'package:flutter_template/views/data/repository/auth_repository.dart';
import 'package:flutter_template/views/data/services/api/auth_api_service.dart';

/// Mock AuthApiService
class MockAuthApiService implements AuthApiService {
  bool shouldFail = false;
  UserResponseDto? mockUser;
  bool logoutCalled = false;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  Future<BaseResponse<UserResponseDto>?> login(LoginRequestDto request) async {
    if (shouldFail) throw Exception('Login failed');
    return BaseResponse<UserResponseDto>()
      ..code = 200
      ..success = true
      ..data = mockUser;
  }

  @override
  Future<void> logout() async {
    logoutCalled = true;
  }
}

void main() {
  group('AuthRepository Tests', () {
    late AuthRepository repository;
    late MockAuthApiService mockApi;

    setUp(() {
      mockApi = MockAuthApiService();
      repository = AuthRepository(mockApi);
    });

    group('login', () {
      test('登录成功应该返回 UserEntity', () async {
        mockApi.mockUser = UserResponseDto(
          id: '1',
          username: 'testuser',
          sex: '男',
          age: 25,
          city: '上海',
          email: 'test@example.com',
        );

        final result = await repository.login('testuser', 'password');

        expect(result, isNotNull);
        expect(result!.data, isA<UserEntity>());
        expect(result.data!.id, equals('1'));
        expect(result.data!.name, equals('testuser'));
      });

      test('登录失败应该抛出异常', () async {
        mockApi.shouldFail = true;

        expect(() => repository.login('user', 'pass'), throwsException);
      });

      test('用户不存在应该返回 null data', () async {
        mockApi.mockUser = null;

        final result = await repository.login('user', 'pass');

        expect(result, isNotNull);
        expect(result!.data, isNull);
      });
    });

    group('logout', () {
      test('登出应该调用 API', () async {
        await repository.logout();

        expect(mockApi.logoutCalled, isTrue);
      });
    });

    group('mock mode', () {
      test('useMock=true 应该返回 mock 响应', () async {
        final mockRepository = AuthRepository(mockApi, useMock: true);

        final result = await mockRepository.login('user', 'pass');

        expect(result, isNotNull);
        expect(result!.code, equals(200));
      });
    });
  });
}
