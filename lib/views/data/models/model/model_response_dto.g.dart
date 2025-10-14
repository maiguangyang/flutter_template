// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelResponseDto _$ModelResponseDtoFromJson(Map<String, dynamic> json) =>
    ModelResponseDto(
      modelName: json['modelName'] as String,
      type: json['type'] as String,
      paramsSize: (json['paramsSize'] as num).toInt(),
      size: json['size'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$ModelResponseDtoToJson(ModelResponseDto instance) =>
    <String, dynamic>{
      'modelName': instance.modelName,
      'type': instance.type,
      'paramsSize': instance.paramsSize,
      'size': instance.size,
      'status': instance.status,
    };
