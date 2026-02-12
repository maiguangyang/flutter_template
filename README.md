<!--
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-01-02 14:21:32
-->

# FlutterTemplate

> Flutter >= 3.35.1 | 多平台（iOS / Android / macOS / Windows / Web）白牌模板项目

## 系统架构

```
UI → Notifier → Repository → ApiService → 后端 API
                    ↕
               Model / Entity
```

项目采用**三层架构**：

| 层级 | 目录 | 职责 |
|------|------|------|
| **Core** | `lib/core/` | 基础设施，不含业务逻辑 |
| **Shared** | `lib/shared/` | 跨 Feature 共享的业务逻辑和数据 |
| **Features** | `lib/features/` | 独立功能模块，按 Feature 隔离 |

## 目录结构

```
assets/                       # 静态资源（图片、字体、jks）
docs/                         # 开发文档
scripts/                      # 构建和辅助脚本
lib/
├── core/                     # 基础设施层
│   ├── abstracts/            # 组件抽象基类（CustomStatelessWidget 等）
│   ├── config/               # 项目配置（多客户端白牌配置）
│   ├── enums/                # 全局枚举
│   ├── errors/               # 异常类和错误映射
│   ├── extensions/           # Dart 扩展方法
│   ├── l10n/                 # 国际化（18 种语言）
│   ├── middleware/           # 路由中间件（authRedirectMiddleware）
│   ├── mixins/               # 通用 Mixin（PaginationMixin）
│   ├── network/              # 网络层（Dio Provider + 拦截器）
│   ├── providers/            # 全局 Provider（Theme、Locale、Lang 等）
│   ├── theme/                # 主题系统（Design Tokens、AppTheme）
│   └── utils/                # 工具类
├── routing/                  # 路由配置
│   ├── route_path.dart       # 路由路径常量定义
│   ├── routes.dart           # FlutterRouter 路由列表（Provider）
│   ├── router.dart           # GoRouter 配置（含 ShellRoute、权限控制）
│   └── navigator_keys.dart   # 全局 NavigatorKey
├── shared/                   # 共享层（跨 Feature）
│   ├── application/          # 共享业务逻辑
│   │   ├── notifiers/        # 状态管理（Auth、User、Menu 等）
│   │   └── providers/        # Provider 注入
│   ├── data/                 # 共享数据层
│   │   ├── models/           # 数据模型（Entity、DTO、Request/Response）
│   │   ├── repositories/     # 仓库（聚合 Service，输出 Entity）
│   │   ├── services/api/     # API 接口调用
│   │   └── mock/             # Mock 数据
│   ├── constants/            # 全局常量（API 地址、缓存 Key）
│   └── widgets/              # 共享组件
│       ├── common/           # 通用组件（OxButton、OxTable、OxPagination）
│       ├── desktop/          # 桌面端组件（导航栏、布局、对话框）
│       └── mobile/           # 移动端组件
├── features/                 # Feature 模块（每个 Feature 结构一致 ↓）
│   ├── home_screen/
│   │   ├── application/      # Feature 专属业务逻辑
│   │   │   ├── notifiers/
│   │   │   └── providers/
│   │   ├── data/             # Feature 专属数据层（按需创建子目录）
│   │   └── ui/               # UI 层
│   │       ├── desktop/      # 桌面端页面
│   │       └── mobile/       # 移动端页面
│   ├── login_screen/
│   ├── model_screen/
│   └── test_screen/
├── app.dart                  # App 根组件（MaterialApp.router）
├── bootstrap.dart            # 启动初始化（ProviderContainer、缓存、重试策略）
└── main.dart                 # 入口（平台初始化、CacheService、GoRouter）
```

## 快速开始

### 安装

```bash
npm install -g @maiguangyang/oxygen_cli
oxygen_cli create myApp

# 或者
npx @maiguangyang/oxygen_cli create myApp
```

### 常用命令

| 命令 | 说明 |
|------|------|
| `make install` | 安装依赖 |
| `make code` | 代码生成（Entity `.g.dart`） |
| `make watch` | 监听文件变化自动生成代码 |
| `make l10n` | 生成多语言文件 |
| `make lang` | 自动翻译 `zh_CN.json` 并生成多语言 |
| `make icon` | 生成字体图标文件 |
| `make config name=xxx` | 切换白牌客户端配置 |
| `make start` | Web 端开发启动（Chrome，端口 1988） |

