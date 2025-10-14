/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-26 14:04:40
 */

import 'package:json_annotation/json_annotation.dart';

part 'user_request_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class GetUsersRequestDto {
  GetUsersRequestDto();

  factory GetUsersRequestDto.fromJson(Map<String, dynamic> json) =>
      _$GetUsersRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetUsersRequestDtoToJson(this);
}
