# WhatsAi 项目宪法 (Project Constitution)

> **指令说明**：本文件是 WhatsAi 项目的最高构建准则。作为 AI 助手，在生成代码、重构或解释逻辑时，**必须**同时遵守架构分层原则、Snippet 模板结构以及详细的代码规范。

## 0. 全局上下文 (Context & Imports)

在生成代码前，请默认假设项目具有以下基础路径别名和配置：

- **基础框架类** (`CustomStatefulWidget` 等): `import 'package:whats_ai/abstracts/index.dart';`
- **通用库**: `import 'package:whats_ai/common/index.dart';` (含 `BaseResponse`, `ApiEndpoints`)
- **数据层**: `import 'package:whats_ai/views/data/index.dart';`
- **主题与多语言**: `import 'package:whats_ai/core/theme/theme_provider.dart';` 及 `import 'package:whats_ai/common/l10n/l10n_extension.dart';`

---

## I. 核心架构原则 (Layered Architecture)

### 1. 数据流向
严格执行单向依赖，禁止跨层反向调用：

```mermaid
graph TD
    UI[UI层 (views/pages)] -->|监听状态/触发意图| Notifier[业务逻辑层 (Application)]
    Notifier -->|调用| Repo[仓储层 (Data/Repository)]
    Repo -->|调用| Service[服务层 (API/DB/Storage)]
```

### 2. 职责边界
- **UI 层**: 严禁包含业务逻辑。只负责 `build`，通过 `ref.read(provider.notifier).method()` 触发逻辑。
- **Notifier**: 纯状态管理。**UI 逻辑（如 SnackBar, Dialog）** 需通过状态回调或副作用处理，不能直接写在 Notifier 中。
- **Repository**: 数据聚合者。负责判断 `useMock`，负责 `DTO -> Entity` 转换，负责调用 API。
- **Service**: 纯粹的数据通道（Dio/Hive）。

---

## II. UI 组件开发模式 (Component Patterns)

根据组件复杂度，**严格区分**两种开发模式。AI 需根据需求判断使用哪一种 Snippet 逻辑。

### 模式 A：无状态/简单组件 (Lightweight)
*   **适用场景**: 纯展示组件、通用原子组件 (`widgets/`)、无生命周期依赖的组件。
*   **对应 Snippet**: `sw` (CustomStatelessWidget)
*   **结构**: **二层结构** (Class -> buildView)

```dart
// 1. 定义类
class MyWidget extends CustomStatelessWidget {
  const MyWidget({super.key});
  // 2. 渲染层 (覆盖 buildView)
  @override
  Widget buildView(BuildContext context, WidgetRef ref) => Container(...);
}
```

### 模式 B：页面/复杂组件 (Tri-Layer Architecture)
*   **适用场景**: 所有路由页面 (`screens/`)、含生命周期 (`initState/dispose`) 的组件。
*   **对应 Snippet**: `sfw` (CustomStatefulWidget)
*   **结构**: **三层分离结构** (Entry -> Logic -> View)

```dart
// 1. 入口层 (Entry): 参数定义
class MyScreen extends CustomStatefulWidget {
  const MyScreen({super.key});
  @override
  CustomState<MyScreen> createState() => _MyScreenState();
}

// 2. 逻辑层 (Logic): 生命周期、状态初始化
class _MyScreenState extends CustomState<MyScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(myNotifierProvider.notifier).initData();
  }
  @override
  Widget build(BuildContext context) => _MyScreenView(this);
}

// 3. UI层 (View): 纯渲染，持有 State 引用
class _MyScreenView extends CustomStatefulView<MyScreen, _MyScreenState> {
  const _MyScreenView(super.state); // 必须透传 state
  @override
  Widget buildView(BuildContext context, WidgetRef ref) { ... }
}
```

---

## III. 目录与命名规范 (Directory & Naming)

### 1. 目录结构树
```text
lib/
├── views/
│   ├── pages/
│   │   ├── mobile/          # 移动端页面 {platform}
│   │   │   ├── routes.dart
│   │   │   └── screens/
│   │   │       └── home_screen/         # 页面文件夹 (snake_case)
│   │   │           ├── home_screen.dart # 入口文件 (使用 sfw)
│   │   │           └── widgets/         # 页面独有组件 (使用 sw)
│   │   │               └── home_header_widget.dart
│   │   └── desktop/
│   ├── widgets/             # 全局通用组件 (Ox前缀)
│   ├── application/         # Notifiers & Providers
│   └── data/                # Repository, APIs, DTOs
```

### 2. 命名规则
- **页面入口文件**: `{name}_screen.dart` / 类名 `{Name}Screen`
- **子组件文件**: `{name}_widget.dart` / 类名 `{Name}Widget`
- **全局组件**: `ox_{name}.dart` / 类名 `Ox{Name}`

---

## IV. 状态与数据层规范 (State & Data)

### 1. Notifier 模板选择
根据业务场景选择对应的 Snippet：

| 场景 | 模板 | Snippet | 说明 |
|:---|:---|:---|:---|
| **详情/全局配置** | `AsyncNotifier` | `ntf` | `@Riverpod(keepAlive: true)`，单数据流。 |
| **分页列表** | `PaginatedNotifier` | `ntfp` | `@riverpod` (autoDispose)，混入 `PaginationMixin`，提供 `loadMore/refresh`。 |

### 2. Repository 规范 (`rep`)
- **Mock 控制**: 必须包含 `final bool useMock` 字段。
- **数据转换**: 必须在 Repository 层完成 `DTO` (网络层对象) 到 `Entity` (业务层对象) 的转换。
- **返回类型**: `Future<BaseResponse<List<Entity>>?>`。

