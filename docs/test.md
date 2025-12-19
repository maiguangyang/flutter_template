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

### Widget 测试清单

| # | 场景 | 说明 | 必须 |
|---|------|------|:----:|
| 1 | **渲染测试** | Widget 正确渲染、显示预期元素 | ✅ |
| 2 | **交互测试** | 点击、输入等交互正常响应 | ✅ |
| 3 | **主题测试** | Light/Dark 主题正确应用 | ✅ |
| 4 | **状态测试** | Loading/Error/Empty 状态正确显示 | ✅ |
| 5 | **布局测试** | 组件布局符合预期 | 可选 |

### E2E 测试清单

| # | 场景 | 说明 | 必须 |
|---|------|------|:----:|
| 1 | **应用启动** | 应用成功启动并显示主页面 | ✅ |
| 2 | **导航流程** | 页面跳转正常工作 | ✅ |
| 3 | **用户交互** | 按钮点击、滚动等响应正常 | ✅ |
| 4 | **关键业务流程** | 登录、主题切换等核心功能 | ✅ |

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
      });
    });

    // ✅ 2-4. 序列化测试
    group('serialization', () {
      test('toJson 应该正确序列化', () {
        final json = testUser.toJson();
        expect(json['id'], equals('1'));
      });

      test('fromJson 应该正确反序列化', () {
        final json = {'id': '1', 'name': 'Test User', ...};
        final entity = UserEntity.fromJson(json);
        expect(entity.id, equals('1'));
      });

      test('序列化往返应该保持数据一致', () {
        final json = testUser.toJson();
        final restored = UserEntity.fromJson(json);
        expect(restored.id, equals(testUser.id));
      });
    });

    // ✅ 5. 业务方法测试
    group('business logic', () {
      test('isEmailVerified 应该正确判断', () {
        expect(testUser.isEmailVerified, isTrue);
      });
    });

    // ✅ 6. 边界值测试
    group('edge cases', () {
      test('age 为 0 应该正常创建', () {
        final user = UserEntity(id: '1', name: 'Baby', ...age: 0...);
        expect(user.age, equals(0));
      });
    });
  });
}
```

### Repository 完整测试模板

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/views/data/models/index.dart';
import 'package:flutter_template/views/data/repository/user_repository.dart';
import 'package:flutter_template/views/data/services/api/user_api_service.dart';

/// Mock ApiService
class MockUserApiService implements UserApiService {
  bool shouldFail = false;
  List<UserResponseDto> mockUsers = [];

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  Future<BaseResponse<List<UserResponseDto>>?> getUserList(request) async {
    if (shouldFail) throw Exception('API Error');
    return BaseResponse<List<UserResponseDto>>()
      ..code = 200
      ..data = mockUsers;
  }
}

void main() {
  group('UserRepository Tests', () {
    late UserRepository repository;
    late MockUserApiService mockApi;

    setUp(() {
      mockApi = MockUserApiService();
      repository = UserRepository(mockApi);
    });

    // ✅ 1. 成功请求
    group('success', () {
      test('应该返回 Entity 列表', () async {
        mockApi.mockUsers = [UserResponseDto(id: '1', username: 'test', ...)];
        final result = await repository.getUsers();
        expect(result!.data, hasLength(1));
      });
    });

    // ✅ 2. 空数据
    group('empty data', () {
      test('空列表应该正常返回', () async {
        mockApi.mockUsers = [];
        final result = await repository.getUsers();
        expect(result!.data, isEmpty);
      });
    });

    // ✅ 3. 错误处理
    group('error handling', () {
      test('API 错误应该抛出异常', () async {
        mockApi.shouldFail = true;
        expect(() => repository.getUsers(), throwsException);
      });
    });

    // ✅ 4. DTO→Entity 转换
    group('DTO conversion', () {
      test('应该正确将 DTO 转换为 Entity', () async {
        mockApi.mockUsers = [UserResponseDto(id: '1', username: 'test', ...)];
        final result = await repository.getUsers();
        expect(result!.data![0], isA<UserEntity>());
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
    return BaseResponse<List<UserEntity>>()..code = 200..data = mockUsers;
  }
}

void main() {
  group('AsyncUserNotifier Tests', () {
    late ProviderContainer container;
    late MockUserRepository mockRepository;

    setUp(() {
      mockRepository = MockUserRepository();
      container = ProviderContainer(
        overrides: [userRepositoryProvider.overrideWithValue(mockRepository)],
      );
    });

    tearDown(() => container.dispose());

    // ✅ 1. 初始状态
    group('initial state', () {
      test('初始化应该自动加载数据', () async {
        mockRepository.mockUsers = [UserEntity(...)];
        final users = await container.read(asyncUserProvider.future);
        expect(users, hasLength(1));
      });
    });

    // ✅ 2-3. 成功状态
    group('success', () {
      test('加载成功应该返回数据', () async {
        mockRepository.mockUsers = [UserEntity(...)];
        final users = await container.read(asyncUserProvider.future);
        expect(users[0].name, equals('User1'));
      });
    });

    // ✅ 4. 错误状态
    group('error', () {
      test('加载失败应该显示错误状态', () async {
        mockRepository.shouldFail = true;
        try { await container.read(asyncUserProvider.future); } catch (_) {}
        final state = container.read(asyncUserProvider);
        expect(state.hasError, isTrue);
      });
    });

    // ✅ 5. 刷新
    group('refresh', () {
      test('刷新应该重新加载数据', () async {
        mockRepository.mockUsers = [];
        await container.read(asyncUserProvider.future);
        mockRepository.mockUsers = [UserEntity(...)];
        await container.read(asyncUserProvider.notifier).getUsers();
        expect(container.read(asyncUserProvider).value, hasLength(1));
      });
    });

    // ✅ 6. 状态转换
    group('state transitions', () {
      test('应该从 loading 变为 data', () async {
        final states = <AsyncValue>[];
        container.listen(asyncUserProvider, (_, next) => states.add(next));
        await container.read(asyncUserProvider.future);
        expect(states.any((s) => s.isLoading), isTrue);
        expect(states.last.hasValue, isTrue);
      });
    });
  });
}
```