### 构建命令

| 命令 | 说明 |
|------|------|
| `make mac` | 构建 macOS Release（.dmg） |
| `make apk` | 构建 Android Release（.apk） |
| `make ipa` | 构建 iOS Release（.ipa） |
| `make html` | 构建 Web Release（.tar.xz） |
| `make app` | 一键构建 macOS + iOS + Android |

### 测试命令

| 命令 | 说明 |
|------|------|
| `make test` | 运行单元测试 + 集成测试 |
| `make test_widget` | 运行 Widget 测试 |
| `make test_e2e` | 运行 E2E 测试 |
| `make test_all` | 运行所有测试 |
| `make test_coverage` | 生成覆盖率报告 |
| `make check_tests` | 检查缺少测试的文件 |

## 开发指南

### 新建页面（三步）

1. **定义路径** — `lib/routing/route_path.dart`
```dart
static Route myPage = const Route(name: 'myPage', path: '/my-page');
```

2. **注册路由** — `lib/routing/routes.dart`
```dart
FlutterRouter(
  name: RoutePath.myPage.name,
  path: RoutePath.myPage.path,
  builder: (context, state) => const MyPageScreen(),
),
```

3. **创建 Feature** — `lib/features/my_page_screen/`
```
my_page_screen/
├── application/     # 业务逻辑（按需）
│   ├── notifiers/
│   └── providers/
├── data/            # 数据层（按需）
└── ui/
    ├── desktop/index.dart
    └── mobile/index.dart
```

### 主题使用

```dart
/// 自定义颜色
final colors = ref.watch(themeProvider.select((t) => t.colors));

/// 自定义间距
final spacing = ref.watch(themeProvider.select((t) => t.spacing));

/// 自定义字体
final fontSize = ref.watch(themeProvider.select((t) => t.fontSize));

/// 自定义字体粗细
final fontWeight = ref.watch(themeProvider.select((t) => t.fontWeight));

/// 主题自带颜色方案
final colorScheme = ref.watch(themeProvider.select((t) => t.colorScheme));
```

### 路由跳转

```dart
// 压栈跳转（可后退）
NavigatorUtilsCore.go(RoutePath.myPage);

// 替换跳转（不可后退）
NavigatorUtilsCore.replace(RoutePath.home);

// 带参数跳转
NavigatorUtilsCore.go(
  RoutePath.userDetail,
  pathParameters: {'id': '123'},
);
```

### 国际化

1. 修改 `lib/core/l10n/language.json`
```json
"key": {
  "zh": "",
  "en": "",
  "es": "",
  "zh_TW": ""
}
```

2. 运行 `make l10n`

3. 使用
```dart
ref.lang.homePage
ref.lang.leftQuantity(product.stock)  // 插值语法
```

### Icon 图标

- 上传 svg 到 [iconfont.cn](https://www.iconfont.cn) 项目
- 下载字体文件覆盖 `assets/fonts/*`
- 运行 `make icon`
- 使用：`IconFont.loading`

### 代码片段

在 `.dart` 文件中（参见 `.vscode/dart.code-snippets`）：
- 输入 `sfw`：有状态组件
- 输入 `sw`：无状态组件

## 开发规范

- 所有 Widget 必须在 Class 上方**注释**用途
- 开发时在 `build()` 中打 `log` 检查是否重复渲染
- 当前目录下的文件使用 **相对路径** `import './xxxx.dart'` 而非 `package:` 路径
- 通用组件及时抽成公共组件放入 `shared/widgets/`
- API 地址统一写在 `lib/shared/constants/api_endpoints.dart`
- 多语言写在 `lib/core/l10n/language.json`
- **禁止**直接使用 `Colors.xxx` 和硬编码 `Size`，使用 `ref.themeStore.xxx`
- **禁止**在页面直接写方法/逻辑/模拟数据，统一放 `application/`
- UI 不直接调用 Repository，通过 Notifier 触发
- 页面必须拆分成多个子组件再组装
- 超过 15 位的雪花 ID 统一用 `String` 类型

## 相关文档

- [测试指南](./docs/test.md)
- [Riverpod 使用](./docs/riverpod/riverpod.md)
- [颜色主题](./docs/colors.md)
- [开发流程](./docs/开发流程.md)
- [架构说明](./docs/说明文档.md)
- [概念解析](./docs/概念.md)