/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-12-19
 */

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/views/data/models/model/model_entity.dart';

void main() {
  group('ModelEntity Tests', () {
    late ModelEntity testModel;

    setUp(() {
      testModel = ModelEntity(
        modelName: 'GPT-4',
        type: 'LLM',
        paramsSize: 175000000000,
        size: '800GB',
        status: 'active',
      );
    });

    group('creation', () {
      test('应该正确创建实体', () {
        expect(testModel.modelName, equals('GPT-4'));
        expect(testModel.type, equals('LLM'));
        expect(testModel.paramsSize, equals(175000000000));
        expect(testModel.size, equals('800GB'));
        expect(testModel.status, equals('active'));
      });
    });

    group('serialization', () {
      test('toJson 应该正确序列化', () {
        final json = testModel.toJson();

        expect(json['modelName'], equals('GPT-4'));
        expect(json['type'], equals('LLM'));
        expect(json['paramsSize'], equals(175000000000));
        expect(json['size'], equals('800GB'));
        expect(json['status'], equals('active'));
      });

      test('fromJson 应该正确反序列化', () {
        final json = {
          'modelName': 'GPT-4',
          'type': 'LLM',
          'paramsSize': 175000000000,
          'size': '800GB',
          'status': 'active',
        };

        final entity = ModelEntity.fromJson(json);

        expect(entity.modelName, equals('GPT-4'));
        expect(entity.type, equals('LLM'));
        expect(entity.paramsSize, equals(175000000000));
      });

      test('序列化往返应该保持数据一致', () {
        final json = testModel.toJson();
        final restored = ModelEntity.fromJson(json);

        expect(restored.modelName, equals(testModel.modelName));
        expect(restored.type, equals(testModel.type));
        expect(restored.paramsSize, equals(testModel.paramsSize));
        expect(restored.size, equals(testModel.size));
        expect(restored.status, equals(testModel.status));
      });
    });

    group('edge cases', () {
      test('paramsSize 为 0 应该正常创建', () {
        final model = ModelEntity(
          modelName: 'Tiny',
          type: 'test',
          paramsSize: 0,
          size: '1KB',
          status: 'inactive',
        );

        expect(model.paramsSize, equals(0));
      });

      test('空字符串字段应该正常创建', () {
        final model = ModelEntity(
          modelName: '',
          type: '',
          paramsSize: 0,
          size: '',
          status: '',
        );

        expect(model.modelName, isEmpty);
        expect(model.type, isEmpty);
      });
    });
  });
}
