/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-26 08:32:10
 */

import 'package:json_annotation/json_annotation.dart';

import 'model_entity.dart';

part 'model_response_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class ModelResponseDto {
  ModelResponseDto({
    required this.modelName,
    required this.type,
    required this.paramsSize,
    required this.size,
    required this.status,
  });

  /// 模型名称
  final String modelName;

  /// 类型
  final String type;

  /// 参数大小
  final int paramsSize;

  /// 尺寸
  final String size;

  /// 状态
  final String status;

  factory ModelResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ModelResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ModelResponseDtoToJson(this);

  // DTO → Entity 转换
  ModelEntity toEntity() {
    return ModelEntity(
      modelName: modelName,
      type: type,
      paramsSize: paramsSize,
      size: size,
      status: status,
    );
  }
}
