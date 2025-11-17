/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-17 13:24:27
 */
import 'package:flutter_template/abstracts/index.dart';

class ModelDialogWidget extends CustomStatelessWidget {
  const ModelDialogWidget({super.key});

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("我是一个可拖拽弹窗"),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => DialogUtilsCore.dismiss(result: "123434"),
            child: Text("关闭"),
          ),
        ],
      ),
    );
  }
}
