/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-26 14:49:35
 */
import 'package:sugar_talk/abstracts/index.dart';
import 'package:sugar_talk/views/pages/desktop/widgets/index.dart';

class LoginScreen extends CustomStatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final primary = ref.watch(themeProvider.select((s) => s.primary));

    return Scaffold(
      body: MainLayout(
        child: Container(
          alignment: AlignmentGeometry.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  NavigatorUtilsCore.go(Routes.test);
                },
                child: Text("打开测试页", style: TextStyle(color: primary)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
