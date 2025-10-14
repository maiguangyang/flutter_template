/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-26 08:32:10
 */

import 'package:json_annotation/json_annotation.dart';

import 'user_entity.dart';

part 'user_response_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class UserResponseDto {
  UserResponseDto({
    required this.id,
    required this.username,
    required this.sex,
    required this.age,
    required this.city,
    required this.email,
  });

  /// 用户ID
  final String id;

  /// 用户名
  final String username;

  /// 性别
  final String sex;

  /// 年龄
  final int age;

  /// 城市
  final String city;

  /// 邮箱
  final String email;

  factory UserResponseDto.fromJson(Map<String, dynamic> json) =>
      _$UserResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseDtoToJson(this);

  // DTO → Entity 转换
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: username,
      sex: sex,
      age: age,
      city: city,
      email: email,
    );
  }
}
