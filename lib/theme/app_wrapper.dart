/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-07-07 20:32:30
 */

import 'package:flutter_template/abstracts/index.dart';

import 'app_localization_wrapper.dart';

class AppWrapper extends CustomStatelessWidget {
  const AppWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).unfocus(),
      child: AppLocalizationWrapper(child: child),
    );
  }
}
