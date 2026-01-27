import 'package:amaan_tv/Features/stories/widgets/category_widget.dart';
import 'package:amaan_tv/core/widget/tv_click_button.dart';
import 'package:flutter/material.dart';
import '../../Home/data/models/home_categories_model/categories.dart';

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
            child: TvClickButton(
              onTap: () {
                widget.onSelect?.call(currentStoreIndex);
              },
              builder: (context, hasFocus){
                return CategoryWidget(
                  category: category,
                  isSelected: isSelected,
                  fromAssets: widget.fromAssets,
                  hasFocus: hasFocus,
                );
              },
            ),
          );
        },
      ).toList(),
    );
  }
}
