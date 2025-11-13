/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-26 08:42:07
 */
import 'package:flutter_template/abstracts/index.dart';
import 'package:flutter_template/views/widgets/index.dart';

class FooterWidget<T> extends CustomStatelessWidget {
  const FooterWidget({super.key, required this.data});

  /// 数据
  final List<T> data;

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    return OxPagination(
      current: 10,
      total: 200,
      pageSize: 10,
      pageSizeOptions: [10, 20, 50],
      showSizeChanger: true,
      onPageChanged: (page, size) {
        debugPrint("当前页: $page, 每页: $size");
      },
    );
  }
}
