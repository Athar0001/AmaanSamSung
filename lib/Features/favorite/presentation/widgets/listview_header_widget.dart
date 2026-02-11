
import 'package:flutter/material.dart';
import '../../../../core/utils/focus_helper.dart';
import '../../../../core/widget/tv_click.dart';
import '../../../Home/data/models/home_categories_model/categories.dart';
import '../../../Home/presentation/widget/category_widget.dart';

class ListViewHeader extends StatefulWidget {
  const ListViewHeader({
    required this.items,
    super.key,
    this.onSelect,
    this.selectedIndex,
    this.fromAssets = false,
  });

  final List<Category> items;
  final Function(int)? onSelect;
  final int? selectedIndex;
  final bool fromAssets;

  @override
  State<ListViewHeader> createState() => _ListViewHeaderState();
}

class _ListViewHeaderState extends State<ListViewHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(

      children: widget.items.map(
        (category) {
          final currentStoreIndex = widget.items.indexOf(category);
          final isSelected = currentStoreIndex == widget.selectedIndex;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: TvClick(
              id: FocusId.list(FocusKeys.favCategory, currentStoreIndex),
              isList: true,
              index: currentStoreIndex,
              length: widget.items.length,
              downId: FocusId.favGridEntryKey(widget.selectedIndex!),
              upId: FocusKeys.homeTab,
              onSelect: () {
                widget.onSelect?.call(currentStoreIndex);
              },
              child: CategoryWidget(
                category: category,
                isSelected: isSelected,
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
