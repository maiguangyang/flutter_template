// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier 管理 UserState
/// - autoDispose: 页面离开时自动释放
/// - PaginationMixin: 提供分页能力
/// - 缓存由 Repository 层负责

@ProviderFor(AsyncUserNotifier)
final asyncUserProvider = AsyncUserNotifierProvider._();

/// Notifier 管理 UserState
/// - autoDispose: 页面离开时自动释放
/// - PaginationMixin: 提供分页能力
/// - 缓存由 Repository 层负责
final class AsyncUserNotifierProvider
    extends $AsyncNotifierProvider<AsyncUserNotifier, List<UserEntity>> {
  /// Notifier 管理 UserState
  /// - autoDispose: 页面离开时自动释放
  /// - PaginationMixin: 提供分页能力
  /// - 缓存由 Repository 层负责
  AsyncUserNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'asyncUserProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$asyncUserNotifierHash();

  @$internal
  @override
  AsyncUserNotifier create() => AsyncUserNotifier();
}

String _$asyncUserNotifierHash() => r'67631ee77a6336a75a2b8fbe5e182611cb12845a';

/// Notifier 管理 UserState
/// - autoDispose: 页面离开时自动释放
/// - PaginationMixin: 提供分页能力
/// - 缓存由 Repository 层负责

abstract class _$AsyncUserNotifier extends $AsyncNotifier<List<UserEntity>> {
  FutureOr<List<UserEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
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
    element.handleCreate(ref, build);
  }
}
