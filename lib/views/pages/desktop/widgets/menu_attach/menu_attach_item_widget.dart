/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-04 15:17:10
 */
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_template/abstracts/index.dart';
import 'package:flutter_template/views/data/models/index.dart';

import '../navigation_rail_menu/menu_item_child_widget.dart';

/// 入口层
class MenuAttachItemWidget extends CustomStatefulWidget {
  const MenuAttachItemWidget({super.key, required this.item});

  final MenuEntity item;

  @override
  CustomState<MenuAttachItemWidget> createState() =>
      _MenuAttachItemWidgetState();
}

/// 逻辑层
class _MenuAttachItemWidgetState extends CustomState<MenuAttachItemWidget> {
  bool isHovered = false;

  /// 鼠标进入
  /// [value] 是否进入
  void handleHoverToggle(bool value) {
    if (value != isHovered) {
      setState(() {
        isHovered = value;
      });
    }
  }

  void handleTap(MenuEntity item) {
    SmartDialog.dismiss();

    item.goTo();
  }

  @override
  Widget build(BuildContext context) => _MenuAttachItemWidgetView(this);
}

/// UI层
class _MenuAttachItemWidgetView
    extends
        CustomStatefulView<MenuAttachItemWidget, _MenuAttachItemWidgetState> {
  const _MenuAttachItemWidgetView(super.state);

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    return InkWell(
      onTap: () => state.handleTap(widget.item),
      child: MouseRegion(
        onEnter: (_) => state.handleHoverToggle(true),
        onExit: (_) => state.handleHoverToggle(false),
        child: Container(
          decoration: BoxDecoration(
            // color: theme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(theme.spacing4),
          ),
          child: Center(
            child: MenuItemChildWidget(
              item: widget.item,
              isHovered: state.isHovered,
            ),
          ),
        ),
      ),
    );
  }
}
