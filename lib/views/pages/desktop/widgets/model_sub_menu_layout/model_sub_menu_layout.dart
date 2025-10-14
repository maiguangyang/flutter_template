/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-15 13:56:59
 */
import 'package:flutter_template/abstracts/index.dart';
import 'package:flutter_template/views/application/index.dart';

import '../app_header_bar/back_button_widget.dart';
import '../sub_menu_layout/sub_menu_layout.dart';

class ModelSubMenuLayout extends CustomStatelessWidget {
  const ModelSubMenuLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    final menuStore = ref.watch(asyncModelMenuProvider);
    final menus = menuStore.value ?? [];

    return SubMenuLayout(
      width: 55,
      paddingTop: 0,
      menus: menus,
      bgColor: theme.white,
      divider: true,
      child: child,
      leading: Container(
        margin: EdgeInsets.only(top: theme.spacing8, bottom: theme.spacing6),
        padding: EdgeInsets.only(left: theme.spacing4),
        decoration: BoxDecoration(
          color: theme.grey.withValues(alpha: 0.1),
          borderRadius: BorderRadius.all(Radius.circular(theme.spacing4)),
        ),
        child: BackButtonWidget(
          showBack: true,
          paddingLeft: 0,
          backIconColor: theme.black.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}
