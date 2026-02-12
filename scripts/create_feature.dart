/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2026-02-12 15:22:36
 *
 * Feature 脚手架脚本
 * 用法: dart scripts/create_feature.dart name=home
 * 效果: 在 lib/features/ 下创建 home_screen/ 完整目录结构
 */

import 'dart:io';

import 'params.dart';

void main(List<String> args) {
  final params = Params().get(args);
  final name = params['name'];

  if (name == null || name.isEmpty) {
    print('❌ 请指定 Feature 名称，例如: dart scripts/create_feature.dart name=home');
    exit(1);
  }

  final featureName = '${name}_screen';
  final className = _toPascalCase(name);
  final screenClassName = '${className}Screen';
  final projectName = _getProjectPackageName();

  final basePath = 'lib/features/$featureName';

  // 检查是否已存在
  if (Directory(basePath).existsSync()) {
    print('❌ Feature "$featureName" 已存在！');
    exit(1);
  }

  print('🚀 正在创建 Feature: $featureName ...\n');

  // 创建目录结构
  final dirs = [
    '$basePath/application/notifiers',
    '$basePath/application/providers',
    '$basePath/data/models',
    '$basePath/data/repositories',
    '$basePath/data/services',
    '$basePath/ui/desktop/widgets',
    '$basePath/ui/mobile/widgets',
  ];

  for (final dir in dirs) {
    Directory(dir).createSync(recursive: true);
    print('  📁 $dir');
  }

  // 生成文件
  final files = <String, String>{
    // ── application ──
    '$basePath/application/notifiers/index.dart': '',
    '$basePath/application/providers/index.dart': '',
    '$basePath/application/index.dart': _applicationIndex(),

    // ── data ──
    '$basePath/data/models/index.dart': '',
    '$basePath/data/repositories/index.dart': '',
    '$basePath/data/services/index.dart': '',
    '$basePath/data/index.dart': _dataIndex(),

    // ── ui ──
    '$basePath/ui/index.dart': _uiIndex(projectName, screenClassName),
    '$basePath/ui/desktop/index.dart': _desktopIndex(
      projectName,
      screenClassName,
    ),
    '$basePath/ui/mobile/index.dart': _mobileIndex(
      projectName,
      screenClassName,
    ),
  };

  for (final entry in files.entries) {
    File(entry.key).writeAsStringSync(entry.value);
    print('  📄 ${entry.key}');
  }

  // 追加 export 到 features/index.dart
  _appendFeatureExport(featureName);

  print('\n✅ Feature "$featureName" 创建成功！');
  print('\n📋 后续步骤:');
  print('  1. 在 lib/routing/route_path.dart 定义路由路径');
  print('  2. 在 lib/routing/routes.dart 注册路由');
  print('  3. 开始编写页面逻辑\n');
}

/// 追加 export 到 features/index.dart
void _appendFeatureExport(String featureName) {
  final indexFile = File('lib/features/index.dart');
  final exportLine = "export '$featureName/ui/index.dart';";

  if (indexFile.existsSync()) {
    final content = indexFile.readAsStringSync();
    if (content.contains(exportLine)) return;
    indexFile.writeAsStringSync('$content$exportLine\n');
  } else {
    indexFile.writeAsStringSync('$exportLine\n');
  }

  print('  📄 lib/features/index.dart (已追加 export)');
}

/// 获取项目包名
String _getProjectPackageName() {
  final pubspec = File('pubspec.yaml');
  if (pubspec.existsSync()) {
    final lines = pubspec.readAsLinesSync();
    for (final line in lines) {
      if (line.startsWith('name:')) {
        return line.split(':').last.trim();
      }
    }
  }
  return 'flutter_template';
}

/// snake_case → PascalCase
String _toPascalCase(String input) {
  return input
      .split('_')
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join('');
}

// ══════════════════════════════════════════
// 模板内容
// ══════════════════════════════════════════

String _applicationIndex() => '''export 'notifiers/index.dart';
export 'providers/index.dart';
''';

String _dataIndex() => '''export 'models/index.dart';
export 'repositories/index.dart';
export 'services/index.dart';
''';

String _uiIndex(String pkg, String cls) =>
    """import 'package:$pkg/core/index.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'desktop/index.dart';
import 'mobile/index.dart';

class $cls extends CustomStatelessWidget {
  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => MobileScreen(),
      desktop: (BuildContext context) => DesktopScreen(),
      tablet: (BuildContext context) => MobileScreen(),
    );
  }
}
""";

String _desktopIndex(String pkg, String cls) =>
    """import 'package:$pkg/core/index.dart';

/// 入口层
class DesktopScreen extends CustomStatefulWidget {
  const DesktopScreen({super.key});

  @override
  CustomState<DesktopScreen> createState() => _DesktopScreenState();
}

/// 逻辑层
class _DesktopScreenState extends CustomState<DesktopScreen> {
  @override
  Widget build(BuildContext context) => _DesktopScreenView(this);
}

/// UI层
class _DesktopScreenView
    extends CustomStatefulView<DesktopScreen, _DesktopScreenState> {
  const _DesktopScreenView(super.state);

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Text('$cls Desktop'),
      ),
    );
  }
}
""";

String _mobileIndex(String pkg, String cls) =>
    """import 'package:$pkg/core/index.dart';

/// 入口层
class MobileScreen extends CustomStatefulWidget {
  const MobileScreen({super.key});

  @override
  CustomState<MobileScreen> createState() => _MobileScreenState();
}

/// 逻辑层
class _MobileScreenState extends CustomState<MobileScreen> {
  @override
  Widget build(BuildContext context) => _MobileScreenView(this);
}

/// UI层
class _MobileScreenView
    extends CustomStatefulView<MobileScreen, _MobileScreenState> {
  const _MobileScreenView(super.state);

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Text('$cls Mobile'),
      ),
    );
  }
}
""";
