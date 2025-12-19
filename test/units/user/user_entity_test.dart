/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-12-19
 */

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/views/data/models/user/user_entity.dart';
import 'package:flutter_template/views/data/models/user/user_response_dto.dart';

void main() {
  group('UserEntity Tests', () {
    late UserEntity testUser;

    setUp(() {
      testUser = UserEntity(
        id: '1',
        name: 'John Doe',
        sex: '男',
        age: 25,
        city: '上海',
        email: 'john@example.com',
      );
    });

    group('creation', () {
      test('应该正确创建 UserEntity', () {
        expect(testUser.id, equals('1'));
        expect(testUser.name, equals('John Doe'));
        expect(testUser.sex, equals('男'));
        expect(testUser.age, equals(25));
        expect(testUser.city, equals('上海'));
        expect(testUser.email, equals('john@example.com'));
      });
    });

    group('business logic', () {
      test('isEmailVerified 当 email 不为空时应该返回 true', () {
        expect(testUser.isEmailVerified, isTrue);
      });

      test('isEmailVerified 当 email 为空时应该返回 false', () {
        final userWithEmptyEmail = UserEntity(
          id: '2',
          name: 'Jane',
          sex: '女',
          age: 20,
          city: '北京',
          email: '',
        );

        expect(userWithEmptyEmail.isEmailVerified, isFalse);
      });
    });

    group('serialization', () {
      test('toJson 应该正确序列化', () {
        final json = testUser.toJson();

        expect(json['id'], equals('1'));
        expect(json['name'], equals('John Doe'));
        expect(json['sex'], equals('男'));
        expect(json['age'], equals(25));
        expect(json['city'], equals('上海'));
        expect(json['email'], equals('john@example.com'));
      });

      test('fromJson 应该正确反序列化', () {
        final json = {
          'id': '1',
          'name': 'John Doe',
          'sex': '男',
          'age': 25,
          'city': '上海',
          'email': 'john@example.com',
        };

        final user = UserEntity.fromJson(json);

        expect(user.id, equals('1'));
        expect(user.name, equals('John Doe'));
        expect(user.sex, equals('男'));
        expect(user.age, equals(25));
        expect(user.city, equals('上海'));
        expect(user.email, equals('john@example.com'));
      });
    });
  });

  group('UserResponseDto Tests', () {
    late UserResponseDto testDto;

    setUp(() {
      testDto = UserResponseDto(
        id: '1',
        username: 'johndoe',
        sex: '男',
        age: 25,
        city: '上海',
        email: 'john@example.com',
      );
    });

    group('creation', () {
      test('应该正确创建 UserResponseDto', () {
        expect(testDto.id, equals('1'));
        expect(testDto.username, equals('johndoe'));
        expect(testDto.sex, equals('男'));
        expect(testDto.age, equals(25));
        expect(testDto.city, equals('上海'));
        expect(testDto.email, equals('john@example.com'));
      });
    });

    group('toEntity', () {
      test('应该正确转换为 UserEntity', () {
        final entity = testDto.toEntity();

        expect(entity, isA<UserEntity>());
        expect(entity.id, equals('1'));
        expect(entity.name, equals('johndoe')); // username -> name
        expect(entity.sex, equals('男'));
        expect(entity.age, equals(25));
        expect(entity.city, equals('上海'));
        expect(entity.email, equals('john@example.com'));
      });
    });

    group('serialization', () {
      test('toJson 应该正确序列化', () {
        final json = testDto.toJson();

        expect(json['id'], equals('1'));
        expect(json['username'], equals('johndoe'));
        expect(json['sex'], equals('男'));
        expect(json['age'], equals(25));
        expect(json['city'], equals('上海'));
        expect(json['email'], equals('john@example.com'));
      });

      test('fromJson 应该正确反序列化', () {
        final json = {
          'id': '1',
          'username': 'johndoe',
          'sex': '男',
          'age': 25,
          'city': '上海',
          'email': 'john@example.com',
        };

        final dto = UserResponseDto.fromJson(json);

        expect(dto.id, equals('1'));
        expect(dto.username, equals('johndoe'));
      });
    });
  });
}
