// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier 管理 ModelState
/// 使用 autoDispose 在页面离开时自动释放内存

@ProviderFor(AsyncModelNotifier)
final asyncModelProvider = AsyncModelNotifierProvider._();

/// Notifier 管理 ModelState
/// 使用 autoDispose 在页面离开时自动释放内存
final class AsyncModelNotifierProvider
    extends $AsyncNotifierProvider<AsyncModelNotifier, List<ModelEntity>> {
  /// Notifier 管理 ModelState
  /// 使用 autoDispose 在页面离开时自动释放内存
  AsyncModelNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'asyncModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$asyncModelNotifierHash();

  @$internal
  @override
  AsyncModelNotifier create() => AsyncModelNotifier();
}

String _$asyncModelNotifierHash() =>
    r'f56ddb4c8afcbb747cb44632b73b67816b8b04f1';

/// Notifier 管理 ModelState
/// 使用 autoDispose 在页面离开时自动释放内存

abstract class _$AsyncModelNotifier extends $AsyncNotifier<List<ModelEntity>> {
  FutureOr<List<ModelEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<ModelEntity>>, List<ModelEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ModelEntity>>, List<ModelEntity>>,
              AsyncValue<List<ModelEntity>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
