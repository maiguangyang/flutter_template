/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-12-19
 */

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/views/data/models/base_entity.dart';

/// 测试用的 Entity 子类
class TestEntity extends BaseEntity {
  final String id;
  final String name;
  final int age;

  TestEntity({required this.id, required this.name, required this.age});

  @override
  List<Object?> get props => [id, name, age];

  @override
  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'age': age};

  factory TestEntity.fromJson(Map<String, dynamic> json) => TestEntity(
    id: json['id'] as String,
    name: json['name'] as String,
    age: json['age'] as int,
  );
}

void main() {
  group('BaseEntity Tests', () {
    // ✅ 创建测试
    group('creation', () {
      test('应该正确创建 TestEntity', () {
        final entity = TestEntity(id: '1', name: 'John', age: 25);

        expect(entity.id, equals('1'));
        expect(entity.name, equals('John'));
        expect(entity.age, equals(25));
      });

      test('应该正确创建空的 BaseEntity', () {
        final entity = BaseEntity();

        expect(entity, isNotNull);
        expect(entity.props, isEmpty);
      });
    });

    group('equality', () {
      test('相同属性的两个 Entity 应该相等', () {
        final entity1 = TestEntity(id: '1', name: 'John', age: 25);
        final entity2 = TestEntity(id: '1', name: 'John', age: 25);

        expect(entity1, equals(entity2));
        expect(entity1.hashCode, equals(entity2.hashCode));
      });

      test('不同属性的两个 Entity 应该不相等', () {
        final entity1 = TestEntity(id: '1', name: 'John', age: 25);
        final entity2 = TestEntity(id: '2', name: 'Jane', age: 30);

        expect(entity1, isNot(equals(entity2)));
        expect(entity1.hashCode, isNot(equals(entity2.hashCode)));
      });

      test('部分属性不同的 Entity 应该不相等', () {
        final entity1 = TestEntity(id: '1', name: 'John', age: 25);
        final entity2 = TestEntity(id: '1', name: 'John', age: 30);

        expect(entity1, isNot(equals(entity2)));
      });

      test('identical entity 应该相等', () {
        final entity = TestEntity(id: '1', name: 'John', age: 25);

        expect(entity, equals(entity));
      });

      test('不同类型的对象应该不相等', () {
        final entity = TestEntity(id: '1', name: 'John', age: 25);

        expect(entity, isNot(equals('string')));
        expect(entity, isNot(equals(123)));
        expect(entity, isNot(equals(null)));
      });
    });

    group('stringify', () {
      test('stringify 应该返回可读的调试字符串', () {
        final entity = TestEntity(id: '1', name: 'John', age: 25);

        expect(entity.stringify(), contains('TestEntity'));
        expect(entity.stringify(), contains('1'));
        expect(entity.stringify(), contains('John'));
        expect(entity.stringify(), contains('25'));
      });
    });

    group('serialization', () {
      test('toJson 应该正确序列化', () {
        final entity = TestEntity(id: '1', name: 'John', age: 25);
        final json = entity.toJson();

        expect(json['id'], equals('1'));
        expect(json['name'], equals('John'));
        expect(json['age'], equals(25));
      });

      test('fromJson 应该正确反序列化', () {
        final json = {'id': '1', 'name': 'John', 'age': 25};
        final entity = TestEntity.fromJson(json);

        expect(entity.id, equals('1'));
        expect(entity.name, equals('John'));
        expect(entity.age, equals(25));
      });

      test('序列化和反序列化应该保持数据一致', () {
        final original = TestEntity(id: '1', name: 'John', age: 25);
        final json = original.toJson();
        final restored = TestEntity.fromJson(json);

        expect(restored, equals(original));
      });
    });

    group('props', () {
      test('props 应该返回正确的属性列表', () {
        final entity = TestEntity(id: '1', name: 'John', age: 25);

        expect(entity.props, equals(['1', 'John', 25]));
      });

      test('空的 BaseEntity 应该返回空的 props', () {
        final entity = BaseEntity();

        expect(entity.props, isEmpty);
      });
    });

    // ✅ 边界值测试
    group('edge cases', () {
      test('空字符串 id 应该正常创建', () {
        final entity = TestEntity(id: '', name: 'Test', age: 0);

        expect(entity.id, isEmpty);
      });

      test('age 为 0 应该正常创建', () {
        final entity = TestEntity(id: '1', name: 'Baby', age: 0);

        expect(entity.age, equals(0));
      });

      test('空字符串 name 应该正常创建', () {
        final entity = TestEntity(id: '1', name: '', age: 25);

        expect(entity.name, isEmpty);
      });
    });
  });
}
