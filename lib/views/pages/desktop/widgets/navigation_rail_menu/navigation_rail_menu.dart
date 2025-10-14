/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-02 09:03:20
 */
import 'package:sugar_talk/abstracts/index.dart';
import 'package:sugar_talk/views/data/index.dart';

import 'leading_widget.dart';
import 'menu_item_widget.dart';

class NavigationRailMenu extends CustomStatelessWidget {
  const NavigationRailMenu({
    super.key,
    required this.destinations,
    this.width,
    this.leading,
    this.trailing,
    this.paddingTop,
    this.bgColor,
    this.divider = false,
  });

  /// 导航栏项目
  final List<MenuEntity> destinations;

  /// 宽度
  final double? width;

  /// leading
  final Widget? leading;

  /// trailing
  final Widget? trailing;

  /// 顶部
  final double? paddingTop;

  /// 背景色
  final Color? bgColor;

  /// 是否显示边框
  final bool divider;

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    final cardBackgroundColor = ref.watch(
      themeProvider.select((s) => s.cardBackgroundColor),
    );

    /// 获取所有类型为 destination 的导航栏项目
    final destinationItems = destinations
        .where((item) => item.type == MenuTypeEnumCore.destination)
        .toList();

    /// 获取所有类型为 leading 的导航栏项目
    final trailingItems = destinations
        .where((item) => item.type == MenuTypeEnumCore.trailing)
        .toList();

    return Container(
      width: width ?? 65,
      padding: EdgeInsets.only(
        top: paddingTop ?? theme.spacing16,
        bottom: theme.spacing16,
        left: theme.spacing4,
        right: theme.spacing4,
      ),
      decoration: BoxDecoration(
        color: bgColor ?? cardBackgroundColor,
        border: divider
            ? Border(
                right: BorderSide(color: theme.grey.withValues(alpha: 0.15)),
              )
            : null,
      ),
      child: Column(
        children: [
          leading ?? LeadingWidget(),
          Expanded(
            flex: 1,
            child: ListView(
              children: List.generate(destinationItems.length, (index) {
                final item = destinationItems[index];
                if (item.isHideLabel) {
                  return Tooltip(
                    message: item.label,
                    preferBelow: false,
                    verticalOffset: -15,
                    margin: EdgeInsets.only(left: 45),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    child: MenuItemWidget(item: item),
                  );
                }
                return MenuItemWidget(item: item);
              }),
            ),
          ),
          Column(
            children: List.generate(trailingItems.length, (index) {
              final item = trailingItems[index];

              return Tooltip(
                message: item.label,
                child: MenuItemWidget(item: item),
              );
            }),
          ),
        ],
      ),
    );
  }
}
