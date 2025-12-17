import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/core/widget/Text%20Field/text_field_widget.dart';

class DropdownButtonWidget extends StatefulWidget {
  const DropdownButtonWidget({
    required this.items,
    super.key,
    this.onChanged,
    this.hint,
    this.menuColor,
    this.prefix,
    this.paddingheight,
    this.paddingwidth,
    this.value,
    this.initAnswers,
    this.validator,
  });

  final List<String> items;
  final String? hint;
  final ValueChanged<String?>? onChanged;
  final ValueChanged<String>? initAnswers;
  final Color? menuColor;
  final Widget? prefix;
  final double? paddingheight;
  final double? paddingwidth;
  final String? value; // Initial value (e.g., past answer)
  final String? Function(String? value)? validator;

  @override
  DropdownButtonWidgetState createState() => DropdownButtonWidgetState();
}

class DropdownButtonWidgetState extends State<DropdownButtonWidget> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    // Initialize `selectedValue` with the past answer or default to null
    selectedValue = widget.value;
    if (selectedValue != null && widget.initAnswers != null) {
      widget.initAnswers!(selectedValue!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return DropdownButtonFormField2<String>(
      isExpanded: true,
      value: selectedValue,
      style: AppTextStylesNew.style14RegularAlmarai,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        prefixIcon: widget.prefix,
        filled: true,
        fillColor: isLight
            ? AppColorsNew.white1
            : AppColorsNew.white1.withValues(alpha: 0.05),
        contentPadding: EdgeInsets.symmetric(
          horizontal: widget.paddingwidth ?? 15.r,
          vertical: widget.paddingheight ?? 12.r,
        ),
        border: borderBuilder(),
        enabledBorder: borderBuilder(),
        focusedBorder: selectedBorderBuilder(),
      ),
      hint: Text(
        widget.hint ?? '',
        style: isLight
            ? AppTextStylesNew.style14RegularAlmarai
            : AppTextStylesNew.style14RegularAlmarai.copyWith(
                color: AppColorsNew.grey2,
              ),
      ),
      items: widget.items
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: AppTextStylesNew.style14RegularAlmarai),
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedValue = value;
        });
        widget.onChanged?.call(value);
      },
      dropdownStyleData: DropdownStyleData(
        padding: EdgeInsets.symmetric(),
        decoration: BoxDecoration(
          color: widget.menuColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      menuItemStyleData: MenuItemStyleData(
        padding: EdgeInsetsDirectional.only(start: 10.r),
        selectedMenuItemBuilder: (context, child) =>
            ColoredBox(color: Colors.black26, child: child),
      ),
    );
  }
}
