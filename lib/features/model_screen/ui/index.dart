/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2026-02-11 20:03:09
 */
import 'package:flutter_template/core/index.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'desktop/index.dart';
import 'mobile/index.dart';

class ModelScreen extends CustomStatelessWidget {
  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => MobileScreen(),
      desktop: (BuildContext context) => DesktopScreen(),
      tablet: (BuildContext context) => MobileScreen(),
    );
  }
}
