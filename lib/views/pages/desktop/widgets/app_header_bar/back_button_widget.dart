/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-10 09:32:50
 */
import 'package:flutter_template/abstracts/index.dart';

class BackButtonWidget extends CustomStatelessWidget {
  const BackButtonWidget({
    super.key,
    this.showBack = true,
    this.backIcon,
    this.backIconColor,
    this.backIconSize,
    this.backText,
    this.showBackText = false,
    this.paddingLeft,
    this.onBackTap,
  });

  /// 是否显示返回按钮
  final bool showBack;

  /// 返回按钮图标
  final IconData? backIcon;

  /// 返回按钮图标颜色
  final Color? backIconColor;

  /// 返回按钮图标大小
  final double? backIconSize;

  /// 是否显示返回按钮文字
  final bool showBackText;

  /// 返回按钮文字
  final String? backText;

  /// 边距
  final double? paddingLeft;

  /// 返回按钮点击回调
  final VoidCallback? onBackTap;

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    if (!showBack) {
      return SizedBox.shrink();
    }

    final theme = ref.watch(themeProvider);

    final canPop = Navigator.of(context).canPop();

    // 通用按钮组件
    Widget _buildIconButton({
      required IconData icon,
      required VoidCallback onPressed,
      double? iconSize,
    }) {
      return Padding(
        padding: EdgeInsets.only(left: paddingLeft ?? 70),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: iconSize ?? theme.fontSize.f20,
            color: backIconColor ?? theme.colors.black.withValues(alpha: 0.7),
          ),
          style: ButtonStyle(
            overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
            splashFactory: NoSplash.splashFactory,
          ),
        ),
      );
    }

    // 如果没有返回页面，则不显示返回按钮
    if (!canPop) {
      return _buildIconButton(
        icon: Icons.home,
        onPressed: () {
          NavigatorUtilsCore.replace(Routes.home);
        },
      );
    }

    return _buildIconButton(
      icon: backIcon ?? Icons.arrow_back_ios,
      onPressed:
          onBackTap ??
          () {
            Navigator.of(context).pop();
          },
    );
  }
}
