import 'package:amaan_tv/core/utils/app_router.dart';

class ProfileItemsModel {
  const ProfileItemsModel({
    required this.icon,
    required this.title,
    this.navigator,
    this.extra,
  });

  final String icon;
  final String title;
  final AppRoutes? navigator;
  final Map<String, dynamic>? extra;
}
