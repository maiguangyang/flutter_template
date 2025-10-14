/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-02 09:15:56
 */
import 'package:sugar_talk/abstracts/index.dart';

class LeadingWidget extends CustomStatelessWidget {
  const LeadingWidget({super.key});

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final spacing24 = ref.watch(themeProvider.select((s) => s.spacing24));
    final spacing10 = ref.watch(themeProvider.select((s) => s.spacing10));
    final primary = ref.watch(themeProvider.select((s) => s.primary));

    return Container(
      padding: EdgeInsetsDirectional.only(top: spacing24, bottom: spacing10),
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
