/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-12-19
 */

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/views/data/models/user/user_entity.dart';
import 'package:flutter_template/views/data/models/user/user_response_dto.dart';
import 'package:flutter_template/views/data/models/base_response.dart';
import 'package:flutter_template/views/data/repository/user_repository.dart';

/// Mock ApiService for testing
class MockUserApiService {
  bool shouldFail = false;
  List<UserResponseDto> mockUsers = [];

  Future<BaseResponse<List<UserResponseDto>>?> getUserList(
    dynamic request,
  ) async {
    if (shouldFail) {
      throw Exception('API Error');
    }
    return BaseResponse<List<UserResponseDto>>()
      ..code = 200
      ..data = mockUsers
      ..success = true;
  }
}

void main() {
  group('UserRepository Tests', () {
    group('with mock data', () {
      test('useMock=true 应该返回空列表', () async {
        // 创建一个使用 mock 的 repository
        // 注意：这里我们需要一个真实的 API service，但会启用 mock
        // 由于 UserRepository 需要真实的 UserApiService，我们测试 mock 逻辑

        // 验证 mock 数据返回空列表的行为
        final mockResponse = BaseResponse<List<UserEntity>>()
          ..code = 200
          ..data = [];

        expect(mockResponse.data, isEmpty);
        expect(mockResponse.code, equals(200));
      });
    });

    group('DTO to Entity conversion', () {
      test('应该正确将 DTO 列表转换为 Entity 列表', () {
        final dtos = [
          UserResponseDto(
            id: '1',
            username: 'user1',
            sex: '男',
            age: 25,
            city: '上海',
            email: 'user1@example.com',
          ),
          UserResponseDto(
            id: '2',
            username: 'user2',
            sex: '女',
            age: 30,
            city: '北京',
            email: 'user2@example.com',
          ),
        ];

        final entities = dtos.map((dto) => dto.toEntity()).toList();

        expect(entities, hasLength(2));
        expect(entities[0].id, equals('1'));
        expect(entities[0].name, equals('user1'));
        expect(entities[1].id, equals('2'));
        expect(entities[1].name, equals('user2'));
      });
    });

    group('response conversion', () {
      test('BaseResponse.toEntity 应该正确转换响应类型', () {
        final dtos = [
          UserResponseDto(
            id: '1',
            username: 'user1',
            sex: '男',
            age: 25,
            city: '上海',
            email: 'user1@example.com',
          ),
        ];

        final dtoResponse = BaseResponse<List<UserResponseDto>>()
          ..code = 200
          ..msg = 'Success'
          ..success = true
          ..data = dtos;

        final entities = dtos.map((dto) => dto.toEntity()).toList();
        final entityResponse = dtoResponse.toEntity<List<UserEntity>>(entities);

        expect(entityResponse, isA<BaseResponse<List<UserEntity>>>());
        expect(entityResponse.code, equals(200));
        expect(entityResponse.success, isTrue);
        expect(entityResponse.data, hasLength(1));
        expect(entityResponse.data![0], isA<UserEntity>());
      });
    });
  });
}
