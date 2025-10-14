/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-04 15:27:54
 */
import 'package:flutter_template/abstracts/index.dart';
import 'package:flutter_template/views/data/models/index.dart';

class MenuItemIconWidget extends CustomStatelessWidget {
  const MenuItemIconWidget({
    super.key,
    required this.item,
    this.isHovered = false,
  });

  final MenuEntity item;
  final bool isHovered;

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    // 如果有图标，显示图标；否则显示首字母
    if (item.icon != null) {
      return Icon(
        item.icon,
        color: item.iconColor != null
            ? item.iconColor
            : isHovered
            ? theme.primary
            : theme.grey.withValues(alpha: 0.65),
      );
    }

    // 使用标签首字母
    String label = item.label;
    String firstLetter = label.isNotEmpty
        ? label.substring(0, 1).toUpperCase()
        : '?';

    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: isHovered
            ? theme.primary.withValues(alpha: 0.1)
            : theme.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          firstLetter,
          style: TextStyle(
            color: isHovered
                ? theme.primary
                : theme.grey.withValues(alpha: 0.65),
            fontSize: theme.fontSize12,
            fontWeight: theme.fontWeightBold,
          ),
        ),
      ),
    );
  }
}
