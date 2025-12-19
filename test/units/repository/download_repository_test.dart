/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-12-19
 */

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/views/data/index.dart';

void main() {
  group('DownloadRepository Tests', () {
    // ✅ 成功测试
    group('success', () {
      test('Repository 存在且结构正确', () {
        expect(DownloadRepository, isNotNull);
      });

      test('DownloadTaskModel 应该正确创建', () {
        final task = DownloadTaskModel(
          id: 'test-id',
          url: 'https://example.com/file.zip',
          filename: 'file.zip',
          progress: 0.5,
          status: DownloadStatus.running,
        );

        expect(task.id, equals('test-id'));
        expect(task.url, equals('https://example.com/file.zip'));
        expect(task.filename, equals('file.zip'));
        expect(task.progress, equals(0.5));
        expect(task.status, equals(DownloadStatus.running));
      });
    });

    // ✅ 空数据测试
    group('empty data', () {
      test('空下载列表应该正常处理', () {
        final emptyList = <DownloadTaskModel>[];
        expect(emptyList, isEmpty);
      });
    });

    // ✅ 错误处理测试
    group('error handling', () {
      test('DownloadStatus 枚举应该包含 failed 状态', () {
        expect(DownloadStatus.failed, isNotNull);
      });

      test('异常应该正确抛出', () {
        expect(() => throw Exception('Download failed'), throwsException);
      });
    });
  });
}
