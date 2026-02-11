/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-26 08:32:10
 */
// features/auth/data/models/user.dart

import 'dart:async';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:flutter_oxygen/flutter_oxygen.dart';
import 'package:json_annotation/json_annotation.dart';

part 'menu_entity.g.dart';

typedef MenuRender =
    FutureOr<void> Function(BuildContext context, MenuEntity data);

@JsonSerializable(explicitToJson: true)
@CopyWith(copyWithNull: true)
class MenuEntity {
  MenuEntity({
    required this.label,
    this.route,
    this.icon,
    this.iconColor,
    this.type = MenuTypeEnumCore.destination,
    this.badgeCount,
    this.showBadge = false,
    this.render,
    this.isHideLabel = false,
  });

  /// 标签
  final String label;

  /// 图标
  @JsonKey(includeFromJson: false, includeToJson: false)
  final IconData? icon;

  /// 图标颜色
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Color? iconColor;

  /// 路由名称
  @JsonKey(fromJson: _routeFromJson, toJson: _routeToJson)
  final Route? route;

  /// 类型
  @JsonKey(defaultValue: MenuTypeEnumCore.destination)
  final MenuTypeEnumCore? type;

  /// 角标数量
  @JsonKey(defaultValue: null)
  final int? badgeCount;

  /// 是否显示角标
  @JsonKey(defaultValue: false)
  final bool? showBadge;

  /// 是否是控制器
  @JsonKey(includeFromJson: false, includeToJson: false)
  final MenuRender? render;

  /// 是否隐藏标签
  @JsonKey(defaultValue: false)
  final bool isHideLabel;

  /// 是否有角标
  bool get hasBadgeCount =>
      showBadge == true || badgeCount != null && badgeCount! > 0;

  /// 跳转
  Future<void> goTo() async {
    // 当前路由相同，则不执行跳转
    if (NavigatorUtilsCore.instance.currentRoute?.name == route?.name ||
        route == null) {
      return;
    }

    // 获取路由
    final routes = NavigatorUtilsCore.instance.routes;

    final currentRoute = routes
        .where((item) => item.name == route?.name)
        .firstOrNull;

    if (currentRoute != null) {
      final route = Route(name: currentRoute.name, path: currentRoute.path);
      NavigatorUtilsCore.go(route);
    }
  }

  static Route? _routeFromJson(Map<String, dynamic>? json) =>
      json == null ? null : Route.fromJson(json);

  static Map<String, dynamic>? _routeToJson(Route? route) => route?.toJson();

  factory MenuEntity.fromJson(Map<String, dynamic> json) =>
      _$MenuEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MenuEntityToJson(this);
}
