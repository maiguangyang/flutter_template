<!--
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-01-02 14:21:32
-->

# SugarTalk

## 该项目使用 flutter >= 3.35.1 版本开发，后面有变化这里会更新，再通知大家

## 每个月第 4 周对 flutter sdk 和 package 包版本进行一次升级

## 谨记：UI 不直接调用 Repository 的方法，而是通过 Notifier 触发动作，并读取状态

### 目录结构

```
assets/                   # 静态文件
lib/
|-- abstracts             # 抽象类：很少用，目前就用在代码片段
|-- config                # 配置文件
|-- common                  # 核心文件夹
    |-- constants         # 常量
    |-- enums             # 枚举
    |-- errors            # 枚举
    |-- l10n              # 国际化配置
    |-- providers         # 全局providers
    |-- services          # 全局services
    |-- utils             # 工具类
    |-- extensions        # 扩展
    |-- middleware        # 中间件
|-- router                # 路由配置
|-- theme                 # 模板配置
|-- views/                # 表示层
    |-- application       # 应用层（Notifiers, Providers）
      |-- notifiers       # 管理 可变状态
      |-- providers       # 提供 不可变、可复用的数据或依赖
    |-- data              #  数据层（Repository, API, Model）
    |-- pages             # 屏幕/页面
    |-- widgets           # 可复用的UI组件
|-- app.dart              # App 根组件
|-- bootstrap.dart        # 启动初始化逻辑 (依赖注入, 全局配置等)
|-- main.dart             # 入口文件

```

### TODO 统一查漏补缺进行修改

- 页面组件（`pages -> mobile -> screens`）：以首页举例
  1. 入口文件统一命名：`home_screen/home_screen.dart`
  2. 子组件放在`widgets`，文件名、对外暴露统一带`widget`，例如：`category_widget.dart`、`CategoryWidget`
- 项目组件：`pages -> mobile -> widgets`，对外暴露的组件名不带`widget`，其子组件文件名、对外暴露统一带`widget`
- 全局组件：`pages -> widgets`，以`ox_xxxx`文件夹形式命名，对外暴露组件名为：`OxXxxx`，其子组件文件名、对外暴露统一带`widget`

### 开发

- 写一个组件，先看看官方的组件是否有合适：https://docs.flutter.cn/reference/widgets
- git clone 代码后先去`pubspec.yaml`注释掉`flutter_oxygen`
- 然后执行：`make init`拉取子模块，`make install`重新拉取子模块
- 修改实体层（entitys）后，执行代码生成命令：`make code`
- 修改`lib/core/l10n/language.json`后，执行命令生成多语言：`make l10n`

- 测试 [常用断言类型](./docs/test.md)

### Icon 图标

- `https://www.iconfont.cn`，上传 svg 文件到 White Label 项目。
- 下载最新的字体文件，覆盖替换`assets/fonts/*`，执行命令生成字体文件：`make icon`
- 使用：`IconFont.loading`

### 国际化

#### 添加项目多语言

1. 修改 `/lib/core/l10n/language.json`

```json
"key": {
  "zh": "",
  "en": "",
  "es": "",
  "zh_TW": ""
}

// 插值语法：
// "en": "{qty} Left",
```

1. 运行 `make l10n` 命令
   
2. 在代码中使用

```dart
appBar: AppBar(
  title: Text(ref.lang.homePage),
),

/// 插值语法
ref.lang.leftQuantity(product.stock)
```

### 代码片段（在`.dart` 文件中）
- ，输入 `sfw`： 有状态组件
- ，输入 `sw`： 无状态组件

### 开发规范
- 所有`Widget`都要在`Class`上面一行注释是做什么的
- 开发的时候最好在`Widget build(BuildContext context)`里面打一个`log`，看看是否重复渲染
- 如果是当前目录下的，不要使用`package`包方式引入，使用：`import './xxxx.dart';`
- 开发的时候遇到其他页面可能也用到的基础功能组件，记得抽成一个公共组件，例如：`button`

---

- `api`地址统一写在`lib/core/constants/api_endpoints.dart`
- 记得写多语言：`lib/core/l10n/language.json`
- 禁止直接使用`Colors.xxx` 和 `Size`
- 颜色、字体相关这样使用：`ref.themeStore.xxx`，具体可以去看：`lib/core/providers/theme_provider.dart`
- 禁止直接在页面里面写方法、逻辑、模拟数据，统一放`application`
- UI 不直接调用 Repository 的方法，而是通过 Notifier 触发动作，并读取状态
- 一个页面一定要拆分成多个页面子组件来写，最后再组装起来，这样的好处就是页面里面的代码不会太长，可维护性也大大增强
- 超过 15 位的雪花 ID，在 web 下都有可能出现精度问题，所以目前 ID 统一用 string 类型