// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 管理下载任务状态

@ProviderFor(DownloadNotifier)
const downloadProvider = DownloadNotifierProvider._();

/// 管理下载任务状态
final class DownloadNotifierProvider
    extends $AsyncNotifierProvider<DownloadNotifier, List<DownloadTaskModel>> {
  /// 管理下载任务状态
  const DownloadNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'downloadProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$downloadNotifierHash();

  @$internal
  @override
  DownloadNotifier create() => DownloadNotifier();
}

String _$downloadNotifierHash() => r'405efb6e9b0d9985669ef82536af23dc40fc54e6';

/// 管理下载任务状态

abstract class _$DownloadNotifier
    extends $AsyncNotifier<List<DownloadTaskModel>> {
  FutureOr<List<DownloadTaskModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<DownloadTaskModel>>,
              List<DownloadTaskModel>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<DownloadTaskModel>>,
                List<DownloadTaskModel>
              >,
              AsyncValue<List<DownloadTaskModel>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
