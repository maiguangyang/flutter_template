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
    r'66401f9996ac2b52661eb94e38099eb680ab6f23';

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
