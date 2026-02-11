/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-15 13:56:59
 */
import 'package:flutter_template/core/index.dart';
import 'package:flutter_template/views/application/index.dart';

import '../sub_menu_layout/sub_menu_layout.dart';

class MainLayout extends CustomStatelessWidget {
  const MainLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final menuStore = ref.watch(asyncMenuProvider);
    final menus = menuStore.value ?? [];

    return SubMenuLayout(menus: menus, child: child);
  }
}
