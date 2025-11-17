/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-26 14:49:35
 */
import 'package:flutter_template/abstracts/index.dart';
import 'package:flutter_template/views/pages/desktop/widgets/index.dart';

class TestScreen extends CustomStatelessWidget {
  const TestScreen({super.key});

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final colorScheme = ref.watch(themeProvider.select((t) => t.colorScheme));
    final primary = colorScheme.primary;

    return Scaffold(
      body: MainLayout(
        child: Container(
          alignment: AlignmentGeometry.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  NavigatorUtilsCore.go(Routes.login);
                },
                child: Text("打开登录页", style: TextStyle(color: primary)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
