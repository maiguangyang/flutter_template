# 测试指南

> 本项目测试框架基于 Flutter Test + Riverpod，覆盖单元测试和集成测试。

## 快速开始

```bash
# 运行所有测试
flutter test

# 运行单元测试
flutter test test/units/

# 运行集成测试
flutter test test/integration/

# 运行单个测试文件
flutter test test/units/models/base_entity_test.dart

# 带覆盖率报告
flutter test --coverage

# 检查是否有文件缺少测试
make check_tests
```

---

## 目录结构

```
test/
├── units/                    # 单元测试
│   ├── models/               # Entity/DTO 测试
│   ├── errors/               # 异常类测试
│   ├── repository/           # Repository 测试
│   └── user/                 # 用户模块测试
├── integration/              # 集成测试
│   ├── notifiers/            # Notifier 状态管理测试
│   └── providers/            # Provider 依赖链测试
└── widgets/                  # Widget 测试
```

---

## 📋 测试用例清单（必须遵循）

> ⚠️ **强制要求**：所有测试必须覆盖以下场景，PR 审核时会检查。

### Entity 测试清单

| # | 场景 | 说明 | 必须 |
|---|------|------|:----:|
| 1 | **创建测试** | 验证所有字段正确初始化 | ✅ |
| 2 | **toJson 序列化** | 验证所有字段正确输出到 JSON | ✅ |
| 3 | **fromJson 反序列化** | 验证从 JSON 正确恢复对象 | ✅ |
| 4 | **序列化往返** | `fromJson(toJson(entity)) == entity` | ✅ |
| 5 | **业务方法** | 测试每个 getter/method 的逻辑 | ✅ |
| 6 | **边界值** | 空字符串、0、null（如果可空） | ✅ |
| 7 | **copyWith** | 验证部分修改后不影响原对象 | 可选 |

### Repository 测试清单

| # | 场景 | 说明 | 必须 |
|---|------|------|:----:|
| 1 | **成功请求** | Mock API 返回正常数据 | ✅ |
| 2 | **空数据** | API 返回空列表或 null | ✅ |
| 3 | **网络错误** | Mock API 抛出异常 | ✅ |
| 4 | **DTO→Entity 转换** | 验证转换逻辑正确 | ✅ |
| 5 | **Mock 模式** | 验证 useMock=true 时的行为 | 可选 |

### Notifier 测试清单

| # | 场景 | 说明 | 必须 |
|---|------|------|:----:|
| 1 | **初始状态** | build() 后的初始值正确 | ✅ |
| 2 | **Loading 状态** | 调用异步方法时显示 loading | ✅ |
| 3 | **成功状态** | 数据加载成功后状态正确 | ✅ |
| 4 | **错误状态** | 请求失败时 hasError=true | ✅ |
| 5 | **刷新/重试** | 再次调用方法应更新状态 | ✅ |
| 6 | **状态转换** | loading → data 或 loading → error | ✅ |

### Provider 测试清单

| # | 场景 | 说明 | 必须 |
|---|------|------|:----:|
| 1 | **创建实例** | Provider 返回正确类型 | ✅ |
| 2 | **依赖链** | Dio → Api → Repository 正确连接 | ✅ |
| 3 | **单例缓存** | 同一 container 返回相同实例 | ✅ |
| 4 | **Override** | 可以成功 override 进行测试 | ✅ |

---

## 📐 测试用例编写规范

### 1. 结构规范

```dart
void main() {
  group('类名 Tests', () {
    // 1️⃣ 声明测试变量
    late UserEntity testUser;
    
    // 2️⃣ setUp 初始化（每个测试前执行）
    setUp(() {
      testUser = UserEntity(...);
    });
    
    // 3️⃣ tearDown 清理（每个测试后执行）
    tearDown(() {
      // 清理资源（如 ProviderContainer.dispose）
    });
    
    // 4️⃣ 按功能分组
    group('creation', () {
      test('应该正确创建实体', () { ... });
    });
    
    group('serialization', () {
      test('toJson 应该正确序列化', () { ... });
      test('fromJson 应该正确反序列化', () { ... });
    });
    
    group('business logic', () {
      test('xxx 方法应该 yyy', () { ... });
    });
    
    group('edge cases', () {
      test('空值应该 xxx', () { ... });
    });
  });
}
```

### 2. 命名规范

