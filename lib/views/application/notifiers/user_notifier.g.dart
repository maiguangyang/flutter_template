// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier 管理 UserState

@ProviderFor(AsyncUserNotifier)
const asyncUserProvider = AsyncUserNotifierProvider._();

/// Notifier 管理 UserState
final class AsyncUserNotifierProvider
    extends $AsyncNotifierProvider<AsyncUserNotifier, List<UserEntity>> {
  /// Notifier 管理 UserState
  const AsyncUserNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'asyncUserProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$asyncUserNotifierHash();

  @$internal
  @override
  AsyncUserNotifier create() => AsyncUserNotifier();
}

String _$asyncUserNotifierHash() => r'dae477669a56d0e2b09e6dcce9ff25b1b5c455f4';

/// Notifier 管理 UserState

abstract class _$AsyncUserNotifier extends $AsyncNotifier<List<UserEntity>> {
  FutureOr<List<UserEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<UserEntity>>, List<UserEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<UserEntity>>, List<UserEntity>>,
              AsyncValue<List<UserEntity>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
