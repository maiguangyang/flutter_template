/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-25 10:43:50
 */
import 'package:flutter/services.dart';
import 'package:flutter_template/abstracts/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

/// 全局build组件
class GlobalBuildWidget {
  /// 加载状态
  static Widget loading(WidgetRef ref, {Widget? child}) {
    if (child != null) {
      return child;
    }

    return Center(
      child: CircularProgressIndicator(
        color: Colors.grey.withValues(alpha: 0.5),
      ),
    );
  }

  /// 错误状态
  static Widget error(
    Object error,
    WidgetRef ref, {
    $AsyncNotifierProvider? provider,
    Widget? child,
  }) {
    final spacing = ref.watch(themeProvider.select((t) => t.spacing));
    final colorScheme = ref.watch(themeProvider.select((t) => t.colorScheme));

    if (child != null) {
      return child;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(error.toString()),
        SizedBox(height: spacing.s20),
        if (provider != null)
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: spacing.s10,
                horizontal: spacing.s20,
              ),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(spacing.s4),
              ),
              child: Text(
                ref.lang.retry,
                style: TextStyle(color: Colors.white),
              ),
            ),
            onTap: () async {
              // 复制到剪贴板
              Clipboard.setData(ClipboardData(text: error.toString()));

              // 重试
              ref.invalidate(provider, asReload: false);
            },
          ),
      ],
    );
  }
}
