/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-04 14:11:55
 */
import 'package:flutter_template/abstracts/index.dart';
import 'package:flutter_template/views/application/index.dart';

import 'menu_attach_item_widget.dart';

class MenuAttach extends CustomStatelessWidget {
  const MenuAttach({super.key});

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final menuStore = ref.watch(asyncMenuProvider);
    final menus = menuStore.value ?? [];

    /// 获取所有类型为 controller 的导航栏项目
    final controllerItems = menus
        .where((item) => item.type == MenuTypeEnumCore.controller)
        .toList();

    return Container(
      width: 200,
      margin: EdgeInsets.only(left: theme.spacing10),
      padding: EdgeInsets.symmetric(
        vertical: theme.spacing10,
        horizontal: theme.spacing10,
      ),
      decoration: BoxDecoration(
        color: theme.white,
        border: Border.all(
          color: theme.grey.withValues(alpha: 0.3),
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(theme.spacing4),
        boxShadow: [
          BoxShadow(
            color: theme.grey.withValues(alpha: 0.3), // 阴影颜色
            spreadRadius: 2, // 阴影扩散程度
            blurRadius: 10, // 阴影模糊半径
            offset: Offset(0, 4), // 阴影偏移量
          ),
        ],
      ),
      child: GridView.count(
        crossAxisCount: 3, // 3列
        crossAxisSpacing: theme.spacing8, // 列间距
        mainAxisSpacing: theme.spacing8, // 行间距
        shrinkWrap: true, // 根据内容调整大小
        physics: NeverScrollableScrollPhysics(), // 禁止滚动
        children: controllerItems.map((menu) {
          return MenuAttachItemWidget(item: menu);
        }).toList(),
      ),
    );
  }
}
