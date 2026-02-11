/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-05 13:56:05
 */
import 'package:flutter_template/core/index.dart';

class DraggableHeaderWidget extends CustomStatelessWidget {
  const DraggableHeaderWidget({
    super.key,
    this.title,
    this.width,
    this.canMove,
    this.onCancel,
  });

  /// 标题
  final Widget? title;

  /// 宽度
  final double? width;

  /// 是否可拖动
  final bool? canMove;

  /// 取消
  final VoidCallback? onCancel;

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final colorScheme = ref.watch(themeProvider.select((s) => s.colorScheme));

    return MouseRegion(
      cursor: canMove == true
          ? SystemMouseCursors.grab
          : SystemMouseCursors.basic,
      child: Container(
        width: width,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
        ),
        child: Stack(
          children: [
            if (title != null) Center(child: title),
            Positioned(
              right: 0,
              child: IconButton(
                onPressed: onCancel != null
                    ? onCancel
                    : () => DialogUtilsCore.dismiss(),
                icon: Icon(
                  Icons.close,
                  color: colorScheme.onSecondaryContainer,
                ),
                style: ButtonStyle(
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: WidgetStateProperty.all<Color>(
                    Colors.transparent,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
