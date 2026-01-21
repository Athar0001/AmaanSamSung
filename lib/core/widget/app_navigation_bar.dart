import 'package:amaan_tv/Features/Auth/provider/user_notifier.dart';
import 'package:amaan_tv/Features/Home/provider/time_provider.dart';
import 'package:amaan_tv/core/languages/app_localizations.dart';
import 'package:amaan_tv/core/utils/cash_services/cashe_helper.dart';
import 'package:flutter/material.dart';
import 'package:amaan_tv/core/widget/tv_click_button.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/core/utils/app_router.dart';
import 'package:amaan_tv/core/widget/SVG_Image/svg_img.dart';
import 'package:amaan_tv/gen/assets.gen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({
    this.selectedIndex = 0,
    this.onTabChanged,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int>? onTabChanged;

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  late int _selectedTabIndex;

  @override
  void initState() {
    super.initState();
    _selectedTabIndex = widget.selectedIndex;
  }

  @override
  void didUpdateWidget(AppNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      _selectedTabIndex = widget.selectedIndex;
    }
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
    // Call the callback if provided
    widget.onTabChanged?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black.withOpacity(0.7), Colors.transparent],
        ),
      ),
      child: Row(
        children: [
          // Logo/App Name (Right side for RTL)
          50.horizontalSpace,

          // Tabs (Right side for RTL)
          _HeaderTab(
            title: 'الرئيسية',
            isSelected: _selectedTabIndex == 0,
            onTap: () => _onTabSelected(0),
          ),
          _HeaderTab(
            title: 'مسلسلات',
            isSelected: _selectedTabIndex == 1,
            onTap: () => _onTabSelected(1),
          ),
          _HeaderTab(
            title: AppLocalizations.of(context)!.favorites,
            isSelected: _selectedTabIndex == 2,
            onTap: () => _onTabSelected(2),
          ),

          // Spacer
          Spacer(),

          // Search Icon (Left side for RTL)
          TvClickButton(
            onTap: () {
              context.pushNamed(AppRoutes.search.routeName);
            },
            child: Padding(
              padding: EdgeInsets.all(8.r),
              child: Icon(Icons.search, color: AppColorsNew.white, size: 24.r),
            ),
          ),

          8.horizontalSpace,

          // Logout Icon
          TvClickButton(
            onTap: () async {
              await context.read<UserNotifier>().logout();
              await CacheHelper.removeAllData();
              context.read<TimeProvider>().resetVideoLogDataAndTime();
              if (context.mounted) {
                context.goNamed(AppRoutes.qrLogin.routeName);
              }
            },
            child: Padding(
              padding: EdgeInsets.all(8.r),
              child: SVGImage(
                path: Assets.images.loginSvg.path,
                color: AppColorsNew.red2,
                width: 24.r,
                height: 24.r,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Header Tab Widget
class _HeaderTab extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _HeaderTab({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TvClickButton(
      onTap: onTap,
      focusScale: 1.1,
      builder: (context, focused) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 200),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: isSelected ? AppColorsNew.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(50.r), // Pill shape
            border: Border.all(
              color: focused ? AppColorsNew.white : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Text(
            title,
            style: AppTextStylesNew.style14BoldAlmarai.copyWith(
              color: AppColorsNew.white,
              fontSize: 14.r,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        );
      },
    );
  }
}