| 类型 | 格式 | 示例 |
|------|------|------|
| 文件名 | `{被测类}_test.dart` | `user_entity_test.dart` |
| group | `'{类名} Tests'` | `'UserEntity Tests'` |
| 子group | `'{功能}'` | `'serialization'` |
| test | `'{行为描述}'` | `'应该正确创建实体'` |

### 3. Arrange-Act-Assert 模式

```dart
test('登录成功应该更新用户状态', () async {
  // Arrange - 准备测试数据
  final testUser = UserEntity(id: '1', name: 'Test');
  mockRepository.mockUser = testUser;
  
  // Act - 执行被测行为
  await notifier.login();
  
  // Assert - 验证结果
  expect(state.hasValue, isTrue);
  expect(state.value?.id, equals('1'));
});
```

---

## 🎯 覆盖率标准

| 模块类型 | 最低覆盖率 | 目标覆盖率 |
|----------|:----------:|:----------:|
| Entity/DTO | 90% | 100% |
| Repository | 80% | 90% |
| Notifier | 80% | 90% |
| Provider | 70% | 80% |
| Utils | 80% | 95% |

### 检查覆盖率

```bash
# 生成覆盖率报告
flutter test --coverage

# 查看详细报告（需要安装 lcov）
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

---

## 🧪 测试模板

### Entity 完整测试模板

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/views/data/models/user/user_entity.dart';

void main() {
  group('UserEntity Tests', () {
    late UserEntity testUser;

    setUp(() {
      testUser = UserEntity(
        id: '1',
        name: 'Test User',
        sex: '男',
        age: 25,
        city: '上海',
        email: 'test@example.com',
      );
    });

    // ✅ 1. 创建测试
    group('creation', () {
      test('应该正确创建实体', () {
        expect(testUser.id, equals('1'));
        expect(testUser.name, equals('Test User'));
        expect(testUser.sex, equals('男'));
        expect(testUser.age, equals(25));
        expect(testUser.city, equals('上海'));
        expect(testUser.email, equals('test@example.com'));
      });
    });

    // ✅ 2-4. 序列化测试
    group('serialization', () {
      test('toJson 应该正确序列化', () {
        final json = testUser.toJson();
        expect(json['id'], equals('1'));
        expect(json['name'], equals('Test User'));
        expect(json['email'], equals('test@example.com'));
      });

      test('fromJson 应该正确反序列化', () {
        final json = {
          'id': '1',
          'name': 'Test User',
          'sex': '男',
          'age': 25,
          'city': '上海',
          'email': 'test@example.com',
        };
        final entity = UserEntity.fromJson(json);
        expect(entity.id, equals('1'));
        expect(entity.name, equals('Test User'));
      });

      test('序列化往返应该保持数据一致', () {
        final json = testUser.toJson();
        final restored = UserEntity.fromJson(json);
        // 如果实现了 props，可以直接比较
        expect(restored.id, equals(testUser.id));
        expect(restored.name, equals(testUser.name));
      });
    });

    // ✅ 5. 业务方法测试
    group('business logic', () {
      test('isEmailVerified 当 email 不为空应该返回 true', () {
        expect(testUser.isEmailVerified, isTrue);
      });

      test('isEmailVerified 当 email 为空应该返回 false', () {
        final user = UserEntity(
          id: '2', name: 'Test', sex: '男',
          age: 20, city: '北京', email: '',
        );
        expect(user.isEmailVerified, isFalse);
      });
    });

    // ✅ 6. 边界值测试
    group('edge cases', () {
      test('age 为 0 应该正常创建', () {
        final user = UserEntity(
          id: '1', name: 'Baby', sex: '男',
          age: 0, city: '上海', email: 'test@example.com',
        );
        expect(user.age, equals(0));
      });

      test('name 为空字符串应该正常创建', () {
        final user = UserEntity(
          id: '1', name: '', sex: '男',
          age: 25, city: '上海', email: 'test@example.com',
        );
        expect(user.name, isEmpty);
      });
    });
  });
}
```

### Notifier 完整测试模板

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/views/application/notifiers/index.dart';
import 'package:flutter_template/views/application/providers/user_provider.dart';
import 'package:flutter_template/views/data/models/index.dart';
import 'package:flutter_template/views/data/repository/user_repository.dart';

class MockUserRepository implements UserRepository {
  bool shouldFail = false;
  List<UserEntity> mockUsers = [];

  @override
  bool get useMock => true;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  Future<BaseResponse<List<UserEntity>>?> getUsers() async {
    if (shouldFail) throw Exception('Failed');
    return BaseResponse<List<UserEntity>>()
      ..code = 200
      ..data = mockUsers;
  }
}

