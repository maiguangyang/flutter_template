/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-25 15:39:06
 */

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/common/index.dart';
import 'package:flutter_template/views/application/index.dart';

extension WidgetRefExtension on WidgetRef {
  /// **********
  /// watch
  /// **********

  /// 获取多语言
  AppLocalizations get lang => watch(langProvider);

  /// **********
  /// read
  /// **********

  /// 获取主题
  ThemeProvider get theme => read(themeProvider.notifier);

  /// 获取设置语言
  LocaleProvider get locale => read(localeProvider.notifier);

  /// **********
  /// application
  /// **********

  /// 获取认证
  AsyncAuthNotifier get auth => read(asyncAuthProvider.notifier);

  /// 获取菜单
  AsyncMenuNotifier get menu => read(asyncMenuProvider.notifier);

  /// user
  AsyncUserNotifier get user => read(asyncUserProvider.notifier);

  /// model
  AsyncModelNotifier get model => read(asyncModelProvider.notifier);
}
