/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-15 19:59:58
 */
import 'package:sugar_talk/abstracts/index.dart';

import 'row_cell_widget.dart';
import 'table_column.dart';

class RowWidget<T> extends CustomStatelessWidget {
  const RowWidget({
    super.key,
    required this.columns,
    required this.row,
    required this.contentBuilder,
    required this.index,
    required this.selected,
    required this.toggleRowSelection,
    this.divider = true,
    this.rowClickable = true,
    this.selection = true,
  });

  /// 列
  final List<TableColumn> columns;

  /// 行
  final Map<String, dynamic> row;

  /// 工厂函数
  final Widget Function(BuildContext, Widget Function(BuildContext, int))
  contentBuilder;

  /// 行索引
  final int index;

  /// 行选中
  final bool selected;

  /// 切换行选中
  final ValueChanged<int> toggleRowSelection;

  /// 是否显示边框
  final bool divider;

  /// 行点击
  final bool rowClickable;

  /// 是否可选择
  final bool selection;

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    final Color bgColor = selected
        ? theme.blue.withValues(alpha: 0.05)
        : index % 2 == 0
        ? theme.white
        : theme.grey.withValues(alpha: 0.045);

    /// 边框颜色
    final borderColor = divider
        ? theme.grey.withValues(alpha: 0.15)
        : Colors.transparent;

    return GestureDetector(
      onTap: !rowClickable ? null : () => toggleRowSelection(index),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          border: divider
              ? Border(
                  left: BorderSide(color: borderColor),
                  right: BorderSide(color: borderColor),
                  bottom: BorderSide(color: borderColor),
                )
              : Border(
                  bottom: BorderSide(color: theme.grey.withValues(alpha: 0.15)),
                ),
        ),
        child: contentBuilder(context, (context, colIndex) {
          final column = columns[colIndex];
          return column.title == ''
              ? Checkbox(
                  value: selected,
                  activeColor: theme.blue,
                  checkColor: theme.white,
                  side: BorderSide(color: theme.grey, width: 0.5),
                  onChanged: (_) => toggleRowSelection(index),
                )
              : RowCellWidget(
                  column: column,
                  row: row,
                  borderColor: borderColor,
                );
        }),
      ),
    );
  }
}
