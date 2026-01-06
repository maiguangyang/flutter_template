/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-10-22 21:49:10
 */

import 'dart:async';

import 'package:flutter_template/views/application/index.dart';
import 'package:flutter_template/views/data/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'download_notifier.g.dart';

/// 管理下载任务状态
@Riverpod(keepAlive: true)
class DownloadNotifier extends _$DownloadNotifier {
  DownloadRepository get _repository => ref.watch(downloadRepositoryProvider);

  StreamSubscription<DownloadTaskModel>? _sub;

  @override
  FutureOr<List<DownloadTaskModel>> build() async {
    await _repository.initialize();

    _sub = _repository.watchDownloads().listen(
      (task) {
        final list = state.value ?? [];
        final index = list.indexWhere((t) => t.id == task.id);

        List<DownloadTaskModel> updated;
        if (index != -1) {
          // 如果存在，替换原来的
          updated = List.from(list);
          updated[index] = task;
        } else {
          // 不存在，直接添加
          updated = [...list, task];
        }

        state = AsyncValue.data(updated);
      },
      onError: (error, stack) {
        state = AsyncValue.error(error, stack);
      },
    );

    // 使用 ref.onDispose 确保订阅被正确取消
    ref.onDispose(() {
      _sub?.cancel();
    });

    return [];
  }

  /// 开始下载
  Future<void> startDownload(String url, {String? filename}) async {
    await _repository.startDownload(url, filename: filename);
  }

  /// 暂停下载
  Future<void> pauseDownload(DownloadTaskModel task) async {
    await _repository.pauseDownload(task);
  }

  /// 继续下载
  Future<void> resumeDownload(DownloadTaskModel task) async {
    await _repository.resumeDownload(task);
  }

  /// 重新下载
  Future<void> retryDownload(DownloadTaskModel task) async {
    await _repository.retryDownload(task);
  }
}
