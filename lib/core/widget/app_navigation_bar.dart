import 'dart:io';

import 'package:amaan_tv/Features/Auth/provider/user_notifier.dart';
import 'package:amaan_tv/Features/Home/provider/home_provider.dart';
import 'package:amaan_tv/Features/Home/provider/time_provider.dart';
import 'package:amaan_tv/core/languages/app_localizations.dart';
import 'package:amaan_tv/core/utils/cash_services/cashe_helper.dart';
import 'package:amaan_tv/core/widget/tv_click.dart';
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
import 'package:simple_tv_navigation/simple_tv_navigation.dart';
import '../../Features/Home/provider/show_player_provider.dart';
import '../utils/focus_helper.dart';
import 'custom_dialog.dart';

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({
    this.selectedIndex = 0,
    this.onTabChanged,
    super.key,
  });

  final int selectedIndex;
  final Function(int)? onTabChanged;

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  int _selectedTabIndex = 0;
  bool popupOpen = false;

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
    widget.onTabChanged?.call(index);
  }

  bool _handleKey(KeyEvent event) {
    if (event is KeyDownEvent) {
      print(
          "Key Pressed: ${event.logicalKey.debugName} | ID: ${event.logicalKey.keyId}");
      if (event.logicalKey == LogicalKeyboardKey.escape ||
          event.logicalKey == LogicalKeyboardKey.goBack ||
          event.logicalKey == LogicalKeyboardKey.browserBack ||
          event.logicalKey.keyId == 0x100000009) {
        if (context.tvState.currentlyFocusedElement!.id.contains('player')) {
          final provider = context.read<ShowPlayerProvider>();
          provider.stopAndDispose();
          Navigator.pop(context);
          return true;
        }
        if (context.tvState.currentlyFocusedElement!.id.contains('details') ||
            context.tvState.currentlyFocusedElement!.id.contains('rate') ||
            context.tvState.currentlyFocusedElement!.id.contains('kb.') ||
            context.tvState.currentlyFocusedElement!.id.contains('1') ||
            context.tvState.currentlyFocusedElement!.id.contains('3') ||
            context.tvState.currentlyFocusedElement!.id.contains('5') ||
            context.tvState.currentlyFocusedElement!.id.contains('7') ||
            context.tvState.currentlyFocusedElement!.id
                .contains('characters')) {
          Navigator.pop(context);
        } else if (popupOpen) {
          Navigator.of(context).pop();
          setState(() {
            popupOpen = false;
          });
          context.setFocus(FocusKeys.homeTab);
        } else if (_selectedTabIndex == 0 ||
            context.tvState.currentlyFocusedElement!.id.contains('login')) {
          setState(() {
            popupOpen = true;
          });
          _showExitConfirmationDialog();
        } else if (_selectedTabIndex == 3) {
          Navigator.pop(context);
          context.setFocus(FocusKeys.homeTab);
        } else {
          context.setFocus(FocusKeys.homeTab);
          _onTabSelected(0);
        }
        return false;
      }
    }
    return false;
  }

  void _showExitConfirmationDialog() {
    showDialog<void>(
      context: context,
      builder: (context) {
        context.setFocus(FocusKeys.exitDialogOk);
        return CustomDialog(
          content: Container(
            padding: EdgeInsets.all(24.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'هل تريد مغادرة التطبيق؟',
                  style: AppTextStylesNew.style14RegularAlmarai,
                  textAlign: TextAlign.center,
                ),
                50.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TvClick(
                      id: FocusKeys.exitDialogOk,
                      rightId: FocusKeys.exitDialogCancel,
                      leftId: FocusKeys.exitDialogCancel,
                      onSelect: () {
                        Navigator.of(context).pop();
                        setState(() {
                          popupOpen = false;
                        });
                        context.setFocus(FocusKeys.homeTab);
                        exit(0);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColorsNew.primary),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 16),
                          child: Text(
                            'خروج',
                            style: AppTextStylesNew.style14RegularAlmarai
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    50.horizontalSpace,
                    TvClick(
                      id: FocusKeys.exitDialogCancel,
                      rightId: FocusKeys.exitDialogOk,
                      leftId: FocusKeys.exitDialogOk,
                      onSelect: () {
                        Navigator.of(context).pop();
                        setState(() {
                          popupOpen = false;
                        });
                        context.setFocus(FocusKeys.homeTab);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 16),
                          child: Text(
                            'الغاء',
                            style: AppTextStylesNew.style14RegularAlmarai
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      HardwareKeyboard.instance.addHandler(_handleKey);
    });
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_handleKey);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
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
          50.horizontalSpace,

          /// HOME
          _HeaderTab(
            title: 'الرئيسية',
            isSelected: _selectedTabIndex == 0,
            onTap: () => _onTabSelected(0),
            id: FocusKeys.homeTab,
            autoFocus: true,
            leftId: FocusKeys.seriesTab,
            dynamicDownId: () {
              if (_selectedTabIndex == 0) {
                return FocusKeys.watchNow;
              }
              if (_selectedTabIndex == 1) {
                return FocusId.list(FocusKeys.seriesCategory, 0);
              }
              return FocusId.list(FocusKeys.favCategory, 0);
            },
          ),

          20.horizontalSpace,

          /// SERIES
          _HeaderTab(
            title: 'مسلسلات',
            isSelected: _selectedTabIndex == 1,
            onTap: () => _onTabSelected(1),
            id: FocusKeys.seriesTab,
            rightId: FocusKeys.homeTab,
            leftId: FocusKeys.favTab,
            dynamicDownId: () {
              if (_selectedTabIndex == 0) {
                return FocusKeys.watchNow;
              }
              if (_selectedTabIndex == 1) {
                return FocusId.list(FocusKeys.seriesCategory, 0);
              }
              return FocusId.list(FocusKeys.favCategory, 0);
            },
          ),

          20.horizontalSpace,

          /// FAVORITES
          _HeaderTab(
            title: AppLocalizations.of(context)!.favorites,
            isSelected: _selectedTabIndex == 2,
            onTap: () => _onTabSelected(2),
            id: FocusKeys.favTab,
            rightId: FocusKeys.seriesTab,
            leftId: FocusKeys.searchTab,
            dynamicDownId: () {
              if (_selectedTabIndex == 0) {
                return FocusKeys.watchNow;
              }
              if (_selectedTabIndex == 1) {
                return FocusId.list(FocusKeys.seriesCategory, 0);
              }
              return FocusId.list(FocusKeys.favCategory, 0);
            },
          ),

          const Spacer(),

          /// SEARCH
          Padding(
            padding: const EdgeInsets.all(5),
            child: TvClick(
              id: FocusKeys.searchTab,
              leftId: FocusKeys.logoutTab,
              rightId: FocusKeys.favTab,
              dynamicDownId: () {
                if (_selectedTabIndex == 0) {
                  return FocusKeys.watchNow;
                }
                if (_selectedTabIndex == 1) {
                  return FocusId.list(FocusKeys.seriesCategory, 0);
                }
                return FocusId.list(FocusKeys.favCategory, 0);
              },
              onSelect: () {
                _onTabSelected(3);
                context.pushNamed(AppRoutes.search.routeName).then((value) {
                  if (context.mounted) {
                    context.setFocus(FocusKeys.homeTab);
                    _onTabSelected(0);
                  }
                });
              },
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Icon(
                  Icons.search,
                  color: AppColorsNew.white,
                  size: 25,
                ),
              ),
            ),
          ),

          8.horizontalSpace,

          /// LOGOUT
          Padding(
            padding: const EdgeInsets.all(5),
            child: TvClick(
              id: FocusKeys.logoutTab,
              rightId: FocusKeys.searchTab,
              dynamicDownId: () {
                if (_selectedTabIndex == 0) {
                  return FocusKeys.watchNow;
                }
                if (_selectedTabIndex == 1) {
                  return FocusId.list(FocusKeys.seriesCategory, 0);
                }
                return FocusId.list(FocusKeys.favCategory, 0);
              },
              onSelect: () async {
                await context.read<UserNotifier>().logout();
                await CacheHelper.removeAllData();
                context.read<TimeProvider>().resetVideoLogDataAndTime();
                if (context.mounted) {
                  context.goNamed(AppRoutes.qrLogin.routeName);
                }
              },
              child: Padding(
                padding: EdgeInsets.all(5),
                child: SVGImage(
                  path: Assets.images.loginSvg.path,
                  color: AppColorsNew.red2,
                  width: 35.r,
                  height: 35.r,
                ),
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
  final String id;
  final bool isSelected;
  final VoidCallback onTap;
  final String? leftId;
  final String? rightId;
  final String? downId;
  final bool autoFocus;
  final String Function()? dynamicDownId;

  const _HeaderTab({
    required this.title,
    required this.id,
    required this.isSelected,
    required this.onTap,
    this.leftId,
    this.rightId,
    this.downId,
    this.dynamicDownId,
    this.autoFocus = false,
  });

  @override
  Widget build(BuildContext context) {
    print('$isSelected $id');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TvClick(
        id: id,
        autoFocus: autoFocus,
        leftId: leftId,
        rightId: rightId,
        dynamicDownId: dynamicDownId,
        onSelect: onTap,
        radius: 50.r,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 30.w,
          ),
          decoration: BoxDecoration(
            color: isSelected ? AppColorsNew.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(50.r),
          ),
          child: Center(
            child: Text(
              title,
              style: AppTextStylesNew.style14BoldAlmarai.copyWith(
                color: AppColorsNew.white,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
