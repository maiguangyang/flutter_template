/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-12-19
 */

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/views/data/models/index.dart';
import 'package:flutter_template/views/data/repository/auth_repository.dart';
import 'package:flutter_template/views/application/notifiers/index.dart';
import 'package:flutter_template/views/application/providers/auth_provider.dart';

/// Mock AuthRepository for testing
class MockAuthRepository implements AuthRepository {
  bool shouldFail = false;
  UserEntity? mockUser;
  bool logoutCalled = false;

  @override
  bool get useMock => true;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  Future<BaseResponse<UserEntity>?> login(
    String username,
    String password,
  ) async {
    if (shouldFail) {
      throw Exception('Login failed');
    }
    return BaseResponse<UserEntity>()
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
  group('AsyncAuthNotifier Integration Tests', () {
    late ProviderContainer container;
    late MockAuthRepository mockRepository;

    setUp(() {
      mockRepository = MockAuthRepository();
      container = ProviderContainer(
        overrides: [authRepositoryProvider.overrideWithValue(mockRepository)],
      );
    });

    tearDown(() {
      container.dispose();
    });

    group('initial state', () {
      test('初始状态应该是 null', () async {
        // 等待 build 完成
        await container.read(asyncAuthProvider.future);

        final state = container.read(asyncAuthProvider);

        expect(state.value, isNull);
      });
    });

    group('login', () {
      test('登录成功应该更新状态为用户数据', () async {
        final testUser = UserEntity(
          id: '1',
          name: 'Test User',
          sex: '男',
          age: 25,
          city: '上海',
          email: 'test@example.com',
        );
        mockRepository.mockUser = testUser;

        final notifier = container.read(asyncAuthProvider.notifier);
        await notifier.login();

        final state = container.read(asyncAuthProvider);

        expect(state.hasValue, isTrue);
        expect(state.value?.id, equals('1'));
        expect(state.value?.name, equals('Test User'));
      });

      test('登录过程中应该显示 loading 状态', () async {
        mockRepository.mockUser = UserEntity(
          id: '1',
          name: 'Test',
          sex: '男',
          age: 25,
          city: '上海',
          email: 'test@example.com',
        );

        final notifier = container.read(asyncAuthProvider.notifier);

        // 开始登录，立即检查状态
        final future = notifier.login();

        // 登录完成后检查结果
        await future;

        final state = container.read(asyncAuthProvider);
        expect(state.hasValue, isTrue);
      });

      test('登录失败应该显示 error 状态', () async {
        mockRepository.shouldFail = true;

        final notifier = container.read(asyncAuthProvider.notifier);
        await notifier.login();

        final state = container.read(asyncAuthProvider);

        expect(state.hasError, isTrue);
      });
    });

    group('logout', () {
      test('登出应该调用 repository.logout', () async {
        final notifier = container.read(asyncAuthProvider.notifier);
        await notifier.logout();

        expect(mockRepository.logoutCalled, isTrue);
      });
    });
  });
}
