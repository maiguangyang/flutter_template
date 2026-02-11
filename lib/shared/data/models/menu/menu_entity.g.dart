// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_entity.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MenuEntityCWProxy {
  MenuEntity label(String label);

  MenuEntity route(Route? route);

  MenuEntity icon(IconData? icon);

  MenuEntity iconColor(Color? iconColor);

  MenuEntity type(MenuTypeEnumCore? type);

  MenuEntity badgeCount(int? badgeCount);

  MenuEntity showBadge(bool? showBadge);

  MenuEntity render(MenuRender? render);

  MenuEntity isHideLabel(bool isHideLabel);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MenuEntity(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MenuEntity(...).copyWith(id: 12, name: "My name")
  /// ```
  MenuEntity call({
    String label,
    Route? route,
    IconData? icon,
    Color? iconColor,
    MenuTypeEnumCore? type,
    int? badgeCount,
    bool? showBadge,
    MenuRender? render,
    bool isHideLabel,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMenuEntity.copyWith(...)` or call `instanceOfMenuEntity.copyWith.fieldName(value)` for a single field.
class _$MenuEntityCWProxyImpl implements _$MenuEntityCWProxy {
  const _$MenuEntityCWProxyImpl(this._value);

  final MenuEntity _value;

  @override
  MenuEntity label(String label) => call(label: label);

  @override
  MenuEntity route(Route? route) => call(route: route);

  @override
  MenuEntity icon(IconData? icon) => call(icon: icon);

  @override
  MenuEntity iconColor(Color? iconColor) => call(iconColor: iconColor);

  @override
  MenuEntity type(MenuTypeEnumCore? type) => call(type: type);

  @override
  MenuEntity badgeCount(int? badgeCount) => call(badgeCount: badgeCount);

  @override
  MenuEntity showBadge(bool? showBadge) => call(showBadge: showBadge);

  @override
  MenuEntity render(MenuRender? render) => call(render: render);

  @override
  MenuEntity isHideLabel(bool isHideLabel) => call(isHideLabel: isHideLabel);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MenuEntity(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MenuEntity(...).copyWith(id: 12, name: "My name")
  /// ```
  MenuEntity call({
    Object? label = const $CopyWithPlaceholder(),
    Object? route = const $CopyWithPlaceholder(),
    Object? icon = const $CopyWithPlaceholder(),
    Object? iconColor = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? badgeCount = const $CopyWithPlaceholder(),
    Object? showBadge = const $CopyWithPlaceholder(),
    Object? render = const $CopyWithPlaceholder(),
    Object? isHideLabel = const $CopyWithPlaceholder(),
  }) {
    return MenuEntity(
      label: label == const $CopyWithPlaceholder() || label == null
          ? _value.label
          // ignore: cast_nullable_to_non_nullable
          : label as String,
      route: route == const $CopyWithPlaceholder()
          ? _value.route
          // ignore: cast_nullable_to_non_nullable
          : route as Route?,
      icon: icon == const $CopyWithPlaceholder()
          ? _value.icon
          // ignore: cast_nullable_to_non_nullable
          : icon as IconData?,
      iconColor: iconColor == const $CopyWithPlaceholder()
          ? _value.iconColor
          // ignore: cast_nullable_to_non_nullable
          : iconColor as Color?,
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as MenuTypeEnumCore?,
      badgeCount: badgeCount == const $CopyWithPlaceholder()
          ? _value.badgeCount
          // ignore: cast_nullable_to_non_nullable
          : badgeCount as int?,
      showBadge: showBadge == const $CopyWithPlaceholder()
          ? _value.showBadge
          // ignore: cast_nullable_to_non_nullable
          : showBadge as bool?,
      render: render == const $CopyWithPlaceholder()
          ? _value.render
          // ignore: cast_nullable_to_non_nullable
          : render as MenuRender?,
      isHideLabel:
          isHideLabel == const $CopyWithPlaceholder() || isHideLabel == null
          ? _value.isHideLabel
          // ignore: cast_nullable_to_non_nullable
          : isHideLabel as bool,
    );
  }
}

extension $MenuEntityCopyWith on MenuEntity {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMenuEntity.copyWith(...)` or `instanceOfMenuEntity.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MenuEntityCWProxy get copyWith => _$MenuEntityCWProxyImpl(this);

  /// Returns a copy of the object with the selected fields set to `null`.
  /// A flag set to `false` leaves the field unchanged. Prefer `copyWith(field: null)` or `copyWith.fieldName(null)` for single-field updates.
  ///
  /// Example:
  /// ```dart
  /// MenuEntity(...).copyWithNull(firstField: true, secondField: true)
  /// ```
  MenuEntity copyWithNull({
    bool route = false,
    bool icon = false,
    bool iconColor = false,
    bool type = false,
    bool badgeCount = false,
    bool showBadge = false,
    bool render = false,
  }) {
    return MenuEntity(
      label: label,
      route: route == true ? null : this.route,
      icon: icon == true ? null : this.icon,
      iconColor: iconColor == true ? null : this.iconColor,
      type: type == true ? null : this.type,
      badgeCount: badgeCount == true ? null : this.badgeCount,
      showBadge: showBadge == true ? null : this.showBadge,
      render: render == true ? null : this.render,
      isHideLabel: isHideLabel,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuEntity _$MenuEntityFromJson(Map<String, dynamic> json) => MenuEntity(
  label: json['label'] as String,
  route: MenuEntity._routeFromJson(json['route'] as Map<String, dynamic>?),
  type:
      $enumDecodeNullable(_$MenuTypeEnumCoreEnumMap, json['type']) ??
      MenuTypeEnumCore.destination,
  badgeCount: (json['badgeCount'] as num?)?.toInt(),
  showBadge: json['showBadge'] as bool? ?? false,
  isHideLabel: json['isHideLabel'] as bool? ?? false,
);

Map<String, dynamic> _$MenuEntityToJson(MenuEntity instance) =>
    <String, dynamic>{
      'label': instance.label,
      'route': MenuEntity._routeToJson(instance.route),
      'type': _$MenuTypeEnumCoreEnumMap[instance.type],
      'badgeCount': instance.badgeCount,
      'showBadge': instance.showBadge,
      'isHideLabel': instance.isHideLabel,
    };

const _$MenuTypeEnumCoreEnumMap = {
  MenuTypeEnumCore.leading: 'leading',
  MenuTypeEnumCore.trailing: 'trailing',
  MenuTypeEnumCore.destination: 'destination',
  MenuTypeEnumCore.controller: 'controller',
};
