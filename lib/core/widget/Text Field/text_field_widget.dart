import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    this.hintText,
    this.controller,
    this.ontap,
    this.suffixIcon,
    this.obscureText = false,
    this.readOnly = false,
    this.validator,
    this.focusNode,
    this.onFieldSubmitted,
    this.initialValue,
    this.prefixIcon,
    this.hintStyle,
    this.onChanged,
    this.keyboardType,
    this.inputFormatters,
    this.label,
    this.borderRadius,
    this.autofillHints,
    this.textInputAction,
    this.enableInteractiveSelection,
    this.maxLines,
    this.maxLength,
  });

  final String? hintText;
  final String? label;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? readOnly;
  final TextEditingController? controller;
  final bool obscureText;
  final Function()? ontap;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final String? initialValue;
  final int? maxLines;
  final TextStyle? hintStyle;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final double? borderRadius;
  final Iterable<String>? autofillHints;
  final TextInputAction? textInputAction;
  final bool? enableInteractiveSelection;
  final int? maxLength;
  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(label!, style: AppTextStylesNew.style16RegularAlmarai),
        if (label != null) const Gap(10),
        TextFormField(
          maxLength: maxLength,
          initialValue: initialValue,
          autofillHints: autofillHints,
          focusNode: focusNode,
          textInputAction: textInputAction,
          validator: validator,
          obscureText: obscureText,
          controller: controller,
          style: AppTextStylesNew.style14BoldAlmarai,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          readOnly: readOnly ?? false,
          enableInteractiveSelection: enableInteractiveSelection ?? true,
          onTap: ontap,
          keyboardType: keyboardType,
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged,
          inputFormatters: inputFormatters,
          maxLines: maxLines ?? 1,
          decoration: InputDecoration(
            filled: true,
            fillColor: isLight
                ? AppColorsNew.white1
                : AppColorsNew.white1.withOpacity(0.05),
            suffixIcon: suffixIcon == null
                ? null
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.r),
                    child: suffixIcon,
                  ),
            prefixIcon: prefixIcon == null
                ? null
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.r),
                    child: prefixIcon,
                  ),
            contentPadding: padding(),
            hintText: hintText,
            hintStyle:
                hintStyle ??
                AppTextStylesNew.style14RegularAlmarai.copyWith(
                  color: Theme.of(context).textTheme.labelSmall?.color,
                ),
            border: borderBuilder(
              borderRadius: borderRadius,
              color: isLight
                  ? AppColorsNew.black1.withOpacity(0.1)
                  : AppColorsNew.white1.withOpacity(0.1),
            ),
            enabledBorder: borderBuilder(
              borderRadius: borderRadius,
              color: isLight
                  ? AppColorsNew.black1.withOpacity(0.1)
                  : AppColorsNew.white1.withOpacity(0.1),
            ),
            focusedBorder: selectedBorderBuilder(borderRadius: borderRadius),
            errorBorder: borderBuilder(color: AppColorsNew.red2),
            focusedErrorBorder: borderBuilder(color: AppColorsNew.red2),
            errorStyle: AppTextStylesNew.style12BoldAlmarai.copyWith(
              color: AppColorsNew.red2,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

EdgeInsets padding() {
  return EdgeInsets.symmetric(
    horizontal: 1.sw > 1100 ? 15.r : 10.r,
    vertical: 1.sw > 1100 ? 15.r : 10.r,
  );
}

OutlineInputBorder borderBuilder({Color? color, double? borderRadius}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 12.r)),
    borderSide: BorderSide(
      color: color ?? AppColorsNew.black1.withOpacity(0.1),
      width: 0.5,
    ),
  );
}

OutlineInputBorder selectedBorderBuilder({double? borderRadius}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 12.r)),
    borderSide: BorderSide(color: AppColorsNew.primary),
  );
}
