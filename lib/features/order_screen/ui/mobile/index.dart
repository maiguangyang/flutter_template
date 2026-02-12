import 'package:flutter_template/core/index.dart';

/// 入口层
class MobileScreen extends CustomStatefulWidget {
  const MobileScreen({super.key});

  @override
  CustomState<MobileScreen> createState() => _MobileScreenState();
}

/// 逻辑层
class _MobileScreenState extends CustomState<MobileScreen> {
  @override
  Widget build(BuildContext context) => _MobileScreenView(this);
}

/// UI层
class _MobileScreenView
    extends CustomStatefulView<MobileScreen, _MobileScreenState> {
  const _MobileScreenView(super.state);

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Text('OrderScreen Mobile'),
      ),
    );
  }
}
