/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-18 07:08:32
 */
import 'package:sugar_talk/abstracts/index.dart';

import 'table_column.dart';

class HeaderCellWidget extends CustomStatelessWidget {
  const HeaderCellWidget({
    super.key,
    required this.column,
    this.width,
    this.borderColor = Colors.transparent,
  });

  /// 列
  final TableColumn column;

  /// 列宽
  final double? width;

  /// 边框颜色
  final Color borderColor;

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    return Container(
      width: column.width > 0 ? width : null,
      alignment: column.align,
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: borderColor)),
      ),
      child: Padding(
        padding: EdgeInsets.all(theme.spacing8),
        child: column.title == null
            ? SizedBox.shrink()
            : Text(
                column.title!,
                style: TextStyle(
                  color: theme.black.withValues(alpha: 0.9),
                  fontWeight: theme.fontWeightBold,
                ),
              ),
      ),
    );
  }
}
