/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-13 15:40:12
 */
import 'package:flutter_oxygen/scripts/builds/client_item.dart' as client;
import 'package:json_annotation/json_annotation.dart';

part 'client_item.g.dart';

@JsonSerializable(explicitToJson: true)
class ClientItem extends client.ClientItem {
  const ClientItem({
    required super.password,
    required super.clientName,
    required super.projectName,
    required super.appName,
    required super.apiUrl,
    required super.version,
    super.defaultLanguage,
    super.primaryColor,
    super.env,
  });

  factory ClientItem.fromJson(Map<String, dynamic> json) =>
      _$ClientItemFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ClientItemToJson(this);
}
