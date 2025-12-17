import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../Themes/app_colors_new.dart';
import '../../Themes/app_text_styles_new.dart';

class CustomRadioButton extends StatefulWidget {

  const CustomRadioButton({
    required this.title, required this.value, required this.groupValue, required this.onChanged, super.key,
    this.description,
  });
  final String title;
  final String? description;
  final String value;
  final String? groupValue;
  final ValueChanged<String?> onChanged;

  @override
  CustomRadioButtonState createState() => CustomRadioButtonState();
}

class CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 47,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: widget.value == widget.groupValue
                  ? AppColorsNew.shadowColor1
                  : AppColorsNew.white,
              border: Border.all(color: AppColorsNew.grey2)),
          child: RadioListTile<String>(
            selectedTileColor: Colors.yellow,
            hoverColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            visualDensity: VisualDensity.compact,
            contentPadding: const EdgeInsets.all(0),
            title: Text(
              widget.title,
              style: AppTextStylesNew.style14RegularAlmarai.copyWith(
                  color: AppColorsNew.grey3, fontWeight: FontWeight.w700),
            ),
            value: widget.value,
            groupValue: widget.groupValue,
            onChanged: widget.onChanged,
            activeColor: AppColorsNew.primary,
          ),
        ),
        const Gap(8),
        if (widget.description != null) Text(
                widget.description!,
                style: AppTextStylesNew.style12.copyWith(
                  color: AppColorsNew.grey3,
                ),
              ) else const SizedBox(),
      ],
    );
  }
}
