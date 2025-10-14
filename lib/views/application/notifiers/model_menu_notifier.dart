/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-22 13:37:54
 */

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sugar_talk/abstracts/index.dart';
import 'package:sugar_talk/views/data/index.dart';
import 'package:sugar_talk/views/pages/desktop/dialogs/index.dart';
import 'package:sugar_talk/views/widgets/index.dart';

part 'model_menu_notifier.g.dart';

@Riverpod(keepAlive: true)
class AsyncModelMenuNotifier extends _$AsyncModelMenuNotifier {
  @override
  FutureOr<List<MenuEntity>> build() {
    final theme = ref.watch(themeProvider);

    final menus = [
      /// ***********
      ///  destination
      /// ***********
      MenuEntity(
        label: "聊天",
        icon: Icons.chat_bubble_outline,
        iconColor: theme.orange.withValues(alpha: 0.8),
        route: Routes.test,
        isHideLabel: true,
      ),
      MenuEntity(
        label: "开发者",
        icon: Icons.terminal_outlined,
        iconColor: theme.green.withValues(alpha: 0.8),
        route: Routes.test,
        isHideLabel: true,
      ),
      MenuEntity(
        label: "模型",
        icon: Icons.folder_copy_outlined,
        iconColor: theme.geekBlue.withValues(alpha: 0.8),
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

          print("result $result");
        },
      ),
    ];

    return menus;
  }
}
