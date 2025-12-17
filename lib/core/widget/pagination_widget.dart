import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/core/models/serialized_object.dart';
import 'package:amaan_tv/core/pagination/pagination_mixin.dart';
import 'package:amaan_tv/core/utils/app_localiztion.dart';
import 'package:amaan_tv/core/utils/enum.dart';
import 'package:amaan_tv/core/utils/widget_sliver_extension.dart';
import 'package:amaan_tv/core/widget/circle_progress_helper.dart';

/// A configurable pagination widget that handles:
/// - Automatic pagination triggers
/// - Loading states management
/// - Customizable item rendering
/// - Optional initial data loading
///
/// Type Parameters:
/// - [T]: Data type of the items being paginated
///
/// Usage:
/// - Requires a [PaginationMixin] implementation for data management
/// - Provides builders for different list states
/// - Supports both automatic and manual initial loading
class PaginationWidget<T extends SerializedObject> extends StatefulWidget {
  const PaginationWidget({
    required this.paginationMixin,
    required this.itemBuilder,
    required this.listBuilder,
    super.key,
    this.loadInitialData = false,
    this.loadingBuilder,
    this.emptyStateBuilder,
    this.emptyStateMessage,
    this.disableEmptyState = false,
    this.isSliver = false,
  });

  /// Controls whether the widget should automatically load initial data
  /// when first initialized. Defaults to false.
  final bool loadInitialData;

  final bool disableEmptyState;

  final bool isSliver;

  /// The pagination controller implementing business logic
  /// Handles:
  /// - Data fetching
  /// - Page tracking
  /// - State management
  final PaginationMixin<T> paginationMixin;

  /// Builder function for rendered items
  ///
  /// Parameters:
  /// - [context]: Current build context
  /// - [index]: Item position in the list
  /// - [item]: Data item to display
  final Widget Function(BuildContext context, int index, T item) itemBuilder;

  /// Builder function for loading indicators
  ///
  /// Parameters:
  /// - [context]: Current build context
  /// - [index]: The index that triggered loading
  final IndexedWidgetBuilder? loadingBuilder;

  /// Builder function for the root list container
  ///
  /// Parameters:
  /// - [context]: Current build context
  /// - [length]: Total number of items (loaded + pending)
  /// - [builder]: Item builder function for ListView
  final Widget Function(
    BuildContext context,
    int length,
    IndexedWidgetBuilder builder,
  )
  listBuilder;

  /// Builder function for empty state
  ///
  /// Parameters:
  /// - [context]: Current build context
  final Widget Function(BuildContext context)? emptyStateBuilder;
  final String? emptyStateMessage;

  @override
  State<PaginationWidget<T>> createState() => _PaginationWidgetState<T>();
}

class _PaginationWidgetState<T extends SerializedObject>
    extends State<PaginationWidget<T>> {
  @override
  void initState() {
    super.initState();
    if (widget.loadInitialData) {
      _loadInitialData();
    }
  }

  /// Loads the first page of data when automatic loading is enabled
  /// Ensures widget is still mounted before updating state
  Future<void> _loadInitialData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await widget.paginationMixin.getData(pageNumber: 1);
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use total length including not-yet-loaded items to maintain
    // correct scroll behavior and pagination triggers
    final totalLength = widget.paginationMixin.totalLength;
    if (widget.paginationMixin.pagination != null && totalLength == 0) {
      final emptyState =
          widget.emptyStateBuilder?.call(context) ??
          Center(
            child: widget.disableEmptyState
                ? const SizedBox()
                : Text(
                    widget.emptyStateMessage ??
                        AppLocalization.strings.emptyStateMessage,
                    textAlign: TextAlign.center,
                    style: AppTextStylesNew.style24BoldAlmarai,
                  ),
          );
      return emptyState.isSliver(widget.isSliver);
    }

    /// Builds the root list container widget
    ///
    /// Parameters:
    /// - [context]: Current build context
    /// - [length]: Total number of items (loaded + pending)
    /// - [builder]: Item builder function for ListView
    ///
    /// Returns: A widget representing the root list container
    ///
    /// This widget builds a list container that handles:
    /// - Automatic pagination triggers
    /// - Loading states management
    /// - Customizable item rendering
    /// - Optional initial data loading
    ///
    /// The list length is determined by the maximum of the total length
    /// including not-yet-loaded items and the initial length set by
    /// the pagination mixin. This ensures correct scroll behavior and
    /// pagination triggers even when the list is initially empty.
    final isLoading =
        widget.paginationMixin.state == AppState.init ||
        widget.paginationMixin.state == AppState.loading;
    final initLength = widget.paginationMixin.pageSize;
    final length = isLoading ? math.max(totalLength, initLength) : totalLength;
    return widget.listBuilder(context, length, _buildListItem);
  }

  /// Builds list items or loading indicators based on current index
  ///
  /// Automatically triggers pagination when reaching unloaded indices
  Widget _buildListItem(BuildContext context, int index) {
    // Render actual items when available
    if (index < widget.paginationMixin.allItems.length) {
      return widget.itemBuilder(
        context,
        index,
        widget.paginationMixin.allItems[index],
      );
    }

    // Trigger pagination and show loading state for unloaded indices
    widget.paginationMixin.loadPageForIndex(
      index,
      onSuccess: (_) => setState(() {}),
    );
    return widget.loadingBuilder?.call(context, index) ??
        const AppCircleProgressHelper();
  }
}
