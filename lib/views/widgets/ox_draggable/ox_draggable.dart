/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-10 15:42:35
 */
import 'package:flutter_template/abstracts/index.dart';

import 'draggable_header_widget.dart';

/// 入口层
class OxDraggable extends CustomStatefulWidget {
  const OxDraggable({
    super.key,
    required this.child,
    this.title,
    this.width,
    this.canMove = true,
    this.alignment = Alignment.center,
  });

  /// 子组件
  final Widget child;

  /// 头部
  final Widget? title;

  /// 是否可拖动
  final bool canMove;

  /// 宽度
  final double? width;

  /// 对齐方式
  final Alignment alignment;

  @override
  CustomState<OxDraggable> createState() => _OxDraggableState();
}

/// 逻辑层
class _OxDraggableState extends CustomState<OxDraggable> {
  Offset position = const Offset(0, 0);
  final GlobalKey _boxKey = GlobalKey();
  Size _boxSize = Size.zero;
  bool _initialized = false;

  void onPanUpdate(DragUpdateDetails details, BoxConstraints constraints) {
    final maxWidth = constraints.maxWidth;
    final maxHeight = constraints.maxHeight;
    setState(() {
      double newX = position.dx + details.delta.dx;
      double newY = position.dy + details.delta.dy;

      // 限制左右边界
      newX = newX.clamp(0.0, maxWidth - _boxSize.width);
      // 限制上下边界
      newY = newY.clamp(0.0, maxHeight - _boxSize.height);

      position = Offset(newX, newY);
    });
  }

  void _initPositionIfNeeded(BoxConstraints constraints) {
    if (_initialized || _boxSize == Size.zero) return;

    final parentW = constraints.maxWidth;
    final parentH = constraints.maxHeight;

    // Alignment(-1,-1) 左上角，Alignment(1,1) 右下角
    final dx = (parentW - _boxSize.width) * (widget.alignment.x + 1) / 2;
    final dy = (parentH - _boxSize.height) * (widget.alignment.y + 1) / 2;

    setState(() {
      position = Offset(dx, dy);
      _initialized = true;
    });
  }

  @override
  Widget build(BuildContext context) => _OxDraggableView(this);
}

/// UI层
class _OxDraggableView
    extends CustomStatefulView<OxDraggable, _OxDraggableState> {
  const _OxDraggableView(super.state);

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeProvider.select((s) => s.colors));

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Positioned(
              left: state.position.dx,
              top: state.position.dy,
              width: widget.width,
              child: Container(
                key: state._boxKey,
                decoration: BoxDecoration(
                  color: colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: colors.grey.withValues(alpha: 0.2)),
                ),
                child: Column(
                  children: [
                    widget.canMove
                        ? GestureDetector(
                            onPanUpdate: (details) =>
                                state.onPanUpdate(details, constraints),
                            child: DraggableHeaderWidget(
                              canMove: widget.canMove,
                              width: double.infinity,
                              title: widget.title,
                            ),
                          )
                        : DraggableHeaderWidget(
                            width: double.infinity,
                            title: widget.title,
                          ),

                    LayoutBuilder(
                      builder: (context, _) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          final renderBox =
                              state._boxKey.currentContext?.findRenderObject()
                                  as RenderBox?;
                          if (renderBox != null) {
                            final size = renderBox.size;
                            if (size != state._boxSize) {
                              state._boxSize = size;
                              state._initPositionIfNeeded(constraints);
                            }
                          }
                        });
                        return widget.child;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
