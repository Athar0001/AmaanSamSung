import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';

import '../widget/transation_builder.dart';

final class KidsAppTheme {

  // Private constructor for the singleton
  KidsAppTheme._internal();
  static KidsAppTheme? _instance;

  // Singleton instance getter
  static KidsAppTheme get instance {
    _instance ??= KidsAppTheme._internal();
    return _instance!;
  }

  ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: NoTransitionsBuilder(),
          TargetPlatform.iOS: NoTransitionsBuilder(),
        },
      ),
      colorScheme: ColorScheme.light(
          primary: AppColorsNew.primary,
          error: AppColorsNew.red2),
      inputDecorationTheme: InputDecorationTheme(
          errorStyle: AppTextStylesNew.style12RegularAlmarai
              .copyWith(color: AppColorsNew.red2)),
      primaryColor: AppColorsNew.primary,
      primaryColorLight: AppColorsNew.lightGrey4,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColorsNew.scaffoldLightColor,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColorsNew.primary),
        titleTextStyle: AppTextStylesNew.style24BoldAlmarai
            .copyWith(color: AppColorsNew.grey4),
        backgroundColor: AppColorsNew.scaffoldLightColor,
        elevation: 0.0,
        surfaceTintColor: Colors.transparent,
      ),
      textTheme: TextTheme(
        bodyMedium: TextStyle(color: AppColorsNew.grey4),
        labelSmall: TextStyle(color: AppColorsNew.darkGrey1),
        labelMedium: TextStyle(color: AppColorsNew.black1),
        displaySmall: TextStyle(color: AppColorsNew.grey7),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        unselectedItemColor: AppColorsNew.grey4,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 0.0,
        backgroundColor: AppColorsNew.scaffoldLightColor,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColorsNew.scaffoldLightColor,
        surfaceTintColor: AppColorsNew.scaffoldLightColor,
      ),
      iconTheme: IconThemeData(color: AppColorsNew.primary),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: AppColorsNew.scaffoldLightColor,
        dayBackgroundColor: WidgetStateProperty.resolveWith<Color?>(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return AppColorsNew.primary;
            } else if (states.contains(WidgetState.disabled)) {
              return Colors.white;
            }
            return Colors.transparent;
          },
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: AppTextStylesNew.style16BoldAlmarai
              .copyWith(color: AppColorsNew.primary),
        ),
      ),
      dialogTheme: DialogThemeData(
        shadowColor: AppColorsNew.white.withValues(alpha: 0.8),
        backgroundColor: AppColorsNew.scaffoldLightColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        // Add constraints to control dialog size
      ),
      timePickerTheme: TimePickerThemeData(
        backgroundColor: AppColorsNew.scaffoldLightColor,
        hourMinuteColor: AppColorsNew.white,
        hourMinuteTextColor: AppColorsNew.grey4,
        dialHandColor: AppColorsNew.primary,
        dayPeriodColor: AppColorsNew.primary,
      ),
    );
  }

  ///////////////////////////////////////////////////////////////////////////////////
  ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: NoTransitionsBuilder(),
          TargetPlatform.iOS: NoTransitionsBuilder(),
        },
      ),
      primaryColor: AppColorsNew.primary,
      primaryColorLight: AppColorsNew.darkBlue2,
      colorScheme: ColorScheme.dark(
          onPrimary: AppColorsNew.white,
          primary: AppColorsNew.primary,
          error: AppColorsNew.red2),
      inputDecorationTheme: InputDecorationTheme(
          errorStyle: AppTextStylesNew.style12RegularAlmarai
              .copyWith(color: AppColorsNew.red2)),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
          labelSmall: TextStyle(color: AppColorsNew.grey2),
          labelMedium: TextStyle(color: AppColorsNew.white),
          displaySmall: TextStyle(color: AppColorsNew.grey7)),
      iconTheme: IconThemeData(color: AppColorsNew.white),
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColorsNew.scaffoldDarkColor,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        titleTextStyle: AppTextStylesNew.style24BoldAlmarai,
        backgroundColor: AppColorsNew.scaffoldDarkColor,
        elevation: 0,
        surfaceTintColor: AppColorsNew.scaffoldDarkColor,
        iconTheme: const IconThemeData(color: AppColorsNew.grey1),
      ),
      dialogTheme: DialogThemeData(
        shadowColor: AppColorsNew.white.withValues(alpha: 0.05),
        backgroundColor: AppColorsNew.darkBlue2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 24.h),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 0.0,
        backgroundColor: AppColorsNew.darkBlue2,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColorsNew.primary,
        unselectedItemColor: AppColorsNew.grey1,
        selectedLabelStyle: AppTextStylesNew.style12.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: AppTextStylesNew.style12.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColorsNew.scaffoldDarkColor,
        surfaceTintColor: AppColorsNew.scaffoldDarkColor,
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: AppColorsNew.scaffoldDarkColor,
        dayBackgroundColor: WidgetStateProperty.resolveWith<Color?>(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return AppColorsNew.primary;
            } else if (states.contains(WidgetState.disabled)) {
              return Colors.black;
            }
            return Colors.transparent;
          },
        ),
      ),
    );
  }
}
