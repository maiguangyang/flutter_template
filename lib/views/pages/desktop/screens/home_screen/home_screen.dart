import 'package:sugar_talk/abstracts/index.dart';
import 'package:sugar_talk/views/application/index.dart';
import 'package:sugar_talk/views/pages/desktop/widgets/index.dart';

/// 入口层
class HomeScreen extends CustomStatefulWidget {
  const HomeScreen({super.key});

  @override
  CustomState<HomeScreen> createState() => _HomeScreenState();
}

/// 逻辑层
class _HomeScreenState extends CustomState<HomeScreen> {
  /// 切换颜色
  void handleColorSwitch() {
    final primary = ref.read(themeProvider).primary;

    ref.theme.setPrimaryColor(
      primary.toARGB32() == Color(0xFF0672FF).toARGB32()
          ? Color(0xFFFF0000)
          : Color(0xFF0672FF),
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

  /// 更新菜单
  void handleUpdateMenu() {
    final menuStore = ref.read(asyncMenuProvider);
    final menus = menuStore.value ?? [];

    final count = menus[2].badgeCount ?? 0;

    ref.menu.updateBadgeCount(2, count + 1);
  }

  @override
  Widget build(BuildContext context) => _HomeScreenView(this);
}

/// UI层
class _HomeScreenView extends CustomStatefulView<HomeScreen, _HomeScreenState> {
  const _HomeScreenView(super.state);

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final primary = ref.watch(themeProvider.select((s) => s.primary));

    return Scaffold(
      body: Container(
        alignment: AlignmentGeometry.center,
        child: MainLayout(
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
                  await ref.auth.login();
                },
                child: Text("请求数据", style: TextStyle(color: primary)),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: state.handleUpdateMenu,
                child: Text("修改IM数量", style: TextStyle(color: primary)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
