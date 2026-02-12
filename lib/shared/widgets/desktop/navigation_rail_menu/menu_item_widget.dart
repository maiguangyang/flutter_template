/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-02 09:42:01
 */

import 'package:flutter_template/core/index.dart';
import 'package:flutter_template/shared/index.dart';

import 'menu_item_child_widget.dart';

/// 入口层
class MenuItemWidget extends CustomStatefulWidget {
  const MenuItemWidget({super.key, required this.item});

  final MenuEntity item;

  @override
  CustomState<MenuItemWidget> createState() => _MenuItemWidgetState();
}

/// 逻辑层
class _MenuItemWidgetState extends CustomState<MenuItemWidget> {
  bool isHovered = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
    Future.microtask(() {
      handleHoverToggle(false);
    });
  }

  void handleHoverToggle(bool value) {
    if (value != isHovered && mounted) {
      setState(() {
        isHovered = value;
      });
    }
  }

  void handleTap(BuildContext context, MenuEntity item) {
    if (item.render != null) {
      item.render?.call(context, item);
      return;
    }

    item.goTo();
  }

  @override
  Widget build(BuildContext context) => _MenuItemWidgetView(this);
}

/// UI层
class _MenuItemWidgetView
    extends CustomStatefulView<MenuItemWidget, _MenuItemWidgetState> {
  const _MenuItemWidgetView(super.state);

  Widget buildIcon(WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    final item = widget.item;
    final currentRoute = NavigatorUtilsCore.instance.currentRoute;
    final isChecked = currentRoute?.name == item.route?.name;

    return Icon(
      item.icon,
      color: state.isHovered || isChecked
          ? theme.colorScheme.primary
          : theme.colors.grey.withValues(alpha: 0.65),
    );
  }

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    final item = widget.item;
    final currentRoute = NavigatorUtilsCore.instance.currentRoute;
    final isChecked = currentRoute?.name == item.route?.name;

    return InkWell(
      onTap: () => state.handleTap(context, item),
      borderRadius: BorderRadius.circular(4),
      child: MouseRegion(
        onEnter: (_) => state.handleHoverToggle(true),
        onExit: (_) => state.handleHoverToggle(false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: EdgeInsets.only(
            top: item.isHideLabel ? theme.spacing.s10 : theme.spacing.s8,
            bottom: item.isHideLabel ? theme.spacing.s10 : theme.spacing.s8,
            left: theme.spacing.s8,
            right: theme.spacing.s8,
          ),
          decoration: item.isHideLabel
              ? BoxDecoration(
                  color: state.isHovered || isChecked
                      ? theme.colorScheme.primary.withValues(alpha: 0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                )
              : null,
          child: MenuItemChildWidget(
            item: item,
            isHovered: state.isHovered || isChecked,
          ),
        ),
      ),
    );
  }
}
