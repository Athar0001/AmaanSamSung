
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/core/utils/app_router.dart';
import 'package:go_router/go_router.dart';

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

          // Spacer
          Spacer(),

          // Search Icon (Left side for RTL)
          IconButton(
            onPressed: () {
              context.pushNamed(AppRoutes.search.routeName);
            },
            icon: Icon(Icons.search, color: AppColorsNew.white, size: 24.r),
          ),

          8.horizontalSpace,

          // Profile Icon (Left side for RTL)
          Container(
            width: 36.r,
            height: 36.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.2),
            ),
            child: Icon(Icons.person, color: AppColorsNew.white, size: 20.r),
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
    return Focus(
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent &&
            (event.logicalKey == LogicalKeyboardKey.enter ||
                event.logicalKey == LogicalKeyboardKey.select)) {
          onTap.call();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: Builder(
        builder: (context) {
          final focused = Focus.of(context).hasFocus;
          return GestureDetector(
            onTap: onTap,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              margin: EdgeInsets.only(left: 8.w),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected ? AppColorsNew.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color:
                  focused? AppColorsNew.white :
                  isSelected ? AppColorsNew.primary : Colors.transparent,
                  width: 1,
                ),
              ),
              child: Text(
                title,
                style: AppTextStylesNew.style14BoldAlmarai.copyWith(
                  color: AppColorsNew.white,
                  fontSize: isSelected ? 15.r : 14.r,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
