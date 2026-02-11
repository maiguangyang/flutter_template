// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponseDto _$UserResponseDtoFromJson(Map<String, dynamic> json) =>
    UserResponseDto(
      id: json['id'] as String,
      username: json['username'] as String,
      sex: json['sex'] as String,
      age: (json['age'] as num).toInt(),
      city: json['city'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$UserResponseDtoToJson(UserResponseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'sex': instance.sex,
      'age': instance.age,
      'city': instance.city,
      'email': instance.email,
    };
