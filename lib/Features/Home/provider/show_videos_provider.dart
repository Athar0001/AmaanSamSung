import 'package:flutter/material.dart';
import 'package:amaan_tv/Features/Home/data/models/home/reals_model.dart';
import 'package:amaan_tv/core/pagination/pagination_mixin.dart';

class ShowPromosProvider extends ChangeNotifier
    with PaginationMixin<ReelModel> {
  // Stub
  @override
  Future<void> getData({
    dynamic Function(List<ReelModel>)? onSuccess,
    int? pageNumber,
  }) async {}
}
