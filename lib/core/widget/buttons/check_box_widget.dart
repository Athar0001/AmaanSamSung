import 'package:flutter/material.dart';
import 'package:amaan_tv/core/widget/tv_click_button.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';

import 'package:amaan_tv/core/widget/radio%20button/radio_button_multi_select_package.dart';

class CheckBoxWidget extends StatefulWidget {
  const CheckBoxWidget({
    required this.items,
    super.key,
    this.onChanged,
    this.selectedItems,
  });

  final List<String> items;
  final List<String>? selectedItems;
  final ValueChanged<List<String>>? onChanged;

  @override
  CheckBoxListState createState() => CheckBoxListState();
}

class CheckBoxListState extends State<CheckBoxWidget> {
  MultiSelectController<String>? controller = MultiSelectController();
  List<String> selectedValues = [];

  @override
  void initState() {
    selectedValues = widget.selectedItems ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ListView.builder(
      itemCount: widget.items.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: TvClickButton(
            onTap: () {
              if (selectedValues.contains(widget.items[index])) {
                selectedValues.remove(widget.items[index]);
              } else {
                selectedValues.add(widget.items[index]);
              }
              setState(() {});
              widget.onChanged!(selectedValues);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: !selectedValues.contains(widget.items[index])
                  ? containerDecoration(context)
                  : BoxDecoration(
                      color: isDarkMode
                          ? AppColorsNew.white1.withValues(alpha: 0.05)
                          : AppColorsNew.white1.withValues(alpha: 0.8),
                      border: Border.all(color: AppColorsNew.primary),
                    ),
              child: Row(
                children: [
                  Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      color: selectedValues.contains(widget.items[index])
                          ? AppColorsNew.primary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: selectedValues.contains(widget.items[index])
                            ? AppColorsNew.primary
                            : Colors.grey,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.check,
                        color: selectedValues.contains(widget.items[index])
                            ? AppColorsNew.white
                            : Colors.transparent,
                        size: 18,
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Flexible(
                    child: Text(
                      widget.items[index],
                      style: AppTextStylesNew.style14BoldAlmarai,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
