import 'package:flutter_template/core/index.dart';
import 'package:flutter_template/views/application/notifiers/index.dart';

import 'widgets/app_header_bar.dart';

/// 入口层
class HomeScreen extends CustomStatefulWidget {
  const HomeScreen({super.key});

  @override
  CustomState<HomeScreen> createState() => _HomeScreenState();
}

/// 逻辑层
class _HomeScreenState extends CustomState<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  /// 切换颜色
  void handleColorSwitch() {
    final flexScheme = ref.read(themeProvider).flexScheme;

    ref.theme.changeScheme(
      flexScheme == FlexScheme.shadBlue
          ? FlexScheme.mandyRed
          : FlexScheme.shadBlue,
    );
  }

  /// 主题切换
  void handleThemeSwitch() {
    final theme = ref.read(themeProvider);
    ref.theme.setThemeMode(
      theme.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
    );
  }

  /// 语言切换
  void handleLangSwitch() {
    final languageCode = ref.watch(
      localeProvider.select((s) => s.languageCode),
    );

    ref.locale.setLang(languageCode == "en" ? "zh" : "en");
  }

  @override
  Widget build(BuildContext context) => _HomeScreenView(this);
}

/// UI层
class _HomeScreenView extends CustomStatefulView<HomeScreen, _HomeScreenState> {
  const _HomeScreenView(super.state);

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final colorScheme = ref.watch(themeProvider.select((s) => s.colorScheme));
    final primary = colorScheme.primary;

    return Scaffold(
      appBar: AppHeaderBar(),
      body: Container(
        alignment: AlignmentGeometry.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: state.handleColorSwitch,
              child: Text("切换颜色", style: TextStyle(color: primary)),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: state.handleThemeSwitch,
              child: Text("切换主题", style: TextStyle(color: primary)),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: state.handleLangSwitch,
              child: Text("切换多语言", style: TextStyle(color: primary)),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                NavigatorUtilsCore.go(Routes.login);
              },
              child: Text(
                "打开${ref.lang.loginPage}",
                style: TextStyle(color: primary),
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () async {
                final auth = ref.read(asyncAuthProvider.notifier);
                await auth.login();
              },
              child: Text("请求数据", style: TextStyle(color: primary)),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () async {},
              child: Text("打开多窗口", style: TextStyle(color: primary)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: null,
    );
  }
}
