/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-07-23 10:08:58
 */
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ---------------------------
/// 无状态组件（Stateless）
/// ---------------------------
abstract class CustomStatelessWidget extends ConsumerWidget {
  const CustomStatelessWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return buildView(context, ref);
  }

  /// 子类只需要实现这个
  Widget buildView(BuildContext context, WidgetRef ref);
}

/// ---------------------------
/// 有状态组件（Stateful）
/// ---------------------------
abstract class CustomStatefulView<
  T1 extends CustomStatefulWidget,
  T2 extends CustomState<T1>
>
    extends StatelessWidget {
  const CustomStatefulView(this.state, {super.key});

  final T2 state;

  T1 get widget => (state as State).widget as T1;

  @override
  Widget build(BuildContext context) {
    return buildView(context, state.ref);
  }

  /// 子类实现 UI，直接拿 ref 即可
  Widget buildView(BuildContext context, WidgetRef ref);
}

/// Stateful 基类（类似 StatefulWidget）
abstract class CustomStatefulWidget extends ConsumerStatefulWidget {
  const CustomStatefulWidget({super.key});
}

/// State 基类
abstract class CustomState<T extends CustomStatefulWidget>
    extends ConsumerState<T> {}
