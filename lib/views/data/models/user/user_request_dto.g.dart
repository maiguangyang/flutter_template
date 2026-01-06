// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUsersRequestDto _$GetUsersRequestDtoFromJson(Map<String, dynamic> json) =>
    GetUsersRequestDto(
      page: (json['page'] as num?)?.toInt() ?? 1,
      size: (json['size'] as num?)?.toInt() ?? 20,
    );

Map<String, dynamic> _$GetUsersRequestDtoToJson(GetUsersRequestDto instance) =>
    <String, dynamic>{'page': instance.page, 'size': instance.size};
