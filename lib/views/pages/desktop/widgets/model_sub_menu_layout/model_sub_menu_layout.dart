/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-15 13:56:59
 */
import 'package:flutter_template/core/index.dart';
import 'package:flutter_template/views/application/index.dart';

import '../app_header_bar/back_button_widget.dart';
import '../sub_menu_layout/sub_menu_layout.dart';

class ModelSubMenuLayout extends CustomStatelessWidget {
  const ModelSubMenuLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final spacing = ref.watch(themeProvider.select((t) => t.spacing));
    final colors = ref.watch(themeProvider.select((t) => t.colors));

    final menuStore = ref.watch(asyncModelMenuProvider);
    final menus = menuStore.value ?? [];

    return SubMenuLayout(
      width: 55,
      paddingTop: 0,
      menus: menus,
      bgColor: colors.white,
      divider: true,
      child: child,
      leading: Container(
        margin: EdgeInsets.only(top: spacing.s8, bottom: spacing.s6),
        padding: EdgeInsets.only(left: spacing.s4),
        decoration: BoxDecoration(
          color: colors.grey.withValues(alpha: 0.1),
          borderRadius: BorderRadius.all(Radius.circular(spacing.s4)),
        ),
        child: BackButtonWidget(
          showBack: true,
          paddingLeft: 0,
          backIconColor: colors.black.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}
