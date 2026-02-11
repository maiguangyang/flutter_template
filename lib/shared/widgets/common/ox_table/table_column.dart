/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-16 21:22:17
 */
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:material_table_view/material_table_view.dart' as t;

part 'table_column.g.dart';

// 定义渲染函数类型
typedef ColumnRender =
    Widget Function(BuildContext context, Map<String, dynamic> data);

@JsonSerializable(explicitToJson: true)
@CopyWith(copyWithNull: true)
class TableColumn extends t.TableColumn {
  TableColumn({
    super.freezePriority,
    super.sticky,
    super.flex,
    super.translation,
    super.minResizeWidth,
    super.maxResizeWidth,
    this.title,
    this.label,
    double? width,
    this.align = Alignment.centerLeft,
    this.ellipsis = true,
    this.render,
  }) : super(width: width ?? -1.0);

  /// 标题
  final String? title;

  /// label
  final String? label;

  /// 列内容是否省略;
  final bool ellipsis;

  /// 列内容对齐方式
  @JsonKey(includeFromJson: false, includeToJson: false)
  final AlignmentGeometry align;

  /// 自定义渲染
  @JsonKey(includeFromJson: false, includeToJson: false)
  final ColumnRender? render;

  factory TableColumn.fromJson(Map<String, dynamic> json) =>
      _$TableColumnFromJson(json);

  Map<String, dynamic> toJson() => _$TableColumnToJson(this);
}
