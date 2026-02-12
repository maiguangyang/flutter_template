/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-22 13:37:54
 */
import 'package:flutter_template/core/index.dart';

final langProvider = Provider<AppLocalizations>((ref) {
  // 读取当前语言
  final locale = ref.watch(localeProvider); // appProvider 返回 Locale
  // 返回对应的 AppLocalizations
  return lookupAppLocalizations(locale);
});
