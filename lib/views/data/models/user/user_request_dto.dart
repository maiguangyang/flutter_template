/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-26 14:04:40
 */

import 'package:json_annotation/json_annotation.dart';

import '../page_request.dart';

part 'user_request_dto.g.dart';

/// 获取用户列表请求
@JsonSerializable(explicitToJson: true)
class GetUsersRequestDto extends PageRequest {
  GetUsersRequestDto({super.page, super.size});

  factory GetUsersRequestDto.fromJson(Map<String, dynamic> json) =>
      _$GetUsersRequestDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetUsersRequestDtoToJson(this);
}
