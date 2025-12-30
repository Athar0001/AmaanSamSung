import 'package:flutter/material.dart';
import 'package:amaan_tv/core/widget/tv_click_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Themes/app_colors_new.dart';
import '../../Themes/app_text_styles_new.dart';

class RowButtonsWidget extends StatelessWidget {
  const RowButtonsWidget({
    required this.items,
    required this.selectedIndex,
    required this.onChanged,
    super.key,
  });

  final List<String> items;
  final int selectedIndex;
  final void Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
            items.length,
            (index) => TvClickButton(
                  onTap: () => onChanged(index),
                  child: Container(
                    width: 110.r,
                    height: 35.r,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: index == selectedIndex
                          ? const LinearGradient(
                              colors: [
                                Color.fromRGBO(43, 152, 255, 1),
                                Color.fromRGBO(33, 99, 161, 1),
                              ],
                              begin: Alignment.center,
                              end: Alignment.topRight,
                            )
                          : const LinearGradient(
                              colors: [
                                Color.fromRGBO(43, 152, 255, 0.1),
                                Color.fromRGBO(33, 99, 161, 0.1),
                              ],
                              begin: Alignment.center,
                              end: Alignment.topRight,
                            ),
                      border: Border.all(color: AppColorsNew.darkBlue1),
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Text(
                      items[index],
                      style: index == selectedIndex
                          ? AppTextStylesNew.style16BoldAlmarai.copyWith(
                              color: AppColorsNew.white,
                              height: 1,
                            )
                          : AppTextStylesNew.style16BoldAlmarai.copyWith(
                              color:
                                  Theme.of(context).textTheme.bodyMedium?.color,
                              height: 1,
                            ),
                    ),
                  ),
                )),
      ),
    );
  }
}
