/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-12-19
 */

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/common/errors/app_exception.dart';

void main() {
  group('AppException Tests', () {
    group('AppException', () {
      test('应该正确创建基础异常', () {
        final exception = AppException('Test error', code: 'E001');

        expect(exception.message, equals('Test error'));
        expect(exception.code, equals('E001'));
        expect(exception.original, isNull);
      });

      test('应该支持包装原始异常', () {
        final original = Exception('Original error');
        final exception = AppException(
          'Wrapped error',
          code: 'E002',
          original: original,
        );

        expect(exception.original, equals(original));
      });

      test('toString 应该包含 code 和 message', () {
        final exception = AppException('Test error', code: 'E001');

        expect(exception.toString(), contains('E001'));
        expect(exception.toString(), contains('Test error'));
      });
    });

    group('NetworkException', () {
      test('应该正确创建网络异常', () {
        final exception = NetworkException('网络连接超时', code: 'NET001');

        expect(exception.message, equals('网络连接超时'));
        expect(exception.code, equals('NET001'));
        expect(exception, isA<AppException>());
      });
    });

    group('AuthException', () {
      test('应该正确创建认证异常', () {
        final exception = AuthException('Token 已过期', code: '401');

        expect(exception.message, equals('Token 已过期'));
        expect(exception.code, equals('401'));
        expect(exception, isA<AppException>());
      });
    });

    group('ServerException', () {
      test('应该正确创建服务端异常', () {
        final exception = ServerException('服务器内部错误', code: '500');

        expect(exception.message, equals('服务器内部错误'));
        expect(exception.code, equals('500'));
        expect(exception, isA<AppException>());
      });
    });

    group('ValidationException', () {
      test('应该正确创建验证异常', () {
        final exception = ValidationException(
          '表单验证失败',
          code: 'VAL001',
          fieldErrors: {'email': '邮箱格式不正确', 'password': '密码长度不足'},
        );

        expect(exception.message, equals('表单验证失败'));
        expect(exception.code, equals('VAL001'));
        expect(exception.fieldErrors, isNotNull);
        expect(exception.fieldErrors!['email'], equals('邮箱格式不正确'));
        expect(exception, isA<AppException>());
      });

      test('toString 应该包含字段错误信息', () {
        final exception = ValidationException(
          '表单验证失败',
          fieldErrors: {'email': '邮箱格式不正确'},
        );

        expect(exception.toString(), contains('email'));
        expect(exception.toString(), contains('邮箱格式不正确'));
      });

      test('无字段错误时 toString 不应包含 fields', () {
        final exception = ValidationException('表单验证失败');

        expect(exception.toString(), contains('表单验证失败'));
        expect(exception.fieldErrors, isNull);
      });
    });

    group('BusinessException', () {
      test('应该正确创建业务异常', () {
        final exception = BusinessException('余额不足', code: 'BIZ001');

        expect(exception.message, equals('余额不足'));
        expect(exception.code, equals('BIZ001'));
        expect(exception, isA<AppException>());
      });
    });

    group('CacheException', () {
      test('应该正确创建缓存异常', () {
        final exception = CacheException('缓存读取失败', code: 'CACHE001');

        expect(exception.message, equals('缓存读取失败'));
        expect(exception.code, equals('CACHE001'));
        expect(exception, isA<AppException>());
      });
    });

    group('异常继承关系', () {
      test('所有异常应该都是 Exception', () {
        expect(AppException('test'), isA<Exception>());
        expect(NetworkException('test'), isA<Exception>());
        expect(AuthException('test'), isA<Exception>());
        expect(ServerException('test'), isA<Exception>());
        expect(ValidationException('test'), isA<Exception>());
        expect(BusinessException('test'), isA<Exception>());
        expect(CacheException('test'), isA<Exception>());
      });

      test('所有子类异常应该都是 AppException', () {
        expect(NetworkException('test'), isA<AppException>());
        expect(AuthException('test'), isA<AppException>());
        expect(ServerException('test'), isA<AppException>());
        expect(ValidationException('test'), isA<AppException>());
        expect(BusinessException('test'), isA<AppException>());
        expect(CacheException('test'), isA<AppException>());
      });
    });
  });
}
