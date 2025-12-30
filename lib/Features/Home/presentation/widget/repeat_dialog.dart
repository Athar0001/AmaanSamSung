import 'package:flutter/material.dart';
import 'package:amaan_tv/core/widget/tv_click_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/Themes/app_colors_new.dart';
import '../../../../core/Themes/app_text_styles_new.dart';
import '../../../../core/utils/app_localiztion.dart';

class RepeatDialog extends StatefulWidget {
  const RepeatDialog({super.key});

  @override
  State<RepeatDialog> createState() => _RepeatDialogState();
}

class _RepeatDialogState extends State<RepeatDialog> {
  List<int> repeats = [1, 3, 5, 7];
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppLocalization.strings.welcomeFriend,
          style: AppTextStylesNew.style20BoldAlmarai,
        ),
        5.verticalSpace,
        Text(AppLocalization.strings.chooseRepeat,
            style: AppTextStylesNew.style20BoldAlmarai),
        15.verticalSpace,
        SizedBox(
          height: 180.r, // Fixed height instead of Expanded
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 2.2,
            children: List.generate(
                repeats.length,
                (index) => Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TvClickButton(
                        onTap: () {
                          setState(() {
                            selected = repeats[index];
                          });
                          Future.delayed(Duration(milliseconds: 200), () {
                            Navigator.pop(context, selected);
                          });
                        },
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: selected == repeats[index]
                                  ? AppColorsNew.primary
                                  : Colors.white.withOpacity(0.2)),
                          child: Center(
                            child: Text('${repeats[index]}',
                                style: AppTextStylesNew.style20BoldAlmarai),
                          ),
                        ),
                      ),
                    )),
          ),
        ),
      ],
    );
  }
}
