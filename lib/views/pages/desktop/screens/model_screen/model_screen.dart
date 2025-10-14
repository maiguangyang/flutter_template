/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-03 10:47:44
 */
import 'package:sugar_talk/abstracts/index.dart';
import 'package:sugar_talk/views/application/index.dart';
import 'package:sugar_talk/views/data/models/index.dart';
import 'package:sugar_talk/views/pages/desktop/widgets/index.dart';
import 'package:sugar_talk/views/widgets/index.dart';
import 'package:sugar_talk/views/widgets/ox_table/table_column.dart';

/// 入口层
class ModelScreen extends CustomStatefulWidget {
  const ModelScreen({super.key});

  @override
  CustomState<ModelScreen> createState() => _ModelScreenState();
}

/// 逻辑层
class _ModelScreenState extends CustomState<ModelScreen> {
  @override
  Widget build(BuildContext context) => _ModelScreenView(this);
}

/// UI层
class _ModelScreenView
    extends CustomStatefulView<ModelScreen, _ModelScreenState> {
  const _ModelScreenView(super.state);

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final models = ref.watch(asyncModelProvider);

    final lang = ref.lang;

    return Scaffold(
      appBar: AppHeaderBar(
        showBack: false,
        title: Text(lang.model),
        divider: true,
      ),
      body: ModelSubMenuLayout(
        child: Padding(
          padding: EdgeInsetsGeometry.all(10),
          child: OxTable<ModelEntity>(
            dataSource: models,
            provider: asyncModelProvider,
            columns: [
              TableColumn(
                title: lang.modelName,
                label: "modelName",
                width: 200,
              ),
              TableColumn(title: lang.type, label: "type", width: 200),
              TableColumn(
                title: lang.paramsSize,
                label: "paramsSize",
                width: 150,
              ),
              TableColumn(title: lang.size, label: "size"),
              TableColumn(title: lang.status, label: "status"),
              TableColumn(
                title: lang.action,
                width: 100,
                render: (context, data) {
                  final user = ModelEntity.fromJson(data);

                  return TextButton(
                    onPressed: () {
                      print("user-2 $user");
                    },
                    child: Text("Delete", style: TextStyle(color: Colors.red)),
                  );
                },
              ),
            ],

            pagination: OxPagination(
              total: 200,
              showSizeChanger: true,
              onPageChanged: (page, size) {
                print("当前页: $page, 每页: $size");
              },
            ),
          ),
        ),
      ),
    );
  }
}
