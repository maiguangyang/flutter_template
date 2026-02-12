import 'package:flutter_template/core/index.dart';

/// 入口层
class DesktopScreen extends CustomStatefulWidget {
  const DesktopScreen({super.key});

  @override
  CustomState<DesktopScreen> createState() => _DesktopScreenState();
}

/// 逻辑层
class _DesktopScreenState extends CustomState<DesktopScreen> {
  @override
  Widget build(BuildContext context) => _DesktopScreenView(this);
}

/// UI层
class _DesktopScreenView
    extends CustomStatefulView<DesktopScreen, _DesktopScreenState> {
  const _DesktopScreenView(super.state);

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Text('OrderScreen Desktop'),
      ),
    );
  }
}
