import 'package:flutter/material.dart';
import 'package:amaan_tv/core/widget/tv_click_button.dart';
import 'package:amaan_tv/Features/Home/data/models/home_categories_model/categories.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/category_widget.dart';

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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: _scrollController,
      child: Row(
        children: widget.items.asMap().entries.map((entry) {
          final index = entry.key;
          final category = entry.value;
          final isSelected = index == widget.selectedIndex;

          return TvClickButton(
            onFocusChange: (hasFocus) {
              if (hasFocus) {
                widget.onSelect?.call(index);
                _scrollToIndex(index);
              }
            },
            onTap: () {
              widget.onSelect?.call(index);
              FocusScope.of(context).requestFocus(
                Focus.of(context).enclosingScope?.focusedChild,
              ); // Keep or Request Focus logic
            },
            builder: (context, isFocused) {
              return CategoryWidget(
                category: category,
                isSelected: isSelected,
                isFocused: isFocused,
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
