import 'package:flutter_template/core/index.dart';
import 'package:flutter_template/shared/index.dart';

/// 入口层
class DesktopScreen extends CustomStatefulWidget {
  const DesktopScreen({super.key});

  @override
  CustomState<DesktopScreen> createState() => _DesktopScreenState();
}

/// 逻辑层
class _DesktopScreenState extends CustomState<DesktopScreen> {
  /// 切换颜色
  void handleColorSwitch() {
    // final primary = ref.read(themeProvider).primary;

    // ref.theme.setPrimaryColor(
    //   primary.toARGB32() == Color(0xFF0672FF).toARGB32()
    //       ? Color(0xFFFF0000)
    //       : Color(0xFF0672FF),
    // );

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

  /// 更新菜单
  void handleUpdateMenu() {
    final menuStore = ref.read(asyncMenuProvider);
    final menus = menuStore.value ?? [];

    final count = menus[2].badgeCount ?? 0;

    ref.menu.updateBadgeCount(2, count + 1);
  }

  @override
  Widget build(BuildContext context) => _DesktopScreenView(this);
}

/// UI层
class _DesktopScreenView
    extends CustomStatefulView<DesktopScreen, _DesktopScreenState> {
  const _DesktopScreenView(super.state);

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final colorScheme = ref.watch(themeProvider.select((t) => t.colorScheme));
    final primary = colorScheme.primary;

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
