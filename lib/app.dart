/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2024-04-24 19:55:57
 */

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_template/abstracts/index.dart';
import 'package:flutter_template/theme/index.dart';

import 'config/config.dart';

/// 入口层
class MyApp extends CustomStatefulWidget {
  const MyApp({super.key});

  @override
  CustomState<MyApp> createState() => _MyAppState();
}

/// 逻辑层
class _MyAppState extends CustomState<MyApp> with WidgetsBindingObserver {
  late DeviceTypeEnum deviceType;
  late RouteStrategy routeStrategy;
  RouterConfig<Object>? routerConfig;

  /// 初始化
  void init() async {
    // 获取设备类型并且初始化路由
    // deviceType = DeviceUtilsCore.getDeviceType();
    // routeStrategy = CustomRouter.init(deviceType);
    deviceType = ref.read(deviceTypeProvider);
    routeStrategy = ref.read(routeProvider);

    routeStrategy.navigatorKey ??= GlobalKey<NavigatorState>();
    routerConfig ??= routeStrategy.generateRoutes();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this as WidgetsBindingObserver);
    init();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this as WidgetsBindingObserver);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _MyAppView(this);
}

/// UI层
class _MyAppView extends CustomStatefulView<MyApp, _MyAppState> {
  const _MyAppView(super.state);

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    // final themeMode = ref.watch(themeProvider.select((s) => s.themeMode));
    // final isDark = ref.watch(themeProvider.select((s) => s.isDark));

    final theme = ref.watch(themeProvider);

    final appRoutes = ref.watch(flutterRouterListProvider);

    return MaterialApp.router(
      title: Config.project.appName,
      routerConfig: state.routerConfig,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: theme.themeData,
      darkTheme: theme.themeData,
      themeMode: theme.themeMode,
      builder: NavigatorUtilsCore.init(
        // 初始化路由
        routers: appRoutes,
        deviceType: state.deviceType,
        isDesktop: DeviceUtilsCore.isDesktop,
        appName: Config.project.appName,
        builder: FlutterSmartDialog.init(
          builder: (context, child) {
            final wrappedChild = AppWrapper(child: child!);

            if (Config.project.env != EnvEnumCore.prd.name) {
              return Banner(
                message: Config.project.env.toUpperCase(),
                location: BannerLocation.bottomEnd,
                child: wrappedChild,
              );
            }

            return wrappedChild;
          },
        ),
      ),
    );
  }
}
