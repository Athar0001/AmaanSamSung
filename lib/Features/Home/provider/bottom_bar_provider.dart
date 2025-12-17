import 'package:flutter/material.dart';
import 'package:amaan_tv/gen/assets.gen.dart';
import 'package:amaan_tv/Features/Auth/data/models/login_model.dart';
import 'package:amaan_tv/Features/Home/presentation/screens/soon_screen.dart';
import 'package:amaan_tv/Features/child_profile/presentation/screens/child_profile_screen.dart';
import 'package:amaan_tv/Features/family/presentation/screens/family_screen.dart';
import 'package:amaan_tv/Features/Home/presentation/screens/home_screen.dart';
import 'package:amaan_tv/Features/parent%20settings/screens/parent_settings_screen.dart';
import 'package:amaan_tv/Features/reels/presentation/reels_screen.dart';
import 'package:amaan_tv/Features/Auth/provider/user_notifier.dart';

import '../../search/presentation/screens/search_screen.dart';

class BottomBarItem {
  BottomBarItem({
    required this.screen,
    required this.icon,
    required this.activeIcon,
  });
  final Widget screen;
  final String icon;
  final String activeIcon;
}

class BottomBarProvider extends ChangeNotifier {
  BottomBarProvider(this.userNotifier);
  int currentIndex = 0;
  final UserNotifier userNotifier;

  List<BottomBarItem> _childScreens = [
    BottomBarItem(
      screen: const HomeScreen(),
      icon: Assets.images.home.path,
      activeIcon: Assets.images.activeHome.path,
    ),
    BottomBarItem(
      screen: const SearchScreen(),
      icon: Assets.images.search.path,
      activeIcon: Assets.images.activeSearch.path,
    ),
    BottomBarItem(
      screen: const SoonScreen(backButton: false),
      icon: Assets.images.games.path,
      activeIcon: Assets.images.games.path,
    ),
    BottomBarItem(
      screen: ReelsScreen(),
      icon: Assets.images.videos.path,
      activeIcon: Assets.images.activeVideos.path,
    ),
    BottomBarItem(
      screen: const ChildProfileScreen(),
      icon: Assets.images.profile.path,
      activeIcon: Assets.images.activeProfile.path,
    ),
  ];

  List<BottomBarItem> _parentScreens = [
    BottomBarItem(
      screen: const HomeScreen(),
      icon: Assets.images.home.path,
      activeIcon: Assets.images.activeHome.path,
    ),
    BottomBarItem(
      screen: const SearchScreen(),
      icon: Assets.images.search.path,
      activeIcon: Assets.images.activeSearch.path,
    ),
    BottomBarItem(
      screen: ReelsScreen(),
      icon: Assets.images.videos.path,
      activeIcon: Assets.images.activeVideos.path,
    ),
    BottomBarItem(
      screen: const FamilyScreen(),
      icon: Assets.images.mykids.path,
      activeIcon: Assets.images.activemykids.path,
    ),
    BottomBarItem(
      screen: const ParentSettingsScreen(),
      icon: Assets.images.setting.path,
      activeIcon: Assets.images.activeSettings.path,
    ),
  ];

  UserData? get currentUser => userNotifier.userData;

  List<BottomBarItem> get items =>
      currentUser?.userType.isChild == true ? _childScreens : _parentScreens;

  void changeIndex({required int index}) {
    if (index == currentIndex) return;
    if (items.length <= index) {
      currentIndex = 0;
    } else {
      currentIndex = index;
    }

    notifyListeners();
  }
}
