/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-15 15:32:01
 */
import 'package:material_table_view/material_table_view.dart' hide TableColumn;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sugar_talk/abstracts/index.dart';
import 'package:sugar_talk/theme/index.dart';
import 'package:sugar_talk/views/data/models/index.dart';

import 'header_widget.dart';
import 'row_widget.dart';
import 'table_column.dart';

/// 入口层
class OxTable<T> extends CustomStatefulWidget {
  const OxTable({
    super.key,
    required this.columns,
    required this.dataSource,
    this.provider,
    this.pagination,
    this.rowHeight = 50,
    this.headerHeight = 55,
    this.footerHeight = 50,
    this.divider = false,
    this.rowClickable = true,
    this.selection = true,
  });

  /// 列
  final List<TableColumn> columns;

  /// 数据
  final AsyncValue<List<T>> dataSource;

  /// provider
  final $AsyncNotifierProvider? provider;

  /// 分页
  final Widget? pagination;

  /// 列高
  final double rowHeight;

  /// 头高
  final double headerHeight;

  /// 尾高
  final double footerHeight;

  /// 是否显示边框
  final bool divider;

  /// 行点击
  final bool rowClickable;

  /// 是否可选择
  final bool selection;

  @override
  CustomState<OxTable> createState() => _OxTableState<T>();
}

/// 逻辑层
class _OxTableState<T> extends CustomState<OxTable> {
  final TableViewController controller = TableViewController();
  Set<int> selectedRows = {};

  bool allSelected = false;

  /// 切换全选
  void toggleSelectAll(bool? value) {
    setState(() {
      if (allSelected) {
        selectedRows.clear();
      } else {
        selectedRows = Set.from(
          List.generate(widget.dataSource.value?.length ?? 0, (index) => index),
        );
      }
      allSelected = !allSelected;
    });
  }

  /// 切换行选中
  void toggleRowSelection(int index) {
    setState(() {
      if (selectedRows.contains(index)) {
        selectedRows.remove(index);
      } else {
        selectedRows.add(index);
      }
      allSelected = selectedRows.length == widget.dataSource.value?.length;
    });
  }

  @override
  Widget build(BuildContext context) => _OxTableView<T>(this);
}

/// UI层
class _OxTableView<T> extends CustomStatefulView<OxTable, _OxTableState> {
  const _OxTableView(super.state);

  Widget _buildTableView({
    required double maxHeight,
    required List<TableColumn> columns,
    required AsyncValue<List<dynamic>> dataSource,
    required Widget? Function(
      BuildContext context,
      int index,
      Widget Function(BuildContext, Widget Function(BuildContext, int))
      contentBuilder,
    )
    rowBuilder,
  }) {
    final data = dataSource.value ?? [];

    return TableView.builder(
      controller: state.controller,
      columns: columns,
      rowCount: dataSource.isLoading || dataSource.hasError ? 1 : data.length,
      rowHeight: dataSource.isLoading || dataSource.hasError
          ? maxHeight - (widget.headerHeight + widget.footerHeight)
          : widget.rowHeight,
      headerHeight: widget.headerHeight,
      footerHeight: widget.footerHeight,
      headerBuilder: (context, contentBuilder) {
        return HeaderWidget(
          columns: columns,
          rowCount: data.length,
          contentBuilder: contentBuilder,
          allSelected: state.allSelected,
          selection: widget.selection,
          divider: widget.divider,
          toggleSelectAll: state.toggleSelectAll,
        );
      },
      footerBuilder: widget.pagination != null
          ? (context, contentBuilder) => widget.pagination!
          : null,
      rowBuilder: rowBuilder,
    );
  }

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;

        /// columns
        List<TableColumn> columns = widget.columns;
        if (widget.selection) {
          columns = [
            TableColumn(title: '', width: 50, freezePriority: 1),
            ...columns,
          ];
        }

        /// 累计columns总宽度
        final totalWidth = columns.fold<double>(
          50,
          (sum, item) => sum + item.width,
        );

        // 循环改变column的flex、width
        for (int i = 0; i < columns.length; i++) {
          final column = columns[i];

          if (column.width > 0) continue;

          final json = column.toJson();

          // 如果窗口大小 大于 columns总使用的宽度，可用flex
          if (maxWidth > totalWidth) {
            json["flex"] = 1;
          } else {
            json["flex"] = 0;
            json["width"] = 120;
          }

          columns[i] = TableColumn.fromJson(json);
        }

        return widget.dataSource.when(
          data: (data) {
            return _buildTableView(
              maxHeight: maxHeight,
              columns: columns,
              dataSource: widget.dataSource,
              rowBuilder: (context, index, contentBuilder) {
                final bool selected = state.selectedRows.contains(index);
                final row = (data[index] as BaseEntity).toJson();

                return RowWidget(
                  index: index,
                  columns: columns,
                  row: row,
                  contentBuilder: contentBuilder,
                  selected: selected,
                  divider: widget.divider,
                  rowClickable: widget.rowClickable,
                  selection: widget.selection,
                  toggleRowSelection: state.toggleRowSelection,
                );
              },
            );
          },
          error: (error, stackTrace) {
            return _buildTableView(
              maxHeight: maxHeight,
              columns: columns,
              dataSource: widget.dataSource,
              rowBuilder: (context, index, contentBuilder) {
                return GlobalBuildWidget.error(
                  error,
                  ref,
                  provider: widget.provider,
                );
              },
            );
          },
          loading: () {
            return _buildTableView(
              maxHeight: maxHeight,
              columns: columns,
              dataSource: widget.dataSource,
              rowBuilder: (context, index, contentBuilder) {
                return GlobalBuildWidget.loading(ref);
              },
            );
          },
        );
      },
    );
  }
}
