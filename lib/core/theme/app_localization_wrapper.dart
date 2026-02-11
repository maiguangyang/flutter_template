/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-07-07 20:32:56
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:flutter_template/core/index.dart';
import 'package:flutter_template/shared/index.dart';

class AppLocalizationWrapper extends riverpod.ConsumerWidget {
  const AppLocalizationWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, riverpod.WidgetRef ref) {
    // final currentLocale = ref.watch(appProvider.select((s) => s.currentLocale));
    final currentLocale = ref.watch(localeProvider);

    return Localizations.override(
      context: context,
      locale: currentLocale,
      child: child,
    );
  }
}
