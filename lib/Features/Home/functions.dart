import 'package:flutter/material.dart';
import 'package:amaan_tv/Features/Auth/presentation/widget/request_login_dialog.dart';
import 'package:amaan_tv/Features/subscription/presentation/dialogs/request_subscription_dialog.dart';
import 'package:amaan_tv/core/utils/app_localiztion.dart';
import 'package:amaan_tv/core/utils/app_router.dart';
import 'package:amaan_tv/core/utils/cash_services/cashe_helper.dart';
import 'package:amaan_tv/core/utils/constant.dart';
import 'package:amaan_tv/Features/Auth/provider/user_notifier.dart';
import 'package:provider/provider.dart';

String? checkIfVideoAllowed({
  required bool? isGuest,
  required bool? isFree,
  BuildContext? context,
}) {
  final isShowGuest = isGuest ?? true;
  final appContext = context ?? appNavigatorKey.currentContext!;
  final userNotifier = appContext.read<UserNotifier>();
  final isUserGuest = userNotifier.userData == null;
  final isShowFree = isFree ?? true;
  final isUserFree = CacheHelper.getData(key: Constant.isFree) ?? true;

  if (!isShowGuest && isUserGuest) {
    if (context != null) {
      RequestLoginDialog.show(context);
    }
    return AppLocalization.strings.loginPlz;
  }
  if (!isShowFree && isUserFree) {
    if (context != null) {
      RequestSubscriptionsDialog.show(context);
      //workaround to not show toast message
      // and return string to notify not valid to play
      return '';
    }
    return AppLocalization.strings.subscribeNow;
  }
  return null;
}
