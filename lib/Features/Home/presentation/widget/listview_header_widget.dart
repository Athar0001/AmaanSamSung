import 'package:flutter/material.dart';
import 'package:amaan_tv/core/widget/tv_click_button.dart';
import 'package:amaan_tv/Features/Home/data/models/home_categories_model/categories.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/category_widget.dart';

import '../../../../core/utils/focus_helper.dart';
import '../../../../core/widget/tv_click.dart';

class ListViewHeader extends StatefulWidget {
  const ListViewHeader({
    required this.items,
    super.key,
    this.onSelect,
    this.selectedIndex,
    this.focusNode,
  });

  final List<Category> items;
  final Function(int)? onSelect;
  final int? selectedIndex;
  final FocusNode? focusNode;

  @override
  State<ListViewHeader> createState() => _ListViewHeaderState();
}

class _ListViewHeaderState extends State<ListViewHeader> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToIndex(int index) {
    // Simple offset calculation or use helper to ensure visible
    // For now, basic scrolling
    if (_scrollController.hasClients) {
      // Approximate width of item + padding
      // This is a naive implementation, better to use scroll_to_index if available or just ensure visibility logic
      double itemWidth = 150.0; // Estimate
      double offset = (index * itemWidth) -
          (MediaQuery.of(context).size.width / 2) +
          (itemWidth / 2);
      if (offset < 0) offset = 0;
      if (offset > _scrollController.position.maxScrollExtent)
        offset = _scrollController.position.maxScrollExtent;

      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: widget.items.asMap().entries.map((entry) {
        final index = entry.key;
        final category = entry.value;
        final isSelected = index == widget.selectedIndex;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TvClick(
            id: FocusId.list(FocusKeys.seriesCategory, index),
            isList: true,
            index: index,
            length: widget.items.length,
            upId: FocusKeys.seriesTab,
            listBaseId: FocusKeys.seriesCategory,
            downId: FocusId.grid(FocusKeys.seriesEpisodes, 0, 0),
            onSelect: () {
              widget.onSelect?.call(index);
              FocusScope.of(context).requestFocus(
                Focus.of(context).enclosingScope?.focusedChild,
              ); // Keep or Request Focus logic
            },
            child: CategoryWidget(
              category: category,
              isSelected: isSelected,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class ListViewHeaderFavorite extends StatefulWidget {
  const ListViewHeaderFavorite({
    required this.items,
    super.key,
    this.onSelect,
    this.selectedIndex,
    this.focusNode,
  });

  final List<Category> items;
  final Function(int)? onSelect;
  final int? selectedIndex;
  final FocusNode? focusNode;

  @override
  State<ListViewHeaderFavorite> createState() => _ListViewHeaderFavoriteState();
}

class _ListViewHeaderFavoriteState extends State<ListViewHeaderFavorite> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToIndex(int index) {
    // Simple offset calculation or use helper to ensure visible
    // For now, basic scrolling
    if (_scrollController.hasClients) {
      // Approximate width of item + padding
      // This is a naive implementation, better to use scroll_to_index if available or just ensure visibility logic
      double itemWidth = 150.0; // Estimate
      double offset = (index * itemWidth) -
          (MediaQuery.of(context).size.width / 2) +
          (itemWidth / 2);
      if (offset < 0) offset = 0;
      if (offset > _scrollController.position.maxScrollExtent)
        offset = _scrollController.position.maxScrollExtent;

      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: widget.items.asMap().entries.map((entry) {
        final index = entry.key;
        final category = entry.value;
        final isSelected = index == widget.selectedIndex;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TvClick(
            id: FocusId.list(FocusKeys.favCategory, index),
            isList: true,
            index: index,
            length: widget.items.length,
            upId: FocusKeys.favTab,
            listBaseId: FocusKeys.favCategory,
            dynamicDownId: () {
              if (widget.selectedIndex == 0) {
                return FocusId.grid(FocusKeys.favEpisodes, 0, 0);
              } else if (widget.selectedIndex == 1) {
                return FocusId.grid(FocusKeys.favShows, 0, 0);
              } else {
                return FocusId.grid(FocusKeys.favCharacters, 0, 0);
              }
            },
            onSelect: () {
              widget.onSelect?.call(index);
              FocusScope.of(context).requestFocus(
                Focus.of(context).enclosingScope?.focusedChild,
              ); // Keep or Request Focus logic
            },
            child: CategoryWidget(
              category: category,
              isSelected: isSelected,
            ),
          ),
        );
      }).toList(),
    );
  }
}
