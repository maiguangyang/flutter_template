/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-26 14:49:35
 */
import 'package:flutter_template/core/index.dart';

class LoginScreen extends CustomStatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final colorScheme = ref.watch(themeProvider.select((s) => s.colorScheme));
    final primary = colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: Text(ref.lang.loginPage)),
      body: Container(
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
      bottomNavigationBar: null,
    );
  }
}
