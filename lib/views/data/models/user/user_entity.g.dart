// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
  id: json['id'] as String,
  name: json['name'] as String,
  sex: json['sex'] as String,
  age: (json['age'] as num).toInt(),
  city: json['city'] as String,
  email: json['email'] as String,
);

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sex': instance.sex,
      'age': instance.age,
      'city': instance.city,
      'email': instance.email,
    };
