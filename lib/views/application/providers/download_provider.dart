/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-10-22 21:43:35
 */

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/views/data/index.dart';

/// 提供 DownloadService 实例
final downloadApiProvider = Provider<DownloadService>((ref) {
  return DownloadService();
});

/// 提供 DownloadRepository 实例
final downloadRepositoryProvider = Provider<DownloadRepository>((ref) {
  final api = ref.watch(downloadApiProvider);
  return DownloadRepository(api);
});
