// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier 管理 AuthState

@ProviderFor(AsyncAuthNotifier)
final asyncAuthProvider = AsyncAuthNotifierProvider._();

/// Notifier 管理 AuthState
final class AsyncAuthNotifierProvider
    extends $AsyncNotifierProvider<AsyncAuthNotifier, UserEntity?> {
  /// Notifier 管理 AuthState
  AsyncAuthNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'asyncAuthProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$asyncAuthNotifierHash();

  @$internal
  @override
  AsyncAuthNotifier create() => AsyncAuthNotifier();
}

String _$asyncAuthNotifierHash() => r'ce6b1b107fe6b08acbaf907a2d57505c4aa0dfe0';

/// Notifier 管理 AuthState

abstract class _$AsyncAuthNotifier extends $AsyncNotifier<UserEntity?> {
  FutureOr<UserEntity?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<UserEntity?>, UserEntity?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UserEntity?>, UserEntity?>,
              AsyncValue<UserEntity?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
