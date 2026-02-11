// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_column.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TableColumnCWProxy {
  TableColumn freezePriority(int freezePriority);

  TableColumn sticky(bool sticky);

  TableColumn flex(int flex);

  TableColumn translation(double translation);

  TableColumn minResizeWidth(double? minResizeWidth);

  TableColumn maxResizeWidth(double? maxResizeWidth);

  TableColumn title(String? title);

  TableColumn label(String? label);

  TableColumn width(double? width);

  TableColumn align(AlignmentGeometry align);

  TableColumn ellipsis(bool ellipsis);

  TableColumn render(ColumnRender? render);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `TableColumn(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// TableColumn(...).copyWith(id: 12, name: "My name")
  /// ```
  TableColumn call({
    int freezePriority,
    bool sticky,
    int flex,
    double translation,
    double? minResizeWidth,
    double? maxResizeWidth,
    String? title,
    String? label,
    double? width,
    AlignmentGeometry align,
    bool ellipsis,
    ColumnRender? render,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfTableColumn.copyWith(...)` or call `instanceOfTableColumn.copyWith.fieldName(value)` for a single field.
class _$TableColumnCWProxyImpl implements _$TableColumnCWProxy {
  const _$TableColumnCWProxyImpl(this._value);

  final TableColumn _value;

  @override
  TableColumn freezePriority(int freezePriority) =>
      call(freezePriority: freezePriority);

  @override
  TableColumn sticky(bool sticky) => call(sticky: sticky);

  @override
  TableColumn flex(int flex) => call(flex: flex);

  @override
  TableColumn translation(double translation) => call(translation: translation);

  @override
  TableColumn minResizeWidth(double? minResizeWidth) =>
      call(minResizeWidth: minResizeWidth);

  @override
  TableColumn maxResizeWidth(double? maxResizeWidth) =>
      call(maxResizeWidth: maxResizeWidth);

  @override
  TableColumn title(String? title) => call(title: title);

  @override
  TableColumn label(String? label) => call(label: label);

  @override
  TableColumn width(double? width) => call(width: width);

  @override
  TableColumn align(AlignmentGeometry align) => call(align: align);

  @override
  TableColumn ellipsis(bool ellipsis) => call(ellipsis: ellipsis);

  @override
  TableColumn render(ColumnRender? render) => call(render: render);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `TableColumn(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// TableColumn(...).copyWith(id: 12, name: "My name")
  /// ```
  TableColumn call({
    Object? freezePriority = const $CopyWithPlaceholder(),
    Object? sticky = const $CopyWithPlaceholder(),
    Object? flex = const $CopyWithPlaceholder(),
    Object? translation = const $CopyWithPlaceholder(),
    Object? minResizeWidth = const $CopyWithPlaceholder(),
    Object? maxResizeWidth = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
    Object? label = const $CopyWithPlaceholder(),
    Object? width = const $CopyWithPlaceholder(),
    Object? align = const $CopyWithPlaceholder(),
    Object? ellipsis = const $CopyWithPlaceholder(),
    Object? render = const $CopyWithPlaceholder(),
  }) {
    return TableColumn(
      freezePriority:
          freezePriority == const $CopyWithPlaceholder() ||
              freezePriority == null
          ? _value.freezePriority
          // ignore: cast_nullable_to_non_nullable
          : freezePriority as int,
      sticky: sticky == const $CopyWithPlaceholder() || sticky == null
          ? _value.sticky
          // ignore: cast_nullable_to_non_nullable
          : sticky as bool,
      flex: flex == const $CopyWithPlaceholder() || flex == null
          ? _value.flex
          // ignore: cast_nullable_to_non_nullable
          : flex as int,
      translation:
          translation == const $CopyWithPlaceholder() || translation == null
          ? _value.translation
          // ignore: cast_nullable_to_non_nullable
          : translation as double,
      minResizeWidth: minResizeWidth == const $CopyWithPlaceholder()
          ? _value.minResizeWidth
          // ignore: cast_nullable_to_non_nullable
          : minResizeWidth as double?,
      maxResizeWidth: maxResizeWidth == const $CopyWithPlaceholder()
          ? _value.maxResizeWidth
          // ignore: cast_nullable_to_non_nullable
          : maxResizeWidth as double?,
      title: title == const $CopyWithPlaceholder()
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String?,
      label: label == const $CopyWithPlaceholder()
          ? _value.label
          // ignore: cast_nullable_to_non_nullable
          : label as String?,
      width: width == const $CopyWithPlaceholder()
          ? _value.width
          // ignore: cast_nullable_to_non_nullable
          : width as double?,
      align: align == const $CopyWithPlaceholder() || align == null
          ? _value.align
          // ignore: cast_nullable_to_non_nullable
          : align as AlignmentGeometry,
      ellipsis: ellipsis == const $CopyWithPlaceholder() || ellipsis == null
          ? _value.ellipsis
          // ignore: cast_nullable_to_non_nullable
          : ellipsis as bool,
      render: render == const $CopyWithPlaceholder()
          ? _value.render
          // ignore: cast_nullable_to_non_nullable
          : render as ColumnRender?,
    );
  }
}

extension $TableColumnCopyWith on TableColumn {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfTableColumn.copyWith(...)` or `instanceOfTableColumn.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TableColumnCWProxy get copyWith => _$TableColumnCWProxyImpl(this);

  /// Returns a copy of the object with the selected fields set to `null`.
  /// A flag set to `false` leaves the field unchanged. Prefer `copyWith(field: null)` or `copyWith.fieldName(null)` for single-field updates.
  ///
  /// Example:
  /// ```dart
  /// TableColumn(...).copyWithNull(firstField: true, secondField: true)
  /// ```
  TableColumn copyWithNull({
    bool minResizeWidth = false,
    bool maxResizeWidth = false,
    bool title = false,
    bool label = false,
    bool width = false,
    bool render = false,
  }) {
    return TableColumn(
      freezePriority: freezePriority,
      sticky: sticky,
      flex: flex,
      translation: translation,
      minResizeWidth: minResizeWidth == true ? null : this.minResizeWidth,
      maxResizeWidth: maxResizeWidth == true ? null : this.maxResizeWidth,
      title: title == true ? null : this.title,
      label: label == true ? null : this.label,
      width: width == true ? null : this.width,
      align: align,
      ellipsis: ellipsis,
      render: render == true ? null : this.render,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TableColumn _$TableColumnFromJson(Map<String, dynamic> json) => TableColumn(
  freezePriority: (json['freezePriority'] as num?)?.toInt() ?? 0,
  sticky: json['sticky'] as bool? ?? false,
  flex: (json['flex'] as num?)?.toInt() ?? 0,
  translation: (json['translation'] as num?)?.toDouble() ?? 0,
  minResizeWidth: (json['minResizeWidth'] as num?)?.toDouble(),
  maxResizeWidth: (json['maxResizeWidth'] as num?)?.toDouble(),
  title: json['title'] as String?,
  label: json['label'] as String?,
  width: (json['width'] as num?)?.toDouble(),
  ellipsis: json['ellipsis'] as bool? ?? true,
);

Map<String, dynamic> _$TableColumnToJson(TableColumn instance) =>
    <String, dynamic>{
      'width': instance.width,
      'freezePriority': instance.freezePriority,
      'sticky': instance.sticky,
      'flex': instance.flex,
      'translation': instance.translation,
      'minResizeWidth': instance.minResizeWidth,
      'maxResizeWidth': instance.maxResizeWidth,
      'title': instance.title,
      'label': instance.label,
      'ellipsis': instance.ellipsis,
    };
