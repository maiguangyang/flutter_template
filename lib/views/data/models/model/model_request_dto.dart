/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-23 13:42:16
 */
import 'package:json_annotation/json_annotation.dart';

part 'model_request_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class GetModelsRequestDto {
  GetModelsRequestDto();

  factory GetModelsRequestDto.fromJson(Map<String, dynamic> json) =>
      _$GetModelsRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetModelsRequestDtoToJson(this);
}