### Provider 完整测试模板

```dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/views/application/providers/index.dart';
import 'package:flutter_template/views/data/repository/user_repository.dart';
import 'package:flutter_template/views/data/services/api/user_api_service.dart';

void main() {
  group('Provider Chain Tests', () {
    late ProviderContainer container;
    late Dio testDio;

    setUp(() {
      testDio = Dio(BaseOptions(baseUrl: 'https://test.api.com'));
      container = ProviderContainer(
        overrides: [dioProvider.overrideWithValue(testDio)],
      );
    });

    tearDown(() => container.dispose());

    // ✅ 1. 创建实例
    group('instance creation', () {
      test('Provider 应该返回正确类型', () {
        final repository = container.read(userRepositoryProvider);
        expect(repository, isA<UserRepository>());
      });
    });

    // ✅ 2. 依赖链
    group('dependency chain', () {
      test('Dio → Api → Repository 应该正确连接', () {
        final api = container.read(userApiProvider);
        final repository = container.read(userRepositoryProvider);
        expect(api, isA<UserApiService>());
        expect(repository, isA<UserRepository>());
      });
    });

    // ✅ 3. 单例缓存
    group('singleton', () {
      test('同一 container 应该返回相同实例', () {
        final api1 = container.read(userApiProvider);
        final api2 = container.read(userApiProvider);
        expect(identical(api1, api2), isTrue);
      });
    });

    // ✅ 4. Override
    group('override', () {
      test('应该能成功 override provider', () {
        final mockDio = Dio();
        final container2 = ProviderContainer(
          overrides: [dioProvider.overrideWithValue(mockDio)],
        );
        final dio = container2.read(dioProvider);
        expect(identical(dio, mockDio), isTrue);
        container2.dispose();
      });
    });
  });
}
```

