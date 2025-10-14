/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-22 13:37:54
 */

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_template/abstracts/index.dart';
import 'package:flutter_template/views/data/index.dart';
import 'package:flutter_template/views/pages/desktop/widgets/index.dart';

part 'menu_notifier.g.dart';

@Riverpod(keepAlive: true)
class AsyncMenuNotifier extends _$AsyncMenuNotifier {
  @override
  FutureOr<List<MenuEntity>> build() {
    final menus = [
      /// ***********
      ///  destination
      /// ***********
      MenuEntity(label: "首页", icon: Icons.home, route: Routes.home),
      MenuEntity(
        label: "会议",
        icon: Icons.video_camera_front,
        route: Routes.test,
      ),
      MenuEntity(
        label: "IM",
        icon: Icons.chat,
        route: Routes.login,
        badgeCount: 10,
      ),

      /// ***********
      ///  controller
      /// ***********
      MenuEntity(
        label: "收件箱",
        icon: Icons.email_outlined,
        route: Routes.login,
        type: MenuTypeEnumCore.controller,
        showBadge: true,
      ),
      MenuEntity(
        label: "文件管理",
        icon: Icons.folder_outlined,
        route: Routes.login,
        type: MenuTypeEnumCore.controller,
      ),
      MenuEntity(
        label: "备忘录",
        icon: Icons.note_alt_outlined,
        route: Routes.login,
        type: MenuTypeEnumCore.controller,
        showBadge: true,
      ),
      MenuEntity(
        label: "Gitlab",
        route: Routes.login,
        type: MenuTypeEnumCore.controller,
      ),
      MenuEntity(
        label: "PMX",
        route: Routes.login,
        type: MenuTypeEnumCore.controller,
      ),
      MenuEntity(
        label: "PlanBan",
        icon: Icons.view_kanban_outlined,
        route: Routes.login,
        type: MenuTypeEnumCore.controller,
      ),
      MenuEntity(
        label: "模型管理",
        icon: Icons.file_download_outlined,
        route: Routes.model,
        type: MenuTypeEnumCore.controller,
      ),

      /// ***********
      ///  trailing
      /// ***********
      MenuEntity(
        label: "Apps",
        icon: Icons.apps,
        type: MenuTypeEnumCore.trailing,
        isHideLabel: true,
        render: (context, data) {
          AttachLocationUtilsCore().attachDialog(
            context: context,
            child: MenuAttach(),
          );
        },
      ),
      MenuEntity(
        label: "设置",
        icon: Icons.settings,
        route: Routes.login,
        type: MenuTypeEnumCore.trailing,
        isHideLabel: true,
      ),
    ];

    return menus;
  }

  /// 更新指定菜单的 badgeCount
  Future<List<MenuEntity>> updateBadgeCount(int index, int? badgeCount) async {
    return update((menus) {
      final updatedMenus = List<MenuEntity>.from(menus);
      updatedMenus[index] = updatedMenus[index].copyWith(
        badgeCount: badgeCount,
      );
      return updatedMenus;
    });
  }

  /// 更新指定菜单的 showBadge
  Future<List<MenuEntity>> updateShowBadge(int index, bool showBadge) async {
    return update((menus) {
      final menus = state.value ?? [];
      final updatedMenus = List<MenuEntity>.from(menus);
      updatedMenus[index] = updatedMenus[index].copyWith(showBadge: showBadge);
      return updatedMenus;
    });
  }
}
