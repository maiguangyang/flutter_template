import 'package:ellipsized_text/ellipsized_text.dart';
import 'package:flutter_template/abstracts/index.dart';

import 'table_column.dart';

class RowCellWidget extends CustomStatelessWidget {
  const RowCellWidget({
    super.key,
    required this.column,
    required this.row,
    this.borderColor = Colors.transparent,
  });

  /// 列
  final TableColumn column;

  /// 数据
  final Map<String, dynamic> row;

  /// 边框颜色
  final Color borderColor;

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final render = column.render;

    return Container(
      width: column.width > 0 ? column.width : null,
      height: double.infinity,
      alignment: column.align,
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: borderColor)),
      ),
      child: Padding(
        padding: EdgeInsets.all(theme.spacing8),
        child: render != null
            ? render(context, row)
            : row.containsKey(column.label)
            ? EllipsizedText(
                row[column.label].toString(),
                type: EllipsisType.end,
              )
            : Text("error", style: TextStyle(color: theme.red)),
      ),
    );
  }
}
