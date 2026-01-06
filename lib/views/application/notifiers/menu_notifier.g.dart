// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AsyncMenuNotifier)
final asyncMenuProvider = AsyncMenuNotifierProvider._();

final class AsyncMenuNotifierProvider
    extends $AsyncNotifierProvider<AsyncMenuNotifier, List<MenuEntity>> {
  AsyncMenuNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'asyncMenuProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$asyncMenuNotifierHash();

  @$internal
  @override
  AsyncMenuNotifier create() => AsyncMenuNotifier();
}

String _$asyncMenuNotifierHash() => r'e550a6822b1d6db8c24e724948a89d222abfc9bf';

abstract class _$AsyncMenuNotifier extends $AsyncNotifier<List<MenuEntity>> {
  FutureOr<List<MenuEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
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
    element.handleCreate(ref, build);
  }
}
