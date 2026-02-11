/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-11-10 08:18:11
 */
import 'package:flutter_template/core/index.dart';

/// 入口层
class AppLifecycleWrapper extends CustomStatefulWidget {
  const AppLifecycleWrapper({super.key, required this.child});

  final Widget child;

  @override
  CustomState<AppLifecycleWrapper> createState() => _AppLifecycleWrapperState();
}

/// 逻辑层
class _AppLifecycleWrapperState extends CustomState<AppLifecycleWrapper> {
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();
    _listener = AppLifecycleListener(
      /// 应用显示：一般用于恢复 UI、重绘界面或刷新数据
      onShow: () => _handleTransition('show'),

      // 恢复前台：适合恢复动画、视频播放、socket 连接
      onResume: () => _handleTransition('resume'),

      // 隐藏界面：可用于暂停动画、视频播放或保存数据
      onHide: () => _handleTransition('hide'),

      // 临时失活：这时应用仍在前台，但无法与用户交互
      onInactive: () => _handleTransition('inactive'),

      // 进入后台：常用于释放资源、停止监听、持久化状态等
      onPause: () => _handleTransition('pause'),

      // 彻底退出：适合做彻底清理，如断开网络连接、注销服务
      onDetach: () => _handleTransition('detach'),

      // 重新启动：可用于重新初始化全局资源或重建应用状态
      onRestart: () => _handleTransition('restart'),
    );
  }

  /// 处理生命周期转换事件
  void _handleTransition(String name) {
    debugPrint('[AppLifecycle] Transition: $name');
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _AppLifecycleWrapperView(this);
}

/// UI层
class _AppLifecycleWrapperView
    extends CustomStatefulView<AppLifecycleWrapper, _AppLifecycleWrapperState> {
  const _AppLifecycleWrapperView(super.state);

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    return widget.child;
  }
}
