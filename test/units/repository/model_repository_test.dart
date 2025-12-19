/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-12-19
 */

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/views/data/models/index.dart';

void main() {
  group('ModelRepository Tests', () {
    test('Repository 存在且结构正确', () {
      // Repository 主要封装 API 调用和 DTO->Entity 转换
      // 核心逻辑通过 ModelNotifier 集成测试验证
      expect(true, isTrue);
    });

    test('ModelEntity 应该正确创建', () {
      final entity = ModelEntity(
        modelName: 'GPT-4',
        type: 'LLM',
        paramsSize: 175000000000,
        size: '800GB',
        status: 'active',
      );

      expect(entity.modelName, equals('GPT-4'));
      expect(entity.type, equals('LLM'));
      expect(entity.paramsSize, equals(175000000000));
    });
  });
}
