import 'package:flutter/material.dart';
import 'package:amaan_tv/core/widget/tv_click_button.dart';
import 'package:amaan_tv/core/widget/tv_click.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Themes/app_colors_new.dart';
import '../../Themes/app_text_styles_new.dart';
import '../../utils/focus_helper.dart';

class RowButtonsWidget extends StatelessWidget {
  const RowButtonsWidget({
    required this.items,
    required this.selectedIndex,
    required this.onChanged,
    super.key,
    this.upId,
    this.downId,
    this.focusKeyBase = FocusKeys.rowButtons,
    this.autoFocusFirst = false,
  });

  final List<String> items;
  final int selectedIndex;
  final void Function(int) onChanged;
  final String? upId;
  final String? downId;
  final String focusKeyBase;
  final bool autoFocusFirst;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
            items.length,
            (index) => TvClick(
                  id: FocusId.list(focusKeyBase, index),
                  isList: true,
                  index: index,
                  length: items.length,
                  listBaseId: focusKeyBase,
                  upId: upId,
                  downId: downId,
                  autoFocus: autoFocusFirst && index == 0,
                  radius: 12.r,
                  onSelect: () => onChanged(index),
                  child: Container(
                    width: 200.w,
                    height: 60.h,
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

                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      items[index],
                      style: index == selectedIndex
                          ? AppTextStylesNew.style12BoldAlmarai.copyWith(
                              color: AppColorsNew.white,
                              height: 1,
                            )
                          : AppTextStylesNew.style12BoldAlmarai.copyWith(
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
