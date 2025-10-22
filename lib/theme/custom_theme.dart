/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2024-06-17 10:41:43
 */
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/common/index.dart';

ThemeData createLightTheme({required bool isDark, required WidgetRef ref}) {
  final themeStore = ref.watch(themeProvider);

  return ThemeData(
    fontFamily: 'NunitoSans',
    fontFamilyFallback: ['Roboto', 'NotoSansSC'],
    brightness: !isDark ? Brightness.light : Brightness.dark,
    useMaterial3: true,
    primaryColor: themeStore.primary,
    colorScheme: !isDark
        ? ColorScheme.light(
            primary: themeStore.textPrimaryColor,
            surface: themeStore.backgroundColor,
          )
        : ColorScheme.dark(
            primary: themeStore.textPrimaryColor,
            surface: themeStore.backgroundColor,
          ),
    iconTheme: IconThemeData(color: themeStore.iconColor),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: themeStore.white,
      iconTheme: IconThemeData(
        size: themeStore.fontSize16,
        color: themeStore.textTitleColor,
      ),
      titleTextStyle: TextStyle(
        fontSize: themeStore.fontSize14,
        color: themeStore.textTitleColor,
      ),
      actionsIconTheme: IconThemeData(
        size: themeStore.fontSize14,
        color: themeStore.textTitleColor,
      ),
      scrolledUnderElevation: 0.0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: themeStore.white,
      selectedIconTheme: IconThemeData(color: themeStore.red),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: themeStore.backgroundColor,
      indicatorColor: themeStore.primaryColor,
      labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
        if (states.contains(WidgetState.selected)) {
          return TextStyle(color: themeStore.primaryColor); // 选中时的文字颜色
        }
        return TextStyle(color: themeStore.textSecondaryColor); // 未选中时的文字颜色
      }),
      iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: themeStore.white); // 选中时的图标颜色
        }
        return IconThemeData(color: themeStore.textSecondaryColor); // 未选中时的图标颜色
      }),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: themeStore.fontSizeLarge,
        fontWeight: themeStore.fontWeightBold,
        color: themeStore.textPrimaryColor,
      ),
      titleMedium: TextStyle(
        fontSize: themeStore.fontSizeMedium,
        fontWeight: themeStore.fontWeightBold,
        color: themeStore.textPrimaryColor,
      ),
    ),
    dividerTheme: DividerThemeData(color: themeStore.borderPrimaryColor),
    scaffoldBackgroundColor: themeStore.backgroundColor,
    datePickerTheme: DatePickerThemeData(
      backgroundColor: themeStore.backgroundColor,
      surfaceTintColor: themeStore.backgroundColor,
    ),
    tabBarTheme: const TabBarThemeData(dividerColor: Colors.transparent),
    buttonTheme: ButtonThemeData(
      buttonColor: themeStore.textPrimaryColor,
      disabledColor: themeStore.buttonBackgroundColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: themeStore.primaryColor,
        foregroundColor: themeStore.white,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: themeStore.primaryColor,
        side: BorderSide(color: themeStore.primaryColor),
      ),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {TargetPlatform.macOS: NoTransitionPageTransitionsBuilder()},
    ),
  );
}

// 重写路由跳转的动画
class NoTransitionPageTransitionsBuilder extends PageTransitionsBuilder {
  const NoTransitionPageTransitionsBuilder();

  @override
  Widget buildTransitions<String>(
    PageRoute route,
    BuildContext context,
    Animation animation,
    Animation secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}
