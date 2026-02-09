/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-10-10 10:44:38
 */
import 'dart:async';

import 'package:background_downloader/background_downloader.dart';
import 'package:flutter_template/views/data/index.dart';

class DownloadRepository {
  final DownloadService _service;

  DownloadRepository(this._service);

  Future<void> initialize() => _service.init();

  /// 开始下载
  Future<bool> startDownload(String url, {String? filename}) async {
    final task = _service.createTask(url, filename: filename);
    return await _service.enqueue(task);
  }

  /// 暂停下载
  Future<bool> pauseDownload(DownloadTaskModel task) async {
    final downloadTask = DownloadTask(
      url: task.url,
      filename: task.filename,
      taskId: task.id,
    );
    return await _service.pause(downloadTask);
  }

  /// 继续下载
  Future<bool> resumeDownload(DownloadTaskModel task) async {
    final downloadTask = DownloadTask(
      url: task.url,
      filename: task.filename,
      taskId: task.id,
    );
    return await _service.resume(downloadTask);
  }

  /// 重新下载
  Future<bool> retryDownload(DownloadTaskModel task) async {
    final downloadTask = DownloadTask(
      url: task.url,
      filename: task.filename,
      taskId: task.id,
    );
    return await _service.enqueue(downloadTask);
  }

  /// 监听下载
  Stream<DownloadTaskModel> watchDownloads() {
    return _service.updates.map((update) {
      final task = update.task;
      double progress = 0.0;
      DownloadStatus status = DownloadStatus.idle;
      String? error;

      if (update is TaskProgressUpdate) {
        progress = update.progress;
        status = (progress >= 1.0)
            ? DownloadStatus.completed
            : DownloadStatus.running;
      } else if (update is TaskStatusUpdate) {
        switch (update.status) {
          case TaskStatus.running:
            status = DownloadStatus.running;
            break;
          case TaskStatus.complete:
            status = DownloadStatus.completed;
            break;
          case TaskStatus.failed:
            status = DownloadStatus.failed;
            break;
          case TaskStatus.notFound:
            status = DownloadStatus.notFound;
            break;
          case TaskStatus.paused:
            status = DownloadStatus.paused;
            break;
          default:
            status = DownloadStatus.idle;
        }

        if (update.exception != null) {
          error = update.exception.toString();
        }
      }

      return DownloadTaskModel(
        id: task.taskId,
        url: task.url,
        filename: task.filename,
        progress: progress,
        status: status,
        error: error,
      );
    });
  }
}
