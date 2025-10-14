/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-04 15:27:03
 */
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:sugar_talk/abstracts/index.dart';
import 'package:sugar_talk/views/data/models/index.dart';

import 'menu_item_icon_widget.dart';

class MenuItemChildWidget extends CustomStatelessWidget {
  const MenuItemChildWidget({
    super.key,
    required this.item,
    required this.isHovered,
  });

  final MenuEntity item;
  final bool isHovered;

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        !item.hasBadgeCount
            ? MenuItemIconWidget(item: item, isHovered: isHovered)
            : Badge(
                label: item.badgeCount.isNotNullAndZero && item.badgeCount! > 99
                    ? Text("99+")
                    : item.badgeCount.isNotNullAndZero
                    ? AnimatedFlipCounter(value: item.badgeCount!)
                    : null,
                backgroundColor: item.hasBadgeCount ? theme.errorColor : null,
                textColor: item.hasBadgeCount ? theme.white : null,
                largeSize: theme.fontSize12,
                offset: Offset(2, -6),
                child: MenuItemIconWidget(item: item, isHovered: isHovered),
              ),

        if (!item.isHideLabel) SizedBox(height: theme.spacing4),
        if (!item.isHideLabel)
          Text(
            item.label,
            style: TextStyle(
              fontSize: theme.fontSize10,
              color: isHovered ? theme.primary : theme.grey,
            ),
          ),
      ],
    );
  }
}
