/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-26 19:58:17
 */
import 'package:flutter_template/core/index.dart';
import 'package:flutter_template/shared/index.dart';

class AppHeaderBar extends CustomStatelessWidget
    implements PreferredSizeWidget {
  const AppHeaderBar({super.key, this.toolbarHeight = kToolbarHeight});

  final double toolbarHeight;

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(asyncAuthProvider);

    return auth.when(
      // showLoading: false,
      data: (res) => AppBar(title: Text(ref.lang.homePage)),
      error: (e, _) => Text(e.toString()),
      loading: () => SizedBox.shrink(),
    );
  }
}
