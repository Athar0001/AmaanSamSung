import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:provider/provider.dart';

class RadioButtonMultiSelectPackage extends StatelessWidget {
  const RadioButtonMultiSelectPackage({
    required this.items,
    required this.onChanged,
    super.key,
  });

  final List<String> items;
  final void Function(List<String>, String) onChanged;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      height: 50.h,
      child: Center(
        child: MultiSelectContainer(
          singleSelectedItem: true,
          showInListView: true,
          onChange: onChanged,
          itemsDecoration: MultiSelectDecorations(
            decoration: containerDecoration(context),
            selectedDecoration: BoxDecoration(
              color: AppColorsNew.primary,
              border: Border.all(
                color: isDarkMode
                    ? AppColorsNew.white1.withOpacity(0.1)
                    : AppColorsNew.black1.withOpacity(0.1),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          listViewSettings: ListViewSettings(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => Gap(10.w),
          ),
          items: [
            ...List.generate(items.length, (index) {
              return MultiSelectCard(
                child: SizedBox(
                  width: 160.r, // Set a fixed width for each container
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 12.h,
                    ),
                    child: Text(
                      items[index],
                      style: AppTextStylesNew.style14BoldAlmarai,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                textStyles: MultiSelectItemTextStyles(
                  selectedTextStyle: AppTextStylesNew.style14BoldAlmarai
                      .copyWith(color: AppColorsNew.white1),
                ),
                value: items[index],
                label: items[index],
              );
            }),
          ],
        ),
      ),
    );
  }
}

BoxDecoration containerDecoration(
  BuildContext context, {
  List<BoxShadow>? boxShadow,
  BorderRadiusGeometry? borderRadius,
  Color? borderColor,
  BoxShape? shape,
}) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  return BoxDecoration(
    shape: shape ?? BoxShape.rectangle,
    borderRadius: borderRadius ?? BorderRadius.circular(12.r),
    color: isDarkMode
        ? AppColorsNew.white1.withOpacity(0.05)
        : AppColorsNew.white1.withOpacity(0.8),
    border: Border.all(
      color:
          borderColor ??
          (isDarkMode
              ? AppColorsNew.white1.withOpacity(0.1)
              : AppColorsNew.black1.withOpacity(0.1)),
    ),
    boxShadow: boxShadow,
  );
}

BoxDecoration containerDecorationCircular(
  BuildContext context, {
  List<BoxShadow>? boxShadow,
}) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  return BoxDecoration(
    shape: BoxShape.circle,
    color: isDarkMode
        ? AppColorsNew.white1.withOpacity(0.05)
        : AppColorsNew.white1.withOpacity(0.8),
    border: Border.all(
      color: isDarkMode
          ? AppColorsNew.white1.withOpacity(0.1)
          : AppColorsNew.black1.withOpacity(0.1),
    ),
    boxShadow: boxShadow,
  );
}
