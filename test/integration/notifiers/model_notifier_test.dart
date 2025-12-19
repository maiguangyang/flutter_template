/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-12-19
 */

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/views/application/notifiers/index.dart';
import 'package:flutter_template/views/application/providers/model_provider.dart';
import 'package:flutter_template/views/data/models/index.dart';
import 'package:flutter_template/views/data/repository/model_repository.dart';

/// Mock ModelRepository
class MockModelRepository implements ModelRepository {
  bool shouldFail = false;
  List<ModelEntity> mockModels = [];

  @override
  bool get useMock => true;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  Future<BaseResponse<List<ModelEntity>>?> getModels() async {
    if (shouldFail) throw Exception('Failed');
    return BaseResponse<List<ModelEntity>>()
      ..code = 200
      ..data = mockModels;
  }
}

void main() {
  group('AsyncModelNotifier Tests', () {
    late ProviderContainer container;
    late MockModelRepository mockRepository;

    setUp(() {
      mockRepository = MockModelRepository();
      container = ProviderContainer(
        overrides: [modelRepositoryProvider.overrideWithValue(mockRepository)],
      );
    });

    tearDown(() {
      container.dispose();
    });

    group('build (initial load)', () {
      test('初始化应该自动加载模型列表', () async {
        mockRepository.mockModels = [
          ModelEntity(
            modelName: 'GPT-4',
            type: 'LLM',
            paramsSize: 175000000000,
            size: '800GB',
            status: 'active',
          ),
        ];

        final models = await container.read(asyncModelProvider.future);

        expect(models, hasLength(1));
        expect(models[0].modelName, equals('GPT-4'));
      });

      test('空数据应该返回空列表', () async {
        mockRepository.mockModels = [];

        final models = await container.read(asyncModelProvider.future);

        expect(models, isEmpty);
      });
    });

    group('getModels (refresh)', () {
      test('刷新应该重新加载数据', () async {
        mockRepository.mockModels = [];
        await container.read(asyncModelProvider.future);

        mockRepository.mockModels = [
          ModelEntity(
            modelName: 'New Model',
            type: 'LLM',
            paramsSize: 1000000,
            size: '1GB',
            status: 'active',
          ),
        ];

        final notifier = container.read(asyncModelProvider.notifier);
        await notifier.getModels();

        final state = container.read(asyncModelProvider);
        expect(state.value, hasLength(1));
        expect(state.value![0].modelName, equals('New Model'));
      });

      test('刷新失败应该显示错误', () async {
        mockRepository.mockModels = [];
        await container.read(asyncModelProvider.future);

        mockRepository.shouldFail = true;

        final notifier = container.read(asyncModelProvider.notifier);
        await notifier.getModels();

        final state = container.read(asyncModelProvider);
        expect(state.hasError, isTrue);
      });
    });
  });
}
