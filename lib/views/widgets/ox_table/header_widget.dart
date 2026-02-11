/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-15 19:42:01
 */
import 'package:flutter_template/core/index.dart';

import 'header_cell_widget.dart';
import 'table_column.dart';

class HeaderWidget extends CustomStatelessWidget {
  const HeaderWidget({
    super.key,
    required this.columns,
    required this.rowCount,
    required this.contentBuilder,
    required this.allSelected,
    this.divider = true,
    this.selection = true,
    this.toggleSelectAll,
  });

  /// 列
  final List<TableColumn> columns;

  /// 总行数
  final int rowCount;

  /// 工厂函数
  final Widget Function(BuildContext, Widget Function(BuildContext, int))
  contentBuilder;

  /// 是否显示边框
  final bool divider;

  /// 全选
  final bool allSelected;

  /// 是否可选择
  final bool selection;

  /// 切换全选
  final ValueChanged<bool?>? toggleSelectAll;

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeProvider.select((s) => s.colors));
    final colorScheme = ref.watch(themeProvider.select((s) => s.colorScheme));

    /// 背景色
    final Color bgColor = colorScheme.surface;

    /// 边框颜色
    final borderColor = divider
        ? colors.grey.withValues(alpha: 0.15)
        : Colors.transparent;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: divider
            ? Border(
                left: BorderSide(color: borderColor),
                right: BorderSide(color: borderColor),
                top: BorderSide(color: borderColor),
              )
            : null,
      ),
      child: contentBuilder(context, (context, colIndex) {
        final column = columns[colIndex];

        return column.title == '' && rowCount > 0
            ? Checkbox(
                value: allSelected,
                onChanged: rowCount > 0 ? toggleSelectAll : null,
                activeColor: colors.blue,
                checkColor: colors.white,
                side: BorderSide(color: colors.grey, width: 0.5),
              )
            : HeaderCellWidget(column: column, borderColor: borderColor);
      }),
    );
  }
}
