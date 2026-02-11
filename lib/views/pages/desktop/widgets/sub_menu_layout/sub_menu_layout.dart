/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-17 08:41:51
 */
import 'package:flutter_template/core/index.dart';
import 'package:flutter_template/views/data/models/index.dart';
import 'package:flutter_template/views/pages/desktop/widgets/index.dart';

class SubMenuLayout extends CustomStatelessWidget {
  const SubMenuLayout({
    super.key,
    required this.menus,
    required this.child,
    this.leading,
    this.width,
    this.paddingTop,
    this.bgColor,
    this.divider = false,
  });

  /// leading
  final Widget? leading;

  /// 菜单
  final List<MenuEntity> menus;

  /// 子组件
  final Widget child;

  /// 宽度
  final double? width;

  /// 顶部
  final double? paddingTop;

  /// 背景色
  final Color? bgColor;

  /// 是否显示边框
  final bool divider;

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        NavigationRailMenu(
          width: width,
          paddingTop: paddingTop,
          bgColor: bgColor,
          divider: divider,
          leading: leading,
          destinations: menus,
        ),
        Expanded(child: child),
      ],
    );
  }
}
