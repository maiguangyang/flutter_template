/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-16 16:02:15
 */

import 'package:json_annotation/json_annotation.dart';

part 'base_entity.g.dart';

/// 实体基类
///
/// 所有 Entity 都应该继承此类，提供统一的序列化和比较功能。
///
/// 使用方式：
/// ```dart
/// @JsonSerializable(explicitToJson: true)
/// class UserEntity extends BaseEntity {
///   // ...
///   @override
///   List<Object?> get props => [id, name, email];
/// }
/// ```
@JsonSerializable(explicitToJson: true)
class BaseEntity {
  BaseEntity();

  /// 用于相等性比较的属性列表
  ///
  /// 子类应该重写此方法，返回所有需要参与相等性比较的属性。
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<Object?> get props => [];

  /// 判断两个 Entity 是否相等
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! BaseEntity) return false;
    if (runtimeType != other.runtimeType) return false;

    final thisProps = props;
    final otherProps = other.props;

    if (thisProps.length != otherProps.length) return false;

    for (var i = 0; i < thisProps.length; i++) {
      if (thisProps[i] != otherProps[i]) return false;
    }

    return true;
  }

  @override
  int get hashCode => Object.hashAll(props);

  /// 生成易读的调试字符串
  String stringify() => '$runtimeType(${props.join(', ')})';

  factory BaseEntity.fromJson(Map<String, dynamic> json) =>
      _$BaseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BaseEntityToJson(this);
}
