/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-16 16:02:15
 */

import 'package:json_annotation/json_annotation.dart';

part 'base_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class BaseEntity {
  BaseEntity();

  factory BaseEntity.fromJson(Map<String, dynamic> json) =>
      _$BaseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BaseEntityToJson(this);
}
