// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier 管理 ModelState

@ProviderFor(AsyncModelNotifier)
const asyncModelProvider = AsyncModelNotifierProvider._();

/// Notifier 管理 ModelState
final class AsyncModelNotifierProvider
    extends $AsyncNotifierProvider<AsyncModelNotifier, List<ModelEntity>> {
  /// Notifier 管理 ModelState
  const AsyncModelNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'asyncModelProvider',
        isAutoDispose: false,
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
    r'987d81ba8167c17320f6d004c7781e973ccad5e0';

/// Notifier 管理 ModelState

abstract class _$AsyncModelNotifier extends $AsyncNotifier<List<ModelEntity>> {
  FutureOr<List<ModelEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
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
    element.handleValue(ref, created);
  }
}
