import 'package:flutter_template/core/index.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'desktop/index.dart';
import 'mobile/index.dart';

class HomeScreen extends CustomStatelessWidget {
  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => MobileScreen(),
      desktop: (BuildContext context) => DesktopScreen(),
      tablet: (BuildContext context) => MobileScreen(),
    );
  }
}