void main() {
  group('AsyncUserNotifier Tests', () {
    late ProviderContainer container;
    late MockUserRepository mockRepository;

    setUp(() {
      mockRepository = MockUserRepository();
      container = ProviderContainer(
        overrides: [
          userRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    // ✅ 1. 初始状态
    group('initial state', () {
      test('初始化应该自动加载数据', () async {
        mockRepository.mockUsers = [
          UserEntity(id: '1', name: 'User1', sex: '男', age: 25, city: '上海', email: 'a@b.com'),
        ];
        final users = await container.read(asyncUserProvider.future);
        expect(users, hasLength(1));
      });
    });

    // ✅ 2-3. Loading 和成功状态
    group('success', () {
      test('加载成功应该返回数据', () async {
        mockRepository.mockUsers = [
          UserEntity(id: '1', name: 'User1', sex: '男', age: 25, city: '上海', email: 'a@b.com'),
        ];
        final users = await container.read(asyncUserProvider.future);
        expect(users[0].name, equals('User1'));
      });
    });

    // ✅ 4. 错误状态
    group('error', () {
      test('加载失败应该显示错误状态', () async {
        mockRepository.shouldFail = true;
        
        // 初始加载会失败
        try {
          await container.read(asyncUserProvider.future);
        } catch (e) {
          // 预期会抛出异常
        }
        
        final state = container.read(asyncUserProvider);
        expect(state.hasError, isTrue);
      });
    });

    // ✅ 5. 刷新
    group('refresh', () {
      test('刷新应该重新加载数据', () async {
        mockRepository.mockUsers = [];
        await container.read(asyncUserProvider.future);
        
        mockRepository.mockUsers = [
          UserEntity(id: '1', name: 'New', sex: '男', age: 25, city: '上海', email: 'a@b.com'),
        ];
        
        final notifier = container.read(asyncUserProvider.notifier);
        await notifier.getUsers();
        
        final state = container.read(asyncUserProvider);
        expect(state.value, hasLength(1));
      });
    });

    // ✅ 6. 状态转换
    group('state transitions', () {
      test('应该从 loading 变为 data', () async {
        mockRepository.mockUsers = [
          UserEntity(id: '1', name: 'Test', sex: '男', age: 25, city: '上海', email: 'a@b.com'),
        ];
        
        final states = <AsyncValue<List<UserEntity>>>[];
        container.listen(asyncUserProvider, (_, next) => states.add(next), fireImmediately: true);
        
        await container.read(asyncUserProvider.future);
        
        expect(states.any((s) => s.isLoading), isTrue);
        expect(states.last.hasValue, isTrue);
      });
    });
  });
}
```

---

## ✅ DO / ❌ DON'T

### ✅ DO

- 每个测试独立，使用 `setUp`/`tearDown`
- 使用 `group` 组织相关测试
- Mock 外部依赖（API、Repository）
- 测试边界情况（空值、错误、极值）
- 保持测试简洁，一个测试只验证一件事
- 遵循 Arrange-Act-Assert 模式
- 使用清晰的中文描述测试目的

### ❌ DON'T

- 测试之间共享状态
- 依赖真实网络请求
- 测试实现细节，应该测试行为
- 在测试中使用 `print`
- 忽略 `tearDown` 清理
- 一个 test 内验证多个不相关的行为

---

## 常用 Matcher

```dart
// 基础比较
expect(value, equals(expected));
expect(value, isTrue / isFalse);
expect(value, isNull / isNotNull);
expect(value, isEmpty / isNotEmpty);

// 类型检查
expect(value, isA<SomeType>());

// 集合
expect(list, hasLength(3));
expect(list, contains(item));

// 异步
expect(future, completes);
expect(future, throwsA(isA<Exception>()));

// Riverpod AsyncValue
expect(state.isLoading, isTrue);
expect(state.hasValue, isTrue);
expect(state.hasError, isTrue);
expect(state.value, equals(expected));
```

---

## 当前测试覆盖

| 模块 | 测试数 | 状态 |
|------|--------|------|
| BaseEntity | 12 | ✅ |
| AppException | 13 | ✅ |
| UserEntity/DTO | 9 | ✅ |
| BaseResponse | 8 | ✅ |
| Repository | 3 | ✅ |
| AuthNotifier | 5 | ✅ |
| UserNotifier | 5 | ✅ |
| Provider Chain | 8 | ✅ |
| **Total** | **63** | ✅ |