/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-03 10:47:44
 */
import 'package:flutter_template/core/index.dart';
import 'package:flutter_template/shared/index.dart';

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
                      debugPrint("user-2 $user");
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
                debugPrint("当前页: $page, 每页: $size");
              },
            ),
          ),
        ),
      ),
    );
  }
}
