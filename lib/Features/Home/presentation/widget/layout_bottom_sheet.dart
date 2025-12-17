import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/Features/Auth/provider/user_notifier.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/generated/assets.dart' show Assets;
import 'package:amaan_tv/Features/Auth/presentation/widget/request_login_dialog.dart';
import 'package:amaan_tv/Features/Home/provider/bottom_bar_provider.dart';
import 'package:amaan_tv/core/widget/SVG_Image/svg_img.dart';
import 'package:provider/provider.dart';

class LayoutBottomSheet extends StatelessWidget {
  const LayoutBottomSheet({required this.layoutProvider, super.key});

  final BottomBarProvider layoutProvider;

  @override
  Widget build(BuildContext context) {
    // Detect text direction (LTR or RTL)
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    // Calculate the width of each tab section
    final tabWidth =
        (MediaQuery.of(context).size.width - 20.r) /
        layoutProvider.items.length;
    return Container(
      color: Colors.transparent,
      height: 90.r + MediaQuery.of(context).padding.bottom,
      child: Stack(
        children: [
          // Bottom Navigation Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 70.r + MediaQuery.of(context).padding.bottom,
              padding: EdgeInsets.only(
                top: 20.r, // Increased top padding to accommodate circle
                bottom: 5.r,
                left: 10.r,
                right: 10.r,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(-3, -3),
                    blurRadius: 8,
                    spreadRadius: 3,
                    color: AppColorsNew.shadow.withValues(alpha: .1),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(layoutProvider.items.length, (
                      index,
                    ) {
                      final isGameicon =
                          layoutProvider.items[index].activeIcon ==
                          Assets.images.games.path;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (context.read<UserNotifier>().userData == null &&
                                index != 0 &&
                                index != 1) {
                              RequestLoginDialog.show(context);
                            } else {
                              layoutProvider.changeIndex(index: index);
                            }
                          },
                          behavior: HitTestBehavior.translucent,
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(bottom: 10.r),
                            child: SVGImage(
                              width: 33.r,
                              height: 33.r,
                              noTheme: isGameicon,
                              path: layoutProvider.currentIndex == index
                                  ? layoutProvider.items[index].activeIcon
                                  : layoutProvider.items[index].icon,
                              color: layoutProvider.currentIndex == index
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context)
                                        .bottomNavigationBarTheme
                                        .unselectedItemColor,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          // Animated Circle Indicator (Localized for LTR/RTL)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 900),
            curve: Curves.easeOutBack,
            top: 0.r, // Adjusted to sit slightly higher
            left: isRtl
                ? (MediaQuery.of(context).size.width -
                      10.r -
                      (tabWidth * layoutProvider.currentIndex) -
                      (tabWidth / 2) -
                      20.r)
                : (10.r +
                      (tabWidth * layoutProvider.currentIndex) +
                      (tabWidth / 2) -
                      20.r),
            child: Container(
              width: 40.r,
              height: 40.r,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColorsNew.shadow.withValues(alpha: 0.1),
                    offset: Offset(0, -4), // Negative y for upper shadow
                    blurRadius: 8,
                  ),
                ],
                border: Border.all(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: 13.r,
                ),
                color: AppColorsNew.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
