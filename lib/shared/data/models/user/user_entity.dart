/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-26 08:32:10
 */

import 'package:json_annotation/json_annotation.dart';

import '../base_entity.dart';

part 'user_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class UserEntity extends BaseEntity {
  UserEntity({
    required this.id,
    required this.name,
    required this.sex,
    required this.age,
    required this.city,
    required this.email,
  });

  /// 用户ID
  final String id;

  /// 用户名
  final String name;

  /// 性别
  final String sex;

  /// 年龄
  final int age;

  /// 城市
  final String city;

  /// 邮箱
  final String email;

  // 业务方法
  bool get isEmailVerified => email.isNotEmpty;

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
