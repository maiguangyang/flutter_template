/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-26 08:42:07
 */
import 'package:ellipsized_text/ellipsized_text.dart';
import 'package:flutter_template/core/index.dart';

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
    final spacing = ref.watch(themeProvider.select((s) => s.spacing));
    final colors = ref.watch(themeProvider.select((s) => s.colors));
    final render = column.render;

    return Container(
      width: column.width > 0 ? column.width : null,
      height: double.infinity,
      alignment: column.align,
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: borderColor)),
      ),
      child: Padding(
        padding: EdgeInsets.all(spacing.s8),
        child: render != null
            ? render(context, row)
            : row.containsKey(column.label)
            ? EllipsizedText(
                row[column.label].toString(),
                type: EllipsisType.end,
              )
            : Text("error", style: TextStyle(color: colors.red)),
      ),
    );
  }
}
