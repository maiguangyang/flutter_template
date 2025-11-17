/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-04 15:27:03
 */
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter_template/abstracts/index.dart';
import 'package:flutter_template/views/data/models/index.dart';

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
    final spacing = ref.watch(themeProvider.select((t) => t.spacing));
    final fontSize = ref.watch(themeProvider.select((t) => t.fontSize));
    final colors = ref.watch(themeProvider.select((t) => t.colors));
    final colorScheme = ref.watch(themeProvider.select((t) => t.colorScheme));

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
                backgroundColor: item.hasBadgeCount ? colorScheme.error : null,
                textColor: item.hasBadgeCount ? Colors.white : null,
                largeSize: fontSize.f12,
                offset: Offset(2, -6),
                child: MenuItemIconWidget(item: item, isHovered: isHovered),
              ),

        if (!item.isHideLabel) SizedBox(height: spacing.s4),
        if (!item.isHideLabel)
          Text(
            item.label,
            style: TextStyle(
              fontSize: fontSize.f10,
              color: isHovered ? colorScheme.primary : colors.grey,
            ),
          ),
      ],
    );
  }
}
