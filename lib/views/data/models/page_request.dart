/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2026-01-06 10:18:00
 */

import 'package:json_annotation/json_annotation.dart';

part 'page_request.g.dart';

/// 分页请求基类
///
/// 用于所有需要分页的请求 DTO。
///
/// 使用方式 1：作为 Mixin
/// ```dart
/// @JsonSerializable()
/// class GetUsersRequestDto with PageRequestMixin {
///   GetUsersRequestDto({int page = 1, int size = 20}) {
///     this.page = page;
///     this.size = size;
///   }
/// }
/// ```
///
/// 使用方式 2：继承
/// ```dart
/// @JsonSerializable()
/// class GetUsersRequestDto extends PageRequest {
///   GetUsersRequestDto({super.page, super.size});
/// }
/// ```
@JsonSerializable()
class PageRequest {
  PageRequest({this.page = 1, this.size = 20});

  /// 页码（从 1 开始）
  int page;

  /// 每页数量
  int size;

  /// 偏移量（用于某些 API）
  @JsonKey(includeToJson: false, includeFromJson: false)
  int get offset => (page - 1) * size;

  factory PageRequest.fromJson(Map<String, dynamic> json) =>
      _$PageRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PageRequestToJson(this);

  /// 下一页
  PageRequest nextPage() => PageRequest(page: page + 1, size: size);

  /// 重置到第一页
  PageRequest reset() => PageRequest(page: 1, size: size);

  @override
  String toString() => 'PageRequest(page: $page, size: $size)';
}

/// 分页请求 Mixin
///
/// 用于需要组合其他字段的请求 DTO。
mixin PageRequestMixin {
  int page = 1;
  int size = 20;

  int get offset => (page - 1) * size;

  Map<String, dynamic> pageToJson() => {'page': page, 'size': size};
}
