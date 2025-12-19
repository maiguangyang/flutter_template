/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-12-19
 */

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/views/data/models/base_response.dart';

void main() {
  group('BaseResponse Tests', () {
    group('creation', () {
      test('应该创建默认的 BaseResponse', () {
        final response = BaseResponse<String>();

        expect(response.code, equals(0));
        expect(response.data, isNull);
        expect(response.msg, equals(''));
        expect(response.success, isFalse);
      });

      test('应该正确设置属性', () {
        final response = BaseResponse<String>()
          ..code = 200
          ..data = 'test data'
          ..msg = 'Success'
          ..success = true;

        expect(response.code, equals(200));
        expect(response.data, equals('test data'));
        expect(response.msg, equals('Success'));
        expect(response.success, isTrue);
      });
    });

    group('toEntity', () {
      test('应该正确转换泛型数据', () {
        final original = BaseResponse<String>()
          ..code = 200
          ..msg = 'Success'
          ..success = true
          ..data = 'original data';

        final converted = original.toEntity<int>(42);

        expect(converted, isA<BaseResponse<int>>());
        expect(converted.code, equals(200));
        expect(converted.msg, equals('Success'));
        expect(converted.success, isTrue);
        expect(converted.data, equals(42));
      });

      test('应该正确转换为 List 类型', () {
        final original = BaseResponse<dynamic>()
          ..code = 200
          ..success = true;

        final converted = original.toEntity<List<String>>(['a', 'b', 'c']);

        expect(converted.data, equals(['a', 'b', 'c']));
      });

      test('应该正确处理 null 数据', () {
        final original = BaseResponse<String>()
          ..code = 200
          ..success = true;

        final converted = original.toEntity<int>(null);

        expect(converted.data, isNull);
      });
    });

    group('generic types', () {
      test('应该支持 List 泛型', () {
        final response = BaseResponse<List<String>>()
          ..code = 200
          ..data = ['item1', 'item2', 'item3']
          ..success = true;

        expect(response.data, hasLength(3));
        expect(response.data![0], equals('item1'));
      });

      test('应该支持 Map 泛型', () {
        final response = BaseResponse<Map<String, dynamic>>()
          ..code = 200
          ..data = {'key': 'value'}
          ..success = true;

        expect(response.data!['key'], equals('value'));
      });

      test('应该支持自定义对象泛型', () {
        final response = BaseResponse<_TestData>()
          ..code = 200
          ..data = _TestData(id: 1, name: 'test')
          ..success = true;

        expect(response.data!.id, equals(1));
        expect(response.data!.name, equals('test'));
      });
    });
  });
}

/// 测试用的数据类
class _TestData {
  final int id;
  final String name;

  _TestData({required this.id, required this.name});
}
