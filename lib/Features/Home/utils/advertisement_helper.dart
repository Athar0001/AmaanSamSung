import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:amaan_tv/Features/Home/data/models/advertisement_model.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/advertisement_dialog.dart';
import 'package:amaan_tv/core/utils/cash_services/cashe_helper.dart';
import 'package:amaan_tv/core/utils/constant.dart';

mixin AdvertisementHelper {
  static bool _isAdvertisementShown = false;
  static bool get isAdvertisementShown => _isAdvertisementShown;


  static Future<void> checkAndShowAdvertisement(BuildContext context) async {
    if (_isAdvertisementShown) return;
    _isAdvertisementShown = true;

    try {
      final advertisementJson = CacheHelper.getData<String>(
        key: Constant.advertisementKey,
      );
      if (advertisementJson != null) {
        final advertisement = AdvertisementModel.fromStorageJson(
          jsonDecode(advertisementJson),
        );

        final now = DateTime.now();
        final start = advertisement.startDate;
        final end = advertisement.endDate;

        if (end != null && now.isAfter(end)) {
          await CacheHelper.removeData(key: Constant.advertisementKey);
          _isAdvertisementShown = false;
          return;
        }

        if ((start == null || now.isAfter(start)) &&
            (end == null || now.isBefore(end))) {

          if (context.mounted) {
            await showDialog<void>(
              context: context,
              builder: (context) =>
                  AdvertisementDialog(imageUrl: advertisement.imageUrl),
            );
            _isAdvertisementShown = false;
          }
        }
      }
    } catch (e, st) {
      _isAdvertisementShown = false;
      log(
        'Error showing advertisement: $e',
        stackTrace: st,
        name: 'checkAndShowAdvertisement',
      );
    }
  }
}
