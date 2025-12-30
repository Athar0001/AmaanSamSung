import 'package:flutter/material.dart';
import 'package:amaan_tv/core/widget/tv_click_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/core/utils/app_localiztion.dart';
import 'package:amaan_tv/core/utils/asset_manager.dart';
import 'package:amaan_tv/core/widget/Text%20Field/text_field_widget.dart';

import '../SVG_Image/svg_img.dart';

class LimitedWidthPopup extends StatelessWidget {
  const LimitedWidthPopup({
    required this.child,
    super.key,
    this.width = 0.9,
    this.height,
    this.borderRadius,
  });

  final Widget child;
  final double width;
  final double? height;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 400.r, maxHeight: 400.r),
        width: width.sw,
        height: height?.r,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: borderRadius ?? BorderRadius.circular(16.r),
        ),
        child: child,
      ),
    );
  }
}

class DatePickerTextField extends StatefulWidget {
  const DatePickerTextField({
    this.dateController,
    super.key,
    this.hintText,
    this.initialDate,
    this.minimumDate,
    this.maximumDate,
    this.onChange,
    this.validator,
    this.isParent = true,
    this.defaultValues = true,
  });

  final TextEditingController? dateController;
  final String? hintText;
  final String? initialDate;
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final void Function(DateTime date)? onChange;
  final bool isParent;
  final bool defaultValues;
  final String? Function(String?)? validator;

  @override
  DatePickerTextFieldState createState() => DatePickerTextFieldState();
}

class DatePickerTextFieldState extends State<DatePickerTextField> {
  late final dateController =
      widget.dateController ?? TextEditingController(text: widget.initialDate);
  final dateFormat = DateFormat('yyyy-MM-dd');

  @override
  void dispose() {
    super.dispose();
    if (widget.dateController == null) dateController.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? initialDate;

    initialDate = dateFormat.tryParse(dateController.text);

    if (widget.defaultValues) {
      initialDate ??= widget.isParent ? DateTime(2005) : DateTime.now();
    } else {
      initialDate ??= widget.minimumDate;
    }

    final DateTime? minimumDate;
    final DateTime? maximumDate;
    if (widget.defaultValues) {
      minimumDate = widget.minimumDate ?? DateTime(1950);
      maximumDate = widget.maximumDate ?? DateTime.now();
    } else {
      minimumDate = widget.minimumDate;
      maximumDate = widget.maximumDate;
    }

    await showCupertinoModalPopup<void>(
      context: context,
      builder: (context) {
        return LimitedWidthPopup(
          child: Column(
            children: [
              Expanded(
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle:
                          AppTextStylesNew.style16BoldAlmarai.copyWith(
                        color: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: initialDate,
                    minimumDate: minimumDate,
                    maximumDate: maximumDate,
                    onDateTimeChanged: (newDate) {
                      final formattedDate = dateFormat.format(newDate);
                      setState(() {
                        dateController.text = formattedDate;
                      });
                    },
                  ),
                ),
              ),
              Container(
                height: 50.r,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Theme.of(context).dividerColor),
                  ),
                ),
                child: Center(
                  child: TvClickButton(
                    onTap: () {
                      Navigator.pop(context);
                      final date = dateFormat.tryParse(dateController.text) ??
                          initialDate ??
                          DateTime.now();
                      if (dateController.text.isEmpty) {
                        dateController.text = dateFormat.format(date);
                      }
                      widget.onChange?.call(date);
                    },
                    child: Text(
                      AppLocalization.strings.accept,
                      style: AppTextStylesNew.style16BoldAlmarai.copyWith(
                        color: AppColorsNew.primary,
                      ),
                    ),
                  ),
                ),
              ),
              30.verticalSpace,
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      controller: dateController,
      hintText: widget.hintText,
      prefixIcon: SVGImage(
        path: Assets.imagesCalendarEdit,
        color: Theme.of(context).textTheme.labelSmall?.color,
      ),
      validator: widget.validator,
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return AppLocalization.strings.thisFieldRequired;
      //   }
      //   return null;
      // },
      ontap: () {
        _selectDate(context);
      },
      readOnly: true,
    );
  }
}
