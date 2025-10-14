/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-17 13:58:48
 */
import 'package:flutter_template/abstracts/index.dart';

typedef PageChangedCallback = void Function(int page, int pageSize);

/// 入口层
class OxPagination extends CustomStatefulWidget {
  const OxPagination({
    super.key,
    this.current = 1,
    required this.total,
    this.pageSize = 10,
    this.pageSizeOptions,
    this.simple = false,
    this.hideOnSinglePage = false,
    this.showSizeChanger = false,
    this.onPageChanged,
    this.onPageSizeChanged,
    this.showEllipsis = true,
    this.alignment = MainAxisAlignment.center,
  });

  /// 当前页，从 1 开始
  final int current;

  /// 总条目数
  final int total;

  /// 每页条数
  final int pageSize;

  /// 可选的每页条数选项
  final List<int>? pageSizeOptions;

  /// 简洁模式
  final bool simple;

  /// 如果只有一页，是否隐藏
  final bool hideOnSinglePage;

  /// 是否显示 pageSize 的切换器
  final bool showSizeChanger;

  /// 页码改变回调
  final PageChangedCallback? onPageChanged;

  /// pageSize 改变回调
  final PageChangedCallback? onPageSizeChanged;

  /// 是否启用省略号
  final bool showEllipsis;

  /// 对齐方式
  final MainAxisAlignment alignment;

  @override
  CustomState<OxPagination> createState() => _OxPaginationState();
}

/// 逻辑层
class _OxPaginationState extends CustomState<OxPagination> {
  late int _currentPage;
  late int _pageSize;
  late int _pageCount;
  // final TextEditingController _jumpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentPage = widget.current;
    _pageSize = widget.pageSize;
    _calcPageCount();
  }

  @override
  void didUpdateWidget(OxPagination oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.current != oldWidget.current) {
      _currentPage = widget.current;
    }
    if (widget.pageSize != oldWidget.pageSize) {
      _pageSize = widget.pageSize;
    }
    if (widget.total != oldWidget.total ||
        widget.pageSize != oldWidget.pageSize) {
      _calcPageCount();
      if (_currentPage > _pageCount) {
        _currentPage = _pageCount;
        widget.onPageChanged?.call(_currentPage, _pageSize);
      }
    }
  }

  void _calcPageCount() {
    if (widget.pageSize <= 0) {
      _pageCount = 1;
    } else {
      _pageCount = ((widget.total + widget.pageSize - 1) / widget.pageSize)
          .ceil();
      if (_pageCount < 1) _pageCount = 1;
    }
  }

  void _goToPage(int page) {
    if (page < 1) page = 1;
    if (page > _pageCount) page = _pageCount;
    if (page != _currentPage) {
      setState(() {
        _currentPage = page;
      });
      widget.onPageChanged?.call(_currentPage, _pageSize);
    }
  }

  void _changePageSize(int newSize) {
    if (newSize != _pageSize) {
      setState(() {
        _pageSize = newSize;
        _calcPageCount();
        if (_currentPage > _pageCount) {
          _currentPage = _pageCount;
        }
      });
      widget.onPageSizeChanged?.call(_currentPage, _pageSize);
      widget.onPageChanged?.call(_currentPage, _pageSize);
    }
  }

  @override
  Widget build(BuildContext context) => _OxPaginationView(this);
}

/// UI层
class _OxPaginationView
    extends CustomStatefulView<OxPagination, _OxPaginationState> {
  const _OxPaginationView(super.state);

  Widget _buildPageButton(WidgetRef ref, int page) {
    final theme = ref.watch(themeProvider);

    bool isActive = page == state._currentPage;
    return GestureDetector(
      onTap: () => state._goToPage(page),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: EdgeInsets.symmetric(
          vertical: theme.spacing4,
          horizontal: theme.spacing10,
        ),
        decoration: BoxDecoration(
          color: isActive ? theme.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isActive ? theme.primaryColor : theme.inputBorderColor,
          ),
        ),
        child: Text(
          '$page',
          style: TextStyle(
            color: isActive
                ? Colors.white
                : theme.textTitleColor.withValues(alpha: 0.8),
            fontSize: theme.fontSize14,
          ),
        ),
      ),
    );
  }

  Widget _buildEllipsis() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: const Text("..."),
    );
  }

  /// 构建页码列表（带省略号）
  List<Widget> _buildPageItems(WidgetRef ref) {
    final List<Widget> items = [];
    final int pageCount = state._pageCount;
    final int current = state._currentPage;

    // 页码少时直接全部显示
    if (!widget.showEllipsis || pageCount <= 7) {
      for (int i = 1; i <= pageCount; i++) {
        items.add(_buildPageButton(ref, i));
      }
      return items;
    }

    // 总是显示第一页
    items.add(_buildPageButton(ref, 1));

    // 当前页在前部
    if (current <= 4) {
      for (int i = 2; i <= 5; i++) {
        items.add(_buildPageButton(ref, i));
      }
      items.add(_buildEllipsis());
    }
    // 当前页在尾部
    else if (current >= pageCount - 3) {
      items.add(_buildEllipsis());
      for (int i = pageCount - 4; i < pageCount; i++) {
        items.add(_buildPageButton(ref, i));
      }
    }
    // 当前页在中间
    else {
      items.add(_buildEllipsis());
      for (int i = current - 1; i <= current + 1; i++) {
        items.add(_buildPageButton(ref, i));
      }
      items.add(_buildEllipsis());
    }

    // 总是显示最后一页
    items.add(_buildPageButton(ref, pageCount));

    return items;
  }

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    if (widget.hideOnSinglePage && state._pageCount <= 1) {
      return const SizedBox.shrink();
    }

    /// 构建分页按钮
    final pageSizeOptions = widget.pageSizeOptions ?? [10, 20, 50, 100];

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: widget.alignment,
      children: [
        // Prev button
        if (state._currentPage > 1)
          GestureDetector(
            child: Icon(
              Icons.chevron_left,
              color: theme.grey,
              size: theme.fontSize24,
            ),
            onTap: state._currentPage > 1
                ? () => state._goToPage(state._currentPage - 1)
                : null,
          ),

        if (!widget.simple)
          ..._buildPageItems(ref)
        else
          Text(
            "${state._currentPage} / ${state._pageCount}",
            style: TextStyle(fontSize: theme.fontSize14),
          ),

        // Next button
        if (state._currentPage < state._pageCount)
          GestureDetector(
            child: Icon(
              Icons.chevron_right,
              color: theme.grey,
              size: theme.fontSize24,
            ),
            onTap: state._currentPage < state._pageCount
                ? () => state._goToPage(state._currentPage + 1)
                : null,
          ),

        // pageSize 切换器
        if (widget.showSizeChanger) ...[
          const SizedBox(width: 16),
          Theme(
            data: Theme.of(context).copyWith(
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
            ),
            child: DropdownButton<int>(
              value: state._pageSize,
              style: TextStyle(
                fontSize: theme.fontSize,
                color: theme.textTitleColor.withValues(alpha: 0.8),
              ),
              items: pageSizeOptions
                  .map(
                    (opt) => DropdownMenuItem<int>(
                      value: opt,
                      child: Text('$opt / ${ref.lang.page}'),
                    ),
                  )
                  .toList(),
              onChanged: (val) {
                if (val != null) state._changePageSize(val);
              },
            ),
          ),
        ],
      ],
    );
  }
}
