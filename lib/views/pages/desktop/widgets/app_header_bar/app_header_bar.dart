/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-26 19:58:17
 */
import 'package:flutter_template/abstracts/index.dart';

import 'back_button_widget.dart';

class AppHeaderBar extends CustomStatelessWidget
    implements PreferredSizeWidget {
  const AppHeaderBar({
    super.key,
    this.leading,
    this.title,
    this.actions,
    this.showBack = true,
    this.backIcon,
    this.backIconColor,
    this.backIconSize,
    this.backText,
    this.showBackText = false,
    this.onBackTap,
    this.divider = false,
    this.toolbarHeight = 40,
  });

  /// 左侧控件
  final Widget? leading;

  /// 标题
  final Widget? title;

  /// 右侧控件
  final List<Widget>? actions;

  /// 是否显示返回按钮
  final bool showBack;

  /// 返回按钮图标
  final IconData? backIcon;

  /// 返回按钮图标颜色
  final Color? backIconColor;

  /// 返回按钮图标大小
  final double? backIconSize;

  /// 是否显示返回按钮文字
  final bool showBackText;

  /// 返回按钮文字
  final String? backText;

  /// 返回按钮点击回调
  final VoidCallback? onBackTap;

  /// 分割线
  final bool divider;

  /// 工具栏高度
  final double toolbarHeight;

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeProvider.select((t) => t.colors));

    return Container(
      decoration: BoxDecoration(
        border: divider
            ? Border(
                bottom: BorderSide(
                  color: colors.grey.withValues(alpha: 0.2),
                  width: 1,
                ),
              )
            : null,
      ),
      child: AppBar(
        leadingWidth: 110,
        leading: leading ?? BackButtonWidget(showBack: showBack),
        title: title,
        actions: actions,
      ),
    );
  }
}
