/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-26 08:32:10
 */
// features/auth/data/models/user.dart

import 'package:json_annotation/json_annotation.dart';

import '../base_entity.dart';

part 'model_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class ModelEntity extends BaseEntity {
  ModelEntity({
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

  factory ModelEntity.fromJson(Map<String, dynamic> json) =>
      _$ModelEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ModelEntityToJson(this);
}