### 3. Provider 规范 (`prd`)
- **缓存策略**: 必须使用 `CacheStrategy` 包装 Entity。
- **依赖注入**: Repository 必须通过 `Provider` 注入 API 和 Cache。

#### CacheStrategy 使用指南 (CacheStrategy Guide)

**1. CacheStrategy (Unified Entry)**

统一的缓存入口，支持三种模式：

| 模式 | 说明 | 重启后 |
|------|------|--------|
| `CacheMode.memory` | 纯内存 LRU | 数据丢失 |
| `CacheMode.persistent` | 仅磁盘 | 数据保留 |
| `CacheMode.hybrid` | 内存 + 磁盘 | 数据保留 ✅ |

**基本用法**:

```dart
import 'package:whats_ai/common/index.dart';

// 创建缓存（自动注册到 CacheRegistry）
final userCache = CacheStrategy<UserEntity>(
  mode: CacheMode.hybrid,
  cacheKey: 'user_cache',
  maxSize: 100,
  expiration: Duration(hours: 1),
  fromJson: UserEntity.fromJson,
  toJson: (e) => e.toJson(),
);

// 初始化
await userCache.init();

// 存取
await userCache.put('user_1', user);
final user = userCache.get('user_1');

// 清理过期
await userCache.cleanExpired();
```

**2. CacheRegistry (Unified Management)**

所有 `CacheStrategy` 默认自动注册，可统一管理：

```dart
// App 启动时（在 bootstrap.dart 中）
await CacheRegistry.initAll();       // 初始化所有缓存
await CacheRegistry.cleanExpiredAll(); // 清理所有过期数据

// 查看已注册的缓存
print(CacheRegistry.registeredKeys);

// 清空所有缓存
await CacheRegistry.clearAll();
```

---

## V. 代码红线 (Strict Code Standards)

### 禁止事项 (Don't)
- ❌ **禁止**直接使用 `Colors.xxx` -> ✅ 使用 `ref.watch(themeProvider).colors.primary`
- ❌ **禁止**硬编码尺寸/文本 -> ✅ 使用 `ref.theme.spacing` / `ref.lang`
- ❌ **禁止**在 UI 层 (`buildView`) 直接调用 API 或写 `try-catch`。
- ❌ **禁止**使用 `FutureProvider` 进行写操作（增删改）。

### 必须事项 (Do)
- ✅ **数据模型**: 所有 Entity/DTO 必须使用 `json_annotation` 生成，禁止手写 `fromJson`。
- ✅ **导出规范**: 严禁隐藏文件。所有目录下的文件（如 `abc.dart`）必须在同级 `index.dart` 中导出 (`export 'abc.dart';`)，外部调用必须通过目录级 `index.dart` 引用。
- ✅ **依赖管理**: 项目中禁止使用 `freezed` 及其相关依赖（`freezed_annotation`, `build_runner` 不受限，但不得运行 freezed 生成器）。
- ✅ **ID 类型**: 超过 15 位的 ID 或所有业务 ID 必须使用 `String` 类型。
- ✅ **注释**: 核心类和方法必须有文档注释。
- ✅ **Import**: 禁止使用相对路径导入上级目录。**同级目录下的文件引用必须使用相对路径**，禁止使用 `package:` 全路径导入同级文件。

---

## VI. 测试规范 (Test-First)

- **Entity**: 100% 覆盖率 (测试 JSON 序列化/反序列化)。
- **Repository**: 测试 `useMock=true` 的情况以及 API 异常映射。
- **Notifier**:
    - 测试初始状态 (Loading)。
    - 测试数据获取成功 (Data)。
    - 测试分页逻辑 (`loadMore` 是否追加数据)。

---

## VII. 开发工作流 (Development Workflow)

### 1. VSCode Snippets 映射
AI 应根据指令意图选择以下模板：
- `sw` : 无状态原子组件 (Stateless)
- `sfw` : **所有页面 (Screen)** 及复杂组件 (Stateful - 3层分离)
- `ntf` : 标准状态管理 (AsyncNotifier)
- `ntfp`: 分页列表状态 (PaginationMixin)
- `rep` : 仓储层 (含 Mock/DTO转换)
- `prd` : 依赖注入 (含 CacheStrategy)

### 2. 常用 Make 命令
```bash
make l10n    # 生成多语言
make code    # 运行 build_runner 生成 .g.dart / .freezed.dart
make check_tests # 检查覆盖率
```

---

## VIII. 治理 (Governance)

1. **Constitutional Primacy**: 此文档优于任何口头约定。
2. **Review Gate**: 不符合本规范的代码（如直接在 UI 写逻辑、未用 Freezed、页面未使用三层分离）将被拒绝。

## IX. 计划合规性检查 (Plan Compliance Checklist)

所有 Implementation Plan (`plan.md`) **必须**包含以下检查表，AI 需在生成计划时逐项自检：

| 维度 | 检查项 (Checkpoints) | Pass? |
|------|----------------------|-------|
| **Interfaces** | Repository 是否返回 `Future<BaseResponse<T>>`？是否包含 `useMock`？ | [ ] |
| **Providers** | Provider 是否使用了 `CacheStrategy` 包装 Entity？ | [ ] |
| **Snippets** | 是否为每个新文件指定了正确的 Snippet (`sw/sfw/ntf/rep/prd`)？ | [ ] |
| **Data Flow** | 是否明确 Repository 负责 `DTO -> Entity` 转换？ | [ ] |
| **UI Rules** | 是否明确禁止硬编码颜色/尺寸，强制使用 `ref.theme`？ | [ ] |
| **Testing** | 计划中是否明确包含 Entity(100%) 和 Repository(80%) 测试？ | [ ] |

**Version**: 1.0.1 | **Ratified**: 2026-01-22 | **Last Amended**: 2026-01-22
