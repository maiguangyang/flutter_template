/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-12-19
 */

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/views/data/models/index.dart';
import 'package:flutter_template/views/data/repository/user_repository.dart';
import 'package:flutter_template/views/application/notifiers/index.dart';
import 'package:flutter_template/views/application/providers/user_provider.dart';

/// Mock UserRepository for testing
class MockUserRepository implements UserRepository {
  bool shouldFail = false;
  List<UserEntity> mockUsers = [];

  @override
  bool get useMock => true;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  Future<BaseResponse<List<UserEntity>>?> getUsers({
    int page = 1,
    int size = 20,
    bool forceRefresh = false,
  }) async {
    if (shouldFail) {
      throw Exception('Failed to fetch users');
    }
    return BaseResponse<List<UserEntity>>()
      ..code = 200
      ..success = true
      ..data = mockUsers;
  }
}

void main() {
  group('AsyncUserNotifier Integration Tests', () {
    late ProviderContainer container;
    late MockUserRepository mockRepository;

    setUp(() {
      mockRepository = MockUserRepository();
      container = ProviderContainer(
        overrides: [userRepositoryProvider.overrideWithValue(mockRepository)],
      );
    });

    tearDown(() {
      container.dispose();
    });

    group('build (initial load)', () {
      test('初始化时应该自动加载用户列表', () async {
        mockRepository.mockUsers = [
          UserEntity(
            id: '1',
            name: 'User 1',
            sex: '男',
            age: 25,
            city: '上海',
            email: 'user1@example.com',
          ),
          UserEntity(
            id: '2',
            name: 'User 2',
            sex: '女',
            age: 30,
            city: '北京',
            email: 'user2@example.com',
          ),
        ];

        final users = await container.read(asyncUserProvider.future);

        expect(users, hasLength(2));
        expect(users[0].name, equals('User 1'));
        expect(users[1].name, equals('User 2'));
      });

      test('空用户列表应该返回空数组', () async {
        mockRepository.mockUsers = [];

        final users = await container.read(asyncUserProvider.future);

        expect(users, isEmpty);
      });
    });

    group('getUsers (refresh)', () {
      test('刷新应该重新加载用户列表', () async {
        // 初始数据
        mockRepository.mockUsers = [
          UserEntity(
            id: '1',
            name: 'Initial User',
            sex: '男',
            age: 25,
            city: '上海',
            email: 'initial@example.com',
          ),
        ];

        // 等待初始加载
        await container.read(asyncUserProvider.future);

        // 更新 mock 数据
        mockRepository.mockUsers = [
          UserEntity(
            id: '1',
            name: 'Updated User',
            sex: '男',
            age: 25,
            city: '上海',
            email: 'updated@example.com',
          ),
          UserEntity(
            id: '2',
            name: 'New User',
            sex: '女',
            age: 28,
            city: '深圳',
            email: 'new@example.com',
          ),
        ];

        // 刷新
        final notifier = container.read(asyncUserProvider.notifier);
        await notifier.getUsers();

        final state = container.read(asyncUserProvider);

        expect(state.value, hasLength(2));
        expect(state.value![0].name, equals('Updated User'));
        expect(state.value![1].name, equals('New User'));
      });

      test('刷新失败应该显示 error 状态', () async {
        // 初始加载成功
        mockRepository.mockUsers = [];
        await container.read(asyncUserProvider.future);

        // 模拟失败
        mockRepository.shouldFail = true;

        final notifier = container.read(asyncUserProvider.notifier);
        await notifier.getUsers();

        final state = container.read(asyncUserProvider);

        expect(state.hasError, isTrue);
      });
    });

    group('state transitions', () {
      test('状态应该从 loading 变为 data', () async {
        mockRepository.mockUsers = [
          UserEntity(
            id: '1',
            name: 'Test',
            sex: '男',
            age: 25,
            city: '上海',
            email: 'test@example.com',
          ),
        ];

        final states = <AsyncValue<List<UserEntity>>>[];

        container.listen(asyncUserProvider, (previous, next) {
          states.add(next);
        }, fireImmediately: true);

        await container.read(asyncUserProvider.future);

        // 应该有 loading 和 data 状态
        expect(states.any((s) => s.isLoading), isTrue);
        expect(states.last.hasValue, isTrue);
      });
    });
  });
}
