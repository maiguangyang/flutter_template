/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-02 09:15:56
 */
import 'package:flutter_template/abstracts/index.dart';

class TrailingWidget extends CustomStatelessWidget {
  const TrailingWidget({super.key});

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final spacing10 = ref.watch(themeProvider.select((s) => s.spacing10));
    final primary = ref.watch(themeProvider.select((s) => s.primary));

    return Container(
      padding: EdgeInsetsDirectional.only(top: spacing10),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: primary.withValues(alpha: 0.1),
        child: Icon(
          Icons.account_circle,
          size: 40,
          color: primary.withValues(alpha: 0.7),
        ),
      ),
    );
  }
}
