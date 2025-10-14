import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:flutter_template/abstracts/index.dart';

import 'ox_button_enum.dart';

/// 自定义按钮组件 OxButton\
/// 该组件支持多种按钮类型（如主要按钮、默认按钮、虚线按钮等）、尺寸和样式配置。
class OxButton extends CustomStatelessWidget {
  const OxButton({
    super.key,
    required this.child,
    this.onPressed,
    this.type = OxButtonType.defaults,
    this.size = OxButtonSize.medium,
    this.icon,
    this.iconPosition = MainAxisAlignment.start,
    this.style,
    this.danger = false,
    this.block = false,
    this.href,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderRadius,
    this.padding,
    this.iconSize,
    this.iconColor,
    this.height,
    this.width,
    this.fontWeight,
    this.elevation,
  });

  /// 按钮内容
  final Widget? child;

  /// 按钮点击事件
  final VoidCallback? onPressed;

  /// 按钮类型
  final OxButtonType type;

  /// 按钮尺寸
  final OxButtonSize size;

  /// 按钮图标
  final Widget? icon;

  /// 按钮图标位置
  final MainAxisAlignment iconPosition;

  /// 按钮样式
  final ButtonStyle? style;

  /// 危险状态
  final bool danger;

  /// 撑满宽度
  final bool block;

  /// 链接地址（可选）
  final String? href;

  /// 背景色
  final Color? backgroundColor;

  /// 文本色
  final Color? textColor;

  /// 边框色
  final Color? borderColor;

  /// 边框圆角
  final double? borderRadius;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 图标尺寸（可选）
  final double? iconSize;

  /// 图标颜色
  final Color? iconColor;

  /// 宽度
  final double? width;

  /// 高度
  final double? height;

  /// 字体加粗
  final FontWeight? fontWeight;

  /// 阴影高度
  final double? elevation;

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    /// 获取基础按钮组件
    Widget button = _buildBaseButton(context, ref);

    /// 链接按钮特殊处理
    if (type == OxButtonType.link && href != null) {
      button = InkWell(onTap: onPressed, child: button);
    }

    /// 块级按钮处理
    if (block) {
      button = SizedBox(width: double.infinity, child: button);
    }

