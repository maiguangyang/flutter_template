/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-18 07:08:32
 */
import 'package:flutter_template/core/index.dart';
import 'package:flutter_template/shared/index.dart';

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
    final spacing = ref.watch(themeProvider.select((s) => s.spacing));
    final colors = ref.watch(themeProvider.select((s) => s.colors));
    final fontWeight = ref.watch(themeProvider.select((s) => s.fontWeight));

    return Container(
      width: column.width > 0 ? width : null,
      alignment: column.align,
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: borderColor)),
      ),
      child: Padding(
        padding: EdgeInsets.all(spacing.s8),
        child: column.title == null
            ? SizedBox.shrink()
            : Text(
                column.title!,
                style: TextStyle(
                  color: colors.black.withValues(alpha: 0.9),
                  fontWeight: fontWeight.bold,
                ),
              ),
      ),
    );
  }
}
