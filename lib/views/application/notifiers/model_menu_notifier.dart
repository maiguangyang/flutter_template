/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-22 13:37:54
 */

import 'package:flutter_template/core/index.dart';
import 'package:flutter_template/views/data/index.dart';
import 'package:flutter_template/views/pages/desktop/dialogs/index.dart';
import 'package:flutter_template/views/widgets/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'model_menu_notifier.g.dart';

@Riverpod(keepAlive: true)
class AsyncModelMenuNotifier extends _$AsyncModelMenuNotifier {
  @override
  FutureOr<List<MenuEntity>> build() {
    final colors = ref.watch(themeProvider.select((t) => t.colors));

    final menus = [
      /// ***********
      ///  destination
      /// ***********
      MenuEntity(
        label: "聊天",
        icon: Icons.chat_bubble_outline,
        iconColor: colors.orange.withValues(alpha: 0.8),
        route: Routes.test,
        isHideLabel: true,
      ),
      MenuEntity(
        label: "开发者",
        icon: Icons.terminal_outlined,
        iconColor: colors.green.withValues(alpha: 0.8),
        route: Routes.test,
        isHideLabel: true,
      ),
      MenuEntity(
        label: "模型",
        icon: Icons.folder_copy_outlined,
        iconColor: colors.geekBlue.withValues(alpha: 0.8),
        route: Routes.model,
        isHideLabel: true,
      ),

      /// ***********
      ///  controller
      /// ***********

      /// ***********
      ///  trailing
      /// ***********
      MenuEntity(
        label: "Download",
        icon: Icons.file_download_outlined,
        type: MenuTypeEnumCore.trailing,
        isHideLabel: true,
        render: (context, data) async {
          DialogUtilsCore.dismiss();

          final result = await DialogUtilsCore.show<String?>(
            usePenetrate: true,
            clickMaskDismiss: false,
            builder: (context) {
              return OxDraggable(
                title: Text("测试"),
                child: ModelDialogWidget(),
                width: 300,
                alignment: Alignment.center,
              );
            },
          );

          debugPrint("result $result");
        },
      ),
    ];

    return menus;
  }
}
