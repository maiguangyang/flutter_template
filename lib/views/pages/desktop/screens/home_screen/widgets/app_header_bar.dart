/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-26 19:58:17
 */
import 'package:sugar_talk/abstracts/index.dart';
import 'package:sugar_talk/views/application/index.dart';

class AppHeaderBar extends CustomStatelessWidget
    implements PreferredSizeWidget {
  const AppHeaderBar({super.key, this.toolbarHeight = kToolbarHeight});

  final double toolbarHeight;

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final authStore = ref.watch(asyncAuthProvider);

    return authStore.when(
      // showLoading: false,
      data: (res) => AppBar(title: Text(ref.lang.homePage)),
      error: (e, _) => Text(e.toString()),
      loading: () => SizedBox.shrink(),
    );
  }
}
