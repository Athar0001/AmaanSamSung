import 'package:flutter/material.dart';
import 'package:amaan_tv/core/models/video_types.dart';
import 'package:amaan_tv/core/utils/api/api_service.dart';
import 'package:amaan_tv/core/utils/api/end_point.dart';
import 'package:amaan_tv/core/utils/enum.dart';
import 'package:amaan_tv/Features/Home/data/models/home/reals_model.dart';
import 'package:amaan_tv/core/pagination/pagination_mixin.dart';

class ShowPromosProvider extends ChangeNotifier
    with PaginationMixin<ReelModel> {
  ShowPromosProvider(this.apiService);

  final ApiService apiService;
  String _showId = '';

  void showId(String id) {
    _showId = id;
    currentPage = 1;
    getData();
  }

  // AppState state = AppState.init; // PaginationMixin might have 'state' getter but we need setter or override if it's a mixin with variable.
  // Checking PaginationMixin again: "AppState get state => AppState.init;" -> It is a getter returning init. I need to override it with a variable.

  @override
  AppState state = AppState.init;

  @override
  Future<void> getData({
    dynamic Function(List<ReelModel>)? onSuccess,
    int? pageNumber,
  }) async {
    state = AppState.loading;
    notifyListeners();
    try {
      final response = await apiService.makeGetRequest(
        '${EndPoint.getShowVideoByVideoType}/$_showId',
        query: {
          'VideoTypeId': VideoTypes.promo.id,
          'PageNumber': pageNumber ?? currentPage,
          'PageSize': pageSize,
        },
      );
      final list = List<ReelModel>.from(
        (response.data['data']['data'] as List).map(
          (e) => ReelModel.fromJson(e),
        ),
      );

      if (pageNumber == 1 || pageNumber == null) {
        allItems.clear();
      }
      allItems.addAll(list);
      state = AppState.success;
      notifyListeners();
      onSuccess?.call(list);
    } catch (e) {
      state = AppState.error;
      notifyListeners();
    }
  }
}
