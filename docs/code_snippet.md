

下载 vs code 插件 `Flutter Riverpod Snippets` 

输入：
stlessConsumer 生成 ConsumerStateless widget
stfulConsumer 生成 ConsumerStateful widget


将以下文件命名为 dart.json 并放在 .vscode 目录下

输入：
cw 生成 stateful widget
rpw 生成 ConsumerWidget
rpst 生成 ConsumerStatefulWidget


```json
{
  "Controlled Widget": {
    "prefix": "cw",
    "body": [
      "import 'package:flutter/material.dart';",
      "import 'import 'package:white_label/abstracts/widget_view.dart';",
      "",
      "class ${1:name} extends StatefulWidget {",
      "  const ${1:name}({super.key});",
      "",
      "  @override",
      "  State<${1:name}> createState() => _${1:name}Controller();",
      "}",
      "",
      "class _${1:name}Controller extends State<${1:name}> {",
      "  @override",
      "  Widget build(BuildContext context) => _${1:name}View(this);",
      "}",
      "",
      "class _${1:name}View extends WidgetView<${1:name}, _${1:name}Controller> {",
      "  const _${1:name}View(super.state);",
      "",
      "  @override",
      "  Widget build(BuildContext context) {",
      "    return Container($0);",
      "  }",
      "}"
    ],
    "description": ""
  },
  "Riverpod ConsumerWidget": {
    "prefix": "rpw",
    "body": [
      "import 'package:flutter/material.dart';",
      "import 'package:flutter_riverpod/flutter_riverpod.dart';",
      "",
      "class ${1:MyWidget} extends ConsumerWidget {",
      "  const ${1:MyWidget}({super.key});",
      "",
      "  @override",
      "  Widget build(BuildContext context, WidgetRef ref) {",
      "    final ${2:state} = ref.watch(${3:myProvider});",
      "    return ${4:Container}($0);",
      "  }",
      "}"
    ],
    "description": "Riverpod ConsumerWidget 模板"
  },
  "Riverpod Stateful": {
    "prefix": "rpst",
    "body": [
      "import 'package:flutter/material.dart';",
      "import 'package:flutter_riverpod/flutter_riverpod.dart';",
      "",
      "class ${1:MyWidget} extends ConsumerStatefulWidget {",
      "  const ${1:MyWidget}({super.key});",
      "",
      "  @override",
      "${1:MyWidget}State createState() => _${1:MyWidget}State();",
      "",
      "@override\nConsumerState<${1:MyWidget}> createState() => _${1:MyWidget}State();\n}\n\nclass _${1:MyWidget}State extends ConsumerState<${1:MyWidget}> {\n@override\nvoid initState() {\nsuper.initState();\n// Initialize here\n}\n\n@override\nvoid dispose() {\n// Clean up here\nsuper.dispose();\n}\n\n@override\nvoid didChangeDependencies() {\nsuper.didChangeDependencies();\n// Handle dependency changes\n}\n\n@override\nvoid didUpdateWidget(${1:MyWidget} old) {\nsuper.didUpdate(old);\n// Handle widget updates\n}\n"
    ]
  }
}
```