### Widget 完整测试模板

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// 测试辅助函数
Widget createTestableWidget(Widget child, {ThemeData? theme}) {
  return ProviderScope(
    child: MaterialApp(
      theme: theme ?? ThemeData.light(),
      home: Scaffold(body: child),
    ),
  );
}

void main() {
  group('HomeScreen Widget Tests', () {
    // ✅ 1. 渲染测试
    group('rendering', () {
      testWidgets('应该正确渲染页面', (tester) async {
        await tester.pumpWidget(createTestableWidget(
          Column(children: [TextButton(onPressed: () {}, child: Text('按钮'))]),
        ));
        expect(find.text('按钮'), findsOneWidget);
        expect(find.byType(TextButton), findsOneWidget);
      });
    });

    // ✅ 2. 交互测试
    group('interaction', () {
      testWidgets('点击按钮应该触发回调', (tester) async {
        bool pressed = false;
        await tester.pumpWidget(createTestableWidget(
          TextButton(onPressed: () => pressed = true, child: Text('点击')),
        ));
        await tester.tap(find.text('点击'));
        await tester.pump();
        expect(pressed, isTrue);
      });
    });

    // ✅ 3. 主题测试
    group('theming', () {
      testWidgets('应该应用 Dark 主题', (tester) async {
        await tester.pumpWidget(createTestableWidget(
          Builder(builder: (context) {
            expect(Theme.of(context).brightness, Brightness.dark);
            return Container();
          }),
          theme: ThemeData.dark(),
        ));
      });
    });

    // ✅ 4. 状态测试
    group('state', () {
      testWidgets('Loading 状态应该显示加载指示器', (tester) async {
        await tester.pumpWidget(createTestableWidget(
          CircularProgressIndicator(),
        ));
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

      testWidgets('Error 状态应该显示错误信息', (tester) async {
        await tester.pumpWidget(createTestableWidget(Text('发生错误')));
        expect(find.text('发生错误'), findsOneWidget);
      });
    });
  });
}
```

### E2E 完整测试模板

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_template/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App E2E Tests', () {
    // ✅ 1. 应用启动
    testWidgets('应用应该成功启动', (tester) async {
      app.main();
      await tester.pumpAndSettle(Duration(seconds: 3));
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsWidgets);
    });

    // ✅ 2. 导航流程
    testWidgets('应该能够导航到不同页面', (tester) async {
      app.main();
      await tester.pumpAndSettle(Duration(seconds: 3));
      
      final button = find.text('打开测试页');
      if (button.evaluate().isNotEmpty) {
        await tester.tap(button);
        await tester.pumpAndSettle();
        expect(find.byType(Scaffold), findsWidgets);
      }
    });

    // ✅ 3. 用户交互
    testWidgets('按钮点击应该有响应', (tester) async {
      app.main();
      await tester.pumpAndSettle(Duration(seconds: 3));
      
      final buttons = find.byType(TextButton);
      if (buttons.evaluate().isNotEmpty) {
        await tester.tap(buttons.first);
        await tester.pumpAndSettle();
        expect(find.byType(MaterialApp), findsOneWidget);
      }
    });

    // ✅ 4. 关键业务流程 - 主题切换
    testWidgets('主题切换应该正常工作', (tester) async {
      app.main();
      await tester.pumpAndSettle(Duration(seconds: 3));
      
      final themeButton = find.text('切换主题');
      if (themeButton.evaluate().isNotEmpty) {
        await tester.tap(themeButton);
        await tester.pumpAndSettle();
        expect(find.byType(MaterialApp), findsOneWidget);
      }
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

// Widget 测试
expect(find.text('文本'), findsOneWidget);
expect(find.byType(Button), findsNWidgets(3));
expect(find.byKey(Key('key')), findsNothing);
```