    return button;
  }

  /// 根据类型构建不同按钮
  Widget _buildBaseButton(BuildContext context, WidgetRef ref) {
    switch (type) {
      case OxButtonType.primary:
        return _buildButtonSize(
          ElevatedButton(
            style: _mergedStyle(context, ref),
            onPressed: onPressed,
            child: _buildContent(),
          ),
        );
      case OxButtonType.defaults:
        return _buildButtonSize(
          OutlinedButton(
            style: _mergedStyle(context, ref),
            onPressed: onPressed,
            child: _buildContent(),
          ),
        );
      case OxButtonType.dashed:
        return _buildButtonSize(
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: DashedBorder.fromBorderSide(
                dashLength: 6,
                side: BorderSide(color: _getBorderColor(context, ref)),
              ),
            ),
            child: TextButton(
              style: _mergedStyle(context, ref),
              onPressed: onPressed,
              child: _buildContent(),
            ),
          ),
        );
      case OxButtonType.text:
        return _buildButtonSize(
          TextButton(
            style: _mergedStyle(context, ref),
            onPressed: onPressed,
            child: _buildContent(),
          ),
        );
      case OxButtonType.link:
        return _buildButtonSize(
          TextButton(
            style: _mergedStyle(context, ref),
            onPressed: onPressed,
            child: _buildLinkContent(context, ref),
          ),
        );
    }
  }

  /// 合并样式\
  /// 该方法将默认样式与用户传入的样式进行合并
  ButtonStyle _mergedStyle(BuildContext context, WidgetRef ref) {
    return _getDefaultsStyle(context, ref)
        .copyWith(
          iconColor: iconColor != null
              ? WidgetStateProperty.all(iconColor)
              : null,
          iconSize: iconSize != null ? WidgetStateProperty.all(iconSize) : null,
          backgroundColor: backgroundColor != null
              ? WidgetStateProperty.all(backgroundColor)
              : null,
          foregroundColor: textColor != null
              ? WidgetStateProperty.all(textColor)
              : null,
          side: borderColor != null
              ? WidgetStateProperty.all(BorderSide(color: borderColor!))
              : null,
          shape: borderRadius != null
              ? WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius!),
                  ),
                )
              : null,
          padding: padding != null
              ? WidgetStateProperty.all(padding)
              : WidgetStateProperty.all(
                  EdgeInsetsGeometry.symmetric(vertical: 18, horizontal: 18),
                ),
          elevation: elevation != null
              ? WidgetStateProperty.resolveWith((states) {
                  return elevation;
                })
              : null,
        )
        .merge(style);
  }

  // 默认样式\
  /// 获取按钮的默认样式\
  /// 根据按钮的尺寸和状态计算默认的内边距、背景颜色、文本颜色和边框颜色
  ButtonStyle _getDefaultsStyle(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    /// 颜色逻辑
    final mainColor = danger ? theme.errorColor : theme.primary;
    final textColor = danger ? theme.errorColor : theme.white;

    /// 尺寸逻辑
    final padding = switch (size) {
      OxButtonSize.small => const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      OxButtonSize.medium => const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      OxButtonSize.large => const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 14,
      ),
    };

    return ButtonStyle(
      padding: WidgetStateProperty.all(padding),
      textStyle: WidgetStatePropertyAll(
        TextStyle(color: theme.white, fontSize: theme.fontSize14),
      ),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (type == OxButtonType.primary &&
            !states.contains(WidgetState.disabled)) {
          return mainColor;
        }
        return null;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return theme.textPrimaryColor.withValues(alpha: 0.25);
        }
        return type == OxButtonType.primary ? textColor : theme.primary;
      }),
      side: WidgetStateProperty.resolveWith((states) {
        if (type == OxButtonType.defaults) {
          return BorderSide(
            color: states.contains(WidgetState.disabled)
                ? theme.textPrimaryColor.withValues(alpha: 0.25)
                : mainColor,
          );
        }
        return null;
      }),
    );
  }

  /// 构建带图标的内容\
  ///
  /// 此方法用于根据 `icon` 和 `iconPosition` 的值构建一个包含图标和子组件的行布局。\
  /// 如果 `icon` 为 `null`，则直接返回 `child` 组件。\
  /// 如果 `icon` 不为 `null`，则根据 `iconPosition` 的值将图标放置在 `child` 组件的起始或结束位置，并在它们之间添加间距。\
  ///
  /// 返回值：\
  /// - 一个 `Row` 组件，包含图标和子组件，或者直接返回 `child` 组件。
  Widget _buildContent() {
    // 如果图标为空，则直接返回子组件
    if (icon == null) return child!;

    // 创建一个用于存储子组件的列表
    List<Widget> children = [];

    // 如果图标不为空且图标位置在起始处
    if (icon != null && iconPosition == MainAxisAlignment.start) {
      // 将图标添加到子组件列表中
      children.add(icon!);
      // 添加一个宽度为 8 的间距
      children.add(const SizedBox(width: 8));
    }

    // 如果子组件不为空
    if (child != null) {
      // 将子组件添加到子组件列表中
      children.add(child!);
    }

    // 如果图标不为空且图标位置在结束处
    if (icon != null && iconPosition == MainAxisAlignment.end) {
      // 添加一个宽度为 8 的间距
      children.add(const SizedBox(width: 8));
      // 将图标添加到子组件列表中
      children.add(icon!);
    }

    // 返回一个行布局，主轴大小为最小，主轴对齐方式为图标位置，子组件为上述列表中的组件
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: iconPosition,
      children: children,
    );
  }

  /// 构建带宽高度的内容
  Widget _buildButtonSize(Widget context) {
    return SizedBox(height: height, width: width, child: context);
  }

  /// 链接按钮特殊内容
  Widget _buildLinkContent(BuildContext context, WidgetRef ref) {
    return DefaultTextStyle.merge(
      style: TextStyle(
        decoration: TextDecoration.underline,
        color: _getLinkColor(context, ref),
      ),
      child: child!,
    );
  }

  /// 辅助方法：获取链接颜色
  Color _getLinkColor(BuildContext context, WidgetRef ref) {
    final isDisabled = onPressed == null;
    final theme = ref.watch(themeProvider);

    if (isDisabled) return theme.textPrimaryColor.withValues(alpha: 0.25);
    return danger ? theme.errorColor : theme.primary;
  }

  /// 辅助方法：获取边框颜色
  Color _getBorderColor(BuildContext context, WidgetRef ref) {
    final isDisabled = onPressed == null;
    final theme = ref.watch(themeProvider);

    if (isDisabled) return theme.textPrimaryColor.withValues(alpha: 0.25);
    return danger ? theme.errorColor : theme.primary;
  }
}
