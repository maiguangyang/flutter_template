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
    final spacing = ref.watch(themeProvider.select((s) => s.spacing));
    final colorScheme = ref.watch(themeProvider.select((s) => s.colorScheme));

    return Container(
      padding: EdgeInsetsDirectional.only(top: spacing.s10),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: colorScheme.primary.withValues(alpha: 0.1),
        child: Icon(
          Icons.account_circle,
          size: 40,
          color: colorScheme.primary.withValues(alpha: 0.7),
        ),
      ),
    );
  }
}
