/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-10-10 10:39:04
 */

enum DownloadStatus { idle, running, completed, failed, notFound, paused }

class DownloadTaskModel {
  final String id;
  final String url;
  final String filename;
  final double progress;
  final DownloadStatus status;
  final String? error;

  const DownloadTaskModel({
    required this.id,
    required this.url,
    required this.filename,
    this.progress = 0.0,
    this.status = DownloadStatus.idle,
    this.error,
  });

  DownloadTaskModel copyWith({
    double? progress,
    DownloadStatus? status,
    String? error,
  }) {
    return DownloadTaskModel(
      id: id,
      url: url,
      filename: filename,
      progress: progress ?? this.progress,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
