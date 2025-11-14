// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_menu_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AsyncModelMenuNotifier)
const asyncModelMenuProvider = AsyncModelMenuNotifierProvider._();

final class AsyncModelMenuNotifierProvider
    extends $AsyncNotifierProvider<AsyncModelMenuNotifier, List<MenuEntity>> {
  const AsyncModelMenuNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'asyncModelMenuProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$asyncModelMenuNotifierHash();

  @$internal
  @override
  AsyncModelMenuNotifier create() => AsyncModelMenuNotifier();
}

String _$asyncModelMenuNotifierHash() =>
    r'080e2f550079ce7fa582aad0abce096133822ecd';

abstract class _$AsyncModelMenuNotifier
    extends $AsyncNotifier<List<MenuEntity>> {
  FutureOr<List<MenuEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<MenuEntity>>, List<MenuEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<MenuEntity>>, List<MenuEntity>>,
              AsyncValue<List<MenuEntity>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
