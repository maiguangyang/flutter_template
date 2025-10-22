/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-10-10 10:42:52
 */

import 'package:background_downloader/background_downloader.dart';

class DownloadService {
  // 可传入自定义 FileDownloader（例如带 custom PersistentStorage），否则使用默认实例
  final FileDownloader _downloader;

  DownloadService({FileDownloader? fileDownloader})
    : _downloader = fileDownloader ?? FileDownloader();

  /// 等待插件初始化完成（注意：如果使用自定义 persistentStorage，
  /// 在创建 FileDownloader 时传入后也需要等待 ready）
  Future<void> init() async {
    await _downloader.ready;
  }

  DownloadTask createTask(String url, String filename) {
    return DownloadTask(
      url: url,
      filename: filename,
      updates: Updates.statusAndProgress, // 请求状态+进度更新
    );
  }

  /// 以 enqueue 的方式启动（更适合后台/持久化场景），返回是否 enqueue 成功
  Future<bool> enqueue(DownloadTask task) => _downloader.enqueue(task);

  /// 直接下载并等待最终结果，并可传回调（适合前台短任务）
  Future<TaskStatusUpdate> download(
    DownloadTask task, {
    void Function(TaskStatus)? onStatus,
    void Function(double)? onProgress,
  }) {
    return _downloader.download(
      task,
      onStatus: (u) {
        if (onStatus != null) onStatus(u);
      },
      onProgress: (p) {
        if (onProgress != null) onProgress(p);
      },
    );
  }

  /// 用于中心化监听（注意：updates 流只能被监听一次——官方建议在单例处启动订阅）
  Stream<TaskUpdate> get updates => _downloader.updates;

  /// 其它常用封装（pause/resume/cancel 等）
  Future<bool> pause(DownloadTask task) => _downloader.pause(task);
  Future<bool> resume(DownloadTask task) => _downloader.resume(task);
  Future<bool> cancel(DownloadTask task) => _downloader.cancel(task);
}